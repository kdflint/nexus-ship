<?php

session_start();

require_once("../../../src/framework/Util.php");

// Once we insert the event in db, get this UUID from addEvent return
// (Save file last)
$eventUid = Utilities::newUuid();

// The Basics: http://www.w3schools.com/php/php_file_upload.asp
// TODO - security checks!
if (isset($_FILES) && isset($_FILES["fileToUpload"]["name"]) && strlen($_FILES["fileToUpload"]["name"]) > 0) {
	$dirtyInputFile = basename($_FILES["fileToUpload"]["name"]);
	$targetExt = pathinfo($dirtyInputFile,PATHINFO_EXTENSION);
	$targetFile = Utilities::getPartnerFileRoot() . "/event-" . $eventUid . "." . $targetExt;

	if (move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $targetFile)) {
	  // All good
	} else {
	  trigger_error("Could not upload a file for event " . $eventUid . "\n", E_USER_ERROR);
	}
}	

// Store the event

$message = "This message was just submitted.\r\n\r\n";

foreach ($_POST as $key=>$val) {
 	$message = $message . "\r\n" . $key . ":" . $val . "";
}

$message = $message . "\r\n\eventUuid:" . $eventUid . "";

mail("kathy.flint@northbridgetech.org", "CFCHT Event Add", $message, "");

header("location:" . Utilities::getPluginPath() . "/publicSuite.php?oid=" . $_SESSION['orgId'] . "&context=calendar");

exit(0);


?>