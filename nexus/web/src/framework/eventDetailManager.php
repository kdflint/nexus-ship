<?php

session_start();

require_once("Util.php");
require_once(Utilities::getSrcRoot() . "/schedule/Event.php");

$cleanUuid = "";
if (isset($_GET['uuid']) && Utilities::validateUuid($_GET['uuid'])) {
	$cleanUuid = $_GET['uuid'];
}

if (Utilities::isSessionValid()) {
	$data = Event::getEventDetail($cleanUuid, $_SESSION['timezone'], $_SESSION['uidpk']);
	header('Content-Type: application/json');			
	echo json_encode($data);
} else {
	header("location:" . Utilities::getHttpPath() . "/nexus.php");
	exit(0);		
}			

?>

