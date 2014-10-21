<?php

require_once("/home1/northbr6/php/Validate.php");

class Util {
	
	const VALIDATION_FNAME_ERROR = "Please enter a valid first name."; 
	const VALIDATION_LNAME_ERROR = "Please enter a valid last name (or none)."; 
	const VALIDATION_SMS_ERROR = "Please enter a valid text number (or none).";
	const VALIDATION_PASSWORD_ERROR = "Please enter valid matching passwords.";
	const VALIDATION_USERNAME_FORMAT_ERROR = "Please enter a valid username.";
	const VALIDATION_USERNAME_DUPE_ERROR = "This username already exists. Please select a different username.";
	const VALIDATION_ORGNAME_ERROR = "Please enter the valid organization name that you represent.";
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
	
	public static function validateEmail($in) {
		if (filter_var($in, FILTER_VALIDATE_EMAIL)) {
			return true;
		}
		return false;
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
    				'format' => VALIDATE_EALPHA . VALIDATE_NUM . "'" . "_",
    				'min_length' => self::NAME_MIN,
    				'max_length' => self::NAME_MAX))) {
				$result['good']['fname'] = $input['fname'];			
			} else {
				$result['error']['fname'] = self::VALIDATION_FNAME_ERROR;
			}
 		} else {
			$result['error']['fname'] = self::VALIDATION_FNAME_ERROR;
		}	
		
		// LAST NAME
		if (isset($input['lname']) && strlen($input['lname']) > 0) {
			if (Validate::string($input['lname'], array(
    				'format' => VALIDATE_EALPHA . VALIDATE_NUM . "'" . "_",
    				'min_length' => self::NAME_MIN,
    				'max_length' => self::NAME_MAX))) {
				$result['good']['lname'] = $input['lname'];			
			} else {
				$result['error']['lname'] = self::VALIDATION_LNAME_ERROR;
			}
 		} else {
			$result['good']['lname'] = "";
		}	
		
		// SMS
		if (isset($input['sms']) && strlen($input['sms']) > 0) {
			if (Validate::string($input['sms'], array(
    				'format' => VALIDATE_NUM . VALIDATE_SPACE . "." . "(" . ")" . "-",
    				'min_length' => self::PHONE_MIN,
    				'max_length' => self::PHONE_MAX))) {
				$result['good']['sms'] = self::stripPhone($input['sms']);
			} else {
				$result['error']['sms'] = self::VALIDATION_SMS_ERROR;
			}
		} else {
			$result['good']['sms'] = "";
		}
		
		// PASSWORD
		if (isset($input['password1']) && isset($input['password2']) && strlen($input['password1']) > 0) {
			if (strlen($input['password1']) >= self::PASSWORD_MIN
				&& strlen($input['password1']) <= self::PASSWORD_MAX
    		//&& preg_match("/[A-Z]+/", $input['password1'])
    		&& preg_match("/[a-zA-Z]+/", $input['password1'])
    		&& preg_match("/[0-9]+/", $input['password1'])
    		//&& preg_match("/[~!@#$%^&*_+=`|?:;.,*\'\"\/\-]+/", $input['password1'])
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
			if (Validate::string($input['username'], array(
    				'format' => VALIDATE_ALPHA . VALIDATE_NUM . "_",
    				'min_length' => self::USERNAME_MIN,
    				'max_length' => self::USERNAME_MAX))) {
    		$row = pg_fetch_row(pgDb::userNameExists($input['username']));
    		$exists = $row[0];	
    		if (!strcmp($exists, "t")) {
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
			$result['error']['password'] =  self::VALIDATION_PASSWORD_ERROR;
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

	public static function sanitize($in) {
		$out = strtr($in, array('(' => '&#40;',
                          	')' => '&#41;',
									        	'"' => '&#34;',
									        	'<' => '&#60;',
									        	'>' => '&#62;',
									        	'&' => '&#38;'));
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
	
	public static function isSessionValid() {
		if (isset($_SESSION['username']) && strlen($_SESSION['username']) > 0) {
			return true;
		}
		return false;
	}
	
	public static function setLogin($uid) {
		if (isset($_SERVER['REMOTE_ADDR'])) {
			pgDb::setLoginByIp($_SERVER['REMOTE_ADDR'], $uid);
		}
		return;
	}

	public static function authenticate($uid, $pass) {	
		$hash = self::getPasswordHashByUser($uid, $pass);
		if (pgDb::countActiveUsers($uid, $hash) == 1) {
			return true;
		}
		return false;
	}
	
	public static function setSession($username) {
		session_regenerate_id(TRUE);
		$_SESSION['groups'] = array();
		$_SESSION['username'] = $username;
	
		$cursor = pgDb::getUserSessionByUsername($_SESSION['username']);
	
		while ($row = pg_fetch_array($cursor)) {
			$_SESSION['fname'] = $row['fname'];
  		$_SESSION['lname'] = $row['lname'];
  		$_SESSION['orgName'] = $row['affiliation'];
  		$_SESSION['uidpk'] = $row['id'];
  		$_SESSION['networkName'] = $row['network'];
  		// TODO: Make this dynamic once method decisions network id correctly (see pgDb.php)
  		$_SESSION['networkId'] = '18'; // $row['networkid'];
  		$_SESSION['logo'] = $row['logo'];
  		$_SESSION['email'] = $row['email'];
		} 
	
		$_SESSION['groups'] = pgDb::getUserGroupsByUsername($_SESSION['username']);
	}

	public static function storeSecurePasswordImplA($plaintextPassword, $userId) {
		$salt = self::generateRandomString(32);
		$securePassword = self::systemHashImplA($salt . $plaintextPassword);
		pgDb::setSecurePasswordImplA($userId, '[[ENC]]' . $securePassword, $salt);
		return;
	}
	
	public static function getPasswordHashByUser($userId, $plaintextPassword) {
		$cursor = pgDb::getUserPasswordByUser($userId);
		$row = pg_fetch_array($cursor, 0);
		$encrypted = $row['password'];
		// TODO - handle case where no rows are returned for this username		
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
