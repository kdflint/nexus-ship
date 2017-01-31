<?php

require_once(dirname(__FILE__) . "/../framework/PgDb.php");
require_once(dirname(__FILE__) . "/../framework/forumDb.php");
require_once(dirname(__FILE__) . "/../framework/Util.php");
require_once(Utilities::getSrcRoot() . "/user/Invitation.php");

define('IN_PHPBB', true);
$phpbb_root_path = Utilities::getPhpBbRoot();
$phpEx = 'php';
require_once(Utilities::getPhpBbRoot() . 'includes/functions_user.php');
include(Utilities::getPhpBbRoot() . 'common.php');

class Forum {

	public static function enrollUser($username, $password) {
		
		// https://wiki.phpbb.com/Add_users

		$email_address = 'contact@northbridgetech.org';
		$group_id = '2'; // REGISTERED
		$user_type = USER_NORMAL;
		$registration_time = time();
		$user_row = array(
		    'username'              => $username,
		    'user_password'         => phpbb_hash($password),
		    'user_email'            => $email_address,
		    'group_id'              => (int) $group_id,
		    'user_type'             => $user_type,
		    'user_regdate'          => $registration_time
		);
		
		// all the information has been compiled, add the user
		// the user_add() function will automatically add the user to the correct groups
		// and adding the appropriate database entries for this user...
		// tables affected: users table, profile_fields_data table, groups table, and config table.
		$user_id = false;
		try {
			$user_id = user_add($user_row);
		} catch (Exception $e){
			//$logger->log($e.getMessage(), PEAR_LOG_INFO);
		}
		
		return $user_id;
		
		//insert user watches
	}	
	
	public static function addUserToGroupById($userId, $groupId) {
		// https://wiki.phpbb.com/Function.group_user_add
		// Can also add user by username - see docs
		$result = "EXCEPTION";
		try {
			$result = group_user_add((int) $groupId, (int) $userId, false, false, true);
		} catch (Exception $e) {
			//$logger->log($e.getMessage(), PEAR_LOG_INFO);
		}
		return $result;
	}

}

?>
