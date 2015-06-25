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
	
	public static function getUserPasswordByUser($userId) {
		// TODO - make usernames in db not required to be unique (or, only unique within network). Pair with network id to do authentication.
		$query = "select password, salt, cryptimpl from public.user where username = $1";
		return pgDb::psExecute($query, array($userId));
	}
	
	public static function countActiveUsers($uid, $password) {
		$query = "select id from public.user where username=$1 and password=$2 and status_fk='1'";
		return pg_num_rows(pgDb::psExecute($query, array($uid, $password)));
	}
	
	public static function getUserSessionByUsername($uid) {
		// TODO: add active check?
		// TODO: fix up network id determination (parent, god, etc)
		// TODO - this will fail if user in > 1 group
		$query = "
			select u.id as id, u.fname as fname, u.lname as lname, u.password as password, u.conference_link as link, u.email as email, o1.name as affiliation, o2.name as network, o2.id as networkid, o2.logo as logo, uo.role_fk as role
			from public.user u, user_organization uo, organization o1, organization o2, organization_organization oo
			where u.username = $1
			and uo.user_fk = u.id
			and uo.organization_fk = o1.id
			and oo.organization_to_fk = o1.id 
			and oo.organization_from_fk = o2.id
			and oo.relationship in ('parent', 'god')
			";
		return PgDb::psExecute($query, array($uid));	
	}
	
	public static function getUserGroupsByUsername($uid) {
		$query = "select g.id as id, g.name as name from public.group g, public.user u, user_group ug where u.username = $1 and ug.user_fk = u.id and ug.group_fk = g.id";
		$cursor = PgDb::psExecute($query, array($uid));
	  $resultArray = array();
	  while ($row = pg_fetch_array($cursor)) {
	  	$resultArray[$row['id']] = $row['name'];
	  }		
	  return $resultArray;
	}
	
	public static function setLoginByIp($ip, $userId) {
		$query = "insert into user_session (ip, user_fk, create_dttm) values ($1, $2, now())";
		return PgDb::psExecute($query, array($ip, $userId));
	}
	
}

?>