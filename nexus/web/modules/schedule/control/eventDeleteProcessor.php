<?php

session_start();

require_once("../../../src/framework/Util.php");
require_once(Utilities::getSrcRoot() . "/schedule/Event.php");

$dirty = array('uuid' => $_GET['id']);
$clean = array();

if (isset($dirty['uuid']) && Event::isValidEventUuid($dirty['uuid'])) {
	$clean['uuid'] = $dirty['uuid'];
} else {
	forceLogout();
}

// TODO - put authorization checker, session checker, error handling, etc. in a central place. These should go at the top of every processor.

if (!Utilities::isSessionValid()) {
	header("location:" . Utilities::getHttpPath() . "/index.php");
	exit(0);
}


/* ====================================================

Use only clean input beyond this point (i.e. $clean[])

======================================================= */


Event::deleteEvent($clean['uuid']);

if ((session_status() === PHP_SESSION_ACTIVE) && isset($_SESSION['nexusContext'])) {
 switch($_SESSION['nexusContext']) {
 		case "NWM":
			header("location:" . Utilities::getHttpPath() . "/index.php");
 			break;
 		case "ADV":
			header("location:" . Utilities::getPilotPath() . "/view/nexus.php?thisPage=calendar");
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