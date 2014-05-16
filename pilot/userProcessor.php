<?php

session_start();

include("pgDb.php");
include("util.php");

$action = Util::clean($_POST['action']);

if ($action == "updateProfile") {

	header("location:userViews.php");
	exit(0);
}


?>