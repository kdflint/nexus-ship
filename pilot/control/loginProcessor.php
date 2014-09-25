<?php

session_start();

//require_once dirname(__FILE__).'/forum_sso_functions.php';
include("../model/pgDb.php");
include("util.php");
require_once 'error/handlers.php';

//error_reporting(E_ALL);
//ini_set( 'display_errors','1'); 

$uid = $_POST['uid'];
$password = $_POST['password'];

$_SESSION['fname'] = 
$_SESSION['lname'] = 
$_SESSION['uidpk'] = 
$_SESSION['email'] = 
$_SESSION['forumSessionError'] = 
$_SESSION['orgName'] = 
$_SESSION['networkName'] = 
$_SESSION['orgId'] = 
$_SESSION['networkId'] = 
$_SESSION['inviteId'] =
$_SESSION['username'] =
$_SESSION['password'] =
$_SESSION['roomLink'] = 
$_SESSION['logo'] = 
"";

$_SESSION['groups'] = array();

$isAuthenticated = Util::authenticate($uid, $password);

if($isAuthenticated){
	
	$_SESSION['username'] = $uid;
	
	$cursor = pgDb::getUserSessionByUsername($_SESSION['username']);
	
	while ($row = pg_fetch_array($cursor)) {
		$_SESSION['fname'] = $row['fname'];
  	$_SESSION['lname'] = $row['lname'];
  	$_SESSION['orgName'] = $row['affiliation'];
  	$_SESSION['uidpk'] = $row['id'];
  	$_SESSION['networkName'] = $row['network'];
  	// TODO: Make this dynamic once method decisions network id correctly (see pgDb.php)
  	$_SESSION['networkId'] = '18'; // $row['networkid'];
  	$_SESSION['password'] = $row['password'];
  	$_SESSION['roomLink'] = $row['link'];
  	$_SESSION['logo'] = $row['logo'];
  	$_SESSION['email'] = $row['email'];
	} 
	
	$_SESSION['groups'] = pgDb::getUserGroupsByUsername($_SESSION['username']);

	Util::setLogin($_SESSION['uidpk']);
	
	header("location:../view/nexus.php?thisPage=directory");
	exit(0);	
	
		
} else {
	returnToLoginWithError("");
}

function returnToLoginWithError($errorMessage) {
	header("location:../view/login.php?error=" . $errorMessage);
	exit(0);
}

?>