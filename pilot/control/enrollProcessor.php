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

$_SESSION['fname'] = $_SESSION['lname'] = $_SESSION['uidpk'] = $_SESSION['forumSessionError'] = "";

if(strlen($_SESSION['inviteId']) == 36) {
	if (pgDb::checkValidInvitation($_SESSION['inviteId'])) {
		$validInvitation = true;
	}
}

if ($validInvitation){
	// Insert user into db
	
	// TODO: make sure username is unique inside network, right, ??
	// TODO: activate only on confirmed email code
	// TODO: insert other user values into db
	$cursor1 = pgDb::insertActiveUser(Util::newUuid(), $uid, $password, $fname, $lname, $email);
	$row1 = pg_fetch_row($cursor1);
	$_SESSION['uidpk'] = $row1[0];
	pgDb::insertUserOrgRelation($_SESSION['uidpk'], $_SESSION['orgId'], $_SESSION['grantorId']);
	$isAuthenticated = true;
	
	// TODO; take out 14
	$forumGroupId = array("14" => "710056", "18" => "710056");
	
	// Register user with forum
	$user = array();
	$user['member'] = $uid;
	$user['pw'] = $password;
	// TODO: add check that this email address is not already registered with the forum!!
	$user['email'] = $email;	
	//$user['name'] = $fname . " " . $lname . " (" . $_SESSION['orgName']  . ")";
	$user['name'] = $fname . " " . $lname;
	$user['usergroupid'] = $forumGroupId[$_SESSION['networkId']];
	//$user['profilefieldid'] = "328241";
	$register_status = forumSignup($user);
	if($register_status == 'Registration Complete') {
		$_SESSION['forumSessionError'] = "noError";
	} else {
		$_SESSION['forumSessionError'] = $register_status;
	}
		
	if($isAuthenticated){
		
		$cursor = pgDb::getUserByUsername($uid);
		
		// bizarro php bug: https://bugs.php.net/bug.php?id=31750
		// can't specify PGSQL_ASSOC as one might like, but this works
		while ($row = pg_fetch_array($cursor)) {
			$_SESSION['fname'] = $row['fname'];
  		$_SESSION['lname'] = $row['lname'];
		}
		
		//$user = array();
		//$user['user'] = $uid;
		//$login_status = forumSignin($user);
		//if($login_status == 'Login Successful') {
		//	$_SESSION['forumSessionError'] = "noError";
		//} else {
		//	$_SESSION['forumSessionError'] = $login_status;
		//}
		
		// TODO: focus on user profile
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
	exit(0);
}

?>