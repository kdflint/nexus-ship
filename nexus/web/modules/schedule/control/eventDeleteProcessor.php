<?php

session_start();

require_once("../../../src/framework/Util.php");
require_once(Util::getSrcRoot() . "/schedule/Event.php");

$dirty = array('uuid' => $_GET['id']);
$clean = array();

if (isset($dirty['uuid']) && Event::isValidEventUuid($dirty['uuid'])) {
	$clean['uuid'] = $dirty['uuid'];
} else {
	forceLogout();
}

// TODO - put authorization checker, session checker, error handling, etc. in a central place. These should go at the top of every processor.

if (!Util::isSessionValid()) {
	header("location:" . Util::getHttpPath() . "/index.php");
	exit(0);
}


/* ====================================================

Use only clean input beyond this point (i.e. $clean[])

======================================================= */


Event::deleteEvent($clean['uuid']);

header("location:" . Util::getHttpPath() . "/index.php");
exit(0);

function forceLogout() {
	header("location:" . Util::getHttpPath() . "/login.php?logout=true");
	exit(0);
}

?>