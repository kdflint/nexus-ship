<?php

session_start();

require_once("../../../src/framework/Util.php");
require_once(Util::getSrcRoot() . "/user/User.php");

require_once(Util::getLibRoot() . "/rememberme/rememberme/src/Rememberme/Storage/File.php");
require_once(Util::getLibRoot() . "/rememberme/rememberme/src/Rememberme/Authenticator.php");

use Birke\Rememberme;

$cleanCode = "";

// TODO - use this method in enroll
if (isset($_GET['resetCode']) && Util::validateUuid($_GET['resetCode'])) {
			$cleanCode = $_GET['resetCode'];
}

if ($cleanCode) {	
	$cursor = User::getUserPasswordResetActivityByUuid($cleanCode);
	$result = pg_fetch_array($cursor);
	if (isset($result['uidpk']) && isset($result['username']) && isset($result['id'])) {
		Util::setSession($result['username'], false, "undefined");
		Util::setLogin($_SESSION['uidpk']);
		User::updateUserPasswordResetActivityById($result['id']);
		header("location:" . Util::getHttpPath() . "/index.php?view=profile");
		exit(0);
	}
}

returnToLoginWithMessage(Util::RESET_ERROR);

function returnToLoginWithMessage($message) {
	header("location:" . Util::getHttpPath() . "/login.php?error=" . $message);
	exit(0);
}

?>