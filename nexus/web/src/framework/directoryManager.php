<?php

session_start();

require_once("Util.php");
require_once(Utilities::getSrcRoot() . "/organization/Catalogue.php");

if (Utilities::isSessionValid()) {

	$string = "";
	$filters = array();
	
	if (isset($_GET['string']) && strlen($_GET['string']) > 0) { $string = $_GET['string']; }
	// TODO - allow for multiples on these dropdowns
	if (isset($_GET['specialty']) && $_GET['specialty'] > 0) { $filters['specialty'] = $_GET['specialty']; }
	if (isset($_GET['type']) && strcmp($_GET['type'], "0")) { $filters['type'] = $_GET['type']; }
	
	$data = Catalogue::getEntries(array_keys($_SESSION['groups'])[0], $_SESSION['orgId'], $string, $filters);
	header('Content-Type: application/json');			
	echo json_encode($data);
} else {
	header("location:" . Utilities::getHttpPath() . "/nexus.php");
	exit(0);		
}				

?>

