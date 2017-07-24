<?php

session_start();

require_once("../../../src/framework/Util.php");
require_once(Utilities::getSrcRoot() . "/user/User.php");

$conf = array('append' => true, 'mode' => 0644, 'timeFormat' => '%X %x');
$logger = Log::singleton("file", Utilities::getLogRoot() . "/password_activity.log", "", $conf, PEAR_LOG_INFO);

$dirty = array('username' => $_POST['uid'], 'network' => $_POST['network'], 'isAdminRequest' => $_POST['admin']);
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

if (isset($dirty['isAdminRequest']) && $dirty['isAdminRequest'] === "true") {
	$clean['admin'] = true;
} else {
	$clean['admin'] = false;
}

$cursor = User::getActiveUserByUsername($clean['username']);
$result = pg_fetch_array($cursor);
$uuid = Utilities::newUuid();

if ($clean['admin']) {
	$logger->log("Attempting admin password reset for user" . $clean['username'] . ":" . $result['id'], PEAR_LOG_INFO);
	if  (Utilities::validateEmail($_SESSION['email']) && isset($result['id'])) {
		User::insertPasswordResetActivity($result['id'], $uuid);
		sendAdminResetEmail($uuid);	
		header("location:" . Utilities::getHttpPath() . "/nexus.php?view=network");
		exit(0);	
	}
} else if (isset($result['email']) && isset($result['id'])) {
	$logger->log("Attempting standard password reset for user" . $clean['username'] . ":" . $result['id'], PEAR_LOG_INFO);
	if  (Utilities::validateEmail($result['email'])) {
		User::insertPasswordResetActivity($result['id'], $uuid);
		sendResetEmail($result['email'], $result['fname'], $uuid);
		returnToLoginWithMessage("Your password reset link has been sent to the email address on file.", $clean['network']);	
	} else {
		// TODO - or, say contact customer support?
		returnToLoginWithMessage(Utilities::AUTHENTICATION_ERROR, $clean['network']);
	}
} else {
	$logger->log("No password reset attempt for " . $clean['username'], PEAR_LOG_INFO);
	returnToLoginWithMessage(Utilities::AUTHENTICATION_ERROR, $clean['network']);
}

function returnToLoginWithMessage($message, $network) {
	header("location:" . Utilities::getHttpPath() . "/login.php?network=" . $network . "&error=" . $message);
	exit(0);
}

function sendResetEmail($email, $fname, $uuid) {
	
	$message = "Hello " . $fname . ",
	
Below is your link to reset your password.

Note: This link will expire in 30 minutes. Also, any password links sent to you previously are now void.

" . Utilities::getHttpPath() . "/modules/login/views/reset.php?resetCode=" . $uuid . "

If you did not request this password reset, please contact our support team at support@northbridgetech.org.

The Support Team at
NorthBridge Technology Alliance";

		mail($email, "[Nexus] Password Reset", $message, "From: noreply@northbridgetech.org\r\n");		
		
}

function sendAdminResetEmail($email, $uuid, $fname, $lname) {
	
	$message = "Hello " . $_SESSION['fname'] . ",
	
Below is the link you should use to reset the password for Nexus user " . $fname . " " . $lname . "

If you do not use this link, the password will remain unchanged for this user.

This link will open a new Nexus session focused on the profile for this user.

After you reset their password, make sure you log out of that session and inform your user of their new password. 

Note: This link will expire in 30 minutes. Also, any password reset links previously generated for this user are now void.

" . Utilities::getHttpPath() . "/modules/login/views/reset.php?resetCode=" . $uuid . "

If you did not request this password reset, please contact our support team at support@northbridgetech.org.

The Support Team at
NorthBridge Technology Alliance";

		mail($_SESSION['email'], "[Nexus] Administrative Password Reset", $message, "From: noreply@northbridgetech.org\r\n");		
		
}


?>