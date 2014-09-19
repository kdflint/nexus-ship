<?php

session_start();

//error_reporting(E_ALL);
//ini_set( 'display_errors','1'); 

require_once ("../model/pgDb.php");
require_once ("../control/util.php");
require_once ("../config/env_config.php");
require_once dirname(__FILE__).'/forum_sso_functions.php';

// TODO: leverage util method (see profileProcessor.php line 17)

$_SESSION['inviteId'] = $_POST['invitation'];

if (!isset($_POST['userid']) || strlen($_POST['userid']) < 1) {
	returnToEnrollWithError("Please choose your username");
}

if (!isset($_POST['password']) || strlen($_POST['password']) < 1) {
	returnToEnrollWithError("Please choose your password");
}

if (!isset($_POST['fname']) || strlen($_POST['fname']) < 1) {
	returnToEnrollWithError("Please enter your first name.");
}

if (!Util::validateEmail($_POST['email'])) {
	// TODO: test this method against email specs - am i open to script injection if i pass this test??
	returnToEnrollWithError("Please enter a valid email address.");
}

if (!isset($_POST['orgname']) || strlen($_POST['orgname']) < 1) {
	returnToEnrollWithError("Please enter the name of the organization you represent.");
}

$row1 = pg_fetch_row(pgDb::userNameExists($_POST['userid']));
$exists = $row1[0];
if (!strcmp($exists, "t")) {
	returnToEnrollWithError("This username already exists. Please select a different username.");
}

// TODO: strategy for decon on this user input
$uid = $_POST['userid'];
$password = $_POST['password'];
$fname = $_POST['fname'];
$lname = $_POST['lname'];
$email = $_POST['email'];
$orgName = strtr($_POST['orgname'], array("'" => '&apos;'));

$validInvitation = $isAuthenticated = false;

$_SESSION['fname'] = $_SESSION['lname'] = $_SESSION['uidpk'] = $_SESSION['forumSessionError'] = $_SESSION['username'] = $_SESSION['roomLink'] = "";

if(strlen($_SESSION['inviteId']) == 36) {
	if (pgDb::checkValidInvitation($_SESSION['inviteId'])) {
		$validInvitation = true;
	}
}

if ($validInvitation){
	
	// TODO: make sure username is unique inside network
	// TODO: activate only on confirmed email code
	// TODO: insert other user values into db
	
	$_SESSION['uidpk'] = pgDb::insertActiveUser(Util::newUuid(), $uid, $fname, $lname, $email, $password);
	
	// TODO - will break with dupe org name
	$row3 = pg_fetch_row(pgDb::orgNameExists($orgName));
	$nameMatch = $row3[0];
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
	$_SESSION['roomLink'] = "/openmeetings/swf?invitationHash=" . conferenceRegistration($fname, $wc_roomNumber);
	pgDb::insertRoomLink($_SESSION['uidpk'], $_SESSION['roomLink']);
		
	if($isAuthenticated){
		
		$cursor = pgDb::getUserByUsername($uid);
		$_SESSION['username'] = $uid;
		
		// bizarro php bug: https://bugs.php.net/bug.php?id=31750
		// can't specify PGSQL_ASSOC as one might like, but this works
		while ($row = pg_fetch_array($cursor)) {
			$_SESSION['fname'] = $row['fname'];
  		$_SESSION['lname'] = $row['lname'];
  		$_SESSION['password'] = $row['password'];
		}
		
		$_SESSION['groups'] = pgDb::getUserGroupsByUsername($_SESSION['username']);
		unset($_SESSION['groupId']);
		unset($_SESSION['groupName']);
		unset($_SESSION['grantorId']);

		header("location:../view/nexus.php?thisPage=profile");
		exit(0);
		
	
	} else {
		header("location:../view/login.php");
		exit(0);	
	}
	
} else {
	header("location:../view/login.php");
	exit(0);	
}
	
function returnToEnrollWithError($errorMessage) {
	header("location:../view/enroll.php?invitation=" . $_SESSION['inviteId'] . "&error=" . $errorMessage);
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

?>