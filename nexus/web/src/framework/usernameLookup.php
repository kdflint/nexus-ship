<?php

session_start();

require_once("Util.php");
require_once(Utilities::getSrcRoot() . "/user/User.php");

$cleanUsername = "";
//if (isset($_GET['username']) && Utilities::validateUsernameFormat($_GET['username'])) {
if (Utilities::validateUsernameFormat($_GET['username'])) {
	$cleanUsername = $_GET['username'];
	if (User::userNameExists($cleanUsername)) {
		header('Content-Type: application/json');			
		echo json_encode(array('username-status' => 'dupe'));		
	} else {
		header('Content-Type: application/json');			
		echo json_encode(array('username-status' => 'unique'));	
	}
} else {
	header('Content-Type: application/json');			
	echo json_encode(array('username-status' => 'invalid'));			
}

?>

