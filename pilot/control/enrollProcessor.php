<?php

session_start();

error_reporting(E_ALL);
ini_set( 'display_errors','1'); 

require_once ("../model/pgDb.php");
require_once ("../control/util.php");
require_once dirname(__FILE__).'/forum_sso_functions.php';

// TODO: leverage util method (see profileProcessor.php line 17)

if (!isset($_POST['userid']) || strlen($_POST['userid']) < 1) {
	returnToEnrollWithError("Please choose your username");
}

if (!isset($_POST['password']) || strlen($_POST['password']) < 1) {
	returnToEnrollWithError("Please choose your password");
}

if (!Util::validateEmail($_POST['email'])) {
	// TODO: test this method against email specs - am i open to script injection if i pass this test??
	returnToEnrollWithError("Please enter a valid email address.");
}

if (!isset($_POST['fname']) || strlen($_POST['fname']) < 1) {
	returnToEnrollWithError("Please enter your first name.");
}

// TODO: strategy for decon on this user input
$uid = $_POST['userid'];
$password = $_POST['password'];
$fname = $_POST['fname'];
$lname = $_POST['lname'];
$email = $_POST['email'];

$validInvitation = $isAuthenticated = false;

$_SESSION['fname'] = $_SESSION['lname'] = $_SESSION['uidpk'] = $_SESSION['forumSessionError'] = $_SESSION['username'] = "";

if(strlen($_SESSION['inviteId']) == 36) {
	if (pgDb::checkValidInvitation($_SESSION['inviteId'])) {
		$validInvitation = true;
	}
}

if ($validInvitation){
	// Insert user into db
	
	// TODO: make sure username is unique inside network
	// TODO: activate only on confirmed email code
	// TODO: insert other user values into db
		
	$_SESSION['uidpk'] = pgDb::insertActiveUser(Util::newUuid(), $uid, $fname, $lname, $email, $password);
	pgDb::insertUserOrgRelation($_SESSION['uidpk'], $_SESSION['orgId'], $_SESSION['grantorId']);
	$row3 = pg_fetch_array(pgDb::getOrganizationById($_SESSION['orgId']));
	$orgName = $row3['name'];
	$isAuthenticated = true;
		
	$row4 = pg_fetch_row(pgDb::forumEmailExists($email));
	$emailMatch = $row4[0];
	if (!strcmp($emailMatch, "t")) {
		// This user is enrolling with a duplicate email address, which is legal for Nexus but not for Website Toolbox Forum.
		// Take evasive action so they do not feel an error and follow up by email.
		$email = $_SESSION['uidpk'] . "." . $email;
		mail("contact@northbridgetech.org", "Duplicate attempt for forum email", "User id " . $_SESSION['uidpk'] . " has attempted to enroll with a duplicate forum email address. Please advise.", "From: contact@northbridgetech.org");
	}
	
	$forumUsername = $fname . " " . $lname;
	
	$row5 = pg_fetch_row(pgDb::forumUsernameExists($forumUsername));
	$nameMatch = $row5[0];
	if (!strcmp($nameMatch, "t")) {
		// This user is enrolling with a duplicate forum username.
		// Take evasive action so they do not feel an error.
		$forumUsername = $forumUsername . " " . $_SESSION['uidpk'];
	}	
	
	$row2 = pg_fetch_row(pgDb::insertUserForumRelation($_SESSION['uidpk'], $fname, $password, $forumUsername, $email));
	$forumId = $row2[0];
	
	// TODO: add EDC
	$forumGroupId = array("14" => "710056", "18" => "710056");

	// Register user with forum
	$user = array();
	//$user['member'] = $fname.$forumId;
	$user['member'] = $forumUsername;
	$user['pw'] = $password;
	$user['email'] = $email;	
	//$user['name'] = $fname . " " . $lname;
	// TOD: This will only work if we know organization from invitation. Else we have to put off enrollment until we get the org identified.
	$user['name'] = $orgName;
	$user['usergroupid'] = $forumGroupId[$_SESSION['networkId']];
	$register_status = forumSignup($user);
	if($register_status == 'Registration Complete') {
		$_SESSION['forumSessionError'] = "noError";
	} else {
		$_SESSION['forumSessionError'] = $register_status;
	}
		
	if($isAuthenticated){
		
		$cursor = pgDb::getUserByUsername($uid);
		$_SESSION['username'] = $uid;
		
		// bizarro php bug: https://bugs.php.net/bug.php?id=31750
		// can't specify PGSQL_ASSOC as one might like, but this works
		while ($row = pg_fetch_array($cursor)) {
			$_SESSION['fname'] = $row['fname'];
  		$_SESSION['lname'] = $row['lname'];
  		$_SESSION['password'] = $row['password'];
		}

		header("location:../view/nexus.php?thisPage=profile");
		exit(0);
		
	
	} else {
		header("location:../view/login.php");
		exit(0);	
	}
	
} else {
	header("location:../view/login.php");
	exit(0);	
}


	
function returnToEnrollWithError($errorMessage) {
	header("location:../view/enroll.php?error=" . $errorMessage);
	// TODO: Call session_destroy() here??
	exit(0);
}

?>