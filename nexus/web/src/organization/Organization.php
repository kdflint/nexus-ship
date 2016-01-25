<?php

require_once(dirname(__FILE__) . "/../framework/PgDb.php");

class Organization {
	
	// TODO
	// get valid values for org type
	// select * from pg_enum e where enumtypid = '1569578'
	
	public static function getOrganizationById($orgId) {
		$query = "select name, type, structure, logo, status_fk as status from organization where id = $1";
		return PgDatabase::psExecute($query, array($orgId));
	}
	
	public static function getOrganizationByUid($orgUid) {
		$query = "select id, name, type, structure, logo, status_fk as status from organization where uid = $1";
		return PgDatabase::psExecute($query, array($orgUid));
	}
	
	public static function getOrganizationsByGroupId($groupIdList) {
			$query = "select uo.organization_fk as oid from user_organization uo, user_group ug where ug.group_fk in ($1) and ug.user_fk = uo.user_fk";
			return pgDb::psExecute($query, array($groupIdList));
	}
	
	// LEFT OFF - move over all methods from pilot pgDb to Organization (ones that are referenced in searchProcessor.php)

	public static function validateNetworkId($in) {
		if(Utilities::validateNetworkIdFormat($in)) {
			if (self::networkIdExists($in)) {	
				return TRUE;
			}
		}
		return FALSE;
	}

	public static function validateOrganizationUid($in) {
		if(Utilities::validateOrganizationUidFormat($in)) {
			if (self::organizationUidExists($in)) {	
				return TRUE;
			}
		}
		return FALSE;
	}
	
	private static function networkIdExists($id) {
		$query = "select exists (select true from organization_organization where organization_to_fk = $1)";
		$row = pg_fetch_row(PgDatabase::psExecute($query, array($id)));
		if (!strcmp($row[0], "t")) {
			return TRUE;
		}
		return FALSE;
	}
	
	private static function organizationUidExists($id) {
		$query = "select exists (select true from organization where uid = $1)";
		$row = pg_fetch_row(PgDatabase::psExecute($query, array($id)));
		if (!strcmp($row[0], "t")) {
			return TRUE;
		}
		return FALSE;
	}
	
	public static function getOrganizationByLanguageId($langId) {
			$query = "select o.name, o.id from organization_language ol, organization o where ol.language_fk = $1 and ol.organization_fk = o.id";
			return PgDatabase::psExecute($query, array($langId));		
	}
	
	public static function getOrganizationByTopicId($topicId) {
			$query = "select o.name, o.id from organization_topic ot, organization o where ot.topic_fk = $1 and ot.organization_fk = o.id";
			return PgDatabase::psExecute($query, array($topicId));		
	}

	public static function getOrganizationByProgramId($progId) {
			$query = "select o.name, o.id from organization_program op, organization o where op.program_fk = $1 and op.organization_fk = o.id";
			return PgDatabase::psExecute($query, array($progId));		
	}
	
	public static function getOrganizationByContactId($contactId) {
			$query = "select o.name, o.id from organization_contact oc, organization o where oc.contact_fk = $1 and oc.organization_fk = o.id";
			return PgDatabase::psExecute($query, array($contactId));		
	}
	
	public static function getOrganizationByLocationId($locId) {
			$query = "select o.name, o.id from organization_location ol, organization o where ol.location_fk = $1 and ol.organization_fk = o.id";
			return PgDatabase::psExecute($query, array($locId));		
	}
	
	public static function organizationTopicExists($orgId, $topics) {
		$query = "select exists (select true from organization_topic where organization_fk=$1 and topic_fk in ($2))";
		return PgDatabase::psExecute($query, array($orgId, $topics));
	}

	public static function organizationTypeExists($orgId, $types) {
		$query = "select exists (select true from organization where id = $1 and type in ($2))";
		return PgDatabase::psExecute($query, array($orgId, $types));
	}
	
	public static function getOrganizationsByNetworkId($networkId) {
			$query = "
				select 'Organization' as type, o.id as id, o.name as name
				from organization o, organization_organization oo
				where o.id = oo.organization_to_fk
				and oo.organization_from_fk = $1
				and oo.relationship ='parent'
				";
				return PgDatabase::psExecute($query, array($networkId));	
	}

}

?>
