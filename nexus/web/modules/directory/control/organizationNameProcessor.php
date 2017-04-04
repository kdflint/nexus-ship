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
$result = validateInput($_POST);

if (count($result['error']) > 0) {
	header('Content-Type: application/json');			
	echo json_encode($result);	
 	exit(0);
}

/* ====================================================

Use only clean input beyond this point (i.e. $clean[])

======================================================= */

$return = array();
$return['status'] = "name-exists";
$orgId = Organization::getOrganizationByName($result['clean']['org-name']);
if (!$orgId) {
	$orgId = Organization::addOrganization($result['clean']['org-name'], $_SESSION['networkId']);
	$return['status'] = "name-new";
	$return['org-name'] = $result['clean']['org-name'];
	$return['org-id'] = $orgId;
}
User::addUserOrgRelation($_SESSION['uidpk'],$orgId,88,5);

Utilities::setSessionOrgs($_SESSION['username']);

if ((session_status() === PHP_SESSION_ACTIVE) && isset($_SESSION['nexusContext'])) {
 switch($_SESSION['nexusContext']) {
 		case "ADV":
			header('Content-Type: application/json');			
			echo json_encode($return);	
 			break;
 		default: 			
 	}
}

function validateInput($input) {
	$result = array('clean' => array(), 'error' => array());

	if (isset($input['org-name']) && strlen($input['org-name']) > 0) {
		$result['clean']['org-name'] = Utilities::sanitize($input['org-name']);
	} else {
		$result['error']['org-name'] = "error";
	}

 	return $result;
}

?>