<?php

session_start();

require_once("../../../src/framework/Util.php");
require_once(Utilities::getSrcRoot() . "/schedule/Event.php");
require_once(Utilities::getSrcRoot() . "/schedule/BbbMeeting.php");
require_once(Utilities::getModulesRoot() . "/error/handlers.php");
require_once(Utilities::getLibRoot() . "/bigbluebutton/bbb-api-php/includes/bbb-api.php"); 

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
	$clean['mtype'] = 'collaboration';
}

if (!Utilities::isSessionValid()) {
	header("location:" . Utilities::getHttpPath() . "/nexus.php");
	exit(0);
}

$bbbApi = new BigBlueButton();
$roomName = $_SESSION['groups'][0]['name'];
if ($_SESSION['nexusContext'] === "ADV" && isset($_SESSION['networkName'])) {
	$roomName = $_SESSION['networkName'];
}
$bbbMeeting = new BbbMeeting($clean['uuid'], $roomName . " Conference Room", $clean['mtype']);

$itsAllGood = TRUE;
$joinerPassword = "mp";
if ($clean['mtype'] === "webinar" && !Utilities::isSessionAdmin()) {
	$joinerPassword = "pw";
}
$joinUrl = $configToken = "";

// Create the meeting (if it does not exist yet)
try {
	$response = $bbbApi->createMeetingWithXmlResponseArray($bbbMeeting->getCreationParams());
	if (strcasecmp($response['returncode'], 'SUCCESS') != 0) {
		$itsAllGood = FALSE;
	}
} catch (Exception $e) {
	trigger_error("Cannot create meeting: " . $e->getMessage() . "\n", E_USER_ERROR);
	$itsAllGood = FALSE;
}

// Set the room configuration for this user
if ($itsAllGood) {
	try {
		$response = $bbbApi->setMeetingConfig($bbbMeeting->getMeetingConfigurationXml(), $bbbMeeting->getMeetingId());
		if (strcasecmp($response['returncode'], 'SUCCESS') != 0 || !isset($response['token']) || strlen($response['token']) < 1) {
			$itsAllGood = FALSE;
			// TODO - use the default config?
		} else {
			$configToken = (string)$response['token'];
		}
		} catch (Exception $e) {
		trigger_error("Cannot set configuration: " . $e->getMessage() . "\n", E_USER_ERROR);
		$itsAllGood = FALSE;
	}	
}

$joinParams = array(
	'meetingId' => $bbbMeeting->getMeetingId(),
	'username' => $_SESSION['fname'] . " " . $_SESSION['lname'],
	'password' => $joinerPassword,
	'configToken' => $configToken
);

if ($itsAllGood) {
	try {
		$joinUrl = $bbbApi->getJoinMeetingUrl($joinParams);
		// TODO - figure out how to tell if this url is well formed and valid. See under "join" at https://docs.bigbluebutton.org/dev/api.html
	} catch (Exception $e) {
		trigger_error("Cannot get join meeting url: " . $e->getMessage() . "\n", E_USER_ERROR);
		$itsAllGood = FALSE;
		// TODO - where to land user?
	}
}

if ($itsAllGood) {
	header("location:" . $joinUrl);	
	exit(0);
} else {
	trigger_error("Cannot join conference: " . $joinUrl . "\n", E_USER_ERROR);
	exit(0);
}

function forceLogout() {
	header("location:" . Utilities::getHttpPath() . "/login.php?logout=true");
	exit(0);
}

?>

