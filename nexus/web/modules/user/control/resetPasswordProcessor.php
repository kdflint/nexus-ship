<?php

session_start();

require_once("../../../src/framework/Util.php");
require_once(Utilities::getSrcRoot() . "/user/User.php");

$cleanCode = "";
$success = "false";

// TODO - use this method in enroll
if (isset($_GET['resetCode']) && Utilities::validateUuid($_GET['resetCode'])) {
			$cleanCode = $_GET['resetCode'];
}

if ($cleanCode) {	
	$cursor = User::getUserPasswordResetActivityByUuid($cleanCode);
	$result = pg_fetch_array($cursor);
	if (isset($result['uidpk']) && isset($result['username']) && isset($result['id'])) {
		Utilities::setSession($result['username'], false, "undefined");
		Utilities::setLogin($_SESSION['uidpk']);
		User::updateUserPasswordResetActivityById($result['id']);
		$success = "true";
	}
} else {
	returnToLoginWithMessage(Utilities::RESET_ERROR);
}

function returnToLoginWithMessage($message) {
	header("location:" . Utilities::getHttpPath() . "/login.php?error=" . $message);
	exit(0);
}

?>