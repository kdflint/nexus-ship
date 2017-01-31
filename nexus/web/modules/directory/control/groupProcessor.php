<?php

session_start();

require_once("../../../src/framework/Util.php");
require_once(Utilities::getSrcRoot() . "/group/Group.php");
require_once(Utilities::getSrcRoot() . "/user/Invitation.php");

// TODO - put authorization checker, session checker, error handling, etc. in a central place. These should go at the top of every processor.

if (!Utilities::isSessionValid()) {
	header("location:" . Utilities::getHttpPath() . "/nexus.php");
	exit(0);
}
									
// Following works, but only populates form values that HAVE a value. Empties do not copy over.
$result = validateGroup($_POST);

if (count($result['error']) > 0) {
	print_r($result);
 exit(0);
}

/* ====================================================

Use only clean input beyond this point (i.e. $clean[])

======================================================= */

$groupId = Group::addGroup(); // put name in here
$issuerId = ""; // fill in
$orgId = ""; // fill in
//public static function addInvitation($email, $groupId, $roleId, $issuerId, $orgId)
$inviteUuid = Invitation:addGlobalInvitation("", $groupId, "5", $issuerId, $orgId);

// TODO - can this get simpler?
echo("http://northbridgetech.org/apps/nexus/web/enroll?invitation=" . $inviteUuid);

function validateGroup($input) {
	$result = array('clean' => array(), 'error' => array());
	return true;
}

?>