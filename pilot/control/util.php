<?php

class Util {

	public static function validateEmail($in) {
		if (filter_var($in, FILTER_VALIDATE_EMAIL)) {
			return true;
		}
		return false;
	}
	
	public static function validateUserProfile($input) {
		$result = array('good' => array(), 'error' => array());
		
		if (isset($input['email']) && filter_var($input['email'], FILTER_VALIDATE_EMAIL)) {
			$result['good']['email'] = $input['email'];
		} else {
			$result['error']['email'] = "Please enter a valid email address.";
		}
		
		if (!isset($input['fname']) || strlen($input['fname']) < 1) {
			$result['error']['fname'] = "Please enter your first name.";
 		} else {
			$result['good']['fname'] = $input['fname'];
		}

		if (isset($input['lname'])) {
			$result['good']['lname'] = $input['lname'];
 		} else {
 			// ok - lname is not required
 			$result['good']['lname'] = "";
 		}
 		
		if (!isset($input['password']) || strlen($input['password']) < 1  || strlen($input['password']) > 12) {
			// ok - password is not required (at the moment)
			$result['good']['password'] = "";
 		} else {
			$result['good']['password'] = $input['password'];
		}

		if (isset($input['sms']) && strlen($input['sms']) > 6 && filter_var($input['sms'], FILTER_VALIDATE_INT)) {
			$result['good']['sms'] = $input['sms'];
		} else if (!isset($input['sms']) || strlen($input['sms']) == 0) {
			$result['good']['sms'] = "";
		} else {
			$result['error']['sms'] = "Please enter a valid text address.";
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
	
	static function prettyPrintPhone($num) {
		$num = preg_replace('/[^0-9]/', '', $num);
	 
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
