<?php

require_once(dirname(__FILE__) . "/../framework/PgDb.php");
require_once(dirname(__FILE__) . "/../framework/Util.php");
require_once(Util::getSrcRoot() . "/user/Invitation.php");

class Group {
	
	public static function getGroupById($groupId) {
		$query = "select name, descr, logo from public.group where id = $1";
		return pgDb::psExecute($query, array($groupId));
	}

	public static function validateGroupId($in) {
		if(Util::validateGroupIdFormat($in)) {
			if (self::groupIdExists($in)) {	
				return TRUE;
			}
		}
		return FALSE;
	}
	
	public static function getGroupMembersByGroupId($id, $ssnUser) {
		$users = array();
		
		$cursor = Invitation::getOpenGroupInvitations($id);
		$counter = 0;		
		while ($row = pg_fetch_array($cursor)) {
			$users[$counter]['fname'] = "Pending";
			$users[$counter]['lname'] = "Enrollment";
			$users[$counter]['email'] = $row['email'];
			$users[$counter]['sessionUser'] = $ssnUser;
			$users[$counter]['uidpk'] = $row['uuid'];
			$users[$counter]['role'] = Util::getRoleName($row['roleid']);
			$users[$counter]['status'] = "pending";
			$counter++;
		}

		$query = "select u.id, u.fname, u.lname, u.email, ug.role_fk as roleid, o.name as oname
			from public.user u, user_group ug, organization o, user_organization uo
			where u.id = ug.user_fk
			and u.suspend_dttm is NULL
			and uo.user_fk = u.id
			and o.id = uo.organization_fk
			and ug.group_fk = $1
			order by u.fname, u.lname
			";			
			$cursor = pgDb::psExecute($query, array($id));
			while ($row = pg_fetch_array($cursor)) {
				$users[$counter]['fname'] = $row['fname'];
				$users[$counter]['lname'] = $row['lname'];
				$users[$counter]['title'] = "";
				$users[$counter]['descr'] = "";
				$users[$counter]['email'] = $row['email'];
				$users[$counter]['sessionUser'] = $ssnUser;
				$users[$counter]['uidpk'] = $row['id'];
				$users[$counter]['role'] = Util::getRoleName($row['roleid']);
				$users[$counter]['status'] = "active";
				$counter++;
			}
			
			return $users;
	}	
	
	private static function groupIdExists($id) {
		$query = "select exists (select true from public.group where uid = $1)";
		$row = pg_fetch_row(PgDb::psExecute($query, array($id)));
		if (!strcmp($row[0], "t")) {
			return TRUE;
		}
		return FALSE;
	}

}

?>
