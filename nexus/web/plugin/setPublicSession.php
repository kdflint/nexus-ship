<?php

session_start();

require_once("../src/framework/Util.php");

$cleanTz = "";
if(isset($_GET['timezone']) && strlen($_GET['timezone']) > 0) {
 	$cleanTz = $_GET['timezone'];		
}

$cleanId = "";
if(isset($_GET['oid']) && Utilities::validateOrganizationUidFormat($_GET['oid'])) {
 	$cleanId = $_GET['oid'];		
}

$cleanFname = "";
if(isset($_GET['fname'])) {
 	$cleanFname = Utilities::sanitize($_GET['fname']);		
}

//fake uuid to cover no uuid input
//$cleanUuid = "f1178137-a8a8-4843-9043-d1d772a325b0";
$cleanUuid = false;
if(isset($_GET['uuid']) && strlen($_GET['uuid']) > 0 && Utilities::validateUuid($_GET['uuid'])) {
 	$cleanUuid = $_GET['uuid'];		
}

Utilities::setPublicSession($cleanId, $cleanTz, $cleanFname, $cleanUuid);	

exit(0);

?>