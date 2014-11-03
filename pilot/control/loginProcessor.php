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
	Util::setSession($uid);
	Util::setLogin($_SESSION['uidpk']);
	header("location:../view/nexus.php?thisPage=directory");
	exit(0);	
} else {
	returnToLoginWithError(Util::AUTHENTICATION_ERROR);
}

function returnToLoginWithError($errorMessage) {
	header("location:../view/login.php?error=" . $errorMessage);
	exit(0);
}

?>