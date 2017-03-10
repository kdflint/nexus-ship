<?php

session_start();

require_once("../../../src/framework/Util.php");
require_once(Utilities::getSrcRoot() . "/organization/Organization.php");

$dirty = array('id' => $_GET['id']);
$clean = array();

if (isset($dirty['id']) && Utilities::validateNetworkIdFormat($dirty['id'])) {
	$clean['id'] = $dirty['id'];
} else {
	forceLogout();
}

if (!Utilities::isSessionValid()) {
	header("location:" . Utilities::getHttpPath() . "/nexus.php");
	exit(0);
}


/* ====================================================

Use only clean input beyond this point (i.e. $clean[])

======================================================= */


User::removeUserOrgRelation($_SESSION['uidpk'], $clean['id']);
Utilities::setSessionOrgs($_SESSION['username']);

if ((session_status() === PHP_SESSION_ACTIVE) && isset($_SESSION['nexusContext'])) {
 switch($_SESSION['nexusContext']) {
 		case "NWM":
			header("location:" . Utilities::getHttpPath() . "/nexus.php");
 			break;
 		case "ADV":
			header("location:" . Utilities::getHttpPath() . "/nexus.php#openProfileOrg");
 			break;
 		default: 			
 	}
}

exit(0);

function forceLogout() {
	header("location:" . Utilities::getHttpPath() . "/login.php?logout=true");
	exit(0);
}

?>