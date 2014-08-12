<?php

include("pgDb.php");
include("util.php");

session_start();

$action = Util::clean($_POST['action']);
$orgId = Util::clean($_POST['orgId']);
$term = Util::clean($_POST['term']);


if ($action == "updateOrganization") {


}

if ($action == "inactivateOrganization") {

	pgDb::inactivateOrganization($orgId);

}

if ($action == "reactivateOrganization") {

	pgDb::reactivateOrganization($orgId);

}

if ($action == "searchDirectory") {
	
	header("location:organizationViews.php?term=" . $term);
	exit(0);

}


header("location:organizationViews.php");




?>