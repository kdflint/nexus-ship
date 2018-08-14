<?php

session_start();

require_once("../../../src/framework/Util.php");
require_once(Utilities::getSrcRoot() . "/user/User.php");

$dirty = array('id' => $_GET['id']);
$clean = array();

// TODO - check that user id exists
if (isset($dirty['id'])) {
	$clean['id'] = $dirty['id'];
} else {
	forceLogout();
}

// TODO - put authorization checker, session checker, error handling, etc. in a central place. These should go at the top of every processor.

if (!Utilities::isSessionValid()) {
	header("location:" . Utilities::getHttpPath() . "/nexus.php");
	exit(0);
}


/* ====================================================

Use only clean input beyond this point (i.e. $clean[])

======================================================= */

$result = User::updateToNetworkAdminbyUserId($clean['id']);

if ((session_status() === PHP_SESSION_ACTIVE) && isset($_SESSION['nexusContext'])) {
 switch($_SESSION['nexusContext']) {
 		case "NWM":
			header("location:" . Utilities::getHttpPath() . "/nexus.php?view=team");
 			break;
 		case "ADV":
			header("location:" . Utilities::getHttpPath() . "/nexus.php?view=network");
 			break;
 		case "PUB":
 			header("location:" . Utilities::getPluginPath() . "/publicSuite.php?oid=" . $_SESSION['orgUid'] . "&context=directory");
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