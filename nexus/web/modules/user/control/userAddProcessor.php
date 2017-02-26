<?php

session_start();

require_once("../../../src/framework/Util.php");
require_once(Utilities::getSrcRoot() . "/user/Invitation.php");
require_once(Utilities::getModulesRoot() . "/user/control/MessageInvitation.php");

// TODO - put authorization checker, session checker, error handling, etc. in a central place. These should go at the top of every processor.

if (!Utilities::isSessionValid()) {
	header("location:" . Utilities::getHttpPath() . "/nexus.php");
	exit(0);
}

$dirty = array('fname' => $_POST['fname'], 'email' => $_POST['email']);
$clean = array();

if (isset($dirty['fname']) && strlen($dirty['fname']) <= 50) {
	$clean['fname'] = Utilities::sanitize($dirty['fname']);
} else {
	returnToLoginWithError("");
}

if (isset($dirty['email']) && Utilities::validateEmail($dirty['email'])) {
	$clean['email'] = $dirty['email'];
} else {
	returnToLoginWithError("");
}

$clean['admin'] = (isset($_POST['admin']) ? 4 : 5);

/* ====================================================

Use only clean input beyond this point (i.e. $clean[])

======================================================= */

$inviteUuid = Invitation::addInvitation($clean['email'], $_SESSION['groups'][0]['id'], $clean['admin'], $_SESSION['uidpk'], $_SESSION['orgId']);

$salutation = Utilities::stripTrailingSpace('Hello ' . $clean['fname']);

$messageBody =  $salutation . ',\r\n\r\nYou have been added to the Nexus Web Conference team ' . $_SESSION['groups'][0]['name'] . '\r\n\r\nPlease follow this link to complete your enrollment:\r\n\r\n' . Utilities::getHttpPath() . '/enroll.php?invitation=' . $inviteUuid . '\r\n\r\nThe Development Team at\r\nNorthBridge Technology Alliance';
$message = new MessageInvitation($clean['email'], $messageBody);
$message->send();
	
header("location:" . Utilities::getHttpPath() . "/nexus.php?view=team");
exit(0);

function returnToLoginWithError($errorMessage) {
	header("location:" . Utilities::getHttpPath() . "/login.php?logout=true&error=". $errorMessage);
	exit(0);
}

?>