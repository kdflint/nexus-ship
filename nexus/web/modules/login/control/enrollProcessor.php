<?php

session_start();

require_once("../../../src/framework/Util.php");
require_once(Utilities::getSrcRoot() . "/user/Invitation.php");
require_once(Utilities::getSrcRoot() . "/group/Group.php");
require_once(Utilities::getSrcRoot() . "/organization/Organization.php");
require_once(Utilities::getSrcRoot() . "/message/ExternalMessage.php");
require_once(Utilities::getModulesRoot() . "/login/control/MessageEnrollment.php");
require_once(Utilities::getPhpRoot() . "/Log.php");

$conf = array('append' => true, 'mode' => 0644, 'timeFormat' => '%X %x');
$logger = Log::singleton("file", Utilities::getLogRoot() . "/forum_activity.log", "", $conf, PEAR_LOG_INFO);

// Cleanse all user input

$dirty = array('username' => $_POST['uid'], 'password1' => $_POST['password1'], 'password2' => $_POST['password2'], 'fname' => $_POST['fname'], 'lname' => $_POST['lname'], 'email' => $_POST['email']);
$clean = array();
$validInvitation = false;
			
$result = Utilities::validateUserProfile($dirty, TRUE);

if (isset($_SESSION['invitation']) && Utilities::validateUuid($_SESSION['invitation'])) {
	if (Invitation::isInvitationOpen($_SESSION['invitation'])) {
		$validInvitation = true;
	} else {
	}
}

if (!$validInvitation || count($result['error']) > 0) {
	if ($result['error']['username'] == Utilities::VALIDATION_USERNAME_DUPE_ERROR)  {
		echo(Utilities::VALIDATION_USERNAME_DUPE_ERROR);
	} else {
		print_r($result['error']);
		//header("location:" . Utilities::getHttpPath() . "/login.php?logout=true");
		exit(0);
	}
}

$clean = $result['good'];
$clean['group-enroll'] = array();

if (isset($_POST['group-enroll'])) {
	foreach($_POST['group-enroll'] as $groupid) {
		// check for valid value and assign to $clean['group-enroll']]
		array_push($clean['group-enroll'],$groupid);
	}
}

/* ====================================================

Use only clean input beyond this point (i.e. $clean[])

======================================================= */


	// TODO: make sure username is unique inside network
	// TODO: activate only on confirmed email code
	// TODO: insert other user values into db

$_SESSION['username'] = $clean['username'];	

$invitation = pg_fetch_array(Invitation::getInvitationByUuid($_SESSION['invitation']));

$uidpk = User::addActiveUser(
	Utilities::newUuid(),
	$clean['username'],
	$clean['fname'],
	$clean['lname'],
	$clean['email'],
	$clean['password']
	);

User::addUserOrgRelation($uidpk, $invitation['orgid'], $invitation['grantorid'], $invitation['roleid']);
$forumEnrollments = array();

if (isset($clean['group-enroll'])) {
	foreach ($clean['group-enroll'] as $groupId) {
		User::addUserGroupRelation($uidpk, $groupId, $invitation['roleid']);
		// TODO - put this in User class
		array_push($forumEnrollments, Group::getForumGroupIdByGroupId($groupId));
	}
} else if (isset($invitation['groupid'])) {
	User::addUserGroupRelation($uidpk, $invitation['groupid'], $invitation['roleid']);
	array_push($forumEnrollments, Group::getForumGroupIdByGroupId($invitation['groupid']));
}
	
if ($invitation['type'] === 'single') {
	// TODO - put this in Invitation method
	Invitation::consumeInvitationByUuid($_SESSION['invitation']);
}

require_once(Utilities::getSrcRoot() . "/group/Forum.php");

// NOTE - this also Forum-enrolls all Nexus Web Meet enrollees! Correct??
$addedUserId = Forum::enrollUser($clean['username'], $clean['username']);
if ($addedUserId) {
	// TODO - loop this properly
	// This group is global for everyone (REGISTERED group in phpBB3)
	$groupId = Utilities::getForumRegisteredUserGroup();
	$groupResult = Forum::addUserToGroupById($addedUserId, $groupId);
	if (!$groupResult) {
	} else {
		$logger->log("Fail on add user " . $addedUserId . ":" . $clean['username'] . " to REGISTERED group ", PEAR_LOG_INFO);
	}
	
	// TODO - this should be an array pre-populated
	// This is the network-specific forum group, 1 per network
	$groupId = Organization::getForumUserGroupByOrgId($invitation['orgid']);
	$groupResult = Forum::addUserToGroupById($addedUserId, $groupId);
	if (!$groupResult) {
	} else {
		$logger->log("Fail on add user " . $addedUserId . ":" . $clean['username'] . " to NETWORK group ", PEAR_LOG_INFO);
	}	
	
	Forum::updateUserProfile($clean['username'], $clean['fname'], $clean['lname'], "", $clean['email'], "");
	
	foreach ($forumEnrollments as $forumId) {
		ExternalMessage::addForumSubscription($addedUserId, $forumId);	
	}
	
} else {
	$logger->log("Fail on add user " . $addedUserId . ":" . $clean['username'], PEAR_LOG_INFO);
}
	
$group = Group::getGroupById($invitation['groupid']);
$groupName = $group[0]['name'];
	
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