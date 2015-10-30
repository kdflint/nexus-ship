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
	 	sendEnrollEmail($clean['email'], $env_appRoot, "", $usernames);
		returnToLoginWithMessage("Your enrollment package has been sent to " . $clean['email'] . ".", $clean['network']);
	}		

}

returnToLoginWithMessage(Utilities::AUTHENTICATION_ERROR, $clean['network']);

function returnToLoginWithMessage($errorMessage, $network) {
	header("location:" . Utilities::getHttpPath() . "/login.php?network=" . $network . "&error=" . $errorMessage);
	exit(0);
}

function sendEnrollEmail($email, $path, $fname, $usernames) {
	
	$message = "Welcome!
		
The Nexus user ids registered for this email address: " . Utilities::stripTrailingComma($usernames) . "

This tool is built by committed volunteers working hard to build web resources for organizations that make a positive difference in our communities.

Nexus is constantly being tweaked and new features added. If you have a suggestion for a feature or find a bug please let us know using the feedback tools on the site. We strive to make Nexus as helpful as possible for you.

Some of our current features:

- Discussion Forum and Calendar
- Directory of People and Organizations
- Private Messaging
- Virtual Conference Room

We are working hard on adding:

- Collaboration Tracking
- Advanced Mapping functions

You can login to Nexus using this link. You may wish to check the Help document right away for some information about how to use this site.

" . Utilities::getHttpPath() . "/login.php

Enjoy,

The Development Team at
NorthBridge Technology Alliance

P.S. May we recommend that you visit the Profile tab first to set your messaging settings? Then, you may wish to subscribe to one or more discussions on the Forum tab.
";

		mail($email, "[Nexus] Enrollment Confirmation", $message, "From: noreply@nexus.northbridgetech.org\r\n");		
		
}

?>