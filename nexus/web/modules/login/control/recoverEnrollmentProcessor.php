<?php

session_start();

require_once("../../../src/framework/Util.php");
require_once(Utilities::getSrcRoot() . "/user/User.php");

$dirty = array('email' => $_POST['email'], 'network' => $_POST['network']);
$clean = array();

if (isset($dirty['network']) && Utilities::validateNetworkIdFormat($dirty['network'])) {
	$clean['network'] = $dirty['network'];
} else {
	$clean['network'] = "";	
}

if (isset($dirty['email']) && Utilities::validateEmail($dirty['email'])) {
	$clean['email'] = $dirty['email'];
}

if ($clean['email']) {	
	
	$row = pg_fetch_row(User::userEmailExists($clean['email']));
  $exists = $row[0];	
  if (!strcmp($exists, "t")) {
		$cursor = User::getUsernamesByEmail($clean['email']);
		$usernames = "";
		while ($row = pg_fetch_array($cursor)) {
	  		$usernames = $usernames . $row['username'] . ", ";
	 	}
	 	sendEnrollEmail($clean['email'], $usernames);
		returnToLoginWithMessage("Your enrollment package has been sent to " . $clean['email'] . ".", $clean['network']);
	}		

}

returnToLoginWithMessage(Utilities::AUTHENTICATION_ERROR, $clean['network']);

function returnToLoginWithMessage($errorMessage, $network) {
	header("location:" . Utilities::getHttpPath() . "/login.php?network=" . $network . "&error=" . $errorMessage);
	exit(0);
}

function sendEnrollEmail($email, $usernames) {
	
	$message = "Welcome!
		
The Nexus Web Meet user ids registered for this email address: " . Utilities::stripTrailingComma($usernames) . "

You can login to Nexus Web Meet using this link.

" . Utilities::getHttpPath() . "/login.php

Sincerely,

The Development Team at
NorthBridge Technology Alliance

";

		mail($email, "[Nexus] Enrollment Confirmation", $message, "From: noreply@northbridgetech.org\r\n");		
		
}

?>