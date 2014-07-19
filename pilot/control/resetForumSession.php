<?php

session_start();

error_reporting(E_ALL);
ini_set( 'display_errors','1'); 

require_once dirname(__FILE__).'/forum_sso_functions.php';

$_SESSION['forumSessionError'] = $_SESSION['authtoken'] = "";

forumSignout();
	
// Login user to forum
$user = array();
$user['user'] = $_SESSION['username'];
$login_status = forumSignin($user);
if($login_status == 'Login Successful') {
} else {
	$_SESSION['forumSessionError'] = "true";
}
	
header("location:../view/nexus.php?thisPage=forum");

exit(0);

?>