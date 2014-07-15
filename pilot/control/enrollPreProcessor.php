<?php

include("../model/pgDb.php");
include("../control/util.php");

$inviteId = $networkId = "";

// $_SESSION['orgId'] = $_SESSION['grantorId'] = $_SESSION['inviteId'] = "1234";

if(isset($_GET['invitation'])) {
	$inviteId = Util::clean($_GET['invitation']);
	$_SESSION['inviteId'] = $inviteId;
}

if (pgDb::checkValidInvitation($inviteId)) {
	$_SESSION['inviteId'] = $inviteId;
	
	pgDb::getInvitationByUuid($inviteId);
	$cursor1 = pgDb::getInvitationByUuid($inviteId);
	$row1 = pg_fetch_array($cursor1);
	$networkId = $row1['networkid'];
	$orgId = $row1['orgid'];

	$cursor2 = pgDb::getOrganizationById($networkId);
	$row2 = pg_fetch_array($cursor2);
	$_SESSION['networkName'] = $row2['name'];
	
	$cursor3 = pgDb::getOrganizationById($orgId);
	$row3 = pg_fetch_array($cursor3);
	$_SESSION['orgName'] = $row3['name'];

	
} else {
	header("location:../view/login.php?error=Your enrollment has failed. Please contact the person who sent your enrollment code.");
	exit(0);
}

?>