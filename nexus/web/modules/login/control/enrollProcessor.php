<?php

session_start();

require_once("../../../src/framework/Util.php");
require_once(Util::getSrcRoot() . "/user/Invitation.php");
require_once(Util::getSrcRoot() . "/group/Group.php");
require_once(Util::getModulesRoot() . "/login/control/MessageEnrollment.php");

// Cleanse all user input

$dirty = array('username' => $_POST['uid'], 'password1' => $_POST['password1'], 'password2' => $_POST['password2'], 'fname' => $_POST['fname'], 'lname' => $_POST['lname'], 'email' => $_POST['email']);
$clean = array();
$validInvitation = false;
			
$result = Util::validateUserProfile($dirty, TRUE);

if (isset($_SESSION['invitation']) && Util::validateUuid($_SESSION['invitation'])) {
	if (Invitation::isInvitationOpen($_SESSION['invitation'])) {
		$validInvitation = true;
	}
}

if (!$validInvitation || count($result['error']) > 0) {
	if ($result['error']['username'] == Util::VALIDATION_USERNAME_DUPE_ERROR)  {
		returnToEnrollWithError($result['error']['username']);
	} else {
		echo print_r($result['error']);
		//header("location:" . Util::getHttpPath() . "/login.php?logout=true");
		exit(0);
	}
}

$clean = $result['good'];

/* ====================================================

Use only clean input beyond this point (i.e. $clean[])

======================================================= */

	
	// TODO: make sure username is unique inside network
	// TODO: activate only on confirmed email code
	// TODO: insert other user values into db

$_SESSION['username'] = $clean['username'];	

$invitation = pg_fetch_array(Invitation::getOpenInvitationByUuid($_SESSION['invitation']));

$uidpk = User::addActiveUser(
	Util::newUuid(),
	$clean['username'],
	$clean['fname'],
	$clean['lname'],
	$clean['email'],
	$clean['password']
	);

User::addUserOrgRelation($uidpk, $invitation['orgid'], $invitation['grantorid'], $invitation['roleid']);
	
User::addUserGroupRelation($uidpk, $invitation['groupid'], $invitation['roleid']);

Invitation::consumeInvitationByUuid($_SESSION['invitation']);

$row = pg_fetch_array(Group::getGroupById($invitation['groupid']));
$groupName = $row['name'];
	
$isAuthenticated = true;
	
$cursor = User::getUsernamesByEmail($clean['email']);
$usernames = "";
while ($row = pg_fetch_array($cursor)) {
	if (strcmp($row['username'], $clean['username'])) {
		$usernames = $usernames . $row['username'] . ", ";
	}
}

sendConfirmationEmail($clean['email'], $clean['fname'], $clean['username'], $usernames, $groupName, $invitation['uid']);

if($isAuthenticated){
	header("location:" . Util::getHttpPath() . "/login.php");
	exit(0);	
} else {
	returnToEnrollWithError(Util::ENROLLMENT_ERROR);
}	
		
function returnToEnrollWithError($errorMessage) {
	//echo Util::getHttpPath() . "/enroll.php?invitation=" . $_SESSION['invitation'] . "&error=" . $errorMessage;
	header("location:" . Util::getHttpPath() . "/enroll.php?invitation=" . $_SESSION['invitation'] . "&error=" . $errorMessage);
	exit(0);
}

function sendConfirmationEmail($email, $fname, $username, $allUsernames, $groupName, $orgid) {
	
	$multiples = "";
	if (strlen($allUsernames) > 3) {
		$multiples = '\r\n\r\nNote: There are other usernames currently enrolled with this email address: ' . Util::stripTrailingComma($allUsernames);
	}
	$message = 'Welcome ' . $fname . '!\r\n\r\nYour Nexus enrollment is complete for username: ' . $username . $multiples . '\r\n\r\nYou are now enabled to collaborate with ' . $groupName . '\r\n\r\nYou can login to Nexus using this link.\r\n\r\n' . Util::getHttpPath() . '/login.php?oid=' . $orgid . '\r\n\r\nSincerely,\r\n\r\nThe Development Team at\r\nNorthBridge Technology Alliance';
	echo $message;
	$message = new MessageEnrollment($email, $message);
	$message->send();
		
}

?>