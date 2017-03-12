<?php

session_start();

require_once("Util.php");
require_once(Utilities::getSrcRoot() . "/user/User.php");

if (Utilities::isSessionValid()) {
	
	$cleanGroupId = $cleanUserName = "";
	// TODO - check that session user is in group and user is authorized to view this group
	if (isset($_GET['groupid']) && isset($_GET['username'])) {
		$cleanGroupId = $_GET['groupid'];
		$cleanUserName = $_GET['username'];
	} else {
		echo("unauthorized");
		exit(0);
	}	
	User::removeUserGroupRelationbyUsername($cleanUserName, $cleanGroupId);
} else {
	header("location:" . Utilities::getHttpPath() . "/nexus.php");
	exit(0);		
}

?>

