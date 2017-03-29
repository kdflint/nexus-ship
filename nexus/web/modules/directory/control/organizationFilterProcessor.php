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
	print_r($result);
 	exit(0);
}

/* ====================================================

Use only clean input beyond this point (i.e. $clean[])

======================================================= */

$thisOrg = Organization::getOrganizationById($result['clean']['org-id']);
if (pg_num_rows($thisOrg) == 1) {
	Organization::addOrganizationType($result['clean']['org-id'], $result['clean']['type']);
	foreach ($result['clean']['specialty'] as $specialty) {
		Organization::addOrganizationSpecialty($result['clean']['org-id'], $specialty);
	}
}

unset($_SESSION['tmp_orgeditname']);
unset($_SESSION['tmp_orgeditid']);

if ((session_status() === PHP_SESSION_ACTIVE) && isset($_SESSION['nexusContext'])) {
 switch($_SESSION['nexusContext']) {
 		case "NWM":
			header("location:" . Utilities::getHttpPath() . "/nexus.php");
 			break;
 		case "ADV":
			header("location:" . Utilities::getHttpPath() . "/nexus.php");
 			break;
 		case "PUB":
 			header("location:" . Utilities::getPluginPath() . "/publicSuite.php?oid=" . $_SESSION['orgUid'] . "&context=directory");
 			break;
 		default: 			
 	}
}


function validateOrganization($input) {
	$result = array('clean' => array(), 'error' => array());
	
	if (isset($input['org-id']) && Utilities::validateNetworkIdFormat($input['org-id'])) {
		$result['clean']['org-id'] = $input['org-id'];
	} else {
		$result['error']['org-id'] = "error";
	}
	
	if (isset($input['type'])) {
		$result['clean']['type'] = $input['type'];
	} else {
		$result['error']['type'] = "error";
	}		

	if (isset($input['specialty'])) {
		$result['clean']['specialty'] = $input['specialty'];
	} else {
		$result['clean']['specialty'] = array();
	}	
	
 	return $result;
}

?>