<?php

class pgDb {
	
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
		$query = "select organization_fk as orgid, issuer_fk as grantorid, type, role_fk as role from invitation where uuid = '$uuid' order by create_dttm desc limit 1";
		return pgDb::execute($query);
	}
	
	public static function getInvitationsByOrg($orgId) {
		$query = "select uuid, date_part('days', expire_dt - now()) as days_remaining from invitation where organization_fk = '$orgId'";
		return pgDb::execute($query);
	}
	
	public static function checkValidInvitation($uuid) {
		$query = "select id from invitation where uuid = '$uuid'";
		$count = pg_num_rows(pgDb::execute($query));
		if ($count == 1) {
			return true;
		}
		return false;
	}
	
	public static function orgEinExists($ein) {
		$query = "select exists (select true from organization where ein = '$ein')";
		return pgDb::execute($query);
	}
	
	public static function userEmailExists($email) {
		$query = "select exists (select true from public.user where email = '$email' and status_fk = '1')";
		return pgDb::execute($query);
	}
	
	public static function countUserEmail($email) {
		$query = "select id from public.user where email = '$email' and status_fk = '1'";
		return pg_num_rows(pgDb::execute($query));
	}
	
	public static function userOrgRelationExists($orgId, $email) {
		$query = "select exists (select true from user_organization where organization_fk = '$orgId' and user_fk in (select id from public.user where email = '$email' and status_fk = '1'))";
		return pgDb::execute($query);
	}
	
	public static function insertOrganization($name, $ein) {
			$query = "insert into organization (name, ein, status_fk) values ('$name', '$ein', '1') returning id";
			return pgDb::execute($query);		
	}

	public static function insertInvitationResponse($orgId, $uuid) {
			$query = "insert into invitation_organization (organization_fk, invitation_fk, create_dttm) values ('$orgId', 
				(select id from invitation where uuid = '$uuid'), now())";
			pgDb::execute($query);
	}
	
	public static function insertActiveUser($uuid, $email) {
			$query = "insert into public.user (uuid, email, status_fk, create_dttm, activate_dttm) values ('$uuid', '$email', '1', now(), now()) returning id";
			return pgDb::execute($query);		
	}
	
	public static function insertAdminUserOrgRelation($email, $orgId, $grantorId) {
			// TODO: add active check?
			$query = "insert into user_organization (user_fk, organization_fk, grantor_fk, role_fk, create_dttm) values ((select id from public.user where email = '$email' limit 1), '$orgId', '$grantorId', '1', now()) returning id";
			return pgDb::execute($query);		
	}
	
	public static function getUserSessionByUsername($uid) {
		// TODO: add active check?
		$query = "
			select u.id, u.fname, u.lname, o1.name as affiliation, o2.name as network, uo.role_fk as role
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
		$query = "select name, ein, structure, status_fk as status from organization where id = '$orgId'";
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
		$query = "
			select 'organization' as table, o.id as id
			from organization o
			where o.name like '%{$term}%'
			or o.ein like '%{$term}%'
			
			union
			
			select 'public.user' as table, u.id as id
			from public.user u
			where u.fname like '%{$term}%'
			or u.lname like '%{$term}%'
			or u.mname like '%{$term}%'
			or u.nickname like '%{$term}%'
			or u.email like '%{$term}%'
			or u.sms like '%{$term}%'
			";
			
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
