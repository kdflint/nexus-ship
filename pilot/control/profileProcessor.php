<?php

session_start();

error_reporting(E_ALL);
ini_set( 'display_errors','1');

include("../model/pgDb.php");
include("util.php");

$fname = $lname = $sms = $email = "";
$smsEnabled = $emailEnabled = "false";

if (isset($_POST['sms_status'])) {$smsEnabled = "true";}
if (isset($_POST['email_status'])) {$emailEnabled = "true";}

$input = array('email' => $_POST['email'],
							'fname' => $_POST['fname'],
							'lname' => $_POST['lname'],
							'sms' => Util::stripPhone($_POST['sms'])
							);

$result = Util::validateUserProfile($input);

if (count($result['error']) > 0) {
	// TODO: give array of error strings to page for display
	returnToProfileWithError("Please enter valid data in all required fields.");
}

$_SESSION['email'] = $_SESSION['sms'] = $_SESSION['fname'] = $_SESSION['lname'] = "";

pgDb::updateUserById($_SESSION['uidpk'], 
											$result['good']['fname'], 
											$result['good']['lname'], 
											$result['good']['sms'], 
											$result['good']['email'], 
											$smsEnabled, 
											$emailEnabled);

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