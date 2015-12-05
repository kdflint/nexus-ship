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

$cleanUuid = 0;
if(isset($_GET['uuid']) && Utilities::validateUuid($_GET['uuid'])) {
 	$cleanUuid = $_GET['uuid'];		
}

Utilities::setPublicSession($cleanId, $cleanTz, $cleanFname, $cleanUuid);	

?>