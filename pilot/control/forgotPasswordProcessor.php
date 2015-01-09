<?php

session_start();

require_once("util.php");
require_once(Util::getAppRoot() . "model/pgDb.php");
require_once(Util::getAppRoot() . "control/error/handlers.php");
require_once(Util::getAppRoot() . "config/env_config.php");
require_once(Util::getHome() . "php/Validate.php");

$dirty = array('username' => $_POST['uid'], 'network' => $_POST['network']);
$clean = array();

if (Validate::string($dirty['network'], array('format' => VALIDATE_NUM))) {
	$clean['good']['network'] = $dirty['network'];
} else {
	$clean['good']['network'] = "";	
}

// Rules here slightly different to be backward compatible to data inserted prior to validation enforcement
// TODO - disallow spaces when we go public public
if (Validate::string($dirty['username'], array(
						'format' => VALIDATE_ALPHA . VALIDATE_NUM . VALIDATE_SPACE . "_",
    				'max_length' => Util::USERNAME_MAX))) {
	$clean['good']['username'] = $dirty['username'];
} else {
	returnToLoginWithMessage(Util::AUTHENTICATION_ERROR, $clean['good']['network']);	
}

// TODO - make sure username is unique and only one is returned
echo $clean['good']['username'] . "<br/>";
$cursor = pgDb::getUserByUsername($clean['good']['username']);
$result = pg_fetch_array($cursor);
if (isset($result['email']) && isset($result['id'])) {
	if  (Util::validateEmail($result['email'])) {
		$uuid = Util::newUuid();
		pgDb::insertPasswordResetActivity($result['id'], $uuid);
		sendResetEmail($result['email'], $env_appRoot, $fname, $uuid);
		returnToLoginWithMessage("Your password reset link has been sent to the email address on file.", $clean['good']['network']);	
	} else {
		// TODO - or, say contact customer support?
		returnToLoginWithMessage(Util::AUTHENTICATION_ERROR, $clean['good']['network']);
	}
} else {
	returnToLoginWithMessage("Your password reset link has been sent to the email address on file.", $clean['good']['network']);
}

function returnToLoginWithMessage($message, $network) {
	header("location:../view/login.php?network=" . $network . "&error=" . $message);
	exit(0);
}

function sendResetEmail($email, $path, $fname, $uuid) {
	
	$message = "Hello " . $fname . ",
	
Below is your link to reset your password.

Note: This link will expire in 30 minutes. Also, any password links sent to you previously are now void.

http://northbridgetech.org/" . $path . "/nexus/view/reset.php?resetCode=" . $uuid . "

If you did not request this password reset, please contact our support team at support@northbridgetech.org.

The Support Team at
NorthBridge Technology Alliance";

		mail($email, "[Nexus] Password Reset", $message, "From: noreply@nexus.northbridgetech.org\r\n");		
		
}

?>