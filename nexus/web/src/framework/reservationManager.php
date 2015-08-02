<?php

session_start();

require_once("Util.php");
require_once(Util::getSrcRoot() . "/schedule/Event.php");

//if (is_ajax()) {
	//if (Util::isSessionValid()) {
		// TODO - this will break if user has > 1 group
		//$data = Event::getFutureEvents($_SESSION['groups'][0]);
		$data = Event::getFutureEvents("1");
		header('Content-Type: application/json');
		echo json_encode($data);					
	//}
//}				
	
//Function to check if the request is an AJAX request
function is_ajax() {
	return isset($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest';
}

?>

