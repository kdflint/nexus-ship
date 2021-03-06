<?php

session_start();

require_once("../../../src/framework/Util.php");
require_once(Utilities::getSrcRoot() . "/schedule/Event.php");
require_once(Utilities::getSrcRoot() . "/group/Group.php");

// TODO - put authorization checker, session checker, error handling, etc. in a central place. These should go at the top of every processor.

if (!Utilities::isSessionValid()) {
	header("location:" . Utilities::getHttpPath() . "/nexus.php");
	exit(0);
}

// TODO - um, why am I assigning all these to another array? -kdf
$dirty = array('meeting-name' => $_POST['meeting-name'],
							'meeting-date' => $_POST['meeting-date'],
							'meeting-time' => $_POST['meeting-time'],
							'meeting-duration' => $_POST['meeting-duration'],
							'tzone-name' => $_POST['tzone-name'],
							'meeting-type' => $_POST['meeting-type'],
							'meeting-descr' => $_POST['meeting-descr'],
							'meeting-loc' => $_POST['meeting-loc'],
							'isBbbMeeting' => $_POST['isBbbMeeting'],
							'meeting-url' => $_POST['meeting-url'],
							'meeting-registr' => $_POST['meeting-registr'],
							'registration-url' => $_POST['registration-url'],
							'meeting-date-end' => $_POST['meeting-date-end'],
							'meeting-time-end' => $_POST['meeting-time-end'],
							'meeting-contact' => $_POST['meeting-contact'],
							'meeting-uuid' => $_POST['meeting-uuid'],
							'meeting-visibility' => $_POST['meeting-visibility'],
							'meeting-recur' => $_POST['repeat-check'],
							'meeting-interval' => $_POST['repeat-interval'],
							'meeting-num-occur' => $_POST['repeat-freq'],
							'meeting-recur-dttm' => $_POST['meeting-recur-duration'],
							'old-file-ext' => $_POST['old-file-ext'],
							'bbb-request' => $_POST['bbb-request']
							);
										
$result = validateEvent($dirty);

if (count($result['error']) > 0) {
	print_r($result);
	exit(0);
}

/* ====================================================

Use only clean input beyond this point (i.e. $clean[])

======================================================= */

$meetingRecurPattern = array("0" => "daily", "1" => "weekdays", "2" => "weekly");

$meetingType = array("1" => "video chat", "2" => "collaboration", "3" => "webinar", "4" => "video tether");

// Business rule: If session is PUB or session is ADV and user is non-admin, meetings should go in pending review; If session is NWM, meeting should go in active
$meetingStatus = 1;
if ($_SESSION['nexusContext'] == "PUB") {
	$meetingStatus = 3;
}
if ($_SESSION['nexusContext'] == "ADV" && !Utilities::isSessionAdmin()) {
	$meetingStatus = 3;
}

$timestamp = $result['clean']['meeting-date'] . " " . $result['clean']['meeting-time'] . " " . $result['clean']['tzone-name'];
$targetExt = "";
$isFile = false;

if (isset($_FILES) && isset($_FILES["fileToUpload"]["name"]) && strlen($_FILES["fileToUpload"]["name"]) > 0) {
	$isFile = true;
	$inputFile = basename($_FILES["fileToUpload"]["name"]);
	$targetExt = pathinfo($inputFile,PATHINFO_EXTENSION);
} else if (isset($result['clean']['file-ext'])) {
	$targetExt = $result['clean']['file-ext'];
}

$recurId = null;
if ($result['clean']['meeting-recur']) {
	$recurEndTimestamp = $result['clean']['meeting-recur-dttm'] . " " . $result['clean']['tzone-name'];
	$recurId = Event::addEventRecurrence($meetingRecurPattern[$result['clean']['meeting-interval']], $result['clean']['meeting-num-occur'], $recurEndTimestamp);
}

// TODO - if this new event is result of edit, do we preserve original adder?
$eventUid = Event::addEvent($timestamp, $result['clean']['meeting-duration'], $result['clean']['meeting-name'], $_SESSION['uidpk'], $result['clean']['meeting-group'], $result['clean']['tzone-name'], $meetingType[$result['clean']['meeting-type']], $result['clean']['meeting-descr'], $result['clean']['meeting-loc'], $result['clean']['isBbbMeeting'], $targetExt, $meetingStatus, $result['clean']['meeting-url'], $result['clean']['registration-url'], $result['clean']['meeting-registr'], $result['clean']['meeting-contact'], $result['clean']['meeting-uuid'], $recurId);

if ($isFile) {
	$targetFile = Utilities::getPartnerFileRoot() . "/event-" . $eventUid . "." . $targetExt;
	if (move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $targetFile)) {
	  // All good
	} else {
	  trigger_error("Could not upload a file for event " . $eventUid . "\n", E_USER_ERROR);
	}
}

if ($meetingStatus == "3") {
	$headers = "From: support@northbridgetech.org\r\nBcc: kathy.flint@northbridgetech.org";
	$message = "Hello Administrator,
	
A new event has just been submitted to the " . $_SESSION['networkName'] . " Public Calendar.

Meeting name: " . $result['clean']['meeting-name'] . "

Virtual gathering request? " .  $result['clean']['bbb-request'] . "

You may approve this event for publication at

" . Utilities::getHttpPath() . "/login.php?oid=" . $_SESSION['orgUid'] . "

Sincerely,

Nexus Advantage
on behalf of
" . $_SESSION['networkName'];

	mail(Utilities::getEventApprovalList(), "[Nexus] Public Calendar Event Approval", $message, $headers);
}	

if ((session_status() === PHP_SESSION_ACTIVE) && isset($_SESSION['nexusContext'])) {
 switch($_SESSION['nexusContext']) {
 		case "NWM":
			header("location:" . Utilities::getHttpPath() . "/nexus.php");
 			break;
 		case "ADV":
			header("location:" . Utilities::getHttpPath() . "/nexus.php");
 			break;
 		case "PUB":
 			header("location:" . Utilities::getPluginPath() . "/publicSuite.php?oid=" . $_SESSION['orgUid'] . "&context=calendar&confirm=" . $result['clean']['meeting-contact']);
 			break;
 		default: 			
 			header("location:" . Utilities::getPluginPath() . "/publicSuite.php?oid=" . $_SESSION['orgUid'] . "&context=calendar&confirm=" . $result['clean']['meeting-contact']);
 	}
} else {
 	header("location:" . Utilities::getPluginPath() . "/publicSuite.php?oid=" . $_SESSION['orgUid'] . "&context=calendar&confirm=" . $result['clean']['meeting-contact']);
 	exit(0);
}	

function validateEvent($input) {
	$result = array('clean' => array(), 'error' => array());
	
	// MEETING NAME
	if (isset($input['meeting-name'])) {
		if (strlen($input['meeting-name']) <= 100) {
			$result['clean']['meeting-name'] = Utilities::sanitize($input['meeting-name']);			
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
 	 	$result['clean']['isBbbMeeting'] = "true";
 	} else if (!isset($input['isBbbMeeting'])) {
 		$result['clean']['isBbbMeeting'] = "false";
 	} else {	
 		$result['error']['meeting-type'] = "error";
 		$result['error']['isBbbMeeting'] = "error";
 	}
 	
 	// MEETING DESCR
	if (isset($input['meeting-descr'])) {
		if (strlen($input['meeting-descr']) <= 1500) {
			// TODO - replace this with Utilities::encodeLineBreaks
			$result['clean']['meeting-descr'] = str_replace(["\r\n", "\r", "\n"], "~", Utilities::sanitize($input['meeting-descr']));	
		} else {
			$result['error']['meeting-descr'] = "error";
		}
 	}	else {
 		$result['clean']['meeting-descr'] = "";
 	}
 	 	
 	// MEETING LOC 	
	if (isset($input['meeting-loc'])) {
		if (strlen($input['meeting-loc']) <= 200) {
			$result['clean']['meeting-loc'] = str_replace(["\r\n", "\r", "\n"], ",", Utilities::sanitize($input['meeting-loc']));			
		} else {
			$result['error']['meeting-loc'] = "error";
		}
 	}	else {
 		$result['clean']['meeting-loc'] = "";
 	}

	// MEETING URL
	if (isset($input['meeting-url'])) {
		// TODO - proper validation and compare to javascript
		$result['clean']['meeting-url'] = $input['meeting-url'];
	}
	
	// MEETING REGISTRATION URL
	if (isset($input['registration-url'])) {
		// TODO - proper validation and compare to javascript
		$result['clean']['registration-url'] = $input['registration-url'];
	}
	
	// MEETING REGISTRATION
	if (isset($input['meeting-registr'])) {
		if (strlen($input['meeting-registr']) <= 200) {
			// TODO - proper validation and compare to javascript
			$result['clean']['meeting-registr'] = str_replace(["\r\n", "\r", "\n"], "~", Utilities::sanitize($input['meeting-registr']));;
		} else {
			$result['error']['meeting-registr'] = "error";
		}
	} else {
			$result['clean']['meeting-registr'] = "";
	}
	
	// MEETING CONTACT
	if (isset($input['meeting-contact'])) {
		// TODO - proper validation and compare to javascript
		$result['clean']['meeting-contact'] = $input['meeting-contact'];
	}	
	
	// MEETING UUID
	if (isset($input['meeting-uuid']) && Utilities::validateUuid($input['meeting-uuid'])) {
		$result['clean']['meeting-uuid'] = $input['meeting-uuid'];
	} else {
		$result['clean']['meeting-uuid'] = "";
	}

	// MEETING FILE
	if (isset($input['old-file-ext']) && strlen($input['old-file-ext']) > 0 ) {
		$result['clean']['file-ext'] = $input['old-file-ext'];
	}
	
	// MEETING VISIBILITY
	if (isset($input['meeting-visibility']) && Utilities::validateGroupId($input['meeting-visibility'])) {
		$result['clean']['meeting-group'] = $input['meeting-visibility'];
	} else {
		// TODO - breaks if we want to assign multiple network groups to a meeting. Also, obviously, breaks if index 0 is not the right group.
		$result['clean']['meeting-group'] = $_SESSION['groups'][0]['id'];
	}
	
	// BBB REQUEST
	if (isset($input['bbb-request'])) {
	    $result['clean']['bbb-request'] = "YES";
	} else {
	    $result['clean']['bbb-request'] = "NO";
	}


	
	// MEETING RECURRENCE
	if (isset($input['meeting-recur'])) {
		$result['clean']['meeting-recur'] = true;
		$result['clean']['meeting-recur-dttm'] = $input['meeting-recur-dttm'];
		if (isset($input['meeting-interval']) && Validate::number(
																								$input['meeting-interval'], array(
																								'min' => 0,
																								'max' => 2))) {
			$result['clean']['meeting-interval'] = $input['meeting-interval'];
		} else {
			$result['error']['meeting-interval'] = "error";
		}
		if (isset($input['meeting-num-occur']) && Validate::number(
																									$input['meeting-num-occur'], array(
																									'min' => 2,
																									'max' => 20))) {
			$result['clean']['meeting-num-occur'] = $input['meeting-num-occur'];
		} else {
			$result['error']['meeting-num-occur'] = "error";
		}
	} else {
		$result['clean']['meeting-recur'] = false;
		$result['clean']['meeting-interval'] = "daily";
		$result['clean']['meeting-num-occur'] = 1;
		$result['clean']['meeting-recur-dttm'] = "";
	}

 	return $result;
}

function secondsToTime($seconds)
{
    // extract hours
    $hours = floor($seconds / (60 * 60));
 
    // extract minutes
    $divisor_for_minutes = $seconds % (60 * 60);
    $minutes = floor($divisor_for_minutes / 60);
 
    // extract the remaining seconds
    $divisor_for_seconds = $divisor_for_minutes % 60;
    $seconds = ceil($divisor_for_seconds);
    
    return $hours . ":" . $minutes . ":00";
}

?>