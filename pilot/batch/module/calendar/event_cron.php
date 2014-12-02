#!/usr/bin/php -q

<?php

require_once("../../config/env_config.php");

connect($db_calendar_user, $db_calendar_pass, $db_calendar);
$eventCount = getYdayEventCount();
disconnect(); 

$headers = "From: kathy.flint@northbridgetech.org\r\n"; 	
mail("kathy.flint@northbridgetech.org", date('m/d/Y') . " event count: " . $eventCount . " (" . $env_name . ")", "", $headers);

exit(0);	

function connect($user, $pass, $db) {
	mysql_connect("localhost", $user, $pass) or die("cannot connect");
  mysql_select_db($db) or die("cannot select DB");
}
	
function disconnect() {
	mysql_close();
}
	
function getYdayEventCount() {
	// Select the number of events that were created or updated yesterday and that start today or in the future
	$result = mysql_query("select count(*) from spc_calendar_events where (date(created_on) = curdate()-1 or date(updated_on) = curdate()-1) and start_date >= curdate()");
	return mysql_result($result, 0);
}	

?>