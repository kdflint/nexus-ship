<?php

session_start();

require_once("Util.php");
require_once(Utilities::getSrcRoot() . "/group/Group.php");

if (Utilities::isSessionValid()) {
	// TODO - this will break if user has > 1 group
	$data = Group::getGroupMembersByGroupId($_SESSION['groups'][0]['id'], $_SESSION['uidpk']);
	header('Content-Type: application/json');			
	echo json_encode($data);
} else {
	header("location:" . Utilities::getHttpPath() . "/nexus.php");
	exit(0);		
}			

?>

