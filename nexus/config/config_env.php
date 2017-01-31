<?php

// PATHS
	define("PHP_ROOT", "/home/kdflint/projects/nexus-community/nexus/lib");
	define("WEB_ROOT", "/home/kdflint/projects/nexus-community/nexus/web");
	define("TKN_ROOT", "/home/kdflint/projects/nexus-community/nexus/token");
	define("LIB_ROOT", "/home/kdflint/projects/nexus-community/nexus/lib");
	define("PTR_ROOT", "/home/kdflint/projects/nexus-community/nexus/partner");
	define("LCL_ROOT", "/home/kdflint/projects/nexus-community/nexus/locale");
	define("PHPBB3_ROOT", "/home/kdflint/phpBB3");
	define("LOG_ROOT", "/home/kdflint/projects/nexus-community/nexus/log");
	define("PTR_STC_ROOT", "/partner");
	define("APP_NAME", "/nexus/nexus");
	define("PILOT_NAME", "/nexus/pilot");
	define("ENV_NAME", "local");
	define("ENV_HOST", "localhost");
	define("SUPPORT_URL", "http://northbridgetech.org/dev/support");
	define("FORUM_URL", "http://localhost/phpBB3");

// OTHER
	define("SSN_TIMEOUT", "-1"); // in seconds
	define("PUBLIC_GROUP", "7");
	define("SMS_SERVICE_USER", "kdflint");
	define("FORUM_REGISTERED_USER_GROUP", "8");

// DATABASE
	define("DB_HOST", "localhost"); 
	define("DB_USER", "northbr6_web"); 
	define("DB_NAME", "localnexus");	
	define("FORUM_HOST", "localhost");
	define("FORUM_USER", "postgres");
	define("FORUM_NAME", "localphpbb");
	
// SENSITIVE
	require_once("sensitive_config.php");
	
// DEMO
	define("DEMO_UIDPK", "287");
	define("DEMO_USERNAME", "userdemo");
	define("DEMO_PASSWORD", "fakepassword295");
	define("DEMO_EVENT_NOW", "75");
	define("DEMO_EVENT_FUTURE", "76,77");
	
// TEMPORARY
	define("EVENT_APPROVE_LIST", "kathy.flint@northbridgetech.org");
	define("CFCHT_FORUM_USER_GROUP", "8");
	define("CFCHT_NEW_GROUP", "14");
		
?>