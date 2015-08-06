<?php

session_start();

require_once("../../../src/framework/Util.php");
require_once(Util::getSrcRoot() . "/schedule/Event.php");

$dirty = array('username' => $_POST['uid'], 'password' => $_POST['password'], 'tz' => $_POST['timezone']);
$clean = array();

if (isset($dirty['username']) && Util::validateUsernameFormat($dirty['username'])) {
	$clean['username'] = $dirty['username'];
} else {
	returnToLoginWithError(Util::AUTHENTICATION_ERROR);
}

if (isset($dirty['password']) && Util::isValidPassword($dirty['password'])) {
	$clean['password'] = $dirty['password'];
} else {
	returnToLoginWithError(Util::AUTHENTICATION_ERROR);
}

if (isset($dirty['tz']) && Event::isValidTimeZone($dirty['tz'])) {
	$clean['tz'] = $dirty['tz'];
} else {
	$clean['tz'] = "undefined";
}

$clean['remember'] = (isset($_POST['login-remember']) ? true : false);

/* ====================================================

Use only clean input beyond this point (i.e. $clean[])

======================================================= */

if (isset($_SESSION['remembered']) && $_SESSION['remembered']) {
	unset($_SESSION['remembered']);
	$isAuthenticated = true;
} else {
	$isAuthenticated = Util::authenticate($clean['username'], $clean['password']);
}

if($isAuthenticated){
	Util::setSession($clean['username'], $clean['remember'], $clean['tz']);
	Util::setLogin($_SESSION['uidpk']);
	header("location:" . Util::getHttpPath() . "/index.php");
	exit(0);	
} else {
	returnToLoginWithError(Util::AUTHENTICATION_ERROR);
}

function returnToLoginWithError($errorMessage) {
	header("location:" . Util::getHttpPath() . "/login.php?error=" . $errorMessage);
	exit(0);
}

?>