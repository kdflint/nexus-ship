<?php

require_once(dirname(__FILE__) . "/../framework/PgDb.php");

class Organization {
	
	// TODO
	// get valid values for org type
	// select * from pg_enum e where enumtypid = '1569578'
	
	public static function addOrganization_NWM($orgName, $logoFileName, $parentOrg = '13') {
		// 13 == Northbridge Technology Alliance in prod and dev :)
		// This method is written to serve NWM accounts, where group == org and org parent is 13
		$oid = Utilities::newId();
		$query = "insert into organization (name, create_dttm, activate_dttm, tax_exempt, status_fk, logo, uid) values ($1, now(), now(), true, 1, $2, $3) returning id";
		$row = pg_fetch_row(PgDatabase::psExecute($query, array($orgName, $logoFileName, $oid)));
		$orgId = $row[0];
		
		$query = "insert into organization_organization (organization_from_fk, organization_to_fk, relationship, create_dttm) values ($1, $2, 'parent', now())";
		pg_fetch_row(PgDatabase::psExecute($query, array($parentOrg, $orgId)));		
		
		$query = "insert into organization_account (organization_fk, account_type) values ($1, 'NWM')";
		pg_fetch_row(PgDatabase::psExecute($query, array($orgId)));	
		
		return array($orgId, $oid);	
	}
	
	public static function addOrganization($orgName, $parentOrgId, $logoFileName = "") {
		$oid = Utilities::newId();
		$query = "insert into organization (name, create_dttm, activate_dttm, status_fk, uid, logo) values ($1, now(), now(), 1, $2, $3) returning id";
		$row = pg_fetch_row(PgDatabase::psExecute($query, array($orgName, $oid, $logoFileName)));
		$orgId = $row[0];
		$query = "insert into organization_organization (organization_from_fk, organization_to_fk, relationship) values ($1, $2, 'parent')";
		PgDatabase::psExecute($query, array($parentOrgId, $orgId));
		return $orgId;
	}
	
	public static function updateOrganizationName($orgId, $orgName) {
		$query = "update organization set name = $2 where id = $1 returning id";
		$row = pg_fetch_row(PgDatabase::psExecute($query, array($orgId, $orgName)));
		if ($row[0]) {
			return $row[0];
		} else {
			return false;
		}
	}
	
	public static function addOrganizationParent($from, $to) {
		$query = "insert into organization_organization (organization_from_fk, organization_to_fk, relationship) values ($1, $2, 'parent')";
		$result = PgDatabase::psExecute($query, array($from, $to));
		return $result; 
	}

	public static function addNwmAccountToOrganization($orgId) {
		$query = "insert into organization_account (organization_fk, account_type) values ($1, 'NWM')";
		$result = PgDatabase::psExecute($query, array($orgId));	
		return $result;
	}		

	public static function addAdvAccountToOrganization($orgId) {
		$query = "insert into organization_account (organization_fk, account_type) values ($1, 'ADV')";
		$result = PgDatabase::psExecute($query, array($orgId));	
		return $result;
	}	
	
	public static function addOrganizationType($orgId, $type) {
		$orgExists = self::organizationIdExists($orgId);
		if($orgExists && $type) {
			$query = "update organization set type = $1 where id = $2 returning id";
			return PgDatabase::psExecute($query, array($type, $orgId));
		}
	}	
	
	public static function addOrganizationSize($orgId, $size) {
		$orgExists = self::organizationIdExists($orgId);
		if($orgExists) {
			$query = "update organization set size = $1 where id = $2 returning id";
			return PgDatabase::psExecute($query, array($size, $orgId));
		}
	}
	
	public static function addOrganizationSpecialties($orgId, $specialtyIds) {
		$orgExists = self::organizationIdExists($orgId);
		if($orgExists && $specialtyIds && is_array($specialtyIds)) {
			$query = "delete from organization_topic where organization_fk = $1";
			PgDatabase::psExecute($query, array($orgId));
			foreach ($specialtyIds as $thisId) {
				$query = "insert into organization_topic (organization_fk, topic_fk) values ($1, $2)";
				PgDatabase::psExecute($query, array($orgId, $thisId));
			}
		return true;
		}
	}
	
	public static function addOrganizationContact($orgfk, $name, $title, $email, $phone, $url) {
		// TODO - in edit scenario, this may create a duplicate contact row and leave the existing row stranded (not tied to an org)
		$query = "insert into contact (name, title, email, phone, url) values ($1, $2, $3, $4, $5) returning id";
		$row = pg_fetch_row(PgDatabase::psExecute($query, array($name, $title, $email, $phone, $url)));
		$contactId = $row[0];
		$query = "insert into organization_contact (organization_fk, contact_fk) values ($1, $2) returning id";
		$row = pg_fetch_row(PgDatabase::psExecute($query, array($orgfk, $contactId)));
		// insert on conflict (upsert) would be much better here, but we are on pg 9.4 :(
		if ($row[0]) {
			$query = "select * from organization_contact where organization_fk = $1 and id != $2";
			$count = pg_num_rows(PgDatabase::psExecute($query, array($orgfk, $row[0])));
			if ($count == 1) {
				//$query = "delete from organization_contact where organization_fk = $1 and contact_fk != $2";
				//PgDatabase::psExecute($query, array($orgfk, $row[0]));
			}
		}
		return true;
	}
		
	public static function addOrganizationLocation($orgFk, $formatted, $street, $neighborhood, $city, $county, $state, $country, $postal, $lat, $long, $placeid) {
		// TODO - if this is an edit scenario, this may create a duplicate contact row and leave the existing row stranded (not tied to an org)
		$query = "insert into location (g_formatted_address, address1, neighborhood, municipality, region1, region2, country, postal_code, latitude, longitude, g_placeid) values ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11) returning id";
		$row = pg_fetch_row(PgDatabase::psExecute($query, array($formatted, $street, $neighborhood, $city, $county, $state, $country, $postal, $lat, $long, $placeid)));
		$locId = $row[0];
		$query = "insert into organization_location (organization_fk, location_fk) values ($1, $2) returning id";
		$row = pg_fetch_row(PgDatabase::psExecute($query, array($orgFk, $locId)));
		// insert on conflict (upsert) would be much better here, but we are on pg 9.4 :(
		if ($row[0]) {
			$query = "select * from organization_location where organization_fk = $1 and location_fk != $2";
			$count = pg_num_rows(PgDatabase::psExecute($query, array($orgFk, $row[0])));
			if ($count == 1) {
				//$query = "delete from organization_location where organization_fk = $1 and location_fk != $2";
				//PgDatabase::psExecute($query, array($orgFk, $row[0]));
			}
		}
		return true;		
	}

	public static function addOrganizationProgram($orgFk, $name, $description, $eligibility, $services, $involvement, $partner_interest, $partner_desc, $ada, $hours) {
		$orgExists = self::organizationIdExists($orgFk);
		if($orgExists) {
			// TODO - if this is an edit scenario, this may create a duplicate row and leave the existing row stranded (not tied to an org)
			$query = "insert into program (name, description, eligibility, services, involvement, partner_interest, partner_descr, ada, hours) values ($1, $2, $3, $4, $5, $6, $7, $8, $9) returning id";
			$row = pg_fetch_row(PgDatabase::psExecute($query, array($name, $description, $eligibility, $services, $involvement, $partner_interest, $partner_desc, $ada, $hours)));
			$programId = $row[0];
			$query = "insert into organization_program (organization_fk, program_fk) values ($1, $2) returning id";
			$row = pg_fetch_row(PgDatabase::psExecute($query, array($orgFk, $programId)));
			// insert on conflict (upsert) would be much better here, but we are on pg 9.4 :(
			if ($row[0]) {
				$query = "select * from organization_program where organization_fk = $1 and program_fk != $2";
				$count = pg_num_rows(PgDatabase::psExecute($query, array($orgFk, $row[0])));
				if ($count == 1) {
					//$query = "delete from organization_location where organization_fk = $1 and location_fk != $2";
					//PgDatabase::psExecute($query, array($orgFk, $row[0]));
				}
			}
			return true;	
		}
		return false;	
	}

	public static function addOrganizationLanguages($orgId, $languageIds) {
		$orgExists = self::organizationIdExists($orgId);
		if($orgExists && $languageIds && is_array($languageIds)) {
			$query = "delete from organization_language where organization_fk = $1";
			PgDatabase::psExecute($query, array($orgId));
			foreach ($languageIds as $thisId) {
				$query = "insert into organization_language (organization_fk, language_fk) values ($1, $2)";
				PgDatabase::psExecute($query, array($orgId, $thisId));
			}
		return true;
		}
	}

	public static function addOrganizationEthnicities($orgId, $ethnicityIds) {
		$orgExists = self::organizationIdExists($orgId);
		if($orgExists && $ethnicityIds && is_array($ethnicityIds)) {
			$query = "delete from organization_ethnicity where organization_fk = $1";
			PgDatabase::psExecute($query, array($orgId));
			foreach ($ethnicityIds as $thisId) {
				$query = "insert into organization_ethnicity (organization_fk, ethnicity_fk) values ($1, $2)";
				PgDatabase::psExecute($query, array($orgId, $thisId));
			}
		return true;
		}
	}

	public static function addOrganizationAffiliations($orgId, $affiliationIds) {
		$orgExists = self::organizationIdExists($orgId);
		if($orgExists && $affiliationIds && is_array($affiliationIds)) {
			$query = "delete from organization_affiliation where organization_fk = $1";
			PgDatabase::psExecute($query, array($orgId));
			foreach ($affiliationIds as $thisId) {
				$query = "insert into organization_affiliation (organization_fk, affiliation_fk) values ($1, $2)";
				PgDatabase::psExecute($query, array($orgId, $thisId));
			}
		return true;
		}
	}

	public static function getOidByOrgId($orgId) {
		$row = pg_fetch_array(self::getOrganizationById($orgId));
		if (!$row || $row['uid'] === "NULL") {
			return FALSE;
		} else {
			return $row['uid'];
		}	
	}
		
	public static function getOrganizationById($orgId) {
		$query = "select name, type, structure, logo, status_fk as status, uid from organization where id = $1";
		return PgDatabase::psExecute($query, array($orgId));
	}
	
	public static function getOrganizationByName($name) {
		$query = "select id, type, structure, logo, status_fk as status, uid from organization where upper(name) = $1 limit 1";
		$row = pg_fetch_array(PgDatabase::psExecute($query, array(strtoupper($name))));
		if ($row['id'] === "NULL") {
			return FALSE;
		} else {
			return $row['id'];
		}	
	}	
	
	public static function getNetworkForumByOrgId($orgId) {
		$query = "select network_forum_id from organization where id = $1";
		$row = pg_fetch_row(PgDatabase::psExecute($query, array($orgId)));
		if ($row[0] === "NULL") {
			return FALSE;
		} else {
			return $row[0];
		}
	}
	
	public static function getNetworkAdminEmailByOrgId($orgId) {
		$email = array();
		$query = "select u.email from public.user u, user_organization uo where uo.role_fk = 1 and uo.user_fk = u.id and uo.organization_fk = $1";
		$cursor = PgDatabase::psExecute($query, array($orgId));
	  while ($row = pg_fetch_array($cursor)) {
	  	array_push($email, $row['email']);
	  }		
	  return $email;
	}	

	public static function getNetworkAdminIdByOrgId($orgId) {
		$email = array();
		$query = "select u.id from public.user u, user_organization uo where uo.role_fk = 1 and uo.user_fk = u.id and uo.organization_fk = $1";
		$cursor = PgDatabase::psExecute($query, array($orgId));
	  while ($row = pg_fetch_array($cursor)) {
	  	array_push($email, $row['id']);
	  }		
	  return $email;
	}
	
	public static function getPublicEnrollUuidByOrgUid($orgUid) {
		$query = "select i.uuid from organization o, invitation i where i.id = o.public_global_invite_fk and o.uid = $1";
		$row = pg_fetch_row(PgDatabase::psExecute($query, array($orgUid)));
		if (!$row) {
			return FALSE;
		} else {
			return $row[0];
		}
	}
	
	public static function getOrganizationByUid($orgUid) {
		$query = "select id, name, type, structure, logo, status_fk as status from organization where uid = $1";
		return PgDatabase::psExecute($query, array($orgUid));
	}
	
	public static function getOrganizationsByGroupId($groupIdList) {
			$query = "select uo.organization_fk as oid from user_organization uo, user_group ug where ug.group_fk in ($1) and ug.user_fk = uo.user_fk";
			return PgDatabase::psExecute($query, array($groupIdList));
	}
	
	// LEFT OFF - move over all methods from pilot pgDb to Organization (ones that are referenced in searchProcessor.php)

	public static function getForumUserGroupByOrgId($orgid) {
		$query = "select forum_user_group from organization where id = $1";
		$row = pg_fetch_row(PgDatabase::psExecute($query, array($orgid)));
		return $row[0];
	}
	
	public static function countOrgsInNetworkById($networkId) {
		$query = "select id from organization_organization where organization_from_fk=$1 and relationship='parent'";
		$count = pg_num_rows(PgDatabase::psExecute($query, array($networkId)));
		return $count;
	}

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
	
	private static function organizationIdExists($id) {
		$query = "select exists (select true from organization where id = $1)";
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
	
	public static function getGeoByOrgIds($tmp) {
		$inString = "";
		$elements = count($tmp);
		$out = array();
		for($i = 0; $i < $elements; $i++) {
			$inString .= $tmp[$i];
			if ($i < $elements-1) {
				$inString .= ",";
			}
		}
		if (strlen($inString) > 0) {
			$query = "select l.latitude as lat, l.longitude as long, ol.organization_fk as oid, o.name as name from location l, organization o, organization_location ol where l.id = ol.location_fk and o.id = ol.organization_fk and ol.organization_fk in ($inString)";
			return PgDatabase::psExecute($query, array());
		} else {
			return array();
		}
	}

	public static function organizationNameExists($name) {
		$query = "select exists (select true from organization where upper(name)=$1)";
		$row = pg_fetch_row(PgDatabase::psExecute($query, array(strtoupper($name))));
		if ($row[0] === 't') {
			return TRUE;
		} else {
			return FALSE;
		}
	}
	
	public static function organizationTopicExists($orgId, $topics) {
		$query = "select exists (select true from organization_topic where organization_fk=$1 and topic_fk in ($2))";
		return PgDatabase::psExecute($query, array($orgId, $topics));
	}

	public static function organizationTypeExists($orgId, $types) {
		$query = "select exists (select true from organization where id = $1 and type in ($2))";
		return PgDatabase::psExecute($query, array($orgId, $types));
	}

	public static function organizationAffiliationExists($orgId, $affiliations) {
		$query = "select exists (select true from organization_affiliation where organization_fk=$1 and affiliation_fk in ($2))";
		return PgDatabase::psExecute($query, array($orgId, $affiliations));
	}
	
	public static function getOrganizationsByNetworkId($networkId) {
		$query = "
			select 'Organization' as type, o.id as id, o.name as name
			from organization o, organization_organization oo
			where o.id = oo.organization_to_fk
			and oo.organization_from_fk = $1
			and oo.relationship ='parent'
			and o.suspend_dttm is null
			";
		return PgDatabase::psExecute($query, array($networkId));	
	}
	
	public static function getNetworkByOrgId($orgId) {
		// TODO - will not accomodate orgs belonging to multiple networks
		$query = "select 
			oo.organization_from_fk as networkid, oa.account_type, o.name, o.forum_id as forumid, o.public_forum_id as pforumid, o.uid, o.logo
			from organization_organization oo, organization o, organization_account oa 
			where oo.organization_to_fk = $1 
			and oo.organization_from_fk = o.id
			and oa.organization_fk = o.id
			and relationship = 'parent' 
			and o.uid != '99999999'
			order by networkid desc
			limit 1";
		return PgDatabase::psExecute($query, array($orgId));
	}

	public static function getOrganizationsByUsername($username) {
		$query = "select o.id, o.name, o.uid, o.logo, uo.role_fk from organization o, user_organization uo, public.user u
			where u.username = $1
			and u.id = uo.user_fk
			and uo.organization_fk = o.id";
		$cursor = PgDatabase::psExecute($query, array($username));
			
		$resultArray = array();
	  while ($row = pg_fetch_array($cursor)) {
	  	array_push($resultArray, array("id" => $row['id'], "name" => $row['name'], "uid" => $row['uid'], "role" => $row['role_fk'], "logo" => $row['logo']));
	  }		
	  return $resultArray;
	}
	
	public static function getOrganizationAccountTypeByOrgId($id) {
		$query = "select exists (select account_type from organization_account where organization_fk = $1)";
		$row = pg_fetch_row(PgDatabase::psExecute($query, array($id)));
		if ($row[0] === "t") {
			$query = "select account_type from organization_account where organization_fk = $1";
			$row = pg_fetch_row(PgDatabase::psExecute($query, array($id)));
			return $row[0];
		} else {
			return FALSE;
		}
	}
	
	public static function getNetworksByUsername($username) {
		$query = "select distinct
			oo.organization_from_fk as networkid, oa.account_type, o.name, o.forum_id as forumid, o.public_forum_id as pforumid, o.uid, o.logo
			from public.user u, user_organization uo, organization_organization oo, organization o, organization_account oa
			where u.username = $1
			and uo.user_fk = u.id
			and oo.organization_to_fk = uo.organization_fk
			and oo.organization_from_fk = o.id
			and oo.relationship = 'parent'
			and oa.organization_fk = oo.organization_to_fk
			limit 1";
		$cursor = PgDatabase::psExecute($query, array($username));
		$resultArray = array();
	  while ($row = pg_fetch_array($cursor)) {
	  	array_push($resultArray, array("id" => $row['networkid'], "name" => $row['name'], "uid" => $row['uid'], "account_type" => $row['account_type'], "forumid" => $row['forumid'], "logo" => $row['logo']));
	  }		
	  return $resultArray;
	}
	
	public static function getOrganizationMembersbyOrgId($id, $ssnUser) {
		$users = array();
		$query = "select distinct u.id as id, u.username, u.fname, u.lname, u.email
			from public.user u, user_organization uo
			where u.id = uo.user_fk
			and u.suspend_dttm is NULL
			and u.username not like 'nUser-%'
			and u.username not like 'pUser-%'
			and uo.organization_fk = $1
			order by u.fname, u.lname";
		$cursor = PgDatabase::psExecute($query, array($id));
		$counter = 0;	
		while ($row = pg_fetch_array($cursor)) {
			$users[$counter]['id'] = $row['id'];
			$users[$counter]['username'] = $row['username'];
			$users[$counter]['fname'] = $row['fname'];
			$users[$counter]['lname'] = $row['lname'];
			$users[$counter]['title'] = "";
			$users[$counter]['descr'] = "";
			$users[$counter]['email'] = $row['email'];
			$users[$counter]['sessionUser'] = $ssnUser;
			$users[$counter]['uidpk'] = $row['id'];
			$users[$counter]['role'] = "";
			$users[$counter]['status'] = "active";
			$counter++;
		}
		return $users;
	}
	
	public static function getProgramDetailByOrgId($orgId) {
		$program = array();
		$query = "select p.name, p.description, p.eligibility, p.services, p.involvement, p.partner_interest, p.partner_descr, p.hours, p.ada, o.name as orgname, o.id as orgid 
			from organization o, program p, organization_program op 
			where p.id = op.program_fk
			and o.id = op.organization_fk
			and op.organization_fk = $1 order by op.id desc limit 1";
		$result = PgDatabase::psExecute($query, array($orgId));
		
		$row = pg_fetch_array($result);
		
		$program['name'] = $row['name'];
		$program['description'] = $row['description'];
		$program['eligibility'] = $row['eligibility'];
		$program['services'] = $row['services'];
		$program['involvement'] = $row['involvement'];
		$program['partner_interest'] = $row['partner_interest'];
		$program['partner_descr'] = $row['partner_descr'];
		$program['hours'] = $row['hours'];
		$program['ada'] = $row['ada'];
		$program['oname'] = $row['orgname'];
		$program['orgid'] = $row['orgid'];
		
		return $program;
			
	}
	
	public static function getOrganizationDetailById($orgId) {
		
		$result0 = PgDatabase::psExecute("select name, type, size, structure, status_fk as status from organization where id = $1", array($orgId));
		
		$result1 = PgDatabase::psExecute("select l.g_formatted_address as formatted, l.address1 || ', ' || l.address2 as line1, l.municipality || ', ' || l.region2 || '  ' || l.postal_code as line2, l.latitude as lat, l.longitude as long 
															from location l, organization_location ol
															where ol.organization_fk = $1
															and ol.location_fk = l.id 
															order by ol.id desc 
															limit 1", array($orgId));
															
		$result2 = PgDatabase::psExecute("select c.phone as phone, c.email as email, c.url as url, c.name as name, c.title as title, c.fax as fax 
															from contact c, organization_contact oc
															where oc.organization_fk = $1
															and oc.contact_fk = c.id 
															order by oc.id desc 
															limit 1", array($orgId));
															
		$result3 = PgDatabase::psExecute("select l.language as language
															from language l, organization_language ol
															where ol.organization_fk = $1
															and ol.language_fk = l.id", array($orgId));
															
  	$result4 = PgDatabase::psExecute("select distinct t.name as topic
															from topic t, organization_topic ot
															where ot.organization_fk = $1
															and ot.topic_fk = t.id", array($orgId));
															
		$result5 = PgDatabase::psExecute("select distinct (u.fname || ' ' || u.lname) as name, u.username
															from public.user u, user_organization uo
															where u.id = uo.user_fk
															and u.username not like 'pUser-%'
															and u.username not like 'nUser-%'
															and uo.organization_fk = $1
															order by name asc", array($orgId));

		$result6 = PgDatabase::psExecute("select e.ethnicity as ethnicity
															from ethnicity e, organization_ethnicity oe
															where oe.organization_fk = $1
															and oe.ethnicity_fk = e.id", array($orgId));

		$result7 = PgDatabase::psExecute("select a.affiliation as affiliation
															from affiliation a, organization_affiliation oa
															where oa.organization_fk = $1
															and oa.affiliation_fk = a.id", array($orgId));

		$result8 = PgDatabase::psExecute("select exists (select true from organization_program where organization_fk = $1)", array($orgId));
																														
		$resultArray = array();							
		  
	  $row0 = pg_fetch_array($result0);
	  $resultArray['orgid'] = $orgId;
	  $resultArray['oname'] = $row0['name'];
	  $resultArray['type'] = $row0['type'];
	  $resultArray['size'] = $row0['size'];
	  
	  while ($row1 = pg_fetch_array($result1)) {
	  	$resultArray['formatted'] = $row1['formatted'];
	  	$resultArray['location1'] = $row1['line1'];
	  	$resultArray['location2'] = $row1['line2'];
	  	$resultArray['lat'] = $row1['lat'];
	  	$resultArray['long'] = $row1['long'];
	  }
	  
	  while ($row2 = pg_fetch_array($result2)) {
	  	$resultArray['phone'] = Utilities::prettyPrintPhone($row2['phone']);
	  	$resultArray['email'] = $row2['email'];
	  	$resultArray['url'] = $row2['url'];
	  	$resultArray['cname'] = $row2['name'];
	  	$resultArray['title'] = $row2['title'];
	  	$resultArray['fax'] = Utilities::prettyPrintPhone($row2['fax']);
	  }
	  
	  $counter = 0;
	  while ($row3 = pg_fetch_array($result3)) {
	  	$resultArray['language'][$counter] = $row3['language'];
	  	$counter++;
	  }
	  
	  $counter = 0;
	  while ($row4 = pg_fetch_array($result4)) {
	  	$resultArray['topic'][$counter] = $row4['topic'];
	  	$counter++;
	  }

		$counter = 0;
	  while ($row5 = pg_fetch_array($result5)) {
	  	$resultArray['member'][$counter] = $row5['name'] . "::" . $row5['username'];
	  	$counter++;
	  }

	  $counter = 0;
	  while ($row6 = pg_fetch_array($result6)) {
	  	$resultArray['ethnicity'][$counter] = $row6['ethnicity'];
	  	$counter++;
	  }

	  $counter = 0;
	  while ($row7 = pg_fetch_array($result7)) {
	  	$resultArray['affiliation'][$counter] = $row7['affiliation'];
	  	$counter++;
	  }

		$row8 = pg_fetch_row($result8);
		if (!strcmp($row8[0], "t")) {
			$resultArray['program'] = true;
		} else {
			$resultArray['program'] = false;
		}

		return $resultArray; 	

	}

}

?>
