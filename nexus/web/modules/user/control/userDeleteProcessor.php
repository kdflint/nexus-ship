<?php

session_start();

require_once("../../../src/framework/Util.php");
require_once(Util::getSrcRoot() . "/schedule/Event.php");

$dirty = array('id' => $_GET['id']);
$clean = array();

// TODO - check that user id exists and belongs to this group
if (isset($dirty['id'])) {
	$clean['id'] = $dirty['id'];
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


User::deleteUser($clean['id']);

header("location:" . Util::getHttpPath() . "/index.php");
exit(0);

function forceLogout() {
	header("location:" . Util::getHttpPath() . "/login.php?logout=true");
	exit(0);
}

?>