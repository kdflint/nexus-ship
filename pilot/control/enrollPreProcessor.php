<?php

//error_reporting(E_ALL);
//ini_set( 'display_errors','1');

include("../model/pgDb.php");
include("../control/util.php");

$inviteId = $networkId = "";
$validInvitation = false;

//session_destroy();

$_SESSION['networkName'] = $_SESSION['orgName'] = $_SESSION['networkId'] = $_SESSION['orgId'] = "";

// NOTE: instead, for validation reload, should put the invite back into GET parm so every page load starts in same state
// destroy session at the top of every page load. 
if(isset($_SESSION['inviteId'])) {
	// This is possible if we are reloading page on validation error
	$validInvitation = true;
	
} else if(isset($_GET['invitation'])) {
	
	// TODO: check that none of these characters would be valid in a php-generated uuid
	$inviteId = Util::strip($_GET['invitation']);
	if(strlen($inviteId) == 36) {
		if (pgDb::checkValidInvitation($inviteId)) {
			$validInvitation = true;
			$_SESSION['inviteId'] = $inviteId;
		}
	}
}

if ($validInvitation) {
	
	$cursor1 = pgDb::getInvitationByUuid($_SESSION['inviteId']);
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