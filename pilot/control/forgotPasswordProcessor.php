<?php

session_start();

include("../model/pgDb.php");
include("util.php");
require_once 'error/handlers.php';
require_once("/home1/northbr6/php/Validate.php");
include("../config/env_config.php");

$dirty = array('username' => $_POST['uid']);
$clean = array();

// Rules here slightly different to be backward compatible to data inserted prior to validation enforcement
// TODO - disallow spaces when we go public public
if (Validate::string($dirty['username'], array(
						'format' => VALIDATE_ALPHA . VALIDATE_NUM . VALIDATE_SPACE . "_",
    				'max_length' => Util::USERNAME_MAX))) {
	$clean['good']['username'] = $dirty['username'];
} else {
	returnToLoginWithMessage(Util::AUTHENTICATION_ERROR);	
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
		returnToLoginWithMessage("Your password reset link has been sent to the email address on file.");	
	} else {
		// TODO - or, say contact customer support?
		returnToLoginWithMessage(Util::AUTHENTICATION_ERROR);
	}
} else {
	returnToLoginWithMessage(Util::AUTHENTICATION_ERROR);
}

function returnToLoginWithMessage($message) {
	header("location:../view/login.php?error=" . $message);
	exit(0);
}

function sendResetEmail($email, $path, $fname, $uuid) {
	
	$message = "Hello " . $fname . ",
	
This is good for 30 minutes so dang it you better hurry.

http://northbridgetech.org/" . $path . "/nexus/view/reset.php?resetCode=" . $uuid . "

The Development Team at
NorthBridge Technology Alliance";

		mail($email, "[Nexus] Password Reset", $message, "From: noreply@nexus.northbridgetech.org\r\n");		
		
}

?>