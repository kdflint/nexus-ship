<?php

session_start();

require_once("../../../src/framework/Util.php");

// Cleanse all user input

$dirty = array('username' => $_POST['uid'], 'password1' => $_POST['password1'], 'password2' => $_POST['password2'], 'fname' => $_POST['fname'], 'lname' => $_POST['lname'], 'email' => $_POST['email']);
$clean = array();
$validInvitation = false;
			
$result = Util::validateUserProfile($dirty, TRUE);

if (isset($_SESSION['invitation'] && Util::validateUuid($_SESSION['invitation'])) {
	if (Invitation::isInvitationOpen($_SESSION['invitation'])) {
		$result['good']['invitation'] = $_SESSION['invitation'];
		$validInvitation = true;
	}
}

if (!$validInvitation || count($result['error']) > 0) {
	print_r($result['error']); exit(0);
	//header("location:" . Util::getHttpPath() . "/login.php?logout=true");
	exit(0);
}

$clean = $result['good'];

/* ====================================================

Use only clean input beyond this point (i.e. $clean[])

======================================================= */

	
	// TODO: make sure username is unique inside network
	// TODO: activate only on confirmed email code
	// TODO: insert other user values into db
	
	
$cursor = Invitation::getOpenInvitationByUuid($_SESSION['invitation']);
$invitation = pg_fetch_row($cursor);
$uidpk = User::addActiveUser(
	Util::newUuid(),
	$clean['username'],
	$clean['fname'],
	$clean['fname'],
	$clean['email'],
	$clean['password']
	);
	
User::addUserOrgRelation($uidpk, $invitation['orgid'], $invitation['grantorid']);
	
User::addUserGroupRelation($uidpk, $invitation['groupid'], $invitation['roleid']);
	
$isAuthenticated = true;
	
$cursor = pgDb::getUsernamesByEmail($email);
$usernames = "";
while ($row = pg_fetch_array($cursor)) {
	if (strcmp($row['username'], $uid)) {
		$usernames = $usernames . $row['username'] . ", ";
	}
}


sendConfirmationEmail($clean['email'], $clean['fname'], $clean['username'], $usernames);
	
Util::destroySession();
	
// LEFT OFF

// consume invitation

// go through login.php???

	// have login.php check for $_SESSION['invitation'] and also for first-time login field
	// if exists, do something similar to remember
	
if($isAuthenticated){
	Util::setSession($clean['username'], FALSE, $clean['tz']);
	Util::setLogin($_SESSION['uidpk']);
	header("location:" . Util::getHttpPath() . "/index.php");
	exit(0);	
} else {
	returnToLoginWithError(Util::AUTHENTICATION_ERROR);
}	
		
	
function returnToEnrollWithError($errorMessage) {
	global $cleanInvite;
	header("location:../view/enroll.php?invitation=" . $cleanInvite . "&error=" . $errorMessage);
	exit(0);
}

function sendConfirmationEmail($email, $path, $fname, $username, $allUsernames) {
	
	$multiples = "";
	if (strlen($allUsernames) > 3) {
		$multiples = "
		
Note: There are other usernames currently enrolled with this email address: " . Util::stripTrailingComma($allUsernames);
	}
	$message = "Welcome " . $fname . "!
	
Your enrollment is complete for username: " . $username . $multiples . "
	
You are now enabled to collaborate with the " . $_SESSION['groupName'] . " hosted by " . $_SESSION['networkName'] . ".

This tool is built by committed volunteers working hard to build web resources for organizations that make a positive difference in our communities.

Nexus is constantly being tweaked and new features added. If you have a suggestion for a feature or find a bug please let us know using the feedback tools on the site. We strive to make Nexus as helpful as possible for you.

Some of our current features:

- Discussion Forum and Calendar
- Directory of People and Organizations
- Private Messaging
- Virtual Conference Room

We are working hard on adding:

- Collaboration Tracking
- Advanced Mapping functions

You can login to Nexus using this link. You may wish to check the Help document right away for some information about how to use this site.

http://northbridgetech.org/" . $path . "/nexus/view/login.php?network=" . $_SESSION['networkId'] . "

Enjoy,

The Development Team at
NorthBridge Technology Alliance

P.S. May we recommend that you visit the Profile tab first to set your messaging settings? Then, you may wish to subscribe to one or more discussions on the Forum tab.";

		mail($email, "[Nexus] Enrollment Confirmation", $message, "From: noreply@nexus.northbridgetech.org\r\n");		
		
}



?>