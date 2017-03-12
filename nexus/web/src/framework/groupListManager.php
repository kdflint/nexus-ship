<?php

session_start();

require_once("Util.php");
require_once(Utilities::getSrcRoot() . "/group/Group.php");

//if (Utilities::isSessionValid()) {
if(true) {
	
	$cleanGroupId = "";
	// TODO - check that session user is in group and user is authorized to view this group
	//if (isset($_GET['id']) && ($_GET['id'] === "-1" || Utilities::validateGroupId($_GET['id']))) {
	if (isset($_GET['id'])) {
		$cleanGroupId = $_GET['id'];
	} else {
		echo("unauthorized");
		exit(0);
	}	
	if ($cleanGroupId === "-1") {
		$data = Group::getNetworkMembersbyNetworkId($_SESSION['networkId'], $_SESSION['uidpk']);;
	} else {
		$data = Group::getGroupMembersByGroupId($cleanGroupId, $_SESSION['uidpk']);
	}
	header('Content-Type: application/json');			
	echo json_encode($data);
} else {
	header("location:" . Utilities::getHttpPath() . "/nexus.php");
	exit(0);		
}

?>

