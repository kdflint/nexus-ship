<?php

require_once(dirname(__FILE__) . "/../framework/PgDb.php");

class Organization {
	
	public static function getGroupById($groupId) {
		$query = "select name, descr, logo from group_new where uid = $1";
		return pgDb::psExecute($query, array($orgId));
	}

	public static function validateGroupId($in) {
		if(Util::validateGroupIdFormat($in)) {
			if (self::groupIdExists($in)) {	
				return TRUE;
			}
		}
		return FALSE;
	}
	
	public static function getGroupMembersByGroupId($id) {
		$query = "select u.id, u.fname, u.lname, o.name as oname
			from public.user u, user_group ug, organization o, user_organization uo
			where u.id = ug.user_fk
			and uo.user_fk = u.id
			and o.id = uo.organization_fk
			and ug.group_fk = $1
			order by u.lname, o.name
			";
			return pgDb::psExecute($query, array($id));
	}	
	
	private static function groupIdExists($id) {
		$query = "select exists (select true from group_new where uid = $1)";
		$row = pg_fetch_row(PgDb::psExecute($query, array($id)));
		if (!strcmp($row[0], "t")) {
			return TRUE;
		}
		return FALSE;
	}

}

?>
