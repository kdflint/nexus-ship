<?php

session_start();

//error_reporting(E_ALL);
//ini_set( 'display_errors','1');

include("../model/pgDb.php");
include("util.php");
require_once 'error/handlers.php';

$fname = $lname = $sms = $email = $password = "";
$smsEnabled = $emailEnabled = "false";

if (isset($_POST['sms_status'])) {$smsEnabled = "true";}
if (isset($_POST['email_status'])) {$emailEnabled = "true";}

$input = array('email' => $_POST['email'],
							'fname' => $_POST['fname'],
							'lname' => $_POST['lname'],
							'password1' => $_POST['password1'],
							'password2' => $_POST['password2'],
							'sms' => Util::stripPhone($_POST['sms'])
							);
							
$result = Util::validateUserProfile($input, FALSE);

if (count($result['error']) > 0) {
	foreach ($result['error'] as $value) {
		returnToProfileWithError($value);
		break;
	}
}

if (strcmp($_SESSION['email'], $result['good']['email'])) {
	// If user is updating an email address, advise them that their forum email change is pending. Handle manually.
	mail("contact@northbridgetech.org", "Email update has been processed", "User id " . $_SESSION['uidpk'] . " has changed their email address. Please complete forum part.", "From: contact@northbridgetech.org");
}

$_SESSION['email'] = $_SESSION['sms'] = $_SESSION['fname'] = $_SESSION['lname'] = "";

pgDb::updateUserById($_SESSION['uidpk'], 
											$result['good']['fname'], 
											$result['good']['lname'], 
											$result['good']['sms'], 
											$result['good']['email'], 
											$smsEnabled, 
											$emailEnabled);

if (isset($result['good']['password']) && strlen($result['good']['password']) > 0) {
	Util::storeSecurePasswordImplA($result['good']['password'], $_SESSION['uidpk']);
}

$cursor = pgDb::getUserById($_SESSION['uidpk']);

while ($row = pg_fetch_array($cursor)) {
	$_SESSION['email'] = $row['email'];
  $_SESSION['sms'] = Util::prettyPrintPhone($row['cell']);
  $_SESSION['fname'] = $row['first']; 
  $_SESSION['lname'] = $row['last'];
}

//header("location:../view/sessionViews.php");
header("location:../view/nexus.php?thisPage=profile");
exit(0);

function returnToProfileWithError($errorMessage) {
	header("location:../view/nexus.php?thisPage=profile&error=" . $errorMessage);
	exit(0);
}



?>