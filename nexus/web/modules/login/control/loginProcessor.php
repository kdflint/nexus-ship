<?php

session_start();

require_once("../../../src/framework/Util.php");
require_once(Utilities::getSrcRoot() . "/schedule/Event.php");
require_once(Utilities::getSrcRoot() . "/user/User.php");

$conf = array('append' => true, 'mode' => 0644, 'timeFormat' => '%X %x');	
$logger = Log::singleton("file", Utilities::getLogRoot() ."/sm_login.log", "", $conf, PEAR_LOG_DEBUG);

$dirty = array('username' => $_POST['uid'], 'password' => (isset($_POST['password']) ? $_POST['password'] : ''), 'tz' => $_POST['timezone']);

$clean = array();

if (isset($dirty['username'])) {
	if (isset($_SESSION['demo']) && $_SESSION['demo']) {
		$clean['username'] = Utilities::sanitize($dirty['username']);
		$dirty['password'] = Utilities::getDemoPassword();
	} else if (isset($_SESSION['xfer']) && $_SESSION['xfer']) {
		if (Utilities::validateUsername($dirty['username'])) {
			$clean['username'] = $dirty['username'];
			$clean['password'] = "tokenized";
		}
	} else if (Utilities::validateUsernameFormat($dirty['username'])) {
		$clean['username'] = $dirty['username'];
	} else {
		returnToLoginWithError(Utilities::AUTHENTICATION_ERROR);
	}
} else if (isset($_SESSION['sm_email'])) {
} else {
	returnToLoginWithError(Utilities::AUTHENTICATION_ERROR);
}

if (isset($dirty['password']) && Utilities::isValidPassword($dirty['password'])) {
	$clean['password'] = $dirty['password'];
} else if (isset($_SESSION['sm_email'])) {
} else {
	returnToLoginWithError(Utilities::AUTHENTICATION_ERROR);
}

if (isset($dirty['tz']) && Event::isValidTimeZone($dirty['tz'])) {
	$clean['tz'] = $dirty['tz'];
} else if (isset($_SESSION['timezone']) && Event::isValidTimeZone($_SESSION['timezone'])) {
	// The timezone will come in to this processor via form submit, except in case of sm login when we pick it up from session
	$clean['tz'] = $_SESSION['timezone'];
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
	$storage = new Birke\Rememberme\Storage\FileStorage($storagePath);
	$rememberMe = new Birke\Rememberme\Authenticator($storage);
	$rememberedLoginResult = $rememberMe->login();
	if ($rememberedLoginResult->isSuccess()) {
  	$rememberedUsername = $rememberedLoginResult->getCredential();
	}
}

if (isset($_SESSION['sm_email']) && Utilities::validateEmail($_SESSION['sm_email'])) {
	$usernameLookup = User::getSingleUsernameByEmail($_SESSION['sm_email']);
	if ($usernameLookup === "0") {
		$logger->log($_SESSION['sm_email'] . " session email " . $_SESSION['sm_email'] . " does not return one and only one username.", PEAR_LOG_INFO);
		returnToLoginWithError("Your ". $_SESSION['sm_provider'] ." email does not relate to a Nexus user account.");
	} else if ($usernameLookup === "-1") {
		$logger->log($_SESSION['sm_email'] . " session email " . $_SESSION['sm_email'] . " returns multiple usernames.", PEAR_LOG_INFO);
		returnToLoginWithErrorAndLink("Your ". $_SESSION['sm_provider'] ." email relates to more than one Nexus user account so we cannot sign you in.");
	}
	$clean['username'] = $usernameLookup;
  $clean['password'] = "tokenized";
  $isAuthenticated = true;
} else if (isset($_SESSION['demo']) && $_SESSION['demo']) {
	$isAuthenticated = true;
} else if ($rememberedUsername && Utilities::validateUsernameFormat($rememberedUsername)) {
  	$clean['username'] = $rememberedUsername;
  	$clean['password'] = "tokenized";
  	$isAuthenticated = true;
} else if (isset($_SESSION['xfer']) && $_SESSION['xfer']) {
	$isAuthenticated = true;
} else {
	$isAuthenticated = Utilities::authenticate($clean['username'], $clean['password']);
}

if($isAuthenticated){
	if (isset($_SESSION['demo']) && $_SESSION['demo']) {
		Utilities::setDemoSession($clean['username'], $clean['remember'], $clean['tz']);
	} else {
		// TODO - how does a remembered session interact with a FB session and/or a transferred session?
		Utilities::setSession($clean['username'], $clean['remember'], $clean['tz'], $clean['password']);
		if ($clean['remember']) {
			$rememberMe->getCookie()->setPath("/");
			$rememberMe->createCookie($clean['username']);
		}
	}
	Utilities::setLogin($_SESSION['uidpk']);
	// TODO - filter out 'userdemo'
	if (isset($_SESSION['orgUid'])){
		if(isset($_COOKIE['member_channel_oid'])) {
			$oids = explode (",", $_COOKIE['member_channel_oid']); 
			array_push($oids, $_SESSION['orgUid']); 
			// TODO - make a cookie factory to get rid of redundant code and set cookies to secure in https-enabled environments
			setcookie('member_channel_oid', implode(",", $oids), time() + (10 * 365 * 24 * 60 * 60), '/', Utilities::getEnvHost(), 0, 0);
		} else {
			setcookie('member_channel_oid', $_SESSION['orgUid'], time() + (10 * 365 * 24 * 60 * 60), '/', Utilities::getEnvHost(), 0, 0);
		}
		if(isset($_COOKIE['remembered_oids'])) {
			$roids = explode (",", $_COOKIE['remembered_oids']); 
			if(!in_array($_SESSION['orgUid'], $roids, true)){
				array_push($roids, $_SESSION['orgUid']); 
			}
			setcookie('remembered_oids', implode(",", $roids), time() + (10 * 365 * 24 * 60 * 60), '/', Utilities::getEnvHost(), 0, 0);
		} else {
			setcookie('remembered_oids', $_SESSION['orgUid'], time() + (10 * 365 * 24 * 60 * 60), '/', Utilities::getEnvHost(), 0, 0);
		}
	}
	header("location:" . Utilities::getHttpPath() . "/nexus.php");
	exit(0);
} else {
	returnToLoginWithError("No message");
}

function returnToLoginWithErrorAndLink($errorMessage) {
	$link = "toggleFormDisplay('recover-username-form')";
	header("location:" . Utilities::getHttpPath() . "/login.php?logout=true&error=" . $errorMessage . "&errorlink=" . $link);
	exit(0);
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
