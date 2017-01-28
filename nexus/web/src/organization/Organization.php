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
	
	public static function addOrganization($orgName, $parentOrgId) {
		$oid = Utilities::newId();
		$query = "insert into organization (name, create_dttm, activate_dttm, status_fk, uid) values ($1, now(), now(), 1, $2) returning id";
		$row = pg_fetch_row(PgDatabase::psExecute($query, array($orgName, $oid)));
		$orgId = $row[0];
		$query = "insert into organization_organization (organization_from_fk, organization_to_fk, relationship) values ($1, $2, 'parent')";
		PgDatabase::psExecute($query, array($parentOrgId, $orgId));
		return $orgId;
	}
	
	public static function addOrganizationContact($orgfk, $name, $title, $email, $phone, $url) {
		//print_r(array($name, $title, $email, $phone, $url)); exit(0);
		$query = "insert into contact (name, title, email, phone, url) values ($1, $2, $3, $4, $5) returning id";
		$row = pg_fetch_row(PgDatabase::psExecute($query, array($name, $title, $email, $phone, $url)));
		$contactId = $row[0];
		$query = "insert into organization_contact (organization_fk, contact_fk) values ($1, $2)";
		PgDatabase::psExecute($query, array($orgfk, $contactId));
		return true;
	}
		
	public static function addOrganizationLocation($orgFk, $formatted, $street, $neighborhood, $city, $county, $state, $country, $postal, $lat, $long, $placeid) {
		$query = "insert into location (g_formatted_address, address1, neighborhood, municipality, region1, region2, country, postal_code, latitude, longitude, g_placeid) values ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11) returning id";
		$row = pg_fetch_row(PgDatabase::psExecute($query, array($formatted, $street, $neighborhood, $city, $county, $state, $country, $postal, $lat, $long, $placeid)));
		$locId = $row[0];
		$query = "insert into organization_location (organization_fk, location_fk) values ($1, $2)";
		PgDatabase::psExecute($query, array($orgFk, $locId));
		return true;		
	}
	
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
			return PgDatabase::psExecute($query, array($groupIdList));
	}
	
	// LEFT OFF - move over all methods from pilot pgDb to Organization (ones that are referenced in searchProcessor.php)

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
	
	public static function getNetworkFromOrgId($orgId) {
		// TODO - will not accomodate orgs belonging to multiple networks
		$query = "select organization_from_fk as networkid from organization_organization where organization_to_fk = $1 and relationship = 'parent' limit 1";
		return PgDatabase::psExecute($query, array($orgId));
	}
	
	public static function getOrganizationDetailById($orgId) {
		
		$result0 = PgDatabase::psExecute("select name, type, structure, status_fk as status from organization where id = $1", array($orgId));
		
		$result1 = PgDatabase::psExecute("select l.address1 || ', ' || l.address2 as line1, l.municipality || ', ' || l.region2 || '  ' || l.postal_code as line2, l.latitude as lat, l.longitude as long 
															from location l, organization_location ol
															where ol.organization_fk = $1
															and ol.location_fk = l.id", array($orgId));
															
		$result2 = PgDatabase::psExecute("select c.phone as phone, c.email as email, c.url as url, c.name as name, c.fax as fax 
															from contact c, organization_contact oc
															where oc.organization_fk = $1
															and oc.contact_fk = c.id", array($orgId));
															
		$result3 = PgDatabase::psExecute("select l.language as language
															from language l, organization_language ol
															where ol.organization_fk = $1
															and ol.language_fk = l.id", array($orgId));
															
  	$result4 = PgDatabase::psExecute("select t.name as topic
															from topic t, organization_topic ot
															where ot.organization_fk = $1
															and ot.topic_fk = t.id", array($orgId));
																															
		$resultArray = array();							
		  
	  $row0 = pg_fetch_array($result0);
	  $resultArray['orgid'] = $orgId;
	  $resultArray['oname'] = $row0['name'];
	  $resultArray['type'] = $row0['type'];
	  
	  $counter = 0;
	  while ($row1 = pg_fetch_array($result1)) {
	  	$resultArray['location1'] = $row1['line1'];
	  	$resultArray['location2'] = $row1['line2'];
	  	$resultArray['lat'] = $row1['lat'];
	  	$resultArray['long'] = $row1['long'];
	  	$counter++;
	  }
	  
	  $counter = 0;
	  while ($row2 = pg_fetch_array($result2)) {
	  	$resultArray['phone'] = Utilities::prettyPrintPhone($row2['phone']);
	  	$resultArray['email'] = $row2['email'];
	  	$resultArray['url'] = $row2['url'];
	  	$resultArray['cname'] = $row2['name'];
	  	$resultArray['fax'] = Utilities::prettyPrintPhone($row2['fax']);
	  	$counter++;
	  }
	  
	  $counter = 0;
	  while ($row3 = pg_fetch_array($result3)) {
	  	$resultArray['language'] = $row3['language'];
	  	$counter++;
	  }
	  
	  $counter = 0;
	  while ($row4 = pg_fetch_array($result4)) {
	  	$resultArray['topic'] = $row4['topic'];
	  	$counter++;
	  }
	  
		return $resultArray; 	

	}

}

?>
