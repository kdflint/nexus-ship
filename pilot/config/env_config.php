<?php

require_once(__DIR__ . "/../../new_nexus/config/config_env.php");

// DATABASE

	$db_host = "localhost"; 
	//$db_user = "northbr6_web"; 
	//$db_pass = "bdTEzR?MRs[C";
	$db_user = "postgres"; 
	$db_pass = "postgres";
	$db = "localnexus";
	
	$db_calendar_user = "northbr6";
	$db_calendar_pass = "A56L9Q1X";
	$db_calendar = "northbr6_nbcalendar";

// WEBSITE TOOLBOX

	$wt_forumGroupId = array("1" => "718725", "2" => "718725", "5" => "737073");
	
// WEB CONFERENCE

	$wc_roomNumber = "2222";
	$wc_phone =  array("18" => "(712) 432-1212", "19" => "(712) 775-7031");
	$wc_code =  array("18" => "608 43 0203", "19" => "111 22 3333");
	$wc_pin = "1234";
	
// CALENDAR

	$cal_admin_username = array("18" => "admin", "19" => "kdfTest1");
	
// ENV

	$env_name = "dev";
	$env_number = "1";
	$env_appRoot = "dev";
	$env_fileRoot = "/home1/northbr6/";
	
?>