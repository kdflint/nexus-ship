<?php

class pgDb {
	
	// get valid values for org type
	// select * from pg_enum e where enumtypid = '1569578'
	
	public static function connect() {	
		include("../config/env_config.php");	
		//include(dirname(__FILE__) . "/dev/nexus/config/env_config.php");	
		$con = pg_connect("host=$db_host dbname=$db user=$db_user password=$db_pass")
    or trigger_error("Could not connect to the database server\n", E_USER_ERROR);   
    return $con;
	}
	
	public static function disconnect($con) {
		pg_close($con);
	}
		
	private static function psExecute($query, $input) {
		$result = $prepare = FALSE;
		$con = pgDb::connect();
		$prepare = pg_prepare($con, "ps", $query);
		if (!$prepare) {
				trigger_error("Cannot prepare statement: $query\n", E_USER_ERROR);	
		}
		$result = pg_execute($con, "ps", $input);
		pgDb::disconnect($con);
		if (!$result) {
			trigger_error("Cannot execute query: $query\n", E_USER_ERROR);
		}
		return $result;
	}
	
	public static function countActiveUsers($uid, $password) {
		$query = "select id from public.user where username=$1 and password=$2 and status_fk='1'";
		return pg_num_rows(pgDb::psExecute($query, array($uid, $password)));
	}

	public static function getInvitationByUuid($uuid) {
		$query = "select network_fk as networkid, organization_fk as orgid, issuer_fk as grantorid, type as type, role_fk as role, group_fk as groupid from invitation where uuid=$1 order by create_dttm desc limit 1";
		return pgDb::psExecute($query, array($uuid));
	}

	public static function checkValidInvitation($uuid) {
		if (strlen($uuid) == 36) {
			$query = "select id from invitation where uuid=$1";
			$count = pg_num_rows(pgDb::psExecute($query, array($uuid)));
			if ($count == 1) {
				return true;
			}
		}
		return false;
	}

	public static function forumEmailExists($email) {
		$query = "select exists (select true from forum_user where email=$1)";
		return pgDb::psExecute($query, array($email));
	}

	public static function forumUsernameExists($username) {
		$query = "select exists (select true from forum_user where name=$1)";
		return pgDb::psExecute($query, array($username));
	}
	
	public static function networkIdExists($id) {
		$query = "select exists (select true from organization_organization where organization_to_fk = $1)";
		$row = pg_fetch_row(pgDb::psExecute($query, array($id)));
		if (!strcmp($row[0], "t")) {
			return TRUE;
		}
		return FALSE;
	}
	
	public static function userIdExists($id) {
		$query = "select exists (select true from public.user where id = $1)";
		$row = pg_fetch_row(pgDb::psExecute($query, array($id)));
		if (!strcmp($row[0], "t")) {
			return TRUE;
		}
		return FALSE;
	}
	
	public static function orgNameExists($orgName) {
		$query = "select exists (select true from organization where lower(name) = lower($1))";
		return pgDb::psExecute($query, array($orgName));
	}
	
	public static function userNameExists($name) {
		$query = "select exists (select true from public.user where lower(username) = lower($1))";
		return pgDb::psExecute($query, array($name));
	}
	
	public static function userEmailExists($email) {
		$query = "select exists (select true from public.user where lower(email) = lower($1))";
		return pgDb::psExecute($query, array($email));
	}

	public static function orgTopicExists($orgId, $topics) {
		$query = "select exists (select true from organization_topic where organization_fk=$1 and topic_fk in ($2))";
		return pgDb::psExecute($query, array($orgId, $topics));
	}

	public static function orgTypeExists($orgId, $types) {
		$query = "select exists (select true from organization where id = $1 and type in ($2))";
		return pgDb::psExecute($query, array($orgId, $types));
	}

	public static function countOrgsInNetworkById($networkId) {
		$query = "select id from organization_organization where organization_from_fk=$1 and relationship='parent'";
		$count = pg_num_rows(pgDb::psExecute($query, array($networkId)));
		return $count;
	}

	public static function insertOrgOrgRelation($from, $to, $relation) {
			$query = "insert into organization_organization (organization_from_fk, organization_to_fk, relationship) values ($1, $2, $3)";
			return pgDb::psExecute($query, array($from, $to, $relation));		
	}
	
	public static function insertPendingOrganization($orgName) {
		$query = "insert into organization (name, create_dttm, activate_dttm, status_fk, type) values ($1, now(), null, '3', '') returning id";
		return pgDb::psExecute($query, array($orgName));	
	}

	public static function insertActiveUser($uuid, $username, $fname, $lname, $email, $password) {
			$query = "insert into public.user (uuid, username, fname, lname, email, status_fk, create_dttm, activate_dttm, enable_email) values ($1, $2, $3, $4, $5, '1', now(), now(), $6) returning id";
			$result = pgDb::psExecute($query, array($uuid, $username, $fname, $lname, $email, "true"));		
			$row = pg_fetch_row($result);
			Util::storeSecurePasswordImplA($password, $row[0]);
			return $row[0];
	}
	
	public static function insertRoomLink($userId, $link) {
		$query = "update public.user set conference_link = $2 where id = $1";
		return pgDb::psExecute($query, array($userId, $link));
	}
	
	public static function insertPasswordResetActivity($userId, $uuid) {
		// invalidate prior open reset links
		$query = "update user_password set response_dttm = now() where user_fk = $1";
		pgDb::psExecute($query, array($userId));
		
		$query = "insert into user_password (user_fk, activity, create_dttm, uuid) values ($1, 'RESET', now(), $2)";
		return pgDb::psExecute($query, array($userId, $uuid));
	}
	
	public static function setSecurePasswordImplA($userId, $securePassword, $salt) {
		$query = "update public.user set 
			password = $2, 
			salt = $3, 
			cryptimpl = 'ImplA', 
			crypt_dttm = now() 
			where id = $1
			";
		return pgDb::psExecute($query, array($userId, $securePassword, $salt));
	}
	
	public static function getUserPasswordByUser($userId) {
		// TODO - make usernames in db not required to be unique (or, only unique within network). Pair with network id to do authentication.
		$query = "select password, salt, cryptimpl from public.user where username = $1";
		return pgDb::psExecute($query, array($userId));
	}
	
	public static function getUserPasswordResetActivityByUuid($uuid) {
		$query = "select u.email, u.id as uidpk, u.username, up.id as id
			from public.user u, user_password up
			where up.uuid = $1
			and up.response_dttm is NULL
			and up.activity = 'RESET'
			and up.create_dttm + interval '35 minutes' > now()
			and up.user_fk = u.id
			limit 1";
		return pgDb::psExecute($query, array($uuid));
	}

	public static function updateUserPasswordResetActivityById($id) {
		$query = "update user_password set response_dttm = now() where id = $1";
		return pgDb::psExecute($query, array($id));
	}

	public static function insertUserOrgRelation($userId, $orgId, $grantorId) {
			// TODO: add active check?
			$query = "insert into user_organization (user_fk, organization_fk, grantor_fk, role_fk, create_dttm) values ($1, $2, $3, '1', now()) returning id";
			return pgDb::psExecute($query, array($userId, $orgId, $grantorId));		
	}
	
	public static function insertUserGroupRelation($userId, $groupId) {
			$query = "insert into user_group (user_fk, group_fk, create_dttm) values ($1, $2, now())";
			return pgDb::psExecute($query, array($userId, $groupId));		
	}

	public static function getUserOrgRelationsByUserId($userId) {
			// TODO: add active check?
			$query = "select o.name, o.id from user_organization uo, organization o where uo.user_fk = $1 and uo.organization_fk = o.id";
			return pgDb::psExecute($query, array($userId));
	}

	public static function getOrgByLanguageId($langId) {
			$query = "select o.name, o.id from organization_language ol, organization o where ol.language_fk = $1 and ol.organization_fk = o.id";
			return pgDb::psExecute($query, array($langId));		
	}
	
	public static function getOrgByTopicId($topicId) {
			$query = "select o.name, o.id from organization_topic ot, organization o where ot.topic_fk = $1 and ot.organization_fk = o.id";
			return pgDb::psExecute($query, array($topicId));		
	}

	public static function getOrgByProgramId($progId) {
			$query = "select o.name, o.id from organization_program op, organization o where op.program_fk = $1 and op.organization_fk = o.id";
			return pgDb::psExecute($query, array($progId));		
	}
	
	public static function getOrgByContactId($contactId) {
			$query = "select o.name, o.id from organization_contact oc, organization o where oc.contact_fk = $1 and oc.organization_fk = o.id";
			return pgDb::psExecute($query, array($contactId));		
	}
	

	public static function getOrgByLocationId($locId) {
			$query = "select o.name, o.id from organization_location ol, organization o where ol.location_fk = $1 and ol.organization_fk = o.id";
			return pgDb::psExecute($query, array($locId));		
	}
	
	public static function insertUserForumRelation($userId, $username, $password, $name, $email) {
			$query = "insert into forum_user (user_fk, username, password, name, email) values ($1, $2, $3, $4, $5) returning id";
			return pgDb::psExecute($query, array($userId, $username, $password, $name, $email));
	}	

	
	public static function getUserSessionByUsername($uid) {
		// TODO: add active check?
		// TODO: fix up network id determination (parent, god, etc)
		// TODO - this will fail if user in > 1 group
		$query = "
			select u.id as id, u.fname as fname, u.lname as lname, u.password as password, u.conference_link as link, u.email as email, o1.name as affiliation, o2.name as network, o2.id as networkid, o2.logo as logo, uo.role_fk as role
			from public.user u, user_organization uo, organization o1, organization o2, organization_organization oo
			where u.username = $1
			and uo.user_fk = u.id
			and uo.organization_fk = o1.id
			and oo.organization_to_fk = o1.id 
			and oo.organization_from_fk = o2.id
			and oo.relationship in ('parent', 'god')
			";
		return pgDb::psExecute($query, array($uid));	
	}
		
	public static function getUserGroupsByUsername($uid) {
		$query = "select g.id as id, g.name as name from public.group g, public.user u, user_group ug where u.username = $1 and ug.user_fk = u.id and ug.group_fk = g.id";
		$cursor = pgDb::psExecute($query, array($uid));
	  $resultArray = array();
	  while ($row = pg_fetch_array($cursor)) {
	  	$resultArray[$row['id']] = $row['name'];
	  }		
	  return $resultArray;
	}

	public static function getUserGroupsByUserId($userid) {
		$query = "select g.id as id, g.name as name from public.group g, public.user u, user_group ug where u.id = $1 and ug.user_fk = u.id and ug.group_fk = g.id";
		$cursor = pgDb::psExecute($query, array($userid));
	  $resultArray = array();
	  while ($row = pg_fetch_array($cursor)) {
	  	$resultArray[$row['id']] = $row['name'];
	  }		
	  return $resultArray;
	}
	
	public static function getUserByUsername($uid) {
		// TODO: add active check?
		$query = "select u.id as id, u.email as email, u.fname as fname, u.lname as lname, u.password as password from public.user u where u.username = $1 limit 1";
		return pgDb::psExecute($query, array($uid));	
	}
	
	public static function getUsernamesByEmail($email) {
		$query = "select username from public.user where lower(email) = lower($1)";
		return pgDb::psExecute($query, array($email));
	}

	public static function getForumUserByNexusId($uid) {
		$query = "select id, username, name from forum_user where user_fk = $1";
		return pgDb::psExecute($query, array($uid));			
	}


	public static function getUserById($userId) {
		$query = "
		select u.fname as first, u.lname as last, u.password, u.email as email, u.sms as cell, u.phone as phone, u.enable_email as emailon, u.enable_sms as smson, u.publish_email as emailpub, u.publish_sms as smspub, u.publish_phone as phonepub, u.descr as descr, s.name as status, r.name as role 
			from public.user u, user_organization uo, status s, role r 
			where u.id = $1
			and s.id = u.status_fk
			and uo.user_fk = u.id
			and uo.role_fk = r.id
			";
		return pgDb::psExecute($query, array($userId));
	}

	public static function isUserMessageEnabled($userId) {
		$query = "select u.enable_email, u.enable_sms from public.user u where u.id = $1";
		$result = pg_fetch_array(pgDb::psExecute($query, array($userId)));
		if (!strcmp($result[0], "t") || !strcmp($result[1], "t")) {
				return true;
		}
		return false;
	}

	public static function updateUserById($userId, $fname, $lname, $sms, $email, $smsEnabled, $emailEnabled, $smsPublic, $emailPublic, $descr, $phone, $phonePublic) {
		$query = "
		update public.user set
			fname = $1,
			lname = $2,
			sms = $3,
			email = $4,
			enable_email = $5,
			enable_sms = $6,
			publish_email = $7,
			publish_sms = $8,
			descr = $9,
			phone = $10,
			publish_phone = $11
			where id = $12
			";
		return pgDb::psExecute($query, array($fname, $lname, $sms, $email, $emailEnabled, $smsEnabled, $emailPublic, $smsPublic, $descr, $phone, $phonePublic, $userId));
	}
	
	public static function getOrganizationById($orgId) {
		$query = "select name, type, structure, logo, status_fk as status from organization where id = $1";
		return pgDb::psExecute($query, array($orgId));
	}
	
	public static function getOrganizationByName($orgName) {
		$query = "select id, type, structure, status_fk as status from organization where lower(name) = lower($1)";
		return pgDb::psExecute($query, array($orgName));
	}

	public static function getGroupById($groupId) {
		$query = "select id, name from public.group where id = $1";
		return pgDb::psExecute($query, array($groupId));
	}
	
	public static function setLoginByIp($ip, $userId) {
		$query = "insert into user_session (ip, user_fk, create_dttm) values ($1, $2, now())";
		return pgDb::psExecute($query, array($ip, $userId));
	}		
	
	public static function insertMessage($uidpk, $subject, $message, $replyTo) {
		$query = "insert into message (sender_fk, subject, message, reply_to_fk, create_dttm) values ($1, $2, $3, $4, now()) returning id";
		$result = pgDb::psExecute($query, array($uidpk, $subject, $message, $replyTo));
		$row = pg_fetch_row($result);
		return $row[0];
	}
	
	public static function insertMessageRecipient($messageId, $recipientId, $uuid) {
		$query = "insert into message_recipient (message_fk, recipient_fk, uuid) values ($1, $2, $3)";
		return pgDb::psExecute($query, array($messageId, $recipientId, $uuid));
	}		
	
	public static function getSenderByMessageId($uuid) {
		$query = "select u.id as userId, u.email as email, u.fname as fname, u.lname as lname, m.id as messageId, mr.recipient_fk as recipientId from public.user u, message m, message_recipient mr where mr.uuid = $1 and mr.message_fk = m.id and m.sender_fk = u.id";
		return pgDb::psExecute($query, array($uuid));
	}
	
	public static function getRecipientByMessageId($uuid) {
		$query = "select u.id as userid, u.fname as fname, u.lname as lname, u.email as email from public.user u, message_recipient mr where mr.uuid = $1 and mr.recipient_fk = u.id";
		return pgDb::psExecute($query, array($uuid));
	}

	public static function getGroupMembersByUserId($uid) {
		$query = "select u.id, u.fname, u.lname, o.name as oname
			from public.user u, user_group ug, organization o, user_organization uo
			where u.id = ug.user_fk
			and uo.user_fk = u.id
			and o.id = uo.organization_fk
			and ug.group_fk in 
				(select ug.group_fk from user_group ug where ug.user_fk = $1)
			order by u.lname, o.name
			";	
			return pgDb::psExecute($query, array($uid));
	}
	
	public static function getOrgsByNetwork($networkId) {
			$query = "
				select 'Organization' as type, o.id as id, o.name as name
				from organization o, organization_organization oo
				where o.id = oo.organization_to_fk
				and oo.organization_from_fk = $1
				and oo.relationship ='parent'
				";
				return pgDb::psExecute($query, array($networkId));	
	}
	
	public static function freeSearch($term, $networkId) {
		// TODO: use citext index in db instead of lower() function here
		// http://stackoverflow.com/questions/7005302/postgresql-how-to-make-not-case-sensitive-queries
		
		$query = "
			select 'Organization' as type, o.id as id, o.name as name
			from organization o, organization_organization oo
			where 
				lower(o.name) like lower('%' || $1 || '%')
			and o.id = oo.organization_to_fk
			and oo.organization_from_fk = $2
			and oo.relationship ='parent'
			
			union
			
			select 'Person' as type, u.id as id, (u.fname || ' ' || u.mname || ' ' || u.lname) as name
			from public.user u, organization_organization oo, user_organization uo
			where (
				lower(u.fname) like lower('%' || $1 || '%')
				or lower(u.lname) like lower('%' || $1 || '%')
				or lower(u.mname) like lower('%' || $1 || '%')
				or lower(u.nickname) like lower('%' || $1 || '%')
			)
			and u.id = uo.user_fk
			and uo.organization_fk = oo.organization_to_fk
			and oo.organization_from_fk = $2
			and oo.relationship ='parent'
			
			union
			
			select 'Contact' as type, c.id as id, c.name as name
			from contact c, organization_organization oo, organization_contact oc
			where (
				lower(c.name) like lower('%' || $1 || '%')
				or lower(c.title) like lower('%' || $1 || '%')
			)
			and c.id = oc.contact_fk
			and oc.organization_fk = oo.organization_to_fk
			and oo.organization_from_fk = $2
			and oo.relationship ='parent'
			
			union
			
			select 'Program' as type, p.id as id, p.name as name
			from program p, organization_organization oo, organization_program op
			where (
				lower(p.name) like lower('%' || $1 || '%')
				or lower(p.description) like lower('%' || $1 || '%')
			)
			and p.id = op.program_fk
			and op.organization_fk = oo.organization_to_fk
			and oo.organization_from_fk = $2
			and oo.relationship ='parent'
			
			union
			
			select 'Language' as type, l.id as id, l.language as name
			from language l, organization_organization oo, organization_language ol
			where 
				lower(l.language) like lower('%' || $1 || '%')		
			and l.id = ol.language_fk
			and ol.organization_fk = oo.organization_to_fk
			and oo.organization_from_fk = $2
			and oo.relationship ='parent'
			
			union
			
			select 'Topic' as type, t.id as id, t.name as name
			from topic t, organization_organization oo, organization_topic ot
			where 
				lower(t.name) like lower('%' || $1 || '%')		
			and t.id = ot.topic_fk
			and ot.organization_fk = oo.organization_to_fk
			and oo.organization_from_fk = $2
			and oo.relationship ='parent'	
					
			union
			
			select 'Location' as type, loc.id as id, loc.municipality || ', ' || loc.region2 as name
			from location loc, organization_organization oo, organization_location oloc
			where (
				lower(loc.address1) like lower('%' || $1 || '%')
				or lower(loc.address2) like lower('%' || $1 || '%')
				or lower(loc.municipality) like lower('%' || $1 || '%')
				or lower(loc.region1) like lower('%' || $1 || '%')
				or lower(loc.region2) like lower('%' || $1 || '%')
				or lower(loc.country) like lower('%' || $1 || '%')
				or lower(loc.postal_code) like lower('%' || $1 || '%')
			)		
			and loc.id = oloc.location_fk
			and oloc.organization_fk = oo.organization_to_fk
			and oo.organization_from_fk = $2
			and oo.relationship ='parent'
			";
			
			return pgDb::psExecute($query, array($term, $networkId));			
			
	}

	public static function getOrgByTopicIds($topicIdList, $networkId) {
			$query = "
				select 'Organization' as type, o.id as id, o.name as name
				from organization o, organization_organization oo
				where o.id in (
					select organization_fk
					from organization_topic
					where topic_fk in ($1)
				)
				and oo.organization_from_fk = $2
				and o.id = oo.organization_to_fk
				and oo.relationship ='parent'
				";
			return pgDb::psExecute($query, array($topicIdList, $networkId));		
	}
	
	public static function getOrgsByGroupId($groupIdList) {
			$query = "select uo.organization_fk as oid from user_organization uo, user_group ug where ug.group_fk in ($1) and ug.user_fk = uo.user_fk";
			return pgDb::psExecute($query, array($groupIdList));
	}
	
	public static function getOrgDetailById($orgId) {
		
		$result0 = pgDb::psExecute("select name, type, structure, status_fk as status from organization where id = $1", array($orgId));
		
		$result1 = pgDb::psExecute("select l.address1 || ', ' || l.address2 as line1, l.municipality || ', ' || l.region2 || '  ' || l.postal_code as line2 
															from location l, organization_location ol
															where ol.organization_fk = $1
															and ol.location_fk = l.id", array($orgId));
															
		$result2 = pgDb::psExecute("select c.phone as phone, c.email as email, c.url as url, c.name as name, c.fax as fax 
															from contact c, organization_contact oc
															where oc.organization_fk = $1
															and oc.contact_fk = c.id", array($orgId));
															
		$result3 = pgDb::psExecute("select l.language as language
															from language l, organization_language ol
															where ol.organization_fk = $1
															and ol.language_fk = l.id", array($orgId));
															
  	$result4 = pgDb::psExecute("select t.name as topic
															from topic t, organization_topic ot
															where ot.organization_fk = $1
															and ot.topic_fk = t.id", array($orgId));
															
  	$result5 = pgDb::psExecute("select p.name as name, p.description as descr
															from program p, organization_program op
															where op.organization_fk = $1
															and op.program_fk = p.id", array($orgId));
															
  	$result6 = pgDb::psExecute("select (u.fname || ' ' || u.mname || ' ' || u.lname) as name, u.enable_email as emailon, u.enable_sms as smson, u.id as id
															from public.user u, user_organization uo
															where uo.organization_fk = $1
															and uo.user_fk = u.id", array($orgId));
		
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
	  	$resultArray['orgContact'][$counter][4] = $row2['fax'];
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
