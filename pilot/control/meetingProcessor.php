<?php

session_start();

require_once '../config/env_config.php';
require_once 'error/handlers.php';
require_once('bbb-api-php/includes/bbb-api.php'); 

$bbb = new BigBlueButton();

$creationParams = array(
	'meetingId' => '2222' . $env_number . $_SESSION['networkId'];
	'meetingName' => $_SESSION['networkName'] . " Community Room",
	'attendeePw' => 'ap',
	'moderatorPw' => 'mp',
	'welcomeMsg' => 'Welcome!<br/><br/>If any conference participants have trouble establishing audio connection through the computer, you may wish to talk on the telephone line instead at<br/><br/><b>712.432.1212<br/>Access code: ' . $wc_phone[$_SESSION['networkId']] . '</b>',
	'dialNumber' => '',
	'voiceBridge' => '',
	'webVoice' => '',
	'logoutUrl' => 'http://northbridgetech.org/' . $env_appRoot . '/nexus/view/serviceLogout.php',
	'maxParticipants' => '',
	'record' => '',
	'duration' => '0'
);

$joinParams = array(
	'meetingId' => '2222' . $env_number . $_SESSION['networkId'],
	'username' => $_SESSION['fname'],
	'password' => 'mp'
);

$bbb->createMeetingWithXmlResponseArray($creationParams);
// TOTO - check returnCodes

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
