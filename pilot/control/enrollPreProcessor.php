<?php

//error_reporting(E_ALL);
//ini_set( 'display_errors','1');

include("../model/pgDb.php");
include("../control/util.php");
require_once("/home1/northbr6/php/Validate.php");

$inviteId = $networkId = "";
$validInvitation = false;

// TODO - what if these session vars are not set yet? like, on first load.

$stickyUserId = $_SESSION['stickyForm']['userid'];
$stickyPassword1 = $_SESSION['stickyForm']['password1'];
$stickyPassword2 = $_SESSION['stickyForm']['password2'];
$stickyFname = $_SESSION['stickyForm']['fname'];
$stickyLname = $_SESSION['stickyForm']['lname'];
$stickyEmail = $_SESSION['stickyForm']['email'];
$stickyOrgName = $_SESSION['stickyForm']['orgName'];

unset($_SESSION['stickyForm']);
$_SESSION['networkName'] = $_SESSION['orgName'] = $_SESSION['networkId'] = $_SESSION['orgId'] = "";

if (Validate::string($_GET['invitation'], array(
		'format' => VALIDATE_ALPHA_LOWER . VALIDATE_NUM . "-", 
		'min_length' => 36, 
		'max_length' => 36))) {
	if (pgDb::checkValidInvitation($_GET['invitation'])) {
		$inviteId = $_GET['invitation'];
		$validInvitation = true;
	}
}

if ($validInvitation) {
	
	$cursor1 = pgDb::getInvitationByUuid($inviteId);
	$row1 = pg_fetch_array($cursor1);
	$_SESSION['networkId'] = $row1['networkid'];
	//$_SESSION['orgId'] = $row1['orgid'];
	$_SESSION['grantorId'] = $row1['grantorid'];
	$_SESSION['groupId'] = $row1['groupid'];

	$cursor2 = pgDb::getOrganizationById($_SESSION['networkId']);
	$row2 = pg_fetch_array($cursor2);
	$_SESSION['networkName'] = $row2['name'];
	$_SESSION['logo'] = $row2['logo'];
		
	$cursor4 = pgDb::getGroupById($_SESSION['groupId']);
	$row4 = pg_fetch_array($cursor4);
	$_SESSION['groupName'] = $row4['name'];
	
} else {
	header("location:login.php");
	exit(0);
}

?>