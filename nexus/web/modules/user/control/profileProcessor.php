<?php

session_start();

require_once("../../../src/framework/Util.php");
require_once(Utilities::getSrcRoot() . "/user/User.php");

// TODO - put authorization checker, session checker, error handling, etc. in a central place. These should go at the top of every processor.

if (!Utilities::isSessionValid()) {
	header("location:" . Utilities::getHttpPath() . "/nexus.php");
	exit(0);
}

$fname = $lname = $sms = $email = $password = $phone = "";
$smsEnabled = $emailEnabled = $smsPublic = $emailPublic = $phonePublic = "false";

if (isset($_POST['sms_status'])) {$smsEnabled = "true";}
if (isset($_POST['email_status'])) {$emailEnabled = "true";}
if (isset($_POST['sms_public'])) {$smsPublic = "true";}
if (isset($_POST['email_public'])) {$emailPublic = "true";}
if (isset($_POST['phone_public'])) {$phonePublic = "true";}

$input = array('email' => $_POST['email'],
							'fname' => $_POST['fname'],
							'lname' => $_POST['lname'],
							'password1' => $_POST['password1'],
							'password2' => $_POST['password2'],
							'sms' => $_POST['sms'],
							'phone' => $_POST['phone'],
							'descr' => ""
							);
							
$result = Utilities::validateUserProfile($input, FALSE);

if (count($result['error']) > 0) {
	foreach ($result['error'] as $value) {
		returnToProfileWithError($value);
		break;
	}
}

if (strcmp($_SESSION['email'], $result['good']['email'])) {
	$message = "Hello " . $result['good']['fname'] . ",
	
Recently the email address was updated on your Nexus Web Meet account.

If you did not request this change, please contact our support team at support@northbridgetech.org.

The Support Team at
Northbridge Technology Alliance";

	mail($_SESSION['email'], "[Nexus] Profile Update", $message, "From: noreply@northbridgetech.org\r\nCc: " . $result['good']['email']);
}

$forumUpdateGo = User::updateUserById($_SESSION['uidpk'], 
											$result['good']['fname'], 
											$result['good']['lname'], 
											$result['good']['sms'], 
											$result['good']['email'], 
											$smsEnabled, 
											$emailEnabled,
											$smsPublic,
											$emailPublic,
											$result['good']['descr'],
											$result['good']['phone'],
											$phonePublic);

$forumPasswordGo = false;
$forumUsername = $_SESSION['username'];

if (isset($result['good']['password']) && strlen($result['good']['password']) > 0) {
	$forumPasswordGo = Utilities::storeSecurePasswordImplA($result['good']['password'], $_SESSION['uidpk']);
	
	$message = "Hello " . $result['good']['fname'] . ",
	
Recently the password was updated on your Nexus Web Meet account.

If you did not request this change, please contact our support team at support@northbridgetech.org.

The Support Team at
Northbridge Technology Alliance";

	mail($_SESSION['email'], "[Nexus] Profile Update", $message, "From: noreply@northbridgetech.org\r\nCc: " . $result['good']['email']);
}

$cursor = User::getUserById($_SESSION['uidpk']);

$_SESSION['email'] = $_SESSION['fname'] = $_SESSION['lname'] = $_SESSION['sms'] = $_SESSION['phone'] = "";

while ($row = pg_fetch_array($cursor)) {
	$_SESSION['email'] = $row['email'];
  $_SESSION['sms'] = Utilities::prettyPrintPhone($row['cell']);
  $_SESSION['phone'] = Utilities::prettyPrintPhone($row['phone']);
  $_SESSION['fname'] = $row['first']; 
  $_SESSION['lname'] = $row['last'];
}

// This is jacked up. We should bundle this functionality into User::updateUserProfile. But phpBB restriction on global access makes us push to down here, after all our globals are accessed. There is no time now to refactor. Eventually we will and organize these methods properly into classes.

$forumSms = ($smsPublic === 'true' ? $_SESSION['sms'] : "");
$forumPhone = ($phonePublic === 'true' ? $_SESSION['phone'] : "");
$forumEmail = ($emailPublic === 'true' ? $_SESSION['email'] : "");
$forumFname = $_SESSION['fname'];
$forumLname = $_SESSION['lname'];

if ($forumUpdateGo && $_SESSION['nexusContext'] === "ADV") {
	require_once(Utilities::getSrcRoot() . "/group/Forum.php");	
	Forum::updateUserProfile($forumUsername, $forumFname, $forumLname, $forumSms, $forumEmail, $forumPhone);
}

/*
if ($forumPasswordGo) {
	$result = Forum::updateUserPasword($forumUsername, $result['good']['password']);
	if (!$result) {
		trigger_error("Fail to update user " . $forumUsername " forum password to " . $result['good']['password'], E_USER_ERROR);
	}		
}
*/

header("location:" . Utilities::getHttpPath() . "/nexus.php?view=profile");
exit(0);

function returnToProfileWithError($errorMessage) {
	header("location:" . Utilities::getHttpPath() . "/nexus.php?view=profile&error=" . $errorMessage);
	exit(0);
}

?>