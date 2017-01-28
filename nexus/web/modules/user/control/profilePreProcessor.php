<?php

require_once("src/framework/Util.php");
require_once(Utilities::getSrcRoot() . "/organization/Organization.php");
require_once(Utilities::getSrcRoot() . "/user/User.php");

// TODO - session management should be abstracted to Util
$_SESSION['email'] = $_SESSION['sms'] = $_SESSION['phone'] = $count = "";

$count = Organization::countOrgsInNetworkById($_SESSION['networkId']);

$cursor = User::getUserById($_SESSION['uidpk']);

$email_status = $sms_status = $email_publish = $sms_publish = $phone_publish = "";

while ($row = pg_fetch_array($cursor)) {
	$_SESSION['email'] = $row['email'];
  $_SESSION['sms'] = Utilities::prettyPrintPhone($row['cell']);
  $_SESSION['phone'] = Utilities::prettyPrintPhone($row['phone']);
  $email_status = (strcmp($row['emailon'], "f") == 0 ? "" : "checked");
  $sms_status = (strcmp($row['smson'], "f") == 0 ? "" : "checked");
  $email_publish = (strcmp($row['emailpub'], "f") == 0 ? "" : "checked");
  $sms_publish = (strcmp($row['smspub'], "f") == 0 ? "" : "checked");
  $phone_publish = (strcmp($row['phonepub'], "f") == 0 ? "" : "checked");
  $descr = $row['descr'];
}

?>