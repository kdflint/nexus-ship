<?php

session_start();

require_once("../../../src/framework/Util.php");
require_once(Util::getSrcRoot() . "/schedule/Event.php");

// TODO - put authorization checker, session checker, error handling, etc. in a central place. These should go at the top of every processor.

if (!Util::isSessionValid()) {
	header("location:" . Util::getHttpPath() . "/index.php");
	exit(0);
}

$dirty = array('meeting-name' => $_POST['meeting-name'],
							'meeting-date' => $_POST['meeting-date'],
							'meeting-time' => $_POST['meeting-time'],
							'meeting-duration' => $_POST['meeting-duration'],
							'tzone-name' => $_POST['tzone-name']
							);
											
$result = validateEvent($dirty);

if (count($result['error']) > 0) {
	header("location:" . Util::getHttpPath() . "/login.php?oid=" . $_SESSION['orgId'] . "&logout=true");
	exit(0);
}

// TOTO - update session with this time zone

$timestamp = $result['clean']['meeting-date'] . " " . $result['clean']['meeting-time'] . " " . $result['clean']['tzone-name'];

Event::addEvent($timestamp, $result['clean']['meeting-duration'], $result['clean']['meeting-name'], $_SESSION['uidpk'], array_keys($_SESSION['groups'])[0], $result['clean']['tzone-name']);

header("location:" . Util::getHttpPath() . "/index.php");
exit(0);

function validateEvent($input) {
	$result = array('clean' => array(), 'error' => array());
	
	// MEETING NAME
	if (isset($input['meeting-name'])) {
		if (strlen($input['meeting-name']) <= 50 && Util::isSafeCharacterSet($input['meeting-name'])) {
			$result['clean']['meeting-name'] = $input['meeting-name'];			
		} else {
			$result['error']['meeting-name'] = "error";
		}
 	}	else {
 		$result['clean']['meeting-name'] = "undefined";
 	}
 
	// MEETING DATE
	if (isset($input['meeting-date'])) {
		$result['clean']['meeting-date'] = $input['meeting-date'];			
 	}	else {
 		$result['error']['meeting-date'] = "error";
 	}	
 	
	// MEETING TIME ZONE
	if (isset($input['tzone-name']) && Event::isValidTimeZone($input['tzone-name'])) {
		$result['clean']['tzone-name'] = $input['tzone-name'];
	} else {
		$result['error']['tzone-name'] = "error";
	}
 	
 	$result['clean']['meeting-time'] = $input['meeting-time'];
 	$result['clean']['meeting-duration'] = $input['meeting-duration'];

 	return $result;
}

?>