<?php

session_start();

include("../model/pgDb.php");
include("util.php");
require_once 'error/handlers.php';

$fname = $lname = $sms = $email = $password = "";
$smsEnabled = $emailEnabled = $smsPublic = $emailPublic = "false";

if (isset($_POST['sms_status'])) {$smsEnabled = "true";}
if (isset($_POST['email_status'])) {$emailEnabled = "true";}
if (isset($_POST['sms_public'])) {$smsPublic = "true";}
if (isset($_POST['email_public'])) {$emailPublic = "true";}

$input = array('email' => $_POST['email'],
							'fname' => $_POST['fname'],
							'lname' => $_POST['lname'],
							'password1' => $_POST['password1'],
							'password2' => $_POST['password2'],
							'sms' => $_POST['sms']
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

	$message = "Hello " . $result['good']['fname'] . ",
	
Recently the email address was updated on your Nexus account.

If you did not request this change, please contact our support team at support@northbridgetech.org.

The Support Team at
NorthBridge Technology Alliance";

	mail($_SESSION['email'], "[Nexus] Profile Update", $message, "From: noreply@nexus.northbridgetech.org\r\nCc: " . $result['good']['email']);
}

pgDb::updateUserById($_SESSION['uidpk'], 
											$result['good']['fname'], 
											$result['good']['lname'], 
											$result['good']['sms'], 
											$result['good']['email'], 
											$smsEnabled, 
											$emailEnabled,
											$smsPublic,
											$emailPublic);

if (isset($result['good']['password']) && strlen($result['good']['password']) > 0) {
	Util::storeSecurePasswordImplA($result['good']['password'], $_SESSION['uidpk']);
	
	$message = "Hello " . $result['good']['fname'] . ",
	
Recently the password was updated on your Nexus account.

If you did not request this change, please contact our support team at support@northbridgetech.org.

The Support Team at
NorthBridge Technology Alliance";

	mail($_SESSION['email'], "[Nexus] Profile Update", $message, "From: noreply@nexus.northbridgetech.org\r\nCc: " . $result['good']['email']);
}

$cursor = pgDb::getUserById($_SESSION['uidpk']);

$_SESSION['email'] = $_SESSION['sms'] = $_SESSION['fname'] = $_SESSION['lname'] = "";

while ($row = pg_fetch_array($cursor)) {
	$_SESSION['email'] = $row['email'];
  $_SESSION['sms'] = Util::prettyPrintPhone($row['cell']);
  $_SESSION['fname'] = $row['first']; 
  $_SESSION['lname'] = $row['last'];
}

header("location:../view/nexus.php?thisPage=profile");
exit(0);

function returnToProfileWithError($errorMessage) {
	header("location:../view/nexus.php?thisPage=profile&error=" . $errorMessage);
	exit(0);
}



?>