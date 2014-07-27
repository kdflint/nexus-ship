<?php

session_start();

error_reporting(E_ALL);
ini_set( 'display_errors','1'); 

require_once dirname(__FILE__).'/forum_sso_functions.php';
require_once ("../model/pgDb.php");

$_SESSION['forumSessionError'] = $_SESSION['authtoken'] = $forumUsername = "";

forumSignout();

$cursor = pgDb::getForumUserByNexusId($_SESSION['uidpk']);
while ($row = pg_fetch_array($cursor)) {
	$forumUsername = $row['username'] . $row['id'];
}
	
// Login user to forum
$user = array();
$user['user'] = $forumUsername;
$login_status = forumSignin($user);
if($login_status == 'Login Successful') {
	$_SESSION['forumSessionError'] = "noError";
} else {
	$_SESSION['forumSessionError'] = $login_status;
}
	
header("location:../view/nexus.php?thisPage=forum");

exit(0);

?>