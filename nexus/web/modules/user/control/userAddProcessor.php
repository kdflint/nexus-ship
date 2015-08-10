<?php

session_start();

require_once("../../../src/framework/Util.php");
require_once(Util::getSrcRoot() . "/user/Invitation.php");

// TODO - put authorization checker, session checker, error handling, etc. in a central place. These should go at the top of every processor.

if (!Util::isSessionValid()) {
	header("location:" . Util::getHttpPath() . "/index.php");
	exit(0);
}

$dirty = array('fname' => $_POST['fname'], 'email' => $_POST['email']);
$clean = array();

if (isset($dirty['fname']) && strlen($dirty['fname']) <= 50) {
	$clean['fname'] = Util::sanitize($dirty['fname']);
} else {
	returnToLoginWithError("");
}

if (isset($dirty['email']) && Util::validateEmail($dirty['email'])) {
	$clean['email'] = $dirty['email'];
} else {
	returnToLoginWithError("");
}

$clean['admin'] = (isset($_POST['admin']) ? 4 : 5);

/* ====================================================

Use only clean input beyond this point (i.e. $clean[])

======================================================= */

$inviteUuid = Invitation::addInvitation($clean['email'], array_keys($_SESSION['groups'])[0], Util::newUuid(), $clean['admin'], $_SESSION['uidpk'], $_SESSION['orgId']);

if (Invitation::isInvitationOpen($inviteUuid)) {
	$message = "Hello " . $clean['fname'] . ",
	
You have been added to the team.

To complete your enrollment, click here:" . $inviteUuid . "

The Support Team at
NorthBridge Technology Alliance";

	mail($clean['email'], "[Nexus] Enrollment Notification", $message, "From: noreply@nexus.northbridgetech.org");
}

header("location:" . Util::getHttpPath() . "/index.php");
exit(0);

function returnToLoginWithError($errorMessage) {
	header("location:" . Util::getHttpPath() . "/login.php?logout=true&error=". $errorMessage);
	exit(0);
}

?>