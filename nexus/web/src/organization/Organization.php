<?php

require_once(dirname(__FILE__) . "/../framework/PgDb.php");

class Organization {
	
	// TODO
	// get valid values for org type
	// select * from pg_enum e where enumtypid = '1569578'
	
	public static function getOrganizationById($orgId) {
		$query = "select name, type, structure, logo, status_fk as status from organization where id = $1";
		return pgDb::psExecute($query, array($orgId));
	}
	
	public static function getOrganizationByUid($orgUid) {
		$query = "select name, type, structure, logo, status_fk as status from organization where uid = $1";
		return pgDb::psExecute($query, array($orgUid));
	}

	public static function validateNetworkId($in) {
		if(Util::validateNetworkIdFormat($in)) {
			if (self::networkIdExists($in)) {	
				return TRUE;
			}
		}
		return FALSE;
	}

	public static function validateOrganizationUid($in) {
		if(Util::validateOrganizationUidFormat($in)) {
			if (self::organizationUidExists($in)) {	
				return TRUE;
			}
		}
		return FALSE;
	}
	
	private static function networkIdExists($id) {
		$query = "select exists (select true from organization_organization where organization_to_fk = $1)";
		$row = pg_fetch_row(PgDb::psExecute($query, array($id)));
		if (!strcmp($row[0], "t")) {
			return TRUE;
		}
		return FALSE;
	}
	
	private static function organizationUidExists($id) {
		$query = "select exists (select true from organization where uid = $1)";
		$row = pg_fetch_row(PgDb::psExecute($query, array($id)));
		if (!strcmp($row[0], "t")) {
			return TRUE;
		}
		return FALSE;
	}

}

?>
