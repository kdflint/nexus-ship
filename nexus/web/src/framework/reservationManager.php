<?php

session_start();

require_once("Util.php");
require_once(Utilities::getSrcRoot() . "/schedule/Event.php");

$clean['status'] = "1";

// TODO - this check causes JSON object parse to be thrown from javascript -- better to tokenize it anyway
if (Utilities::isSessionValid()) {
	if ($_SESSION['nexusContext'] === "ADV" && isset($_GET['filter'])) {
		if ($_GET['filter'] === "public") {
			$idList = "{" . $_SESSION['pgpk'] . "}";
			$data = Event::getFutureEventsByGroupIdList($idList, $_SESSION['timezone'], $_SESSION['uidpk'], $clean['status']);	
		} else if ($_GET['filter'] === "network") {
			$data = Event::getFutureNetworkEvents(getFormattedNetworkGroupList(), $_SESSION['timezone'], $_SESSION['uidpk'], $clean['status']);			
		} else if ($_GET['filter'] === "pending") {
			$data = Event::getFuturePendingEvents(getFormattedAllGroupsList(), $_SESSION['timezone'], $_SESSION['uidpk']);
		}
	} else {	
		// TODO - this will break if user has > 1 group. Only works for now becuse NWM context only has one session group.
		$idList = "{" . $_SESSION['groups'][0]['id'] . "}";
		$data = Event::getFutureEventsByGroupIdList($idList, $_SESSION['timezone'], $_SESSION['uidpk']);
	}
	header('Content-Type: application/json');			
	echo json_encode($data);
} else {
	header("location:" . Utilities::getHttpPath() . "/nexus.php");
	exit(0);		
}	

function getFormattedNetworkGroupList() {
	$idList = $_SESSION['ngpk'];
	foreach ($_SESSION['groups'] as $group) {
		if ($group['id'] != $_SESSION['pgpk']) {
			$idList = $idList . "," . $group['id'];
		}
	}
	return "{" . $idList . "}";
}

function getFormattedAllGroupsList() {
	$idList = $_SESSION['pgpk'] . "," . $_SESSION['ngpk'];
	foreach ($_SESSION['groups'] as $group) {
		$idList = $idList . "," . $group['id'];
	}
	return "{" . $idList . "}";
}

?>

