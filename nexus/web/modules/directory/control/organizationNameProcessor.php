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
	//if (Utilities::isSessionAdmin()) {
		alertAdmin();
	//}
}
User::addUserOrgRelation($_SESSION['uidpk'],$orgId,88,5);

Utilities::setSessionOrgs($_SESSION['username']);

$return['org-name'] = $result['clean']['org-name'];
$return['org-id'] = $orgId;
$_SESSION['tmp-editorgid'] = $orgId;

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
		$result['clean']['org-name'] = $input['org-name'];
	} else {
		$result['error']['org-name'] = "error";
	}

 	return $result;
}

function alertAdmin() {
	$headers = "From: support@northbridgetech.org\r\nBcc: kathy.flint@northbridgetech.org";
	$message = "Hello Administrator,
	
A new organization has just been added to the " . $_SESSION['networkName'] . " Organizational Directory.

You may delete or edit this organization at

" . Utilities::getHttpPath() . "/nexus.php?view=orgid-" . $_SESSION['orgUid'] . "

Sincerely,

Nexus Advantage
on behalf of
" . $_SESSION['networkName'];

	mail(Utilities::getEventApprovalList(), "[Nexus] Directory Organization Add Notification", $message, $headers);
}	

?>