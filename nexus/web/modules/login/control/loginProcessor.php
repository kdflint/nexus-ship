<?php

session_start();

require_once("../../../src/framework/Util.php");
require_once(Utilities::getSrcRoot() . "/schedule/Event.php");

$dirty = array('username' => $_POST['uid'], 'password' => (isset($_POST['password']) ? $_POST['password'] : ''), 'tz' => $_POST['timezone']);
$clean = array();

if (isset($_SESSION['demo']) && $_SESSION['demo'] && isset($dirty['username'])) {
	$clean['username'] = Utilities::sanitize($dirty['username']);
	$dirty['password'] = Utilities::getDemoPassword();
} else if (isset($dirty['username']) && Utilities::validateUsernameFormat($dirty['username'])) {
	$clean['username'] = $dirty['username'];
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

if (isset($_SESSION['remembered']) && $_SESSION['remembered']) {
	unset($_SESSION['remembered']);
	$isAuthenticated = true;
} else if (isset($_SESSION['demo']) && $_SESSION['demo']) {
	$isAuthenticated = true;
} else {
	$isAuthenticated = Utilities::authenticate($clean['username'], $clean['password']);
}

if($isAuthenticated){
	if (isset($_SESSION['demo']) && $_SESSION['demo']) {
		Utilities::setDemoSession($clean['username'], $clean['remember'], $clean['tz']);
	} else {
		Utilities::setSession($clean['username'], $clean['remember'], $clean['tz'], $clean['password']);
	}
	Utilities::setLogin($_SESSION['uidpk']);
	
	// Temporary migration for some Nexus CFCHT pilot users, allowing to update pending meetings
	// All EDC users have access under NWM account
	if ($_SESSION['environment'] == "prod" && $_SESSION['orgUid'] == "ed787a92") {
		if ($_SESSION['username'] != "testCfcht3" &&
				$_SESSION['username'] != "kpeachey" &&
				$_SESSION['username'] != "Olga3075") {
					returnToLoginWithPilotMessage("Your access to Nexus is temporarily suspended while we migrate to Nexus Advantage.");
		}
	}
				
	//if ((session_status() === PHP_SESSION_ACTIVE) && isset($_SESSION['nexusContext'])) {
	header("location:" . Utilities::getHttpPath() . "/nexus.php");
	//}
	//} else {
	//}
} else {
	returnToLoginWithError(Utilities::AUTHENTICATION_ERROR);
}

function returnToLoginWithError($errorMessage) {
	header("location:" . Utilities::getHttpPath() . "/login.php?error=" . $errorMessage);
	exit(0);
}

function returnToLoginWithPilotMessage($pilotMessage) {
	header("location:" . Utilities::getHttpPath() . "/login.php?oid=ed787a92&logout=true&error=" . $pilotMessage);
	exit(0);
	}

?>