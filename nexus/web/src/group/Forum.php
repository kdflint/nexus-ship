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
		
	// TODO - move Forum db interactions from ExternalMessage to here

	public static function updateUserProfile($username, $fname, $lname, $sms, $email, $phone) {
		
		$query = "select user_id from phpbb_users where username = $1";
		$userid = pg_fetch_row(ForumDatabase::psExecute($query, array($username)));
		
		$query = "select exists (select true from phpbb_profile_fields_data where user_id = $1)";
		$profileExists = pg_fetch_row(ForumDatabase::psExecute($query, array($userid[0])));		
		
		if ($profileExists[0] === "f") {
			$query = "insert into phpbb_profile_fields_data (user_id) values ($1)";
			ForumDatabase::psExecute($query, array($userid[0]));
		}
		
		$query = "update phpbb_profile_fields_data 
			set pf_nexus_fname = $1,
			pf_nexus_lname = $2,
			pf_nexus_sms  = $3,
			pf_nexus_email = $4,
			pf_nexus_phone = $5 
			where user_id = $6";
		return ForumDatabase::psExecute($query, array($fname, $lname, $sms, $email, $phone, $userid[0]));
	}
	
	public static function updateUserPassword($username, $password) {
	}

}

?>
