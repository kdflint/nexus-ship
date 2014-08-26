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
			$result['error']['password'] = "Please enter your password.";
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

	public static function authenticate($uid, $pass) {	
		if (pgDb::countActiveUsers($uid, $pass) == 1) {
			return true;
		}
		return false;
	}
	
	public static function isSessionValid() {
		if (isset($_SESSION['username']) && strlen($_SESSION['username']) > 0) {
			return true;
		}
		return false;
	}
	
}

?>
