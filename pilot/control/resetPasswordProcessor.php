<?php

// re-use set session code in Util

session_start();

require_once("util.php");
require_once(Util::getAppRoot() . "model/pgDb.php");

$cleanCode = "";

// TODO - use this method in enroll
if (isset($_GET['resetCode']) && Util::validateUuid($_GET['resetCode'])) {
			$cleanCode = $_GET['resetCode'];
}

if ($cleanCode) {	
	$cursor = pgDb::getUserPasswordResetActivityByUuid($cleanCode);
	$result = pg_fetch_array($cursor);
	if (isset($result['uidpk']) && isset($result['username']) && isset($result['id'])) {
		Util::setSession($result['username']);
		Util::setLogin($_SESSION['uidpk']);
		pgDb::updateUserPasswordResetActivityById($result['id']);
		header("location:../view/nexus.php?thisPage=profile");
		exit(0);
	}
}

returnToLoginWithMessage(Util::RESET_ERROR);

function returnToLoginWithMessage($message) {
	header("location:../view/login.php?error=" . $message);
	exit(0);
}

?>