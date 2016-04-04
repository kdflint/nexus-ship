<?php

require_once(dirname(__FILE__) . "/../framework/PgDb.php");
require_once(dirname(__FILE__) . "/../framework/Util.php");
require_once(Utilities::getSrcRoot() . "/user/Invitation.php");

class Group {
	
	public static function getGroupById($groupId) {
		$query = "select id, name, descr, logo from public.group where id = $1";	
		$cursor = PgDatabase::psExecute($query, array($groupId));
	  $resultArray = array();
	  while ($row = pg_fetch_array($cursor)) {
	  	$resultArray[$row['id']] = $row['name'];
	  }		
	  return $resultArray;
	}
	
	public static function getGroupByEventUuid($uuid) {
		$query = "select g.id as id, g.name as name from event e, public.group g, event_group eg
			where e.uuid = $1
			and e.id = eg.event_fk
			and g.id = eg.group_fk
			and e.active = true
			limit 1";		
		$cursor = PgDatabase::psExecute($query, array($uuid));
	  $resultArray = array();
	  while ($row = pg_fetch_array($cursor)) {
	  	$resultArray[$row['id']] = $row['name'];
	  }		
	  return $resultArray;
	}		

	public static function validateGroupId($in) {
		if(Utilities::validateGroupIdFormat($in)) {
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
			$users[$counter]['role'] = Utilities::getRoleName($row['roleid']);
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
			$cursor = PgDatabase::psExecute($query, array($id));
			while ($row = pg_fetch_array($cursor)) {
				$users[$counter]['fname'] = $row['fname'];
				$users[$counter]['lname'] = $row['lname'];
				$users[$counter]['title'] = "";
				$users[$counter]['descr'] = "";
				$users[$counter]['email'] = $row['email'];
				$users[$counter]['sessionUser'] = $ssnUser;
				$users[$counter]['uidpk'] = $row['id'];
				$users[$counter]['role'] = Utilities::getRoleName($row['roleid']);
				$users[$counter]['status'] = "active";
				$counter++;
			}
			
			return $users;
	}	
	
	
	public static function getUserGroupsByUsername($username) {
		$query = "select g.id as id, g.name as name from public.group g, public.user u, user_group ug where u.username = $1 and ug.user_fk = u.id and ug.group_fk = g.id";
		$cursor = PgDatabase::psExecute($query, array($username));
	  $resultArray = array();
	  while ($row = pg_fetch_array($cursor)) {
	  	$resultArray[$row['id']] = $row['name'];
	  }		
	  return $resultArray;
	}
	
	
	/*
	public static function getPublicUserGroupByOrgId($oid) {
		$query = "select u.username from public.user u, user_organization uo, organization o where u.id = uo.user_fk and u.suspend_dttm is NULL and u.username like 'pUser%' and uo.organization_fk = o.id and o.uid = $1 limit 1";
		$row = pg_fetch_row(PgDatabase::psExecute($query, array($oid)));
		if ($row) {
			return self::getUserGroupsByUsername($row[0]);
		} else {
			return array();
		}
	}
	*/		
	
	private static function groupIdExists($id) {
		$query = "select exists (select true from public.group where uid = $1)";
		$row = pg_fetch_row(PgDatabase::psExecute($query, array($id)));
		if (!strcmp($row[0], "t")) {
			return TRUE;
		}
		return FALSE;
	}

}

?>
