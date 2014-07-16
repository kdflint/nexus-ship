<?php

include("../model/pgDb.php");
include("../control/util.php");

$inviteId = $networkId = "";
$validInvitation = false;

$_SESSION['inviteId'] = $_SESSION['networkName'] = $_SESSION['orgName'] = $_SESSION['networkId'] = $_SESSION['orgId'] = "";

if(isset($_GET['invitation'])) {
	// TODO: check that none of these characters would be valid in a php-generated uuid
	$inviteId = Util::strip($_GET['invitation']);
	if(strlen($inviteId) == 36) {
		if (pgDb::checkValidInvitation($inviteId)) {
			$validInvitation = true;
		}
	}
}

if ($validInvitation) {
	
	$_SESSION['inviteId'] = $inviteId;
	
	$cursor1 = pgDb::getInvitationByUuid($inviteId);
	$row1 = pg_fetch_array($cursor1);
	$_SESSION['networkId'] = $row1['networkid'];
	$_SESSION['orgId'] = $row1['orgid'];
	$_SESSION['grantorId'] = $row1['grantorid'];

	$cursor2 = pgDb::getOrganizationById($_SESSION['networkId']);
	$row2 = pg_fetch_array($cursor2);
	$_SESSION['networkName'] = $row2['name'];
	
	$cursor3 = pgDb::getOrganizationById($_SESSION['orgId']);
	$row3 = pg_fetch_array($cursor3);
	$_SESSION['orgName'] = $row3['name'];

	
} else {
	header("location:login.php");
	exit(0);
}

?>