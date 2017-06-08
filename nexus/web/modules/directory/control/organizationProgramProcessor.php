<?php

session_start();

require_once("../../../src/framework/Util.php");
require_once(Utilities::getSrcRoot() . "/organization/Organization.php");

// TODO - put authorization checker, session checker, error handling, etc. in a central place. These should go at the top of every processor.

if (!Utilities::isSessionValid()) {
	header("location:" . Utilities::getHttpPath() . "/nexus.php");
	exit(0);
}
									
// Following works, but only populates form values that HAVE a value. Empties do not copy over.
$result = validateOrganization($_POST);

if (count($result['error']) > 0) {
	header('Content-Type: application/json');			
	echo json_encode($result);	
 	exit(0);
}

/* ====================================================

Use only clean input beyond this point (i.e. $clean[])

======================================================= */

$return = array();
if (isset($result['clean']['org-id'])) {
	$thisOrg = Organization::getOrganizationById($result['clean']['org-id']);
	if (pg_num_rows($thisOrg) == 1) {
		Organization::addOrganizationProgram($result['clean']['org-id'], $result['clean']['name'], $result['clean']['description'], $result['clean']['eligibility'], $result['clean']['services'], $result['clean']['involvement'], $result['clean']['partner_interest'], $result['clean']['partner_kind'], $result['clean']['ada'], $result['clean']['hours']);
	}
}

$return['org-name'] = $result['clean']['org-name'];
$return['org-id'] = $result['clean']['org-id'];

if ((session_status() === PHP_SESSION_ACTIVE) && isset($_SESSION['nexusContext'])) {
 switch($_SESSION['nexusContext']) {
 		case "ADV":
			header('Content-Type: application/json');			
			echo json_encode($return);	
 			break;
 		default: 			
 	}
}

function validateOrganization($input) {
	$result = array('clean' => array(), 'error' => array());

	if (isset($input['org-name']) && strlen($input['org-name']) > 0) {
		$result['clean']['org-name'] = $input['org-name'];
	} else {
		$result['error']['org-name'] = "error";
	}

	if (isset($input['org-id']) && Utilities::validateNetworkIdFormat($input['org-id'])) {
		$result['clean']['org-id'] = $input['org-id'];
	} else {
		$result['error']['org-id'] = "error";
	}

	$result['clean']['name'] = substr(Utilities::sanitize(isset($input['name']) ? Utilities::encodeLineBreaks($input['name']) : ""), 0, 50);
	$result['clean']['description'] = substr(Utilities::sanitize(isset($input['description']) ? Utilities::encodeLineBreaks($input['description']) : ""), 0, 1000);
	$result['clean']['eligibility'] = substr(Utilities::sanitize(isset($input['eligibility']) ? Utilities::encodeLineBreaks($input['eligibility']) : ""), 0, 250);
	$result['clean']['services'] = substr(Utilities::sanitize(isset($input['services']) ? Utilities::encodeLineBreaks($input['services']) : ""), 0, 100);
	$result['clean']['involvement'] = substr(Utilities::sanitize(isset($input['involvement']) ? Utilities::encodeLineBreaks($input['involvement']) : ""), 0, 250);
	$result['clean']['partner_interest'] = substr(Utilities::sanitize(isset($input['partner_interest']) ? Utilities::encodeLineBreaks($input['partner_interest']) : ""), 0, 250);
	$result['clean']['partner_kind'] = substr(Utilities::sanitize(isset($input['partner_kind']) ? Utilities::encodeLineBreaks($input['partner_kind']) : ""), 0, 250);
	if (isset($input['ada'])) {
		$result['clean']['ada'] = $input['ada'] === "yes" ? 't' : 'f';	
	} else {
		$result['clean']['ada'] = null;
	}
	$result['clean']['hours'] = substr(Utilities::sanitize(isset($input['hours']) ? Utilities::encodeLineBreaks($input['hours']) : ""), 0, 50);

 	return $result;
}

?>