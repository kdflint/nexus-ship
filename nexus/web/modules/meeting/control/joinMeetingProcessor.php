<?php

session_start();

require_once("../../../src/framework/Util.php");
require_once(Util::getModulesRoot() . "/error/handlers.php");
require_once(Util::getLibRoot() . "/bigbluebutton/bbb-api-php/includes/bbb-api.php"); 

$bbb = new BigBlueButton();


// LEFT OFF - get from db
// meeting id
// meeting name
$trainingMeetingId = '2963';
$joinerPassword = "mp";

$creationParams = array(
	'meetingId' => $trainingMeetingId,
	'meetingName' => "The Demo Organization Web Room",
	'attendeePw' => 'ap',
	'moderatorPw' => 'mp',
	'welcomeMsg' => '<b>Welcome to the Northbridge Technology Alliance Nexus Training Session!</b><br/><br/>Messages entered here will be displayed to the entire group, including the presenter.',
	'dialNumber' => '',
	'voiceBridge' => '',
	'webVoice' => '',
	'logoutUrl' => '',
	'maxParticipants' => '',
	'record' => '',
	'duration' => '0'
);

$itsAllGood = TRUE;
$joinUrl = "";
$configToken = "";

try {
	$response = $bbb->createMeetingWithXmlResponseArray($creationParams);
	if (strcasecmp($response['returncode'], 'SUCCESS') != 0) {
		$itsAllGood = FALSE;
	}
} catch (Exception $e) {
	trigger_error("Cannot create meeting: " . $e->getMessage() . "\n", E_USER_ERROR);
	$itsAllGood = FALSE;
}

$joinParams = array(
	'meetingId' => $trainingMeetingId,
	'username' => $_SESSION['fname'] . " " . $_SESSION['lname'],
	'password' => $joinerPassword
);

if ($itsAllGood) {
	try {
		$joinUrl = $bbb->getJoinMeetingUrl($joinParams);
		//echo $joinUrl; exit(0);
		// TODO - figure out how to tell if this url is well formed and valid. See under "join" at https://docs.bigbluebutton.org/dev/api.html
	} catch (Exception $e) {
		//echo "Cannot get join meeting url: " . $e->getMessage() . "\n", E_USER_ERROR;
		trigger_error("Cannot get join meeting url: " . $e->getMessage() . "\n", E_USER_ERROR);
		$itsAllGood = FALSE;
	}
}

if ($itsAllGood) {
	header("location:" . $joinUrl);	
	exit(0);
} else {
	trigger_error("Cannot join conference: " . $joinUrl . "\n", E_USER_ERROR);
	exit(0);
}


?>

