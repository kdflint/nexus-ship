<?php

require_once(dirname(__FILE__) . "/../../../config/env_config.php");
require_once(PHP_ROOT . "/Validate.php");
require_once(Util::getSrcRoot() . "/user/User.php");
require_once(Util::getSrcRoot() . "/schedule/Event.php");
require_once(Util::getLibRoot() . "/autoload/autoloader.php");

// set config settings
autoloader(array(array(
      'debug' => false, // turn on debug mode (by default debug mode is off)
      'basepath' => Util::getLibRoot(), // basepath is used to define where your project is located
      'extensions' => array('.php'), // allowed class file extensions
      // 'extensions' => array('.php', '.php4', '.php5'), // example of multiple extensions
)));

// now we can set class autoload paths
autoloader(array(
      //'rememberme/rememberme/src/Rememberme',
      //'rememberme/rememberme/src/Rememberme/Storage'
));

// useful when in debug mode
//$cached_paths = autoloader();

// print array of class autoload paths:
// print_r($cached_paths); exit(0);

class Util {
	
	public static function getDbHost() {
		return DB_HOST; 
	}
	
	public static function getDbUser() {
		return DB_USER;  
	}
	
	public static function getDbPassword() {
		return DB_PASSWORD; 
	}
	
	public static function getDbName() {
		return DB_NAME;
	}		
	
	private static $web_path = "/web";
	
	public static function getHttpPath() {
		return "http://" . ENV_HOST . APP_NAME . self::$web_path;
	}
	
	public static function getWebRoot() {	return WEB_ROOT; }
	
	public static function getModulesRoot() {	return self::getWebRoot() . "/modules"; }
	
	public static function getPhpRoot() {	return PHP_ROOT; }
	
	public static function getSrcRoot() {	return self::getWebRoot() . "/src"; }
	
	public static function getLibRoot() {	return self::getWebRoot() . "/lib"; }
	
	public static function getTokenRoot() { return self::getWebRoot() . "/token"; }
	
	public static function getEnvName() { return ENV_NAME; }
	
	private static function getSessionTimeout() { return SSN_TIMEOUT; }
		
	
	const VALIDATION_FNAME_ERROR = "Please enter a valid first name."; 
	const VALIDATION_LNAME_ERROR = "Please enter a valid last name (or none)."; 
	const VALIDATION_SMS_ERROR = "Please enter a valid text number (or none).";
	const VALIDATION_PHONE_ERROR = "Please enter a valid phone number (or none).";
	const VALIDATION_PASSWORD_ERROR = "Please enter valid matching passwords.";
	const VALIDATION_PASSWORD_USERNAME_ERROR = "Username and password cannot be the same.";
	const VALIDATION_USERNAME_FORMAT_ERROR = "Please enter a valid username.";
	const VALIDATION_USERNAME_DUPE_ERROR = "This username already exists. Please select a different username.";
	const VALIDATION_ORGNAME_ERROR = "Please enter the valid organization name that you represent.";
	const VALIDATION_DESCR_ERROR = "Please enter a valid description (or none).";
	const AUTHENTICATION_ERROR = "Your account is not located.";
	const RESET_ERROR = 'Your reset password link is not valid. Click "Forgot Pasword" to generate a new one.';
	
	const NAME_MAX = 25;
	const NAME_MIN = 1;
	// http://en.wikipedia.org/wiki/E.164
	const PHONE_MAX = 20;
	const PHONE_MIN = 6;
	const PASSWORD_MAX = 25;
	const PASSWORD_MIN = 7;
	const USERNAME_MAX = 25;
	const USERNAME_MIN = 7;
	const DESCR_MIN = 0;
	const DESCR_MAX = 250;
	
	public static function validateEmail($in) {
		if (filter_var($in, FILTER_VALIDATE_EMAIL)) {
			return true;
		}
		return false;
	}
	
	public static function validatePhone($in) {
		if(Validate::string($in, array(
    	'format' => VALIDATE_NUM . VALIDATE_SPACE . "." . "(" . ")" . "-",
    	'min_length' => self::PHONE_MIN,
    	'max_length' => self::PHONE_MAX))) {
			return TRUE;
		}
		return FALSE;
	}
	
	public static function validateUuid($in) {
		if(Validate::string($in, array(
			'format' => VALIDATE_ALPHA_LOWER . VALIDATE_NUM . "-", 
			'min_length' => 36, 
			'max_length' => 36))) {
			return TRUE;
		}
		return FALSE;
	}
	
	public static function validateNetworkIdFormat($in) {
		if(Validate::string($in, array(
			'format' => VALIDATE_NUM, 
			'min_length' => 1, 
			'max_length' => 3))) {
				return TRUE;
		}
		return FALSE;
	}
	
	public static function validateOrganizationUidFormat($in) {
		if(Validate::string($in, array(
			'format' => VALIDATE_NUM . VALIDATE_ALPHA,
			'min_length' => 8, 
			'max_length' => 8))) {
				return TRUE;
		}
		return FALSE;
	}
	
	public static function validateUserId($in) {
		if(self::validateUserIdFormat($in)) {
			if (pgDb::userIdExists($in)) {	
				return TRUE;
			}
		}
		return FALSE;
	}
	
	public static function validateUserIdFormat($in) {
		if(Validate::string($in, array(
			'format' => VALIDATE_NUM, 
			'min_length' => 1, 
			'max_length' => 8))) {
				return TRUE;
		}
		return FALSE;
	}	
	
	public static function getRoleName($in) {
		return (($in < 5) ? "admin" : "user");	
	}
		
	// Rules here slightly different to be backward compatible to data inserted prior to validation enforcement
	// TODO - disallow spaces when we go public public
	public static function validateUsernameFormat($in) {
		if(Validate::string($in, array(
				'min_length' => 1, 
    		'max_length' => Util::USERNAME_MAX) 
    	 && !preg_match("/[ ]+/", $in))) {
    		return TRUE;
    }
    return FALSE;
  }
  
	public static function isValidPassword($in) {
		if (isset($in) 
				&& strlen($in) >= self::PASSWORD_MIN
				&& strlen($in) <= self::PASSWORD_MAX
    		&& preg_match("/[a-zA-Z]+/", $in)
    		&& preg_match("/[0-9]+/", $in)
    		&& !preg_match("/[ ]+/", $in)) { 
					return TRUE;			
			} 
			return FALSE;
	}
	
	public static function stripTrailingComma($in) {
		if (!strcmp(substr($in, -2), ", ")) {
			return substr($in, 0, -2);
		}
		return $in;
	}
	
	public static function validateUserProfile($input, $pwRequired) {
		$result = array('good' => array(), 'error' => array());
		
		// EMAIL ADDRESS
		if (isset($input['email']) && self::validateEmail($input['email'])) {
			$result['good']['email'] = $input['email'];
		} else {
			$result['error']['email'] = "Please enter a valid email address.";
		}
		
		// FIRST NAME
		if (isset($input['fname'])) {
			if (Validate::string($input['fname'], array(
    				'min_length' => self::NAME_MIN,
    				'max_length' => self::NAME_MAX))) {
				$result['good']['fname'] = Util::sanitize($input['fname']);			
			} else {
				$result['error']['fname'] = self::VALIDATION_FNAME_ERROR;
			}
 		} else {
			$result['error']['fname'] = self::VALIDATION_FNAME_ERROR;
		}	
		
		// LAST NAME
		if (isset($input['lname']) && strlen($input['lname']) > 0) {
			if (Validate::string($input['lname'], array(
    				'format' => VALIDATE_EALPHA . VALIDATE_NUM . VALIDATE_SPACE . "'" . "_" . "-",
    				'min_length' => self::NAME_MIN,
    				'max_length' => self::NAME_MAX))) {
				$result['good']['lname'] = Util::sanitize($input['lname']);			
			} else {
				$result['error']['lname'] = self::VALIDATION_LNAME_ERROR;
			}
 		} else {
			$result['good']['lname'] = "";
		}	
		
		// DESCRIPTION
		if (isset($input['descr']) && strlen($input['descr']) > 0) {
			if (Validate::string($input['descr'], array(
    				'format' => VALIDATE_EALPHA . VALIDATE_NUM . VALIDATE_PUNCTUATION . "-",
    				'max_length' => self::DESCR_MAX))) {
				$result['good']['descr'] = htmlspecialchars($input['descr']);			
			} else {
				$result['error']['descr'] = self::VALIDATION_DESCR_ERROR;
			}
 		} else {
			$result['good']['descr'] = "";
		}	
		
		// SMS
		if (isset($input['sms']) && strlen($input['sms']) > 0) {
			if (self::validatePhone($input['sms'])) {
				$result['good']['sms'] = self::stripPhone($input['sms']);
			} else {
				$result['error']['sms'] = self::VALIDATION_SMS_ERROR;
			}
		} else {
			$result['good']['sms'] = "";
		}
		
		// PHONE
		if (isset($input['phone']) && strlen($input['phone']) > 0) {
			if (self::validatePhone($input['phone'])) {
				$result['good']['phone'] = self::stripPhone($input['phone']);
			} else {
				$result['error']['phone'] = self::VALIDATION_PHONE_ERROR;
			}
		} else {
			$result['good']['phone'] = "";
		}
		
		// PASSWORD
		if (isset($input['password1']) && isset($input['password2']) && strlen($input['password1']) > 0) {
			if (strlen($input['password1']) >= self::PASSWORD_MIN
				&& strlen($input['password1']) <= self::PASSWORD_MAX
    		&& preg_match("/[a-zA-Z]+/", $input['password1'])
    		&& preg_match("/[0-9]+/", $input['password1'])
    		&& !preg_match("/[ ]+/", $input['password1'])
    		&& !strcmp($input['password1'], $input['password2'])) { 
				$result['good']['password'] = $input['password1'];			
			} else {
				$result['error']['password'] = self::VALIDATION_PASSWORD_ERROR;
			}
 		} else {
	 		if ($pwRequired) {
				$result['error']['password'] = self::VALIDATION_PASSWORD_ERROR;
			}
		}
		
		// USERNAME
		if (isset($input['username'])) {
			if (self::validateUsernameFormat($input['username'])) {
    		if (User::userNameExists($input['username'])) {
					$result['error']['username'] = self::VALIDATION_USERNAME_DUPE_ERROR;
				}	else {	 					
					$result['good']['username'] = $input['username'];
				}
			} else {
				$result['error']['username'] = self::VALIDATION_USERNAME_FORMAT_ERROR;
			}
 		}
		
		// PREVENT MATCHING USERNAME, PASSWORD
		// Since the allowed char lists for these fields aren't compatible, theoretically these conditions can never both be true
		if (isset($result['good']['password']) && isset($result['good']['username']) && !strcmp($result['good']['password'], $result['good']['username'])) {
			$result['error']['password'] =  self::VALIDATION_PASSWORD_USERNAME_ERROR;
		}

		return $result;
		
	}
	
	public static function validateUserCredentials($input) {
		
	}

	public static function escapeforRegex($in) {
		$out = strtr($in, array('.' => "\.",
									        	'/' => "\/",
									        	'(' => "\(",
									        	')' => "\)",
									        	'+' => "\+",
									        	'?' => "\?"));
		return $out;
	}
	
	public static function isSafeCharacterSet($in) {
		if (isset($in) && strlen($in) > 0) {
			if (preg_match("/[<>%*&=\/\\!]/", $in)) {
				return false;
			}
		}
	return true;
	}

	public static function sanitize($in) {
		$out = strtr($in, array('(' => '&#40;',
                          	')' => '&#41;',
									        	'"' => '&#34;',
									        	'<' => '&#60;',
									        	'>' => '&#62;',
									        	'&' => '&#38;',
									        	'*' => '&#42;',
									        	'%' => '&#37',
									        	'=' => '&#61',
									        	'!' => '&#33',
									        	'\/' => '&#47',
									        	'\\' => '&#92'));
		return $out;
	}
	
	public static function strip($in) {
		$out = strtr($in, array('(' => '',
                          	')' => '',
									        	'"' => '',
									        	'<' => '',
									        	'>' => '',
									        	'&' => '',
									        	'\'' => ''));
		$out = trim($out);
		return $out;
	}
	
	// TODO - this special character situation is chaotic!
	public static function strip2($in) {
		$out = strtr($in, array('(' => '',
                          	')' => '',
									        	'<' => '',
									        	'>' => '',
									        	"'" => '&apos;'));
		$out = trim($out);
		return $out;
	}
	
	static function stripPhone($num) {
		return preg_replace('/[^0-9]/', '', $num);
	}
	
	static function prettyPrintPhone($numIn) {
		$num = self::stripPhone($numIn);
	 
		$len = strlen($num);
		if($len == 7)
			$num = preg_replace('/([0-9]{3})([0-9]{4})/', '$1-$2', $num);
		elseif($len == 10)
			$num = preg_replace('/([0-9]{3})([0-9]{3})([0-9]{4})/', '($1) $2-$3', $num);
		 
		return $num;
	}
	
	public static function newUuid() { 
    $s = strtolower(md5(uniqid(rand(),true))); 
    $guidText = 
        substr($s,0,8) . '-' . 
        substr($s,8,4) . '-' . 
        substr($s,12,4). '-' . 
        substr($s,16,4). '-' . 
        substr($s,20); 
    return $guidText;
	}
	
	public static function hideInEnvironment() {
		//if (!strcmp($_SESSION['environment'], "dev")) {
		//	return true;
		//}
		return false;		
	}
	
	public static function setLogin($uid) {
		if (isset($_SERVER['REMOTE_ADDR'])) {
			User::setLoginByIp($_SERVER['REMOTE_ADDR'], $uid);
		}
		return;
	}

	public static function authenticate($uid, $pass) {	
		$coreAuthenticated = false;
		$hash = self::getPasswordHashByUser($uid, $pass);
		if ($hash && User::countActiveUsers($uid, $hash) == 1) {
			$coreAuthenticated = true;
		}
    return $coreAuthenticated;
	}

	public static function isSessionValid() {
		if (isset($_SESSION['username']) && strlen($_SESSION['username']) > 0 && !self::isSessionExpired()) {
			return true;
		}
		return false;
	}
	
	public static function setSession($username, $remember, $zone = "undefined") {

		session_regenerate_id(TRUE);
		
		$_SESSION['appRoot'] = self::getWebRoot();
		$_SESSION['environment'] = self::getEnvName();
		$_SESSION['username'] = $username;
		$_SESSION['groups'] = User::getUserGroupsByUsername($_SESSION['username']);
		self::setSessionLastActivity();
		$_SESSION['remember'] = ($remember ? "true" : "false");
		$_SESSION['timezone'] = (Event::isValidTimeZone($zone) ? $zone : "undefined");
		
		$cursor = User::getUserSessionByUsername($_SESSION['username']);
		
		while ($row = pg_fetch_array($cursor)) {
			$_SESSION['fname'] = $row['fname'];
  		$_SESSION['lname'] = $row['lname'];
  		$_SESSION['orgName'] = $row['affiliation'];
  		$_SESSION['orgId'] = $row['affiliationuid'];
  		$_SESSION['uidpk'] = $row['id'];
  		$_SESSION['networkName'] = $row['network'];
  		$_SESSION['networkId'] = $row['networkid'];
  		$_SESSION['logo'] = $row['logo'];
  		$_SESSION['email'] = $row['email'];
  		$_SESSION['role'] = self::getRoleName($row['roleid']);
		} 	
	}
	
	public static function setSessionLastActivity() {
		$_SESSION['lastActivity'] = time();
	}
	
	public static function isSessionExpired() {
		if ((isset($_SESSION['remember']) && $_SESSION['remember'] == "true") || Util::getSessionTimeout() == "-1") {
			// don't expire a session if the user has asked to be remembered on login form
			return false;
		}
		if (isset($_SESSION['lastActivity']) && (time() - $_SESSION['lastActivity'] > self::getSessionTimeout())) {
			return true;
		}
		return false;
	}
	
	public static function destroySession() {
		$_SESSION = array();
		if (ini_get("session.use_cookies")) {
    	$params = session_get_cookie_params();
    	setcookie(session_name(), '', time() - 42000, $params["path"], $params["domain"], $params["secure"], $params["httponly"]);
		}
		session_destroy();
	}
	
	public static function is_ajax() {
		return isset($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest';
	}

	// TODO - this security stuff should not be inside Util class
	public static function storeSecurePasswordImplA($plaintextPassword, $userId) {
		$salt = self::generateRandomString(32);
		$securePassword = self::systemHashImplA($salt . $plaintextPassword);
		User::setSecurePasswordImplA($userId, '[[ENC]]' . $securePassword, $salt);
		return;
	}
	
	public static function getPasswordHashByUser($userId, $plaintextPassword) {
		$cursor = User::getUserPasswordByUser($userId);	
		if (pg_num_rows($cursor) < 1) {
			return FALSE;
		}
		// greater than one returned, we ignore
		$row = pg_fetch_array($cursor, 0);
		$encrypted = $row['password'];
	
		if (substr($encrypted, 0, 7) === "[[ENC]]") {
			// Return the salted hash for the plaintext password (using user's unique salt)
			$hash = "[[ENC]]" . self::systemHashImplA($row['salt'] . $plaintextPassword);
		} else {
			// If what is stored for this user has not been hashed OR there is no password at all for this user, return plaintext.
			$hash = $plaintextPassword;
		}
		return $hash;
	}
	
	public static function systemHashImplA($input) {
		return hash('sha256', $input);
	}
		
	public static function generateRandomString($length) {
    $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()';
    $randomString = '';
    for ($i = 0; $i < $length; $i++) {
        $randomString .= $characters[rand(0, strlen($characters) - 1)];
    }
    return $randomString;
	}
		
}

?>
