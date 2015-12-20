<?php

session_start();

require_once("../../../src/framework/Util.php");

$message = "This message was just submitted.\r\n\r\n";

foreach ($_POST as $key=>$val) {
 	$message = $message . "\r\n" . $key . ":" . $val ."";
}

mail("kathy.flint@northbridgetech.org", "CFCHT Event Add", $message, "");

header("location:" . Utilities::getPluginPath() . "/publicSuite.php?oid=" . $_SESSION['orgId'] . "&context=calendar");

exit(0);


?>