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
							'tzone-name' => $_POST['tzone-name'],
							'meeting-type' => $_POST['meeting-type']
							);
											
$result = validateEvent($dirty);

if (count($result['error']) > 0) {
	//header("location:" . Util::getHttpPath() . "/login.php?logout=true");
	print_r($result); exit(0);
	exit(0);
}

/* ====================================================

Use only clean input beyond this point (i.e. $clean[])

======================================================= */

$meetingType = array("1" => "video chat", "2" => "collaboration", "3" => "webinar", "4" => "video link");

$timestamp = $result['clean']['meeting-date'] . " " . $result['clean']['meeting-time'] . " " . $result['clean']['tzone-name'];

Event::addEvent($timestamp, $result['clean']['meeting-duration'], $result['clean']['meeting-name'], $_SESSION['uidpk'], array_keys($_SESSION['groups'])[0], $result['clean']['tzone-name'], $meetingType[$result['clean']['meeting-type']]);

header("location:" . Util::getHttpPath() . "/index.php");
exit(0);

function validateEvent($input) {
	$result = array('clean' => array(), 'error' => array());
	
	// MEETING NAME
	if (isset($input['meeting-name'])) {
		if (strlen($input['meeting-name']) <= 50) {
			$result['clean']['meeting-name'] = Util::sanitize($input['meeting-name']);			
		} else {
			$result['error']['meeting-name'] = "error";
		}
 	}	else {
 		$result['clean']['meeting-name'] = "undefined";
 	}
 
	// MEETING DATE		
	if (isset($input['meeting-date']) && strlen($input['meeting-date']) > 0) {
		$todayNow = date('m/d/Y');
		if ($input['meeting-date'] == "today") {
			$result['clean']['meeting-date'] = $todayNow;
		} else {
			$dateParts = explode('/', $input['meeting-date']);
			if (checkdate($dateParts[0], $dateParts[1], $dateParts[2])) {
				$result['clean']['meeting-date'] = $input['meeting-date'];	
			} else {
				$result['error']['meeting-date'] = "error";
			}	
		}
 	}	else {
 		$result['error']['meeting-date'] = "error";
 	}	
 	
	// MEETING TIME ZONE
	if (isset($input['tzone-name']) && strlen($input['tzone-name']) > 0) {
		$systemTz = date('e');
		if ($input['tzone-name'] == "system" && Event::isValidTimeZone($systemTz)) {
			$result['clean']['tzone-name'] = $systemTz;
		} else if (Event::isValidTimeZone($input['tzone-name'])) {
			$result['clean']['tzone-name'] = $input['tzone-name'];
		} else {
			$result['error']['tzone-name'] = "error";
		}
	} else {
		$result['error']['tzone-name'] = "error";
	}

  // MEETING TIME 
  if (isset($input['meeting-time']) && strlen($input['meeting-time']) > 0) {
  	$timeNow = date('H:i') . ':00';
  	if ($input['meeting-time'] == "now" && Event::isValidTimeInterval($timeNow)) {
  		$result['clean']['meeting-time'] = $timeNow;
  	} else if (Event::isValidTimeInterval($input['meeting-time'])) {
  		$result['clean']['meeting-time'] = $input['meeting-time'];
 		} else {
 			$result['error']['meeting-time'] = "error";
 		}
 	} else {	
 		$result['error']['meeting-time'] = "error";
 	}
 	
 	// MEETING DURATION
  if (isset($input['meeting-duration']) && Event::isValidTimeInterval($input['meeting-duration'])) {
 	 	$result['clean']['meeting-duration'] = $input['meeting-duration'];
 	} else {	
 		$result['error']['meeting-duration'] = "error";
 	}
 	
 	// MEETING TYPE
  if (isset($input['meeting-type']) && $input['meeting-type'] < 5) {
 	 	$result['clean']['meeting-type'] = $input['meeting-type'];
 	} else {	
 		$result['error']['meeting-type'] = "error";
 	} 	

 	return $result;
}

?>