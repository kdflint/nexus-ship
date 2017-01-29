<?php

session_start();

require_once("../../../src/framework/Util.php");
require_once(Utilities::getSrcRoot() . "/user/Invitation.php");
require_once(Utilities::getSrcRoot() . "/group/Group.php");
require_once(Utilities::getModulesRoot() . "/login/control/MessageEnrollment.php");

// Cleanse all user input

$dirty = array('username' => $_POST['uid'], 'password1' => $_POST['password1'], 'password2' => $_POST['password2'], 'fname' => $_POST['fname'], 'lname' => $_POST['lname'], 'email' => $_POST['email']);
$clean = array();
$validInvitation = false;
			
$result = Utilities::validateUserProfile($dirty, TRUE);

if (isset($_SESSION['invitation']) && Utilities::validateUuid($_SESSION['invitation'])) {
	if (Invitation::isInvitationOpen($_SESSION['invitation'])) {
		$validInvitation = true;
	}
}

if (!$validInvitation || count($result['error']) > 0) {
	if ($result['error']['username'] == Utilities::VALIDATION_USERNAME_DUPE_ERROR)  {
		returnToEnrollWithError($result['error']['username']);
	} else {
		echo print_r($result['error']);
		//header("location:" . Utilities::getHttpPath() . "/login.php?logout=true");
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
	Utilities::newUuid(),
	$clean['username'],
	$clean['fname'],
	$clean['lname'],
	$clean['email'],
	$clean['password']
	);

User::addUserOrgRelation($uidpk, $invitation['orgid'], $invitation['grantorid'], $invitation['roleid']);
	
User::addUserGroupRelation($uidpk, $invitation['groupid'], $invitation['roleid']);

/*

$forumGroupId = Group::getForumGroupIdByGroupId($invitation['groupid']);
Forum::enrollUser($clean['username'], $forumGroupId);

*/

Invitation::consumeInvitationByUuid($_SESSION['invitation']);

$row = pg_fetch_array(Group::getGroupById($invitation['groupid']));
$groupName = array_values($row)[1];
	
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
	header("location:" . Utilities::getHttpPath() . "/login.php");
	exit(0);	
} else {
	returnToEnrollWithError(Utilities::ENROLLMENT_ERROR);
}	
		
function returnToEnrollWithError($errorMessage) {
	//echo Utilities::getHttpPath() . "/enroll.php?invitation=" . $_SESSION['invitation'] . "&error=" . $errorMessage;
	header("location:" . Utilities::getHttpPath() . "/enroll.php?invitation=" . $_SESSION['invitation'] . "&error=" . $errorMessage);
	exit(0);
}

function sendConfirmationEmail($email, $fname, $username, $allUsernames, $groupName, $orgid) {
	
	$multiples = "";
	if (strlen($allUsernames) > 3) {
		$multiples = '\r\n\r\nNote: There are other usernames currently enrolled with this email address: ' . Utilities::stripTrailingComma($allUsernames);
	}
	$messageBody = 'Welcome ' . $fname . '!\r\n\r\nYour Nexus enrollment is complete for username: ' . $username . $multiples . '\r\n\r\nYou are now enabled to collaborate with your team.\r\n\r\nYou can login to Nexus using this link.\r\n\r\n' . Utilities::getHttpPath() . '/login.php?oid=' . $orgid . '\r\n\r\nSincerely,\r\n\r\nThe Development Team at\r\nNorthBridge Technology Alliance';
	$message = new MessageEnrollment($email, $messageBody);
	$message->send();
		
}

?>