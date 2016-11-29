<?php

session_start();

require_once("Util.php");

$cleanLang = "";
if(isset($_GET['language']) && strlen($_GET['language']) == 2) {
 	$cleanLang = $_GET['language'];		
}

Utilities::setUserLanguagePreference($cleanLang);	

exit(0);

?>