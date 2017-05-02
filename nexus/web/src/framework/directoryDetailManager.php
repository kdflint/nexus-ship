<?php

session_start();

require_once("Util.php");
require_once(Utilities::getSrcRoot() . "/organization/Catalogue.php");

if (Utilities::isSessionValid()) {

	// TODO - check that this org is in the hierarchy of the parent org? Or use uid instead of id?
	// TODO - format multi-dimensional array and complete output, allowing multiple contacts, etc.
	$cleanOrgId = "";
	if (isset($_GET['id']) && Utilities::validateNetworkIdFormat($_GET['id'])) {
		$cleanOrgId = $_GET['id'];
	} else {
		echo("unauthorized");
		exit(0);
	}		

	$data = Organization::getOrganizationDetailById($cleanOrgId);
	$_SESSION['tmp-editorgid'] = $cleanOrgId;
	header('Content-Type: application/json');			
	echo json_encode($data);
} else {
	header("location:" . Utilities::getHttpPath() . "/nexus.php");
	exit(0);		
}				

?>

