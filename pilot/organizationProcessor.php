<?php

include("pgDb.php");
include("util.php");

session_start();

$name = Util::clean($_POST['orgName']);
$handle = "";
$ein = Util::clean($_POST['ein']);
$exempt = Util::clean($_POST['exempt']);
$structure = Util::clean($_POST['structure']);
$mission = Util::clean($_POST['mission']);
$program = Util::clean($_POST['program']);

//$newId = pgDb::insertOrganization($name, $handle, $ein, $exempt, $structure, $mission, $program);

$newId = pgDb::insertOrganization("test", "test", "452813375", false, "test", "test", "test");

//Util::refreshSessionOrganization($newId);

header("location:organizationDetail.php");

}


?>