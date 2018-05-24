<?php

session_start();

require_once("../../../src/framework/Util.php");
require_once(Utilities::getSrcRoot() . "/schedule/Event.php");
require_once(Utilities::getSrcRoot() . "/schedule/BbbMeeting.php");
require_once(Utilities::getModulesRoot() . "/error/handlers.php");

require_once Utilities::getComposerRoot() . '/autoload.php';

use BigBlueButton\BigBlueButton; 
use BigBlueButton\Parameters\JoinMeetingParameters;

$conf = array('append' => true, 'mode' => 0644, 'timeFormat' => '%X %x');
$logger = Log::singleton("file", Utilities::getLogRoot() . "/join_meeting.log", "", $conf, PEAR_LOG_INFO);

$dirty = array('uuid' => $_GET['id'], 'mtype' => $_GET['type']);
$clean = array();

if (isset($dirty['uuid']) && Event::isValidEventUuid($dirty['uuid'])) {
	$clean['uuid'] = $dirty['uuid'];
} else {
	// TODO - centralize this
	forceLogout();
}

if (isset($dirty['mtype']) && Event::isValidMeetingType($dirty['mtype'])) {
	$clean['mtype'] = $dirty['mtype'];
} else {
	$clean['mtype'] = 'collaboration';
}

if ($clean['mtype'] === "webinar" && Utilities::isSessionAdmin()) {
	// TODO - this should no longer be necessary... revisit... need distinction on ADV role maybe??
	$clean['mtype'] = 'collaboration';
}

$logger->log("=======================", PEAR_LOG_INFO);
//$logger->log("Meeting id: " . $clean['uuid'], PEAR_LOG_INFO);
$logger->log("Meeting type: " . $clean['mtype'], PEAR_LOG_INFO);

if (!Utilities::isSessionValid()) {
	$logger->log("ERROR: invalid Nexus session", PEAR_LOG_INFO);
	header("location:" . Utilities::getHttpPath() . "/nexus.php");
	exit(0);
}

$bbbApi = new BigBlueButton();
$roomName = $_SESSION['groups'][0]['name'];
if ($_SESSION['nexusContext'] === "ADV" && isset($_SESSION['networkName'])) {
	$roomName = $_SESSION['networkName'];
}

$bbbMeeting = new BbbMeeting($clean['uuid'], $roomName . " Conference Room", $clean['mtype']);
$bbbMeeting->setMetaParams($_SESSION['networkId'], $_SESSION['orgUid'], $_SESSION['groups'][0]['id'], $_SESSION['uidpk'], $clean['uuid']);

$itsAllGood = TRUE;
$joinerPassword = "mp";
if ($clean['mtype'] === "webinar" && Utilities::isSessionPublic()) {
	$joinerPassword = "ap";
}
$joinUrl = $configToken = "";

if ($joinerPassword === "mp") {
	$bbbMeeting->setRecordingParams(true);
} else {
	$bbbMeeting->setRecordingParams(false);
}

// Create the meeting (if it does not exist yet)
try {
	$response = $bbbApi->createMeeting($bbbMeeting->getCreationParams());
	if ($response->getReturnCode() == 'FAILED') {
		$itsAllGood = FALSE;
	}
} catch (Exception $e) {
	$logger->log("ERROR: " . $e->getMessage(), PEAR_LOG_INFO);
	trigger_error("Cannot create meeting: " . $e->getMessage() . "\n", E_USER_ERROR);
	$itsAllGood = FALSE;
}

$logger->log("Meeting created: " . var_export($itsAllGood, true), PEAR_LOG_INFO);

// Set the room configuration for this user
if ($itsAllGood) {
	$logger->log("Meeting id: " . $bbbMeeting->getMeetingId(), PEAR_LOG_INFO);
	if (true) {
		// use below for sending meetings to Blindside
		$configToken = $bbbMeeting->getMeetingConfigurationTokenProxy();
	} else {
		// below is how we serve a complete xml file, but incompatible with Blindside
		try {
			$response = $bbbApi->setConfigXML($bbbMeeting->getMeetingConfigurationXml());
			$logger->log("Token: " . $response->getToken(), PEAR_LOG_INFO);
			if (strcasecmp($response->getReturnCode(), 'SUCCESS') != 0 || strlen($response->getToken()) < 1) {
				$itsAllGood = FALSE;
				// TODO - use the default config?
				$configToken = "";
			} else {
				$configToken = $response->getToken();
			}
			} catch (Exception $e) {
			$logger->log("ERROR: " . $e->getMessage(), PEAR_LOG_INFO);
			trigger_error("Cannot set configuration: " . $e->getMessage() . "\n", E_USER_ERROR);
			$itsAllGood = FALSE;
		}
	}	
}

$logger->log("Config token: " . $configToken, PEAR_LOG_INFO);
$logger->log("Room configured: " . var_export($itsAllGood, true), PEAR_LOG_INFO);
$logger->log("Recording parameters: " . var_export(print_r($bbbMeeting)). PEAR_LOG_INFO);

$joinMeetingParams = new JoinMeetingParameters($bbbMeeting->getMeetingId(), $_SESSION['fname'] . " " . $_SESSION['lname'], $joinerPassword);
$joinMeetingParams->setConfigToken($configToken);
$joinMeetingParams->setRedirect(true);

if ($itsAllGood) {
	try {
		$joinUrl = $bbbApi->getJoinMeetingURL($joinMeetingParams);
		// TODO - figure out how to tell if this url is well formed and valid. See under "join" at https://docs.bigbluebutton.org/dev/api.html
	} catch (Exception $e) {
		$logger->log("ERROR: " . $e->getMessage(), PEAR_LOG_INFO);
		trigger_error("Cannot get join meeting url: " . $e->getMessage() . "\n", E_USER_ERROR);
		$itsAllGood = FALSE;
		// TODO - where to land user?
	}
}

$logger->log("Room url retrieved: " . var_export($itsAllGood, true), PEAR_LOG_INFO);
$logger->log("Join url: " . $joinUrl, PEAR_LOG_INFO);

if ($itsAllGood) {
	header("location:" . $joinUrl);	
	exit(0);
} else {
	$logger->log("ERROR: " . $e->getMessage(), PEAR_LOG_INFO);
	trigger_error("Cannot join conference: " . $joinUrl . "\n", E_USER_ERROR);
	exit(0);
}

function forceLogout() {
	header("location:" . Utilities::getHttpPath() . "/login.php?logout=true");
	exit(0);
}

?>

