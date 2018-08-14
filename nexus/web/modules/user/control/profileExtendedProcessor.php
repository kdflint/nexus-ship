<?php

session_start();

require_once("../../../src/framework/Util.php");
require_once(Utilities::getSrcRoot() . "/user/User.php");

// TODO - put authorization checker, session checker, error handling, etc. in a central place. These should go at the top of every processor.

if (!Utilities::isSessionValid()) {
	header("location:" . Utilities::getHttpPath() . "/nexus.php");
	exit(0);
}
									
// Following works, but only populates form values that HAVE a value. Empties do not copy over.
$result = validateExtendedProfile($_POST);

if (count($result['error']) > 0) {
	header('Content-Type: application/json');			
	echo json_encode($result);	
 	exit(0);
}

/* ====================================================

Use only clean input beyond this point (i.e. $clean[])

======================================================= */

if (isset($result['clean']['dump'])) {
	// LEFT OFF - add extended profile table? column? to db
	User::updateExtendedProfileById($_SESSION['uidpk'], json_encode($result['clean']['dump']));
	$_SESSION['profile'] = json_encode($result['clean']['dump']);
}

if ((session_status() === PHP_SESSION_ACTIVE) && isset($_SESSION['nexusContext'])) {
 switch($_SESSION['nexusContext']) {
 		case "ADV":
			header('Content-Type: application/json');			
			echo json_encode($result['clean']['dump']);	
 			break;
 		default: 			
 	}
}

function validateExtendedProfile($input) {
	$result = array('clean' => array(), 'error' => array());
	$result['clean']['dump'] = $input;
	$result['clean']['dump']['network'] = $_SESSION['networkId'];
 	return $result;
}

?>