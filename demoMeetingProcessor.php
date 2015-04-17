<?php

session_start();

error_reporting(E_ALL);
ini_set('display_errors', '1');

require_once("config/env_config.php");
require_once("control/error/handlers.php");
require_once("control/bbb-api-php/includes/bbb-api.php"); 

$bbb = new BigBlueButton();

$creationParams = array(
	'meetingId' => '9999',
	'meetingName' => "Northbridge Demo Community Room",
	'attendeePw' => 'ap',
	'moderatorPw' => 'mp',
	'welcomeMsg' => 'Welcome!<br/><br/>If any conference participants have trouble establishing audio connection through the computer, we will fall back to this phone conference line:<br/><br/><b>800.662.6992<br/>Access code: 2539929</b>',
	'dialNumber' => '',
	'voiceBridge' => '',
	'webVoice' => '',
	'logoutUrl' => 'http://northbridgetech.org/dev/nexus/client_demo.php',
	'maxParticipants' => '',
	'record' => '',
	'duration' => '0'
);

$joinParams = array(
	'meetingId' => '9999',
	'username' => $_POST['username'],
	'password' => 'mp'
);

$bbb->createMeetingWithXmlResponseArray($creationParams);
// TODO - check returnCodes

$itsAllGood = TRUE;

try {
	$result = $bbb->getJoinMeetingUrl($joinParams);
} catch (Exception $e) {
	$itsAllGood = FALSE;
}

if ($itsAllGood) {
	header("location:" . $result);	
	exit(0);
} else {
	trigger_error("Cannot join conference: $result\n", E_USER_ERROR);
	exit(0);
}

?>
