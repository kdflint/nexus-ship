<?php

error_reporting(E_ALL);
ini_set( 'display_errors','1'); 

require_once dirname(__FILE__).'/forum_sso_functions.php';

include("../model/pgDb.php");
include("../control/util.php");

session_start();

$uid = Util::strip($_POST['userid']);
$password = Util::strip($_POST['password']);
$validInvitation = $isAuthenticated = false;

$_SESSION['fname'] = $_SESSION['lname'] = $_SESSION['uidpk'] = "";

if(strlen($_SESSION['inviteId']) == 36) {
	if (pgDb::checkValidInvitation($_SESSION['inviteId'])) {
		$validInvitation = true;
	}
}

if ($validInvitation){
	// TODO: register them with forum - I think we need to collect the email here <== LEFT OFF HERE
	// TODO: make sure username is unique inside network, right, ??
	// TODO: activate only on confirmed email code
	$cursor1 = pgDb::insertActiveUserByCredentials(Util::newUuid(), $uid, $password);
	$row1 = pg_fetch_row($cursor1);
	$_SESSION['uidpk'] = $row1[0];
	pgDb::insertUserOrgRelation($_SESSION['uidpk'], $_SESSION['orgId'], $_SESSION['grantorId']);
	$isAuthenticated = true;
} else {
	header("location:../view/login.php");
	exit(0);	
}

if($isAuthenticated){
	//include("forumLoginProcessor.php");
	$user = array();
	$user['user'] = "ada";
	$login_status = forumSignin($user);
	if($login_status == 'Login Successful') {
	// TODO: do form login
	//if (true) {
		$cursor1 = pgDb::getUserByUsername($uid);
		while ($row1 = mysql_fetch_array($cursor1, MYSQL_BOTH)) {
			// already at SESSION['authtoken'] is the forum SSO token
			// TODO: take these from named columns
			$_SESSION['fname'] = $row1['fname'];
  		$_SESSION['lname'] = $row1['lname'];
		} 
		// TODO: location to nexus.php focus on user profile (and require name to leave?)
		header("location:../view/nexus.php");
		exit(0);
	} else {
		returnToLoginWithError("Forum login failed: " . $login_status);
		exit(0);
	}
} else {
	header("location:../view/login.php");
	exit(0);	
}


function returnToLoginWithError($errorMessage) {
	header("location:login.php?error=" . $errorMessage);
}

?>