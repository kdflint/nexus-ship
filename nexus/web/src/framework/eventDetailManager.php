<?php

set_time_limit(10);

session_start();

require_once("Util.php");
require_once(Utilities::getSrcRoot() . "/schedule/Event.php");

$conf = array('append' => true, 'mode' => 0644, 'timeFormat' => '%X %x');
$logger = Log::singleton("file", Utilities::getLogRoot() . "/event_detail_timing.log", "", $conf, PEAR_LOG_INFO);
$logger->log("START: " . microtime());

$cleanUuid = "";
if (isset($_GET['uuid']) && Utilities::validateUuid($_GET['uuid'])) {
	$cleanUuid = $_GET['uuid'];
}

if (Utilities::isSessionValid()) {
	$data = Event::getEventDetail($cleanUuid, $_SESSION['timezone'], $_SESSION['uidpk']);
	$logger->log("END: " . microtime());
	header('Content-Type: application/json');			
	echo json_encode($data);
} else {
	header("location:" . Utilities::getHttpPath() . "/nexus.php");
	exit(0);		
}			

?>
