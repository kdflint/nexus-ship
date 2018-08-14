<?php

session_start();

require_once("Util.php");
require_once(Utilities::getSrcRoot() . "/organization/Organization.php");

if (Utilities::isSessionValid()) {

	$cleanOrgId = "";
	if (isset($_GET['id']) && Utilities::validateNetworkIdFormat($_GET['id'])) {
		$cleanOrgId = $_GET['id'];
	} else {
		echo("unauthorized");
		exit(0);
	}		

	$data = Organization::getProgramDetailByOrgId($cleanOrgId);
	header('Content-Type: application/json');			
	echo json_encode($data);
} else {
	header("location:" . Utilities::getHttpPath() . "/nexus.php");
	exit(0);		
}				

?>

