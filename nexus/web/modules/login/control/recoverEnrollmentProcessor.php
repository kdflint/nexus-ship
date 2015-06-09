<?php

session_start();

require_once("../../../src/framework/Util.php");
require_once(Util::getPhpRoot() . "/Validate.php");
require_once(Util::getSrcRoot() . "/user/User.php");

echo "Hello from recover enrollment processor.

" . $_POST['email'] . "

" . $_POST['network'];

exit(0);

// clean email
$cleanEmail = "";
$cleanNetwork = "";

if (isset($_POST['network']) && Validate::string($_POST['network'], array('format' => VALIDATE_NUM))) {
	$cleanNetwork = $_POST['network'];
} 

if (isset($_POST['email']) && Util::validateEmail($_POST['email'])) {
			$cleanEmail = $_POST['email'];
}

if ($cleanEmail) {	
	
	$row = pg_fetch_row(User::userEmailExists($cleanEmail));
  $exists = $row[0];	
  if (!strcmp($exists, "t")) {
		$cursor = User::getUsernamesByEmail($cleanEmail);
		$usernames = "";
		while ($row = pg_fetch_array($cursor)) {
	  		$usernames = $usernames . $row['username'] . ", ";
	 	}
	 	sendEnrollEmail($cleanEmail, $env_appRoot, "", $usernames);
		returnToLoginWithMessage("Your enrollment package has been sent to " . $cleanEmail . ".", $cleanNetwork);
	}		

}

returnToLoginWithMessage(Util::AUTHENTICATION_ERROR, $cleanNetwork);

function returnToLoginWithMessage($errorMessage, $network) {
	header("location:../view/login.php?network=" . $network . "&error=" . $errorMessage);
	exit(0);
}

function sendEnrollEmail($email, $path, $fname, $usernames) {
	
	$message = "Welcome!
		
The Nexus user ids registered for this email address: " . Util::stripTrailingComma($usernames) . "

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

http://northbridgetech.org/" . $path . "/nexus/view/login.php

Enjoy,

The Development Team at
NorthBridge Technology Alliance

P.S. May we recommend that you visit the Profile tab first to set your messaging settings? Then, you may wish to subscribe to one or more discussions on the Forum tab.
";

		mail($email, "[Nexus] Enrollment Confirmation", $message, "From: noreply@nexus.northbridgetech.org\r\n");		
		
}

?>