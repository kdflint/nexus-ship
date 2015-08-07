<?php

require_once(dirname(__FILE__) . "/../framework/PgDb.php");

class User {
	
	public static function getActiveUserByUsername($uid) {
		$query = "select u.id as id, u.email as email, u.fname as fname, u.lname as lname, u.password as password from public.user u where u.username = $1 and suspend_dttm is NULL limit 1";
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
		$query = "select id from public.user where username=$1 and password=$2 and status_fk='1' and suspend_dttm is NULL";
		return pg_num_rows(pgDb::psExecute($query, array($uid, $password)));
	}
	
	public static function getUserSessionByUsername($uid) {
		// TODO: add active check?
		// TODO: fix up network id determination (parent, god, etc)
		// TODO - this will fail if user in > 1 group
		$query = "
			select u.id as id, u.fname as fname, u.lname as lname, u.password as password, u.conference_link as link, u.email as email, ug.role_fk as roleid, o1.name as affiliation, o1.uid as affiliationuid, o2.name as network, o2.id as networkid, o2.logo as logo, uo.role_fk as role
			from public.user u, user_organization uo, user_group ug, organization o1, organization o2, organization_organization oo
			where u.username = $1
			and uo.user_fk = u.id
			and ug.user_fk = u.id
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
	
	public static function updateUserById($userId, $fname, $lname, $sms, $email, $smsEnabled, $emailEnabled, $smsPublic, $emailPublic, $descr, $phone, $phonePublic) {
		$query = "
		update public.user set
			fname = $1,
			lname = $2,
			sms = $3,
			email = $4,
			enable_email = $5,
			enable_sms = $6,
			publish_email = $7,
			publish_sms = $8,
			descr = $9,
			phone = $10,
			publish_phone = $11
			where id = $12
			";
		return PgDb::psExecute($query, array($fname, $lname, $sms, $email, $emailEnabled, $smsEnabled, $emailPublic, $smsPublic, $descr, $phone, $phonePublic, $userId));
	}
	
	public static function getUserById($userId) {
		$query = "
		select u.fname as first, u.lname as last, u.password, u.email as email, u.sms as cell, u.phone as phone, u.enable_email as emailon, u.enable_sms as smson, u.publish_email as emailpub, u.publish_sms as smspub, u.publish_phone as phonepub, u.descr as descr, u.create_dttm as create, s.name as status, r.name as role 
			from public.user u, user_organization uo, status s, role r 
			where u.id = $1
			and s.id = u.status_fk
			and uo.user_fk = u.id
			and uo.role_fk = r.id
			";
		return PgDb::psExecute($query, array($userId));
	}
	
	public static function getUserPasswordResetActivityByUuid($uuid) {
		$query = "select u.email, u.id as uidpk, u.username, up.id as id
			from public.user u, user_password up
			where up.uuid = $1
			and up.response_dttm is NULL
			and up.activity = 'RESET'
			and up.create_dttm + interval '35 minutes' > now()
			and up.user_fk = u.id
			limit 1";
		return PgDb::psExecute($query, array($uuid));
	}
	
	public static function updateUserPasswordResetActivityById($id) {
		$query = "update user_password set response_dttm = now() where id = $1";
		return PgDb::psExecute($query, array($id));
	}
	
	public static function setSecurePasswordImplA($userId, $securePassword, $salt) {
		$query = "update public.user set 
			password = $2, 
			salt = $3, 
			cryptimpl = 'ImplA', 
			crypt_dttm = now() 
			where id = $1
			";
		return PgDb::psExecute($query, array($userId, $securePassword, $salt));
	}
	
	public static function deleteUser($id) {
		$query = "update public.user set suspend_dttm = now() where id = $1";
		return PgDb::psExecute($query, array($id));
	}
	
}

?>