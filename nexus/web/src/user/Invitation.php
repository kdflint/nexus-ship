<?php

require_once(dirname(__FILE__) . "/../framework/PgDb.php");
require_once(dirname(__FILE__) . "/../framework/Util.php");

class Invitation {
	
	public static function addInvitation($email, $groupId, $uuid, $roleId, $issuerId, $orgId) {
		$query = "insert into invitation (uuid, email, create_dttm, accept_dttm, network_fk, invitation_dttm, role_fk, expire_dt, issuer_fk, type, organization_fk, group_fk) values ($3, $1, now(), NULL, NULL, now(), $4, (CURRENT_DATE + interval '31 days'), $5, 'single', $6, $2) returning uuid";
		$cursor = PgDatabase::psExecute($query, array($email, $groupId, $uuid, $roleId, $issuerId, $orgId));		
		$row = pg_fetch_row($cursor);
		return $row[0];
	}
	
	public static function isInvitationOpen($uuid) {
		$query = "select exists (select true from invitation where uuid = $1 and accept_dttm is NULL and expire_dt > now())";
		$row = pg_fetch_row(PgDatabase::psExecute($query, array($uuid)));
		if (!strcmp($row[0], "t")) {
			return TRUE;
		}
		return FALSE;
	}
	
	public static function getOpenGroupInvitations($groupId) {
		$query = "select email, role_fk as roleid, uuid as uuid from invitation where group_fk = $1 and accept_dttm is NULL and expire_dt > now() and type = 'single' order by email";
		return PgDatabase::psExecute($query, array($groupId));
	}

	public static function getOpenInvitationByUuid($uuid) {
		$query = "select i.network_fk as networkid, i.organization_fk as orgid, i.issuer_fk as grantorid, i.type as type, i.role_fk as roleid, i.group_fk as groupid, o.uid as uid from invitation i, organization o where i.uuid=$1 and i.organization_fk = o.id order by i.create_dttm desc limit 1";
		return PgDatabase::psExecute($query, array($uuid));
	}
	
	public static function consumeInvitationByUuid($uuid) {
		$query = "update invitation set accept_dttm = now() where uuid = $1";
		return PgDatabase::psExecute($query, array($uuid));
	}
	
	public static function expireInvitationByUUid($uuid) {
		$query = "update invitation set expire_dt = DATE 'yesterday' where uuid = $1";
		return PgDatabase::psExecute($query, array($uuid));
	}

}

?>