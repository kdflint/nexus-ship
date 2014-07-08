<?php

class Db {
	
	public static function connect() {
		mysql_connect("localhost", "northbr6_web", "nbportal") or die("cannot connect");
	  mysql_select_db("northbr6_nbnexus") or die("cannot select DB");
	}
	
	public static function disconnect() {
		mysql_close();
	}
	
	public static function getUserProfile($uid) {
		$cursor = mysql_query(
			"select u.fname as fname, u.lname as lname, u.level as level, o.name as affiliation, u.id as pk, o.handle as handle
			from user u, organization o, user_organization uo
			where u.uid = '$uid'
			and u.id = uo.user_fk
			and o.id = uo.organization_fk"
		);
		return $cursor;
	}
	
	public static function getUserNetwork($uid) {
		$cursor = mysql_query(
			"select o.name as network 
			from user u, user_organization uo, organization o, organization_organization oo
			where u.uid = '$uid'
			and u.id = uo.user_fk
			and uo.organization_fk = oo.organization_to_fk
			and oo.relationship = 'parent'
			and oo.organization_from_fk = o.id"
		);
		return $cursor;
	}
	
	public static function getRecentSearches($uidpk) {
		$cursor = mysql_query(
			"select o.name as name, concat(u.fname,' ' , u.lname) as contact, 'Service focus:' as focus 
			from user_search us, organization o, user_organization uo, user u 
			where us.user_fk = '$uidpk' 
			and us.organization_fk = o.id 
			and o.id = uo.organization_fk 
			and uo.role = 'primary' 
			and uo.user_fk = u.id 
			order by us.date limit 3");
		return $cursor;
		
	}
	
	public static function freeSearch($string) {
		$cursor = mysql_query(
			"select o.name as name, concat(u.fname,' ' , u.lname) as contact, 'Service focus:' as focus
			from organization o, user_organization uo, user u
			where o.name like '%$string%'
			and o.id = uo.organization_fk 
			and uo.role = 'primary' 
			and uo.user_fk = u.id 
			limit 5"
		);
				return $cursor;		
	}
	
}

?>
