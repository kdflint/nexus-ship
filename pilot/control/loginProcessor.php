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

$isAuthenticated = Util::authenticate($uid, $password);

if($isAuthenticated){
	
	session_regenerate_id(TRUE);
	
	$_SESSION['groups'] = array();
	
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