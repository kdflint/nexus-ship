<?php

require_once(dirname(__FILE__) . "/../framework/PgDb.php");

class Invitation {
	
	public static function addInvitation($email, $groupId, $uuid, $roleId, $issuerId) {
		$query = "insert into invitation (uuid, email, create_dttm, accept_dttm, network_fk, invitation_dttm, role_fk, expire_dt, issuer_fk, type, organization_fk, group_fk) values ($3, $1, now(), NULL, NULL, now(), $4, NULL, $5, 'single', NULL, $2)";
		$cursor = PgDb::psExecute($query, array($email, $groupId, $uuid, $roleId, $issuerId));		
		$row = pg_fetch_row($cursor);
		return $row[0];
	}
	
	public static function isInvitationOpen($uuid) {
		$query = "select exists (select true from invitation where uuid = $1 and accept_dttm is NULL and expire_dt > now())";
		$row = pg_fetch_row(pgDb::psExecute($query, array($uuid)));
		if (!strcmp($row[0], "t")) {
			return TRUE;
		}
		return FALSE;
	}
}

?>