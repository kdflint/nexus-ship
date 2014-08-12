<?php

error_reporting(E_ALL);
ini_set( 'display_errors','1');

include("../model/pgDb.php");
include("util.php");

$_SESSION['email'] = $_SESSION['sms'] = $count = "";

$count = pgDb::countOrgsInNetworkById($_SESSION['networkId']);

$cursor = pgDb::getUserById($_SESSION['uidpk']);

$email_status = $sms_status = "";

while ($row = pg_fetch_array($cursor)) {
	$_SESSION['email'] = $row['email'];
  $_SESSION['sms'] = Util::prettyPrintPhone($row['cell']);
  $email_status = (strcmp($row['emailon'], "f") == 0 ? "" : "checked");
  $sms_status = (strcmp($row['smson'], "f") == 0 ? "" : "checked");
}

?>