<?php

session_start();

include("pgDb.php");
include("util.php");

$action = Util::clean($_POST['action']);

if ($action == "updateProfile") {


}

if ($action == "inactivateProfile") {

	pgDb::inactivateUser($_SESSION['userId']);

}

if ($action == "reactivateProfile") {

	pgDb::reactivateUser($_SESSION['userId']);

}

header("location:userViews.php");

?>