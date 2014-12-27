<?php

//error_reporting(E_ALL);
//ini_set( 'display_errors','1');

require_once("util.php");
require_once($_SESSION['appRoot'] . "model/pgDb.php");

$_SESSION['email'] = $_SESSION['sms'] = $_SESSION['phone'] = $count = "";

$count = pgDb::countOrgsInNetworkById($_SESSION['networkId']);

$cursor = pgDb::getUserById($_SESSION['uidpk']);

$email_status = $sms_status = $email_publish = $sms_publish = $phone_publish = "";

while ($row = pg_fetch_array($cursor)) {
	$_SESSION['email'] = $row['email'];
  $_SESSION['sms'] = Util::prettyPrintPhone($row['cell']);
  $_SESSION['phone'] = Util::prettyPrintPhone($row['phone']);
  $email_status = (strcmp($row['emailon'], "f") == 0 ? "" : "checked");
  $sms_status = (strcmp($row['smson'], "f") == 0 ? "" : "checked");
  $email_publish = (strcmp($row['emailpub'], "f") == 0 ? "" : "checked");
  $sms_publish = (strcmp($row['smspub'], "f") == 0 ? "" : "checked");
  $phone_publish = (strcmp($row['phonepub'], "f") == 0 ? "" : "checked");
  $descr = $row['descr'];
}

?>