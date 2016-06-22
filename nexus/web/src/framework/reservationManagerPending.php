<?php

// TODO This file is only temporary - refactor and delete soon

session_start();

require_once("Util.php");
require_once(Utilities::getSrcRoot() . "/schedule/Event.php");

// TODO - this check causes JSON object parse to be thrown from javascript -- better to tokenize it anyway
//if (Utilities::is_ajax()) {
	if (Utilities::isSessionValid()) {
		// TODO - This is customized for CFHT!
		$data = Event::getFutureEvents(array_keys("18" ,$_SESSION['timezone'], $_SESSION['uidpk'], "3");
		header('Content-Type: application/json');			
		echo json_encode($data);
	} else {
		header("location:" . Utilities::getHttpPath() . "/nexus.php");
		exit(0);		
	}			
//}	

?>

