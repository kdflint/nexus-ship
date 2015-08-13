<?php

require_once(dirname(__FILE__) . "/../framework/PgDb.php");
require_once(dirname(__FILE__) . "/../framework/Util.php");

class Invitation {
	
	public static function addInvitation($email, $groupId, $uuid, $roleId, $issuerId, $orgId) {
		$query = "insert into invitation (uuid, email, create_dttm, accept_dttm, network_fk, invitation_dttm, role_fk, expire_dt, issuer_fk, type, organization_fk, group_fk) values ($3, $1, now(), NULL, NULL, now(), $4, (CURRENT_DATE + interval '31 days'), $5, 'single', $6, $2) returning uuid";
		$cursor = PgDb::psExecute($query, array($email, $groupId, $uuid, $roleId, $issuerId, $orgId));		
		$row = pg_fetch_row($cursor);
		return $row[0];
	}
	
	public static function isInvitationOpen($uuid) {
		$query = "select exists (select true from invitation where uuid = $1 and accept_dttm is NULL and expire_dt > now())";
		$row = pg_fetch_row(PgDb::psExecute($query, array($uuid)));
		if (!strcmp($row[0], "t")) {
			return TRUE;
		}
		return FALSE;
	}
	
	public static function getOpenGroupInvitations($groupId) {
		$query = "select email, role_fk as roleid from invitation where group_fk = $1 and accept_dttm is NULL and expire_dt > now() and type = 'single' order by email";
		return PgDb::psExecute($query, array($groupId));
	}
	
	public static function getOpenInvitationByUuid($uuid) {
		$query = "select network_fk as networkid, organization_fk as orgid, issuer_fk as grantorid, type as type, role_fk as roleid, group_fk as groupid from invitation where uuid=$1 order by create_dttm desc limit 1";
		return PgDb::psExecute($query, array($uuid));
	}
	
	public static function consumeInvitationByUuid($uuid) {
		$query = "update invitation set accept_dttm = now() where uuid = $1";
		return PgDb::psExecute($query, array($uuid));
	}

}

?>