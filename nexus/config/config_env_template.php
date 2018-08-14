<?php

// PATH ROOTS - must be configured per environment
	
	// Nexus source code root
	define("CODE_ROOT", "<northbridge-home>/nexus-community/nexus");
	
	// phppBB installation root
	define("PHPBB3_ROOT", "<northbridge-home>/phpBB3");
	
	// Composer root
	define("COMPOSER_ROOT", "<northbridge-home>/vendor");

// RELATIVE PATHS
	define("PHP_ROOT", CODE_ROOT . "/lib");
	define("WEB_ROOT", CODE_ROOT . "/web");
	define("TKN_ROOT", CODE_ROOT . "/token");
	define("LIB_ROOT", CODE_ROOT . "/lib");
	define("PTR_ROOT", CODE_ROOT . "/partner");
	define("LCL_ROOT", CODE_ROOT . "/locale");
	define("INC_ROOT", CODE_ROOT . "/include");
	define("LOG_ROOT", CODE_ROOT . "/log");
	define("PTR_STC_ROOT", "/partner");
	define("APP_NAME", "/nexus");
	define("PILOT_NAME", "/nexus/pilot");
	define("ENV_NAME", "local");
	define("ENV_HOST", "localhost");
	define("SUPPORT_URL", "http://northbridgetech.org/dev/support");
	define("MEMBER_URL", "https://northbridgetech.org/dev/members/?q=login");
	define("FORUM_URL", "localhost/phpBB3");
	define("ENV_PROTOCOL", "http://");

// OTHER
	define("SSN_TIMEOUT", "-1"); // in seconds
	define("PUBLIC_GROUP", "1"); // was 7
	define("SMS_SERVICE_USER", "kdflint");
	define("FORUM_REGISTERED_USER_GROUP", "2"); // was 8
	define("FB_APP_ID", "135380813711111");
	define("LI_APP_ID", "78yai2gi611111");


// DATABASE
	define("DB_HOST", "localhost"); 
	define("DB_USER", "northbri_web"); 
	define("DB_NAME", "localnexus");	
	define("FORUM_HOST", "localhost");
	define("FORUM_USER", "postgres");
	define("FORUM_NAME", "localphpbb");
	define("CRM_HOST", "localhost");
	define("CRM_USER", "");
	define("CRM_NAME", "");
	define("CRM_ACTIVATION_TABLE", "");
	define("CRM_ACTIVATION_ROW_OID", "");
	define("CRM_ACTIVATION_ROW_ENROLL", "");
	define("CRM_ACTIVATION_ROW_IS_ENROLLED", "");
	
// SENSITIVE
	require_once("sensitive_config.php");
	
// DEMO
	define("DEMO_UIDPK", "287");
	define("DEMO_USERNAME", "userdemo");
	define("DEMO_PASSWORD", "fakepassword295");
	define("DEMO_EVENT_NOW", "75");
	define("DEMO_EVENT_FUTURE", "76,77");
	
// TEMPORARY
	define("CFCHT_NEW_GROUP", "14");
		
?>
