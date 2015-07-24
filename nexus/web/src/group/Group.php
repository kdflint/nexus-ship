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
