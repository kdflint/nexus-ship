<?php

session_start();

//error_reporting(E_ALL);
//ini_set( 'display_errors','1'); 

require_once '../model/pgDb.php';
require_once 'util.php';
require_once '../config/env_config.php';
require_once '/home1/northbr6/php/Validate.php';
require_once dirname(__FILE__).'/forum_sso_functions.php';

// TODO - do I have to put these in session?? Better option?
$_SESSION['stickyForm']['userid'] = $_POST['userid'];
$_SESSION['stickyForm']['password1'] = $_POST['password1'];
$_SESSION['stickyForm']['password2'] = $_POST['password2'];
$_SESSION['stickyForm']['fname'] = $_POST['fname'];
$_SESSION['stickyForm']['lname'] = $_POST['lname'];
$_SESSION['stickyForm']['email'] = $_POST['email'];
$_SESSION['stickyForm']['orgName'] = $_POST['orgname'];

// Cleanse all user input

$cleanInvite = "bogus";

if(Validate::string($_POST['invitation'], array(
		'format' => VALIDATE_ALPHA_LOWER . VALIDATE_NUM . "-", 
		'min_length' => 36, 
		'max_length' => 36))) {
	if (pgDb::checkValidInvitation($_POST['invitation'])) {
		$cleanInvite = $_POST['invitation'];
	}
}

$dirty = array('username' => $_POST['userid'],
							'email' => $_POST['email'],
							'fname' => $_POST['fname'],
							'lname' => $_POST['lname'],
							'password1' => $_POST['password1'],
							'password2' => $_POST['password2']
							);
							
$clean = Util::validateUserProfile($dirty, TRUE);

// TODO - when we build org screen, move this logic to validateOrgProfile method.
if (!isset($_POST['orgname']) ||
		!Validate::string($_POST['orgname'], array('format' => VALIDATE_EALPHA . VALIDATE_NUM . VALIDATE_SPACE . "'" . "_", 'min_length' => 2, 'max_length' => 100))) {
		$clean['error']['orgname'] = Util::VALIDATION_ORGNAME_ERROR;
} else {
	$clean['good']['orgname'] = strtr($_POST['orgname'], array("'" => '&apos;'));
}

// From this point, anything in $_SESSION or $clean* can be trusted.

if (count($clean['error']) > 0) {
	foreach ($clean['error'] as $value) {
		returnToEnrollWithError($value);
		break;
	}
}

$uid = $clean['good']['username'];
$password = $clean['good']['password'];
$fname = $clean['good']['fname'];
$lname = $clean['good']['lname'];
$email = $clean['good']['email'];
$orgName = $clean['good']['orgname'];

$validInvitation = $isAuthenticated = FALSE;

$_SESSION['fname'] = $_SESSION['lname'] = $_SESSION['uidpk'] = $_SESSION['forumSessionError'] = $_SESSION['username'] = "";

if (strcmp($cleanInvite, "bogus") && pgDb::checkValidInvitation($cleanInvite)) {
	$validInvitation = TRUE;
}

if ($validInvitation){
	
	// TODO: make sure username is unique inside network
	// TODO: activate only on confirmed email code
	// TODO: insert other user values into db
	
	$_SESSION['uidpk'] = pgDb::insertActiveUser(Util::newUuid(), $uid, $fname, $lname, $email, $password);
	
	// TODO - need policy on dupe org names
	// At this time, user will get enrolled with first org name match if there is > 1 org name match
	$row = pg_fetch_row(pgDb::orgNameExists($orgName));
	$nameMatch = $row[0];
	if (!strcmp($nameMatch, "t")) {
		$row = pg_fetch_array(pgDb::getOrganizationByName($orgName));
		$_SESSION['orgId'] = $row['id'];
	} else {
		$row = pg_fetch_row(pgDb::insertPendingOrganization($orgName, $_SESSION['grantorId'], 3));
		$_SESSION['orgId'] = $row[0];
		pgDb::insertOrgOrgRelation($_SESSION['networkId'], $_SESSION['orgId'], 'parent');
	}
	
	$_SESSION['orgName'] = $orgName;
	
	pgDb::insertUserOrgRelation($_SESSION['uidpk'], $_SESSION['orgId'], $_SESSION['grantorId']);
	
	pgDb::insertUserGroupRelation($_SESSION['uidpk'], $_SESSION['groupId']);
	
	$isAuthenticated = true;
	
	sendConfirmationEmail($email, $env_appRoot, $fname);
		
	$row4 = pg_fetch_row(pgDb::forumEmailExists($email));
	$emailMatch = $row4[0];
	if (!strcmp($emailMatch, "t")) {
		// This user is enrolling with a duplicate email address, which is legal for Nexus but not for Website Toolbox Forum.
		// Take evasive action so they do not feel an error and follow up by email.
		$email = $_SESSION['uidpk'] . "." . $email;
		mail("contact@northbridgetech.org", "Duplicate attempt for forum email", "User id " . $_SESSION['uidpk'] . " has attempted to enroll with a duplicate forum email address. Please advise.", "From: contact@northbridgetech.org");
	}
	
	$forumUsername = $fname . " " . $lname;
	
	$row5 = pg_fetch_row(pgDb::forumUsernameExists($forumUsername));
	$nameMatch = $row5[0];
	if (!strcmp($nameMatch, "t")) {
		// This user is enrolling with a duplicate forum username.
		// Take evasive action so they do not feel an error.
		$forumUsername = $forumUsername . " " . $_SESSION['uidpk'];
	}	
	
	$row2 = pg_fetch_row(pgDb::insertUserForumRelation($_SESSION['uidpk'], $fname, $password, $forumUsername, $email));
	$forumId = $row2[0];
	
	// Register user with forum
	$user = array();
	$user['member'] = $forumUsername;
	$user['pw'] = $password;
	$user['email'] = $email;	
	$user['name'] = $orgName;
	$user['usergroupid'] = $wt_forumGroupId[$_SESSION['networkId']];
	$user['auto_topic_value'] = "topics";
	$register_status = forumSignup($user);
	if($register_status == 'Registration Complete') {
		$_SESSION['forumSessionError'] = "noError";
	} else {
		$_SESSION['forumSessionError'] = $register_status;
	}
	
	// Register user with conference room
	$roomLink = "/openmeetings/swf?invitationHash=" . conferenceRegistration($fname, $wc_roomNumber);
	pgDb::insertRoomLink($_SESSION['uidpk'], $roomLink);
		
	if($isAuthenticated){
		$cursor = pgDb::getUserByUsername($uid);
		$_SESSION['username'] = $uid;
		
		while ($row = pg_fetch_array($cursor)) {
			$_SESSION['fname'] = $row['fname'];
  		$_SESSION['lname'] = $row['lname'];
		}
		
		$_SESSION['groups'] = pgDb::getUserGroupsByUsername($_SESSION['username']);
		unset($_SESSION['groupId']);
		unset($_SESSION['groupName']);
		unset($_SESSION['grantorId']);
	
		header("location:../view/nexus.php?thisPage=profile");
		exit(0);
	
	} else {
		// Basic user setup failed
		header("location:../view/login.php");
		exit(0);	
	}
	
} else {
	// Invitation was invalid
	header("location:../view/login.php");
	exit(0);	
}
	
function returnToEnrollWithError($errorMessage) {
	global $cleanInvite;
	header("location:../view/enroll.php?invitation=" . $cleanInvite . "&error=" . $errorMessage);
	exit(0);
}

function conferenceRegistration($name, $room) {
	$serviceDomain = "http://ec2-54-235-156-5.compute-1.amazonaws.com/openmeetings/services";
	$adminUserName = "kdflint";
	$adminUserPass = "0cnbctc!";
	$sessionId = $invitationHash = "";
	$roomLink = "";
	
	$sessionCall = $serviceDomain . "/UserService/getSession";
	$sessionResult = file_get_contents($sessionCall);       
	preg_match('/:session_id>(.*?)</', $sessionResult, $matches);
	$sessionId = $matches[1];
	
	$loginCall = $serviceDomain . "/UserService/loginUser?SID=" . $sessionId . "&username=" . $adminUserName . "&userpass=" . $adminUserPass;
	$loginResult = file_get_contents($loginCall);
	preg_match('/:return>(.*?)</', $loginResult, $matches);
	$loginResult = $matches[1];
	
	if (!strcmp($loginResult, "1")) {
		// Must make this call using a session id that is tied to an authenticated user
		$inviteCall = $serviceDomain . "/RoomService/getInvitationHash?SID=" . $sessionId . "&username=" . $name . "&room_id=" . $room . "&isPasswordProtected=0&invitationpass=&valid=1&validFromDate=&validFromTime=&validToDate=&validToTime=";
		$xmlInvite = file_get_contents($inviteCall);
		preg_match('/:return>(.*?)</', $xmlInvite, $matches);
		$invitationHash = $matches[1];
}
	
	if ((strcmp($loginResult, "1") != 0) || strlen($invitationHash) != 32) {
		// We think something went wrong generating the invitation link. Handle this manually.
		mail("support@nexus.northbridgetech.org",
		 	"Bad Nexus room link generation",
		 	"User id " . $_SESSION['uidpk'],
		 	"From: contact@northbridgetech.org");
	} else {
		// We think we have a good invitation.
		$roomLink = $invitationHash;
	}

	return $roomLink;
}

function sendConfirmationEmail($email, $path, $fname) {
	
	$message = "Welcome " . $fname . "!
	
Your enrollment is complete. 
	
You are now enabled to collaborate with " . $_SESSION['groupName'] . " hosted by " . $_SESSION['networkName'] . ".

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

You can login to Nexus using this link. Check the Help document for some information about how to use this site.

http://northbridgetech.org/" . $path . "/nexus/view/login.php

Enjoy,

The Development Team at
NorthBridge Technology Alliance

P.S. May we recommend that you visit the Profile tab first to set your messaging settings? Then, you may wish to subscribe to one or more discussions on the Forum tab.";

		mail($email, "[Nexus] Enrollment Confirmation", $message, "From: noreply@nexus.northbridgetech.org\r\n");		
		
}

?>