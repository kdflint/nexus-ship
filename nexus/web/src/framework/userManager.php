<?php

session_start();

require_once("Util.php");
require_once(Util::getSrcRoot() . "/schedule/Event.php");

if (Util::isSessionValid()) {
	// TODO - this will break if user has > 1 group
	$data = Group::getGroupMembersByGroupId(array_keys($_SESSION['groups'])[0]);
	header('Content-Type: application/json');			
	echo json_encode($data);
} else {
	header("location:" . Util::getHttpPath() . "/index.php");
	exit(0);		
}			

?>

