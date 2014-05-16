<?php

session_start();

include("pgDb.php");
include("util.php");

$action = Util::clean($_POST['action']);
$uid = Util::clean($_POST['uid']);
$password = Util::clean($_POST['password']);

if ($action == "authenticate") {
	$message = "";
	if (Util::authenticate($uid, $password)) {
		$message = "?error=Good login.";
		refreshSession($uid);
	} else {
		$message = "?error=Invalid credentials.";
	}
	header("location:sessionViews.php" . $message);
	exit(0);
}

function refreshSession($uid) {

		session_regenerate_id();
		session_unset();
		
		$cursor = pgDb::getUserSessionByUsername($uid);
		$row = pg_fetch_array($cursor);			
		$_SESSION['fname'] = $row['fname'];
		$_SESSION['lname'] = $row['lname'];
 		$_SESSION['role'] = $row['role'];
  	$_SESSION['network'] = $row['network'];
		$_SESSION['affiliation'] = $row['affiliation'];
		$_SESSION['handle'] = "TODO";

}

?>