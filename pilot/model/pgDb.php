<?php

class pgDb {
	
	// TODO: switch this all over to parameterized queries
	
	public static function connect() {
		$host = "localhost"; 
		$user = "northbr6_web"; 
		$pass = "bdTEzR?MRs[C"; 
		//$user = "northbr6"; 
		//$pass = "A56L9Q1X"; 
		$db = "northbr6_nbnexus";		
		
		$con = pg_connect("host=$host dbname=$db user=$user password=$pass")
    or die ("Could not connect to server\n"); 
    
    return $con;
	}
	
	public static function disconnect($con) {
		pg_close($con);
	}
	
	private static function execute($query) {
		$con = pgDb::connect();
		$result = pg_query($con, $query) or die("Cannot execute query: $query\n");
		pgDb::disconnect($con);
		return $result;
	}
	
	public static function insertOpenAdminInvitation($uuid, $orgId) {
		$query = "insert into invitation (uuid, create_dttm, accept_dttm, organization_fk, invitation_dttm, role_fk, expire_dt, issuer_fk) values ('$uuid', now(), NULL, '$orgId', NULL, '1', now() + interval '2 week', '1')";
		return pgDb::execute($query);
	}
	
	public static function insertSingleAdminInvitation($uuid, $orgId, $email, $grantorId) {
		$query = "insert into invitation (uuid, email, create_dttm, accept_dttm, organization_fk, invitation_dttm, role_fk, expire_dt, issuer_fk) values ('$uuid', '$email', now(), NULL, '$orgId', NULL, '1', now() + interval '2 week', '$grantorId')";
		return pgDb::execute($query);
	}
	
	public static function getInvitationByUuid($uuid) {
		// TODO: ensure that input length == 36
		$query = "select network_fk as networkid, organization_fk as orgid, issuer_fk as grantorid, type, role_fk as role from invitation where uuid = '$uuid' order by create_dttm desc limit 1";
		return pgDb::execute($query);
	}
	
	public static function getInvitationsByOrg($orgId) {
		$query = "select uuid, date_part('days', expire_dt - now()) as days_remaining from invitation where organization_fk = '$orgId'";
		return pgDb::execute($query);
	}
	
	public static function checkValidInvitation($uuid) {
		if (strlen($uuid) == 36) {
			$query = "select id from invitation where uuid = '$uuid'";
			$count = pg_num_rows(pgDb::execute($query));
			if ($count == 1) {
				return true;
			}
		}
		return false;
	}
	
	public static function orgEinExists($ein) {
		$query = "select exists (select true from organization where ein = '$ein')";
		return pgDb::execute($query);
	}
	
	public static function userEmailExists($email) {
		$query = "select exists (select true from contact where email = '$email' and status_fk = '1')";
		return pgDb::execute($query);
	}
	
	public static function countUserEmail($email) {
		// TODO: broken now with refactor (email)
		$query = "select id from public.user where email = '$email' and status_fk = '1'";
		return pg_num_rows(pgDb::execute($query));
	}
	
	public static function countActiveUsers($uid, $password) {
		$query = "select id from public.user where username = '$uid' and password = '$password' and status_fk = '1'";
		return pg_num_rows(pgDb::execute($query));
	}
	
	public static function userOrgRelationExists($orgId, $email) {
		// TODO: broken now with refactor (email)
		$query = "select exists (select true from user_organization where organization_fk = '$orgId' and user_fk in (select id from public.user where email = '$email' and status_fk = '1'))";
		return pgDb::execute($query);
	}
	
	public static function insertOrganization($name, $ein) {
			$query = "insert into organization (name, status_fk) values ('$name', '1') returning id";
			return pgDb::execute($query);		
	}
	
	public static function insertOrgOrgRelation($from, $to, $relation) {
			$query = "insert into organization_organization (organization_from, organization_to, relationship) values ('$from', '$to', '$relation')";
			return pgDb::execute($query);		
	}

	public static function insertInvitationResponse($orgId, $uuid) {
			$query = "insert into invitation_organization (organization_fk, invitation_fk, create_dttm) values ('$orgId', 
				(select id from invitation where uuid = '$uuid'), now())";
			pgDb::execute($query);
	}

	public static function insertActiveUser($uuid, $username, $password, $fname, $lname, $email) {
			// TODO: broken now with refactor (email)
			$query = "insert into public.user (uuid, username, password, fname, lname, email, status_fk, create_dttm, activate_dttm) values ('$uuid', '$username', '$password', '$fname', '$lname', '$email', '1', now(), now()) returning id";
			return pgDb::execute($query);		
	}
	
	public static function insertActiveUserByEmail($uuid, $email) {
			// TODO: broken now with refactor (email)
			$query = "insert into public.user (uuid, email, status_fk, create_dttm, activate_dttm) values ('$uuid', '$email', '1', now(), now()) returning id";
			return pgDb::execute($query);		
	}
	
	public static function insertActiveUserByCredentials($uuid, $username, $password) {
			$query = "insert into public.user (uuid, username, password, status_fk, create_dttm, activate_dttm) values ('$uuid', '$username', '$password', '1', now(), now()) returning id";
			return pgDb::execute($query);		
	}
	
	public static function insertUserOrgRelation($userId, $orgId, $grantorId) {
			// TODO: add active check?
			$query = "insert into user_organization (user_fk, organization_fk, grantor_fk, role_fk, create_dttm) values ('$userId', '$orgId', '$grantorId', '1', now()) returning id";
			return pgDb::execute($query);		
	}
	
	public static function insertAdminUserOrgRelation($email, $orgId, $grantorId) {
			// TODO: add active check?
			// TODO: broken now with refactor (email)
			$query = "insert into user_organization (user_fk, organization_fk, grantor_fk, role_fk, create_dttm) values ((select id from public.user where email = '$email' limit 1), '$orgId', '$grantorId', '1', now()) returning id";
			return pgDb::execute($query);		
	}
	
	public static function getUserSessionByUsername($uid) {
		// TODO: add active check?
		$query = "
			select u.id as id, u.fname as fname, u.lname as lname, o1.name as affiliation, o2.name as network, uo.role_fk as role
			from public.user u, user_organization uo, organization o1, organization o2, organization_organization oo
			where u.username = '$uid'
			and uo.user_fk = u.id
			and uo.organization_fk = o1.id
			and oo.organization_to_fk = o1.id 
			and oo.organization_from_fk = o2.id
			and oo.relationship in ('parent', 'god')
			";
		return pgDb::execute($query);	
	}
	
	public static function getUserByUsername($uid) {
		// TODO: add active check?
		$query = "select u.id as id, u.fname as fname, u.lname as lname from public.user u where u.username = '$uid' limit 1";
		return pgDb::execute($query);	
	}
	
	public static function getPrivileges($roleId) {
		$query = "
			select r.name as role, p.name as privilege
			from privilege p, role r, role_privilege pr 
			where pr.role_id_fk = '$roleId' 
			and pr.role_id_fk = r.id
			and pr.privilege_id_fk = p.id
			";
		return pgDb::execute($query);
	}	
	
	public static function getUserById($userId) {
		// TODO: broken now with refactor (email)
		$query = "
		select u.fname as first, u.lname as last, u.email as email, u.sms as cell, s.name as status, r.name as role 
			from public.user u, user_organization uo, status s, role r 
			where u.id = '$userId'
			and s.id = u.status_fk
			and uo.user_fk = u.id
			and uo.role_fk = r.id
			";
		return pgDb::execute($query);
	}
	
	public static function inactivateUser($userId) {
		$query = "update public.user set status_fk = '2', suspend_dttm = now() where id = '$userId'";
		return pgDb::execute($query);
	}
	
	public static function reactivateUser($userId) {
		$query = "update public.user set status_fk = '1', activate_dttm = now() where id = '$userId'";
		return pgDb::execute($query);
	}
	
	public static function getOrganizationById($orgId) {
		$query = "select name, structure, status_fk as status from organization where id = '$orgId'";
		return pgDb::execute($query);
	}
	
	public static function getOrganizationUsersById($orgId) {
		$query = "
		select u1.fname as first, u1.lname as last, s.name as status, r.name as role, u2.fname as grantor
			from public.user u1, public.user u2, user_organization uo, role r, status s
			where uo.organization_fk = '$orgId'
			and uo.user_fk = u1.id
			and uo.role_fk = r.id
			and u1.status_fk = s.id
			and uo.grantor_fk = u2.id
			";
		return pgDb::execute($query);
	}

	public static function inactivateOrganization($orgId) {
		$query = "update organization set status_fk = '2', suspend_dttm = now() where id = '$orgId'";
		return pgDb::execute($query);
	}
	
	public static function reactivateOrganization($orgId) {
		$query = "update organization set status_fk = '1', activate_dttm = now() where id = '$orgId'";
		return pgDb::execute($query);
	}

	public static function freeSearch($term) {
		// TODO: use citext index in db instead of lower() function here
		// http://stackoverflow.com/questions/7005302/postgresql-how-to-make-not-case-sensitive-queries
		$query = "
			select 'Organization' as table, o.id as id, o.name as name
			from organization o
			where lower(o.name) like lower('%{$term}%')
			
			union
			
			select 'Person' as table, u.id as id, u.fname || ' ' || u.lname
			from public.user u
			where lower(u.fname) like lower('%{$term}%')
			or lower(u.lname) like lower('%{$term}%')
			or lower(u.mname) like lower('%{$term}%')
			or lower(u.nickname) like lower('%{$term}%')
			
			union
			
			select 'Program' as table, p.id as id, p.name as name
			from program p
			where lower(p.name) like lower('%{$term}%')
			or lower(p.description) like lower('%{$term}%')
			
			union
			
			select 'Language' as table, l.id as id, l.name as name
			from language l
			where lower(l.language) like lower('%{$term}%')		
			"	
			;
			
			return pgDb::execute($query);			
			
	}
	
	/*
	
	public static function () {
		$query = "";
		return pgDb::execute($query);
	}

  */
}
?>
