<?php

require_once(dirname(__FILE__) . "/../framework/PgDb.php");

class User {
	
	public static function getUserByUsername($uid) {
		// TODO: add active check?
		$query = "select u.id as id, u.email as email, u.fname as fname, u.lname as lname, u.password as password from public.user u where u.username = $1 limit 1";
		return PgDb::psExecute($query, array($uid));	
	}
	
	public static function insertPasswordResetActivity($userId, $uuid) {
		// invalidate prior open reset links
		$query = "update user_password set response_dttm = now() where user_fk = $1";
		PgDb::psExecute($query, array($userId));
		
		$query = "insert into user_password (user_fk, activity, create_dttm, uuid) values ($1, 'RESET', now(), $2)";
		return PgDb::psExecute($query, array($userId, $uuid));
	}
	
	public static function userEmailExists($email) {
		$query = "select exists (select true from public.user where lower(email) = lower($1))";
		return pgDb::psExecute($query, array($email));
	}
	
	public static function getUsernamesByEmail($email) {
		$query = "select username from public.user where lower(email) = lower($1)";
		return pgDb::psExecute($query, array($email));
	}

}

?>