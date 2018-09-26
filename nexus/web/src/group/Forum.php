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
	
	public static function createNewGroupAndForum($groupName, $parentForumId, $isPublic, $networkForumGroupId) {
		// add group to phpbb
		$query = "insert into phpbb_groups (group_id, group_type, group_name, group_receive_pm) values (DEFAULT, 0, $1, 1) returning group_id";
		$privateForumGroupid = pg_fetch_row(ForumDatabase::psExecute($query, array($groupName)));
		
		// add forum to phpbb
		$query = "insert into phpbb_forums (forum_id,parent_id,forum_name,forum_desc,forum_type,forum_flags) values (DEFAULT,$1, $2, '',1,48) returning forum_id";
		$forumid = pg_fetch_row(ForumDatabase::psExecute($query, array($parentForumId,$groupName)));
		
		// map group-forum permissions to phpbb
		$acl = self::getAcl($isPublic);
		foreach ($acl as $static_groupid => $permissionList) {
			foreach ($permissionList as $permission) { 
				$query = "insert into phpbb_acl_groups (forum_id, group_id, auth_option_id, auth_role_id, auth_setting) values ($1,$2,$3,$4,$5)";
				if ($static_groupid === 'group') {
					ForumDatabase::psExecute($query, array($forumid, $privateForumGroupid, $permission[0], $permission[1], $permission[2]));
				} else if ($static_groupid === 'network'){
					ForumDatabase::psExecute($query, array($forumid, $networkForumGroupId, $permission[0], $permission[1], $permission[2]));
				} else {
					ForumDatabase::psExecute($query, array($forumid, $static_groupid, $permission[0], $permission[1], $permission[2]));
				}
			}
		}		
	}
	
	public static function getAcl($isPublic) {
			// key is the group id in phpbb; value is the acl array for that group. These can always be tweaked at runtime from phpbb console. 
			// These will be dumped into phpbb_acl_groups
			// These were taken from CFCHT production examples of public and private forums
			// TODO - Hard-coded groups 1 and 5 probably belong on env_config next to FORUM_REGISTERED_USER_GROUP
			$acl_private = array(
			'1' => (
				array(6,0,1),
				array(8,0,1),
				array(12,0,1),
				array(15,0,1),
				array(17,0,1),
				array(18,0,1),
				array(21,0,1),
				array(31,0,1),
				array(26,0,1),
				array(3,0,1),
				array(4,0,1),
				array(10,0,1),
				array(11,0,1),
				array(13,0,1),
				array(24,0,1),
				array(25,0,1),
				array(5,0,1),
				array(7,0,1),
				array(9,0,1),
				array(14,0,1),
				array(19,0,1),
				array(20,0,1),
				array(22,0,1),
				array(23,0,1),
				array(27,0,1),
				array(28,0,1),
				array(16,0,1),
				array(29,0,1),
				array(30,0,1),
				array(1,0,1)
				),
			'5'	=> (
				array(0,14,0)
				),
			'network'	=> ( // placeholder for network forum group
				array(6,0,1),
				array(8,0,1),
				array(12,0,1),
				array(15,0,1),
				array(17,0,1),
				array(18,0,1),
				array(21,0,1),
				array(31,0,1),
				array(26,0,1),
				array(3,0,1),
				array(4,0,1),
				array(10,0,1),
				array(11,0,1),
				array(13,0,1),
				array(24,0,1),
				array(25,0,1),
				array(5,0,1),
				array(7,0,1),
				array(9,0,1),
				array(14,0,1),
				array(19,0,1),
				array(20,0,1),
				array(22,0,1),
				array(23,0,1),
				array(27,0,1),
				array(28,0,1),
				array(16,0,1),
				array(29,0,1),
				array(30,0,1),
				array(1,0,1)
				),
			'group' => ( // placeholder for private forum group
				array(2,0,1),
				array(6,0,1),
				array(8,0,1),
				array(12,0,1),
				array(15,0,1),
				array(17,0,1),
				array(18,0,1),
				array(21,0,1),
				array(31,0,1),
				array(26,0,1),
				array(3,0,1),
				array(4,0,1),
				array(10,0,1),
				array(11,0,1),
				array(13,0,1),
				array(24,0,1),
				array(25,0,1),
				array(5,0,1),
				array(7,0,1),
				array(9,0,1),
				array(14,0,1),
				array(19,0,1),
				array(20,0,1),
				array(22,0,1),
				array(23,0,1),
				array(27,0,1),
				array(28,0,1),
				array(16,0,1),
				array(29,0,1),
				array(30,0,1),
				array(1,0,1)		
				)	
			);
			
			$acl_public = array(
			'1' => (
				array(15,0,1),
				array(21,0,1),
				array(7,0,1),
				array(9,0,1),
				array(14,0,1),
				array(19,0,1),
				array(20,0,1),
				array(27,0,1),
				array(29,0,1),
				array(1,0,1)
				),
			'5'	=> (
				array(0,14,0)
				),
			'network' => ( // placeholder for network forum group
				array(6,0,1),
				array(8,0,1),
				array(12,0,1),
				array(15,0,1),
				array(17,0,1),
				array(18,0,1),
				array(21,0,1),
				array(31,0,1),
				array(26,0,1),
				array(3,0,1),
				array(4,0,1),
				array(10,0,1),
				array(11,0,1),
				array(13,0,1),
				array(24,0,1),
				array(25,0,1),
				array(5,0,1),
				array(7,0,1),
				array(9,0,1),
				array(14,0,1),
				array(19,0,1),
				array(20,0,1),
				array(22,0,1),
				array(23,0,1),
				array(27,0,1),
				array(28,0,1),
				array(16,0,1),
				array(29,0,1),
				array(30,0,1),
				array(1,0,1)
				)
			);
		
			if ($isPublic) {
				return $acl_public;
			}
			return $acl_private;
	}

}

?>

