<?php

session_start();

require_once("../../../src/framework/Util.php");
require_once(Utilities::getSrcRoot() . "/user/User.php");

$dirty = array('username' => $_POST['uid'], 'network' => $_POST['network']);
$clean = array();

if (isset($dirty['network']) && Utilities::validateNetworkIdFormat($dirty['network'])) {
	$clean['network'] = $dirty['network'];
} else {
	$clean['network'] = "";	
}

if (isset($dirty['username']) && Utilities::validateUsernameFormat($dirty['username'])) {
	$clean['username'] = $dirty['username'];
} else {
	returnToLoginWithMessage(Utilities::AUTHENTICATION_ERROR, $clean['network']);	
}

// TODO - make sure username is unique and only one is returned
$cursor = User::getActiveUserByUsername($clean['username']);
$result = pg_fetch_array($cursor);
if (isset($result['email']) && isset($result['id'])) {
	if  (Utilities::validateEmail($result['email'])) {
		$uuid = Utilities::newUuid();
		User::insertPasswordResetActivity($result['id'], $uuid);
		sendResetEmail($result['email'], $env_appRoot, $fname, $uuid);
		returnToLoginWithMessage("Your password reset link has been sent to the email address on file.", $clean['network']);	
	} else {
		// TODO - or, say contact customer support?
		returnToLoginWithMessage(Utilities::AUTHENTICATION_ERROR, $clean['network']);
	}
} else {
	returnToLoginWithMessage("Your password reset link has been sent to the email address on file.", $clean['network']);
}

function returnToLoginWithMessage($message, $network) {
	header("location:" . Utilities::getHttpPath() . "/login.php?network=" . $network . "&error=" . $message);
	exit(0);
}

function sendResetEmail($email, $path, $fname, $uuid) {
	
	$message = "Hello " . $fname . ",
	
Below is your link to reset your password.

Note: This link will expire in 30 minutes. Also, any password links sent to you previously are now void.

" . Utilities::getHttpPath() . "/modules/login/views/reset.php?resetCode=" . $uuid . "

If you did not request this password reset, please contact our support team at support@northbridgetech.org.

The Support Team at
NorthBridge Technology Alliance";

		mail($email, "[Nexus] Password Reset", $message, "From: noreply@nexus.northbridgetech.org\r\n");		
		
}

?>