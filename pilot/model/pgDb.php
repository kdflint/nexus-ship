<?php

class pgDb {
	
	// get valid values for org type
	// select * from pg_enum e where enumtypid = '1569578'
	
	// TODO: switch this all over to parameterized queries
	
	public static function connect() {
		$host = "localhost"; 
		$user = "northbr6_web"; 
		$pass = "bdTEzR?MRs[C"; 
		//$user = "northbr6"; 
		//$pass = "A56L9Q1X"; 
		$db = "northbr6_nbnexus";		
		
		$con = pg_connect("host=$host dbname=$db user=$user password=$pass")
    or die ("Could not connect to server\n"); 
    
    return $con;
	}
	
	public static function disconnect($con) {
		pg_close($con);
	}
	
	private static function execute($query) {
		$con = pgDb::connect();
		$result = pg_query($con, $query) or die("Cannot execute query: $query\n");
		pgDb::disconnect($con);
		return $result;
	}
	
	public static function insertOpenAdminInvitation($uuid, $orgId) {
		$query = "insert into invitation (uuid, create_dttm, accept_dttm, organization_fk, invitation_dttm, role_fk, expire_dt, issuer_fk) values ('$uuid', now(), NULL, '$orgId', NULL, '1', now() + interval '2 week', '1')";
		return pgDb::execute($query);
	}
	
	public static function insertSingleAdminInvitation($uuid, $orgId, $email, $grantorId) {
		$query = "insert into invitation (uuid, email, create_dttm, accept_dttm, organization_fk, invitation_dttm, role_fk, expire_dt, issuer_fk) values ('$uuid', '$email', now(), NULL, '$orgId', NULL, '1', now() + interval '2 week', '$grantorId')";
		return pgDb::execute($query);
	}
	
	public static function getInvitationByUuid($uuid) {
		// TODO: ensure that input length == 36
		$query = "select network_fk as networkid, organization_fk as orgid, issuer_fk as grantorid, type, role_fk as role from invitation where uuid = '$uuid' order by create_dttm desc limit 1";
		return pgDb::execute($query);
	}
	
	public static function getInvitationsByOrg($orgId) {
		$query = "select uuid, date_part('days', expire_dt - now()) as days_remaining from invitation where organization_fk = '$orgId'";
		return pgDb::execute($query);
	}
	
	public static function checkValidInvitation($uuid) {
		if (strlen($uuid) == 36) {
			$query = "select id from invitation where uuid = '$uuid'";
			$count = pg_num_rows(pgDb::execute($query));
			if ($count == 1) {
				return true;
			}
		}
		return false;
	}
	
	public static function orgEinExists($ein) {
		$query = "select exists (select true from organization where ein = '$ein')";
		return pgDb::execute($query);
	}
	
	public static function forumEmailExists($email) {
		$query = "select exists (select true from forum_user where email = '$email')";
		return pgDb::execute($query);
	}
	
	public static function forumUsernameExists($username) {
		$query = "select exists (select true from forum_user where name = '$username')";
		return pgDb::execute($query);
	}
	
	public static function orgTopicExists($orgId, $topics) {
		$query = "select exists (select true from organization_topic where organization_fk = '$orgId' and topic_fk in($topics))";
		return pgDb::execute($query);
	}
	
	public static function userEmailExists($email) {
		$query = "select exists (select true from contact where email = '$email' and status_fk = '1')";
		return pgDb::execute($query);
	}
	
	public static function countUserEmail($email) {
		// TODO: broken now with refactor (email)
		$query = "select id from public.user where email = '$email' and status_fk = '1'";
		return pg_num_rows(pgDb::execute($query));
	}
	
	public static function countActiveUsers($uid, $password) {
		$query = "select id from public.user where username = '$uid' and password = '$password' and status_fk = '1'";
		return pg_num_rows(pgDb::execute($query));
	}
	
	public static function userOrgRelationExists($orgId, $email) {
		// TODO: broken now with refactor (email)
		$query = "select exists (select true from user_organization where organization_fk = '$orgId' and user_fk in (select id from public.user where email = '$email' and status_fk = '1'))";
		return pgDb::execute($query);
	}
	
	public static function countOrgsInNetworkById($networkId) {
		$query = "select id from organization_organization where organization_from_fk = '$networkId' and relationship = 'parent'";
		$count = pg_num_rows(pgDb::execute($query));
		return $count;
	}
	
	public static function insertOrganization($name, $ein) {
			$query = "insert into organization (name, status_fk) values ('$name', '1') returning id";
			return pgDb::execute($query);		
	}
	
	public static function insertOrgOrgRelation($from, $to, $relation) {
			$query = "insert into organization_organization (organization_from_fk, organization_to_fk, relationship) values ('$from', '$to', '$relation')";
			return pgDb::execute($query);		
	}

	public static function insertInvitationResponse($orgId, $uuid) {
			$query = "insert into invitation_organization (organization_fk, invitation_fk, create_dttm) values ('$orgId', 
				(select id from invitation where uuid = '$uuid'), now())";
			pgDb::execute($query);
	}

	public static function insertActiveUser($uuid, $username, $password, $fname, $lname, $email) {
			// TODO: broken now with refactor (email)
			$query = "insert into public.user (uuid, username, password, fname, lname, email, status_fk, create_dttm, activate_dttm) values ('$uuid', '$username', '$password', '$fname', '$lname', '$email', '1', now(), now()) returning id";
			return pgDb::execute($query);		
	}
	
	public static function insertActiveUserByEmail($uuid, $email) {
			// TODO: broken now with refactor (email)
			$query = "insert into public.user (uuid, email, status_fk, create_dttm, activate_dttm) values ('$uuid', '$email', '1', now(), now()) returning id";
			return pgDb::execute($query);		
	}
	
	public static function insertActiveUserByCredentials($uuid, $username, $password) {
			$query = "insert into public.user (uuid, username, password, status_fk, create_dttm, activate_dttm) values ('$uuid', '$username', '$password', '1', now(), now()) returning id";
			return pgDb::execute($query);		
	}
	
	public static function insertUserOrgRelation($userId, $orgId, $grantorId) {
			// TODO: add active check?
			$query = "insert into user_organization (user_fk, organization_fk, grantor_fk, role_fk, create_dttm) values ('$userId', '$orgId', '$grantorId', '1', now()) returning id";
			return pgDb::execute($query);		
	}
	
	public static function getUserOrgRelationsByUserId($userId) {
			// TODO: add active check?
			$query = "select o.name, o.id from user_organization uo, organization o where uo.user_fk = '$userId' and uo.organization_fk = o.id";
			return pgDb::execute($query);
	}
	
	public static function getOrgByLanguageId($langId) {
			$query = "select o.name, o.id from organization_language ol, organization o where ol.language_fk = '$langId' and ol.organization_fk = o.id";
			return pgDb::execute($query);		
	}
	
	public static function getOrgByProgramId($progId) {
			$query = "select o.name, o.id from organization_program op, organization o where op.program_fk = '$progId' and op.organization_fk = o.id";
			return pgDb::execute($query);		
	}
	
	public static function getOrgByContactId($contactId) {
			$query = "select o.name, o.id from organization_contact oc, organization o where oc.contact_fk = '$contactId' and oc.organization_fk = o.id";
			return pgDb::execute($query);		
	}
	
	public static function getOrgByLocationId($locId) {
			$query = "select o.name, o.id from organization_location ol, organization o where ol.location_fk = '$locId' and ol.organization_fk = o.id";
			return pgDb::execute($query);		
	}
	
	public static function insertAdminUserOrgRelation($email, $orgId, $grantorId) {
			// TODO: add active check?
			// TODO: broken now with refactor (email)
			$query = "insert into user_organization (user_fk, organization_fk, grantor_fk, role_fk, create_dttm) values ((select id from public.user where email = '$email' limit 1), '$orgId', '$grantorId', '1', now()) returning id";
			return pgDb::execute($query);		
	}
	
	public static function insertUserForumRelation($userId, $username, $password, $name, $email) {
			$query = "insert into forum_user (user_fk, username, password, name, email) values ('$userId', '$username', '$password', '$name', '$email') returning id";
			return pgDb::execute($query);
	}
	
	public static function getUserSessionByUsername($uid) {
		// TODO: add active check?
		// TODO: fix up network id determination (parent, god, etc)
		$query = "
			select u.id as id, u.fname as fname, u.lname as lname, u.password as password, o1.name as affiliation, o2.name as network, o2.id as networkid, uo.role_fk as role
			from public.user u, user_organization uo, organization o1, organization o2, organization_organization oo
			where u.username = '$uid'
			and uo.user_fk = u.id
			and uo.organization_fk = o1.id
			and oo.organization_to_fk = o1.id 
			and oo.organization_from_fk = o2.id
			and oo.relationship in ('parent', 'god')
			";
		return pgDb::execute($query);	
	}
	
	public static function getUserByUsername($uid) {
		// TODO: add active check?
		$query = "select u.id as id, u.fname as fname, u.lname as lname from public.user u where u.username = '$uid' limit 1";
		return pgDb::execute($query);	
	}
	
	public static function getForumUserByNexusId($uid) {
		$query = "select id, username, name from forum_user where user_fk = '$uid'";
		return pgDb::execute($query);			
	}
	
	public static function getPrivileges($roleId) {
		$query = "
			select r.name as role, p.name as privilege
			from privilege p, role r, role_privilege pr 
			where pr.role_id_fk = '$roleId' 
			and pr.role_id_fk = r.id
			and pr.privilege_id_fk = p.id
			";
		return pgDb::execute($query);
	}	
	
	public static function getUserById($userId) {
		// TODO: broken now with refactor (email)
		$query = "
		select u.fname as first, u.lname as last, u.email as email, u.sms as cell, u.enable_email as emailon, u.enable_sms as smson, s.name as status, r.name as role 
			from public.user u, user_organization uo, status s, role r 
			where u.id = '$userId'
			and s.id = u.status_fk
			and uo.user_fk = u.id
			and uo.role_fk = r.id
			";
		return pgDb::execute($query);
	}
	
	public static function isUserMessageEnabled($userId) {
		$query = "select u.enable_email, u.enable_sms from public.user u where u.id = '$userId'";
		$result = pg_fetch_array(pgDb::execute($query));
		if (!strcmp($result[0], "t") || !strcmp($result[1], "t")) {
				return true;
		}
		return false;
	}
	
	public static function updateUserById($userId, $fname, $lname, $sms, $email, $smsEnabled, $emailEnabled) {
		// TODO: broken now with refactor (email)
		$query = "
		update public.user set
			fname = '$fname',
			lname = '$lname',
			sms = '$sms',
			email = '$email',
			enable_email = '$emailEnabled',
			enable_sms = '$smsEnabled'
			where id = '$userId'
			";
		return pgDb::execute($query);
	}
	
	public static function inactivateUser($userId) {
		$query = "update public.user set status_fk = '2', suspend_dttm = now() where id = '$userId'";
		return pgDb::execute($query);
	}
	
	public static function reactivateUser($userId) {
		$query = "update public.user set status_fk = '1', activate_dttm = now() where id = '$userId'";
		return pgDb::execute($query);
	}
	
	public static function getOrganizationById($orgId) {
		$query = "select name, type, structure, status_fk as status from organization where id = '$orgId'";
		return pgDb::execute($query);
	}
	
	public static function getOrganizationUsersById($orgId) {
		$query = "
		select u1.fname as first, u1.lname as last, s.name as status, r.name as role, u2.fname as grantor
			from public.user u1, public.user u2, user_organization uo, role r, status s
			where uo.organization_fk = '$orgId'
			and uo.user_fk = u1.id
			and uo.role_fk = r.id
			and u1.status_fk = s.id
			and uo.grantor_fk = u2.id
			";
		return pgDb::execute($query);
	}

	public static function inactivateOrganization($orgId) {
		$query = "update organization set status_fk = '2', suspend_dttm = now() where id = '$orgId'";
		return pgDb::execute($query);
	}
	
	public static function reactivateOrganization($orgId) {
		$query = "update organization set status_fk = '1', activate_dttm = now() where id = '$orgId'";
		return pgDb::execute($query);
	}

	public static function freeSearch($term, $networkId) {
		// TODO: use citext index in db instead of lower() function here
		// http://stackoverflow.com/questions/7005302/postgresql-how-to-make-not-case-sensitive-queries
		
		$query = "
			select 'Organization' as type, o.id as id, o.name as name
			from organization o, organization_organization oo
			where 
				lower(o.name) like lower('%{$term}%')
			and o.id = oo.organization_to_fk
			and oo.organization_from_fk = '$networkId'
			and oo.relationship ='parent'
			
			union
			
			select 'Person' as type, u.id as id, (u.fname || ' ' || u.mname || ' ' || u.lname) as name
			from public.user u, organization_organization oo, user_organization uo
			where (
				lower(u.fname) like lower('%{$term}%')
				or lower(u.lname) like lower('%{$term}%')
				or lower(u.mname) like lower('%{$term}%')
				or lower(u.nickname) like lower('%{$term}%')
			)
			and u.id = uo.user_fk
			and uo.organization_fk = oo.organization_to_fk
			and oo.organization_from_fk = '$networkId'
			and oo.relationship ='parent'
			
			union
			
			select 'Contact' as type, c.id as id, c.name as name
			from contact c, organization_organization oo, organization_contact oc
			where (
				lower(c.name) like lower('%{$term}%')
				or lower(c.title) like lower('%{$term}%')
			)
			and c.id = oc.contact_fk
			and oc.organization_fk = oo.organization_to_fk
			and oo.organization_from_fk = '$networkId'
			and oo.relationship ='parent'
			
			union
			
			select 'Program' as type, p.id as id, p.name as name
			from program p, organization_organization oo, organization_program op
			where (
				lower(p.name) like lower('%{$term}%')
				or lower(p.description) like lower('%{$term}%')
			)
			and p.id = op.program_fk
			and op.organization_fk = oo.organization_to_fk
			and oo.organization_from_fk = '$networkId'
			and oo.relationship ='parent'
			
			union
			
			select 'Language' as type, l.id as id, l.language as name
			from language l, organization_organization oo, organization_language ol
			where 
				lower(l.language) like lower('%{$term}%')		
			and l.id = ol.language_fk
			and ol.organization_fk = oo.organization_to_fk
			and oo.organization_from_fk = '$networkId'
			and oo.relationship ='parent'
			
			union
			
			select 'Location' as type, loc.id as id, loc.municipality || ', ' || loc.region2 as name
			from location loc, organization_organization oo, organization_location oloc
			where (
				lower(loc.address1) like lower('%{$term}%')
				or lower(loc.address2) like lower('%{$term}%')
				or lower(loc.municipality) like lower('%{$term}%')
				or lower(loc.region1) like lower('%{$term}%')
				or lower(loc.region2) like lower('%{$term}%')
				or lower(loc.country) like lower('%{$term}%')
				or lower(loc.postal_code) like lower('%{$term}%')
			)		
			and loc.id = oloc.location_fk
			and oloc.organization_fk = oo.organization_to_fk
			and oo.organization_from_fk = '$networkId'
			and oo.relationship ='parent'
			"	
			;

			return pgDb::execute($query);			
			
	}

	public static function getOrgByTopicIds($topicIdList, $networkId) {
			$query = "
				select 'Organization' as type, o.id as id, o.name as name
				from organization o, organization_organization oo
				where o.id in (
					select organization_fk
					from organization_topic
					where topic_fk in ($topicIdList)
				)
				and oo.organization_from_fk = '$networkId'
				and o.id = oo.organization_to_fk
				and oo.relationship ='parent'
				";
			return pgDb::execute($query);		
	}
	
	public static function getOrgDetailById($orgId) {
		
		$result0 = pgDb::execute("select name, type, structure, status_fk as status from organization where id = '$orgId'");
		
		$result1 = pgDb::execute("select l.address1 || ', ' || l.address2 as line1, l.municipality || ', ' || l.region2 || '  ' || l.postal_code as line2 
															from location l, organization_location ol
															where ol.organization_fk = '$orgId'
															and ol.location_fk = l.id");
															
		$result2 = pgDb::execute("select c.phone as phone, c.email as email, c.url as url, c.name as name 
															from contact c, organization_contact oc
															where oc.organization_fk = '$orgId'
															and oc.contact_fk = c.id");
															
		$result3 = pgDb::execute("select l.language as language
															from language l, organization_language ol
															where ol.organization_fk = '$orgId'
															and ol.language_fk = l.id");
															
  	$result4 = pgDb::execute("select t.name as topic
															from topic t, organization_topic ot
															where ot.organization_fk = '$orgId'
															and ot.topic_fk = t.id");
															
  	$result5 = pgDb::execute("select p.name as name, p.description as descr
															from program p, organization_program op
															where op.organization_fk = '$orgId'
															and op.program_fk = p.id");
															
  	$result6 = pgDb::execute("select (u.fname || ' ' || u.mname || ' ' || u.lname) as name, u.enable_email as emailon, u.enable_sms as smson, u.id as id
															from public.user u, user_organization uo
															where uo.organization_fk = '$orgId'
															and uo.user_fk = u.id");
		
		$resultArray = array("orgId" => "",
												 "orgName" => "",
												 "orgType" => "",
												 "orgLocation" => array(array()),
												 "orgContact" => array(array()),
												 "orgLanguage" => array(),
												 "orgTopic" => array(),
												 "orgProgram" => array(array()),
												 "orgUser" => array(array())
												 );							
		  
	  $row0 = pg_fetch_array($result0);
	  $resultArray['orgId'] = $orgId;
	  $resultArray['orgName'] = $row0['name'];
	  $resultArray['orgType'] = $row0['type'];
	  
	  $counter = 0;
	  while ($row1 = pg_fetch_array($result1)) {
	  	$resultArray['orgLocation'][$counter][0] = $row1['line1'];
	  	$resultArray['orgLocation'][$counter][1] = $row1['line2'];
	  	$counter++;
	  }
	  
	  $counter = 0;
	  while ($row2 = pg_fetch_array($result2)) {
	  	$resultArray['orgContact'][$counter][0] = $row2['phone'];
	  	$resultArray['orgContact'][$counter][1] = $row2['email'];
	  	$resultArray['orgContact'][$counter][2] = $row2['url'];
	  	$resultArray['orgContact'][$counter][3] = $row2['name'];
	  	$counter++;
	  }
	  
	  $counter = 0;
	  while ($row3 = pg_fetch_array($result3)) {
	  	$resultArray['orgLanguage'][$counter] = $row3['language'];
	  	$counter++;
	  }
	  
	  $counter = 0;
	  while ($row4 = pg_fetch_array($result4)) {
	  	$resultArray['orgTopic'][$counter] = $row4['topic'];
	  	$counter++;
	  }
	  
	  $counter = 0;
	  while ($row5 = pg_fetch_array($result5)) {
	  	$resultArray['orgProgram'][$counter][0] = $row5['name'];
	  	$resultArray['orgProgram'][$counter][1] = $row5['descr'];
	  	$counter++;
	  }
	  
	  $counter = 0;
	  while ($row6 = pg_fetch_array($result6)) {
	  	$resultArray['orgUser'][$counter][0] = $row6['name'];
	  	$resultArray['orgUser'][$counter][1] = $row6['emailon'];
	  	$resultArray['orgUser'][$counter][2] = $row6['smson'];
	  	$resultArray['orgUser'][$counter][3] = $row6['id'];
	  	$counter++;
	  }
	  
		return $resultArray; 	

	}
}
?>
