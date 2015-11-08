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

Utilities::setPublicSession($cleanId, $cleanTz);	

?>