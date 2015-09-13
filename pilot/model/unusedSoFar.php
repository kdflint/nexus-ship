<?php

	public static function insertOpenAdminInvitation($uuid, $orgId) {
		$query = "insert into invitation (uuid, create_dttm, accept_dttm, organization_fk, invitation_dttm, role_fk, expire_dt, issuer_fk) values ('$uuid', now(), NULL, '$orgId', NULL, '1', now() + interval '2 week', '1')";
		return pgDb::execute($query);
	}
	
	public static function insertSingleAdminInvitation($uuid, $orgId, $email, $grantorId) {
		$query = "insert into invitation (uuid, email, create_dttm, accept_dttm, organization_fk, invitation_dttm, role_fk, expire_dt, issuer_fk) values ('$uuid', '$email', now(), NULL, '$orgId', NULL, '1', now() + interval '2 week', '$grantorId')";
		return pgDb::execute($query);
	}
	
	public static function getInvitationsByOrg($orgId) {
		$query = "select uuid, date_part('days', expire_dt - now()) as days_remaining from invitation where organization_fk = '$orgId'";
		return pgDb::execute($query);
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
	
	public static function userOrgRelationExists($orgId, $email) {
		// TODO: broken now with refactor (email)
		$query = "select exists (select true from user_organization where organization_fk = '$orgId' and user_fk in (select id from public.user where email = '$email' and status_fk = '1'))";
		return pgDb::execute($query);
	}
	
	public static function insertOrganization($name, $ein) {
			$query = "insert into organization (name, status_fk) values ('$name', '1') returning id";
			return pgDb::execute($query);		
	}

	public static function insertInvitationResponse($orgId, $uuid) {
			$query = "insert into invitation_organization (organization_fk, invitation_fk, create_dttm) values ('$orgId', 
				(select id from invitation where uuid = '$uuid'), now())";
			pgDb::execute($query);
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
	
	public static function insertAdminUserOrgRelation($email, $orgId, $grantorId) {
			// TODO: add active check?
			// TODO: broken now with refactor (email)
			$query = "insert into user_organization (user_fk, organization_fk, grantor_fk, role_fk, create_dttm) values ((select id from public.user where email = '$email' limit 1), '$orgId', '$grantorId', '1', now()) returning id";
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

	public static function inactivateUser($userId) {
		$query = "update public.user set status_fk = '2', suspend_dttm = now() where id = '$userId'";
		return pgDb::execute($query);
	}
	
	public static function reactivateUser($userId) {
		$query = "update public.user set status_fk = '1', activate_dttm = now() where id = '$userId'";
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

?>