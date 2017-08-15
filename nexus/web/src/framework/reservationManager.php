<?php

session_start();

require_once("Util.php");
require_once(Utilities::getSrcRoot() . "/schedule/Event.php");

$clean['status'] = "1";
if (isset($_GET['status']) && $_GET['status'] === "pending") {
	$clean['status'] = "3";
}

$clean['filter'] = $_SESSION['pgpk'];
if (isset($_GET['filter']) && $_GET['filter'] === "network") {
	$clean['filter'] = $_SESSION['ngpk'];;
}

// TODO - this check causes JSON object parse to be thrown from javascript -- better to tokenize it anyway
	if (Utilities::isSessionValid()) {
		if ($_SESSION['nexusContext'] === "ADV") {
			$data = Event::getFutureEvents($clean['filter'], $_SESSION['timezone'], $_SESSION['uidpk'], $clean['status']);	
		} else {	
			// TODO - this will break if user has > 1 group
			$data = Event::getFutureEvents($_SESSION['groups'][0]['id'], $_SESSION['timezone'], $_SESSION['uidpk']);
		}
		header('Content-Type: application/json');			
		echo json_encode($data);
	} else {
		header("location:" . Utilities::getHttpPath() . "/nexus.php");
		exit(0);		
	}			

?>

