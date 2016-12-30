<?php

require_once("../../src/framework/Util.php");
require_once(Utilities::getModulesRoot() . "/forum/forum_integration.php");

session_start();
$user->session_begin();

if (Utilities::isSessionValid()) {
	$isForumSessionValid = $user->data['username'] === $_SESSION['username'] ? true : false;
	header('Content-Type: application/json');			
	echo json_encode(array('isSessionValid' => $isForumSessionValid));
} else {
	header("location:" . Utilities::getHttpPath() . "/nexus.php");
	exit(0);		
}			

?>

