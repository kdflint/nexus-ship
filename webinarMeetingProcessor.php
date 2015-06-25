<?php

session_start();

require_once("config/env_config.php");
require_once("control/error/handlers.php");
require_once("control/bbb-api-php/includes/bbb-api.php"); 
//require_once("control/bbb-api-php/includes/config.php"); 

//$base_url_setConfigXML = CONFIG_SERVER_BASE_URL . "api/setConfigXML.xml?";
//$securitySalt = CONFIG_SECURITY_SALT;

$bbb = new BigBlueButton();

$joinerPassword = "mp";

if (!strcmp($env_name, "prod")) {
	$joinerPassword = "ap";
}

$creationParams = array(
	'meetingId' => '8888',
	'meetingName' => "Northbridge Community Room",
	'attendeePw' => 'ap',
	'moderatorPw' => 'mp',
	'welcomeMsg' => 'Welcome to the Northbridge Technology Alliance Information Webinar!<br/><br/>To join the session audio, click the headphone icon in the upper left corner of your display.<br/><br/>Messages entered here will be displayed to the entire group including the presenter.',
	'dialNumber' => '',
	'voiceBridge' => '',
	'webVoice' => '',
	'logoutUrl' => 'http://northbridgetech.org/index.php?view=apply',
	'maxParticipants' => '',
	'record' => '',
	'duration' => '0'
);

$joinParams = array(
	'meetingId' => '8888',
	'username' => $_POST['username'],
	'password' => $joinerPassword
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
