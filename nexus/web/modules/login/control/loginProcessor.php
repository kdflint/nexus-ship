<?php

session_start();

require_once("../../../src/framework/Util.php");
require_once(Utilities::getSrcRoot() . "/schedule/Event.php");

use Birke\Rememberme;

$dirty = array('username' => $_POST['uid'], 'password' => (isset($_POST['password']) ? $_POST['password'] : ''), 'tz' => $_POST['timezone']);

$clean = array();

if (isset($dirty['username'])) {
	if (isset($_SESSION['demo']) && $_SESSION['demo']) {
		$clean['username'] = Utilities::sanitize($dirty['username']);
		$dirty['password'] = Utilities::getDemoPassword();
	} else if (Utilities::validateUsernameFormat($dirty['username'])) {
		$clean['username'] = $dirty['username'];
	} else {
		returnToLoginWithError(Utilities::AUTHENTICATION_ERROR);
	}
} else {
	returnToLoginWithError(Utilities::AUTHENTICATION_ERROR);
}

if (isset($dirty['password']) && Utilities::isValidPassword($dirty['password'])) {
	$clean['password'] = $dirty['password'];
} else {
	returnToLoginWithError(Utilities::AUTHENTICATION_ERROR);
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

$storagePath = Utilities::getTokenRoot();
$rememberedUsername = false;
if ($storagePath) {
	$storage = new Rememberme\Storage\File($storagePath);
	$rememberMe = new Rememberme\Authenticator($storage);
	$rememberedUsername = $rememberMe->login();
}

if (isset($_SESSION['demo']) && $_SESSION['demo']) {
	$isAuthenticated = true;
} else if ($rememberedUsername && Utilities::validateUsernameFormat($rememberedUsername)) {
  	$clean['username'] = $rememberedUsername;
  	$clean['password'] = "tokenized";
  	$isAuthenticated = true;
} else {
	$isAuthenticated = Utilities::authenticate($clean['username'], $clean['password']);
}

if($isAuthenticated){
	if (isset($_SESSION['demo']) && $_SESSION['demo']) {
		Utilities::setDemoSession($clean['username'], $clean['remember'], $clean['tz']);
	} else {
		Utilities::setSession($clean['username'], $clean['remember'], $clean['tz'], $clean['password']);
		if ($clean['remember']) {
			$rememberMe->getCookie()->setPath("/");
			$rememberMe->createCookie($clean['username']);
		}
	}
	Utilities::setLogin($_SESSION['uidpk']);
	header("location:" . Utilities::getHttpPath() . "/nexus.php");
	exit(0);
} else {
	returnToLoginWithError("No message");
}

function returnToLoginWithError($errorMessage) {
	header("location:" . Utilities::getHttpPath() . "/login.php?logout=true&error=" . $errorMessage);
	exit(0);
}

function returnToLoginWithLogout() {
	header("location:" . Utilities::getHttpPath() . "/login.php?logout=true");
	exit(0);
}

?>