<?php

session_start();

require_once("../src/framework/Util.php");

$cleanTz = "";
if(isset($_GET['timezone']) && strlen($_GET['timezone']) > 0) {
 	$cleanTz = $_GET['timezone'];		
}

Utilities::setSessionTimezone($cleanTz);	

exit(0);

?>