<?php

include("pgDb.php");
include("util.php");

session_start();

if (isset($_POST['activationCode']) {

	$uuid = Util::clean($_POST['activationCode']);

	$con = pgDb::connect();

	$result = pgDb::getOpenInvitation($con, $uuid);
	
	pgDb::disconnect($con);
	
	$rows = pg_num_rows($result);

	if ($rows == 1) {
	
		while ($row = pg_fetch_array($result)) {	
			$_SESSION['network'] = $row['networkName'];
			//$_SESSION['pendingOrgName'] = $row['orgName']; = ??
			$_SESSION['email'] = $row['email'];
			$_SESSION['uuid'] = $uuid;
			$_SESSION['activate'] = "true";
		}
	
		header("location:userDetail.php");
		exit(0);
	} else {

		header("location:activationError.php");
		exit(0);
	}	

} else if (if isset($_SESSION['activate']) { 
	
	$con = pgDb::connect();
  		
  // clean all these values

	$newUserPk = pgDb::activateAdminUser($con, $_SESSION['uuid'], $_POST['fname'], $_POST['mname'], $_POST['lname'], $_POST['email'], $_POST['sms'], $_POST['password'], $_POST['username']);

	$result = pgDb::setInvitationClosed($con, $uuid);
	
	Util::refreshSession($con, $newUserPk);
	
	pgDb::disconnect($con);	
	
	header("location:userDetail.php");
	exit(0);
	
} else {
	
	$con = pgDb::connect();
  		
  // clean all these values

	$newUserPk = pgDb::updateUser($con, $_SESSION['uuid'], $_POST['fname'], $_POST['mname'], $_POST['lname'], $_POST['email'], $_POST['sms'], $_POST['password'], $_POST['username'], $_SESSION['role']);

	Util::refreshSession($con, $newUserPk);
	
	pgDb::disconnect($con);		

	header("location:userDetail.php");
	exit(0);
	
}

?>