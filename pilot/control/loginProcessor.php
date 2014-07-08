<?php
require_once dirname(__FILE__).'/forum_sso_functions.php';
include("../model/pgDb.php");
include("util.php");

session_start();

pgDb::connect();

$uid = Util::clean($_POST['uid']);
$password = Util::clean($_POST['password']);

//if (!$db->validateEmail($userid)) {
//	returnToLoginWithError("Please enter a valid email address.");
//}

$isAuthenticated = Util::authenticate($uid, $password);

/*
if(!$isAuthenticated) {
	if (isset($_POST['register'])) {
		$db->insertVolunteer($userid, "", "", "", "");
		include 'includes/userRegistrationEmail.php';
		mail($userid, $subject, $message, $headers);
		$isAuthenticated = true;
		$tab = "?thisPage=profile";
	}
	if ($userid == "backdoor@test.com") {
		$isAuthenticated = true;
	}
} 
*/

if($isAuthenticated){
	//include("forumLoginProcessor.php");
	$user = array();
	$user['user'] = $uid;
	$login_status = forumSignin($user);
	if($login_status == 'Login Successful') {
		$cursor1 = pgDb::getUserSessionByUsername($uid);
		while ($row = mysql_fetch_array($cursor1, MYSQL_BOTH)) {
			// already at SESSION['authtoken'] is the forum SSO token
			$_SESSION['fname'] = $row[0];
  		$_SESSION['lname'] = $row[1];
  		$_SESSION['affiliation'] = $row[3];
  		$_SESSION['level'] = $row[2];
  		$_SESSION['uidpk'] = $row[4];
  		$_SESSION['handle'] = $row[5];
		} 
		$cursor2 = pgDb::getUserNetwork($uid);
		while ($row = mysql_fetch_array($cursor2, MYSQL_BOTH)) {
  		$_SESSION['network'] = $row[0];
		} 
		pgDb::disconnect();
		header("location:nexus.php?showMap=1");
		exit(0);
	} else {
		returnToLoginWithError("Forum login failed: " . $login_status);
		exit(0);
	}
} else {
	returnToLoginWithError("NorthBrige login failed");
	exit(0);
}

function returnToLoginWithError($errorMessage) {
	pgDb::disconnect();
	//header("location:test/loginConfirm.php?message=Fail NorthBridge: ");
	header("location:login.php?error=" . $errorMessage);
}

?>