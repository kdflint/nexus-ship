<?php

// PATHS

	define("PHP_ROOT", "/home/kdflint/projects/nexus-community/nexus/web/lib");
	define("WEB_ROOT", "/home/kdflint/projects/nexus-community/nexus/web");
	define("TKN_ROOT", "");
	define("APP_NAME", "/nexus/nexus");
	define("ENV_NAME", "local");
	define("ENV_HOST", "localhost");
	define("SSN_TIMEOUT", "-1"); // in seconds


// DATABASE

	//define("DB_HOST", "50.87.120.82"); 
	define("DB_HOST", "localhost"); 
	define("DB_USER", "northbr6_web"); 
	define("DB_NAME", "localnexus");	
	require_once("sensitive_config.php");
		
?>