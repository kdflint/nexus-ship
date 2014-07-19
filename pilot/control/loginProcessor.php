<?php
require_once dirname(__FILE__).'/forum_sso_functions.php';
include("../model/pgDb.php");
include("util.php");

session_start();

error_reporting(E_ALL);
ini_set( 'display_errors','1'); 

$uid = $_POST['uid'];
$password = $_POST['password'];

$_SESSION['fname'] = 
$_SESSION['lname'] = 
$_SESSION['uidpk'] = 
$_SESSION['forumSessionError'] = 
$_SESSION['orgName'] = 
$_SESSION['networkName'] = 
$_SESSION['orgId'] = 
$_SESSION['grantorId'] = 
$_SESSION['networkId'] = 
$_SESSION['inviteId'] =
$_SESSION['username'] =
"";

$isAuthenticated = Util::authenticate($uid, $password);

if($isAuthenticated){
	
	$_SESSION['username'] = $uid;
	
	$cursor = pgDb::getUserSessionByUsername($_SESSION['username']);
	while ($row = pg_fetch_array($cursor)) {
		// already at SESSION['authtoken'] is the forum SSO token
		$_SESSION['fname'] = $row['fname'];
  	$_SESSION['lname'] = $row['lname'];
  	$_SESSION['orgName'] = $row['affiliation'];
  	$_SESSION['uidpk'] = $row['id'];
  	$_SESSION['networkName'] = $row['network'];
	} 
	
	// Login user to forum
	//$user = array();
	//$user['user'] = $_SESSION['username'];
	//$login_status = forumSignin($user);
	//if($login_status == 'Login Successful') {
	//} else {
	//	$_SESSION['forumSessionError'] = "true";
	//}
	
	header("location:../view/nexus.php");
	exit(0);	
	
		
} else {
	returnToLoginWithError("");
}

function returnToLoginWithError($errorMessage) {
	header("location:../view/login.php?error=" . $errorMessage);
	exit(0);
}

?>