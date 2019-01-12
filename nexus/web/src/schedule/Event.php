<?php

require_once(dirname(__FILE__) . "/../framework/PgDb.php");
//require_once(Utilities::getLibRoot() . "/bigbluebutton/bbb-api-php/includes/bbb-api.php"); 
require_once Utilities::getComposerRoot() . '/autoload.php';

use BigBlueButton\BigBlueButton; 
use BigBlueButton\Parameters\IsMeetingRunningParameters;

class Event {
	
	private static function getDay($in) {
		$dayMap = array("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday");
		if (0 <= $in && $in < 7) {
			return $dayMap[$in];
		}
		return "undefined";
	}
	
	private static function getMonth($in) {
		$monthMap = array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");
		if (0 <= $in && $in < 12) {
			return $monthMap[$in];
		}
		return "undefined";
	}
	
	private static function getMonthNum($in) {
		if (0 <= $in && $in < 10) {
			return "0" . $in;
		} else {
			return $in;
		}
	}
	
	private static function getHour($in) {
		$hourMap = array("12", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11");
		if (1 <= $in && $in < 13) {
			return $in;
		} else if (13 <= $in && $in < 24) {
			return $hourMap[$in-12];
		} else if (0 == $in) {
			return "12";
		} else {
			return "undefined";
		}
	}
	
	private static function getHour_24($in) {
		if (0 <= $in && $in < 10) {
			return "0" . $in;
		} else {
			return $in;
		}
	}		
	
	private static function getMinute($in) {
		if (0 <= $in && $in < 10) {
			return "0" . $in;
		} else {
			return $in;
		}
	}
	
	private static function getPeriod($in) {
		if (0 <= $in && $in < 12) {
			return "AM";
		} else if (12 <= $in && $in < 24) {
			return "PM";
		} else {
			return "undefined";
		}
	}
	
	private static function getMeetingTypeDisplay($in) {
		// TODO - should leverage the constants defined in BbbMeeting.php. This is duplicated stringage
		switch($in) {
			case 'video tether':
				return 'Video Link';
				break;
			case 'video chat':
				return 'Video Chat';
				break;
			case 'webinar':
				return 'Webinar';
				break;
			default:
				return 'Collaboration';
				break;
			}
	}
	
	private static function isBbbEventRunning($in) {
		$bbbApi = new BigBlueButton();
		$parameters = new IsMeetingRunningParameters($in);
		//$response = $bbbApi->isMeetingRunningWithXmlResponseArray($in);
		$response = $bbbApi->isMeetingRunning($parameters);
		//if ($response && strcasecmp($response['returncode'], 'SUCCESS') == 0 && strcasecmp($response['running'], 'true') == 0) {
		if ($response->getReturnCode() == 'SUCCESS' && $response->isRunning()) {
			return TRUE;
		}
		return FALSE;
	}

	public static function isValidTimeZone($in) {
		$query = "select exists (select name from pg_timezone_names where name = $1)";		
		$row = pg_fetch_row(PgDatabase::psExecute($query, array($in)));
		if (!strcmp($row[0], "t")) {
			return TRUE;
		}
		return FALSE;		
	}
	
	public static function isValidTimeInterval($in) {
		if (isset($in) && preg_match("/^([01]?[0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9]$/", $in)) {
			return TRUE;
		}
		return FALSE;
	}
	
	public static function isValidEventUuid($in) {
		if (!$in) {return FALSE;}
		if (!strcmp($in, "CfchtCommonMeeting")) {
			return TRUE;
		}
		$query = "select exists (select uuid from event where uuid = $1)";		
		$row = pg_fetch_row(PgDatabase::psExecute($query, array($in)));
		if (!strcmp($row[0], "t")) {
			return TRUE;
		}
		return FALSE;		
	}

	public static function isValidFutureEvent($uuid, $orgId) {
		if (!self::isValidEventUuid($uuid)) { return FALSE; }
	
		// TODO -what if two meetings are running simultaneously?
		$query = "select exists (select e.id from event e, public.group g, organization o, event_group eg, user_organization uo
			where e.uuid = $1
			and e.reserved_user_fk = uo.user_fk
			and o.id = uo.organization_fk
			and o.uid = $2
			and (e.start_dttm + e.duration) > now()
			and e.active = true)";
		$row = pg_fetch_row(PgDatabase::psExecute($query, array($uuid, $orgId)));
		if (!strcmp($row[0], "t")) {
			return TRUE;
		}		
		return FALSE;

	}
	
	public static function isValidMeetingType($in) {
  	$query = "select exists 
  		(select e.enumlabel 
  		from pg_type t, pg_enum e 
  		where t.oid = e.enumtypid
  		and t.typname like 'meeting%'
  		and e.enumlabel = $1)";
  	$row = pg_fetch_row(PgDatabase::psExecute($query, array($in)));
		if (!strcmp($row[0], "t")) {
			return TRUE;
		}
		return FALSE;	
	}
	
	public static function getFuturePendingEvents($idList, $localTz = "Greenwich", $ssnUser) {
		return self::getFutureEventsByGroupIdList($idList, $localTz, $ssnUser, "3");
	}
	
	public static function getFutureNetworkEvents($idList, $localTz = "Greenwich", $ssnUser, $status = "1") {
		return self::getFutureEventsByGroupIdList($idList, $localTz, $ssnUser, $status);
	}
	
	public static function getFutureEventsByGroupIdList($groupIdList, $localTz = "Greenwich", $ssnUser, $status = "1") {	
		
		$events = array();
		if (self::isValidTimeZone($localTz)) {
			$query = "select 
				extract(day from (select e.start_dttm at time zone $2)) as date, 
				extract(dow from (select e.start_dttm at time zone $2)) as day, 
				extract(month from (select e.start_dttm at time zone $2)) as month, 
				extract(hour from (select e.start_dttm at time zone $2)) as hour, 
				extract(minute from (select e.start_dttm at time zone $2)) as minute, 
				extract(year from (select e.start_dttm at time zone $2)) as year,
				extract(epoch from (select e.start_dttm)) as epoch,
				extract(day from (select (e.start_dttm + e.duration) at time zone $2)) as date_end,
				extract(month from (select (e.start_dttm + e.duration) at time zone $2)) as month_end,
				extract(hour from (select (e.start_dttm + e.duration) at time zone $2)) as hour_end, 
				extract(minute from (select (e.start_dttm + e.duration) at time zone $2)) as minute_end, 
				extract(year from (select (e.start_dttm + e.duration) at time zone $2)) as year_end,
				extract(epoch from (select (e.start_dttm + e.duration) at time zone $2)) as epoch_end,
				e.tz_name as tzname, 
				e.duration as duration, 
				e.name as name, 
				e.descr as descr, 
				e.location as location,
				e.uuid as uuid,
				e.reserved_user_fk as adder,
				e.type as meetingtype,
				e.file as file,
				e.registration as registration,
				e.url as url,
				e.registration_url as regr_url,
				e.contact as contact,
				e.recur_fk as recur,
				e.isbbbmeet as bbb,
				g.name as group_name,
				er.pattern as pattern,
				er.num_occur as num,
				eg.group_fk as group_fk,
				u.fname as fname, 
				u.lname as lname,
				pg.abbrev as abbrev,
				pg.name as tz_extract_name 
			from event e
				left outer join event_recur er on e.recur_fk = er.id
				join public.user u on u.id = e.reserved_user_fk
				join event_group eg on eg.event_fk = e.id
				join public.group g on eg.group_fk = g.id 
				join pg_timezone_names pg on pg.name = $2
				where eg.group_fk=ANY($1::int[])
				and eg.status_fk = $3
				and e.active = true
				and (
					((e.start_dttm + e.duration) > now())
					or
					((COALESCE(er.end_dttm,now()) > now()))
				)
			order by e.start_dttm";
						
			$cursor = PgDatabase::psExecute($query, array($groupIdList, $localTz, $status));
			$counter = 0;
			while ($row = pg_fetch_array($cursor)) {
				$events[$counter]['date'] = $row['date'];
				$events[$counter]['day'] = self::getDay($row['day']);
				$events[$counter]['month'] = self::getMonth($row['month']-1);
				$events[$counter]['month_num'] = self::getMonthNum($row['month']);
				$events[$counter]['hour'] = self::getHour($row['hour']);
				$events[$counter]['hour_24'] = self::getHour_24($row['hour']);
				$events[$counter]['minute'] = self::getMinute($row['minute']);
				$events[$counter]['hour_end'] = self::getHour($row['hour_end']);
				$events[$counter]['hour_end_24'] = self::getHour_24($row['hour_end']);
				$events[$counter]['minute_end'] = self::getMinute($row['minute_end']);
				$events[$counter]['year'] = $row['year'];
				$events[$counter]['epoch'] = $row['epoch'];
				$events[$counter]['period'] = self::getPeriod($row['hour']);
				$events[$counter]['date_end'] = $row['date_end'];
				$events[$counter]['month_end'] = self::getMonth($row['month_end']-1);
				$events[$counter]['month_num_end'] = self::getMonthNum($row['month_end']);
				$events[$counter]['year_end'] = $row['year_end'];
				$events[$counter]['period_end'] = self::getPeriod($row['hour_end']);
				$events[$counter]['tzname'] = $row['tzname'];
				$events[$counter]['abbrev'] = $row['abbrev'];
				$events[$counter]['tz_extract_name'] = $row['tz_extract_name'];
				$events[$counter]['purpose'] = $row['name'];
				$events[$counter]['descr'] = $row['descr'];
				$events[$counter]['location'] = $row['location'];
				$events[$counter]['uuid'] = $row['uuid'];
				$events[$counter]['mtype'] = $row['meetingtype'];
				$events[$counter]['mtypdisplay'] = self::getMeetingTypeDisplay($row['meetingtype']);
				$events[$counter]['fileext'] = $row['file'];
				$events[$counter]['fname'] = $row['fname'];
				$events[$counter]['lname'] = $row['lname'];
				$events[$counter]['contact'] = $row['contact'];
				$events[$counter]['recur'] = strlen($row['recur']) > 0 ? true : false;
				$events[$counter]['recur_pattern'] = $row['pattern'];
				$events[$counter]['recur_num'] = $row['num'];
				$events[$counter]['bbb'] = ($row['bbb'] === 't' ? TRUE : FALSE);
				$events[$counter]['sessionUser'] = $ssnUser;
				$events[$counter]['adder'] = $row['adder'];
				$events[$counter]['registration'] = $row['registration'];
				$events[$counter]['url'] = $row['url'];
				$events[$counter]['regr_url'] = $row['regr_url'];
				$events[$counter]['group_assoc'] = $row['group_fk'];
				$events[$counter]['group_name'] = ($row['group_name'] === 'Network Group' ? 'All Network' : $row['group_name']);
				$counter++;
			}
		}
		return $events;
	}
	
	public static function getEventDetail($uuid, $localTz = "Greenwich", $ssnUser = "0") {
		$event = array();
		if (self::isValidEventUuid($uuid)) {
			$query = "select 
				extract(day from (select e.start_dttm at time zone $2)) as date, 
				extract(dow from (select e.start_dttm at time zone $2)) as day, 
				extract(month from (select e.start_dttm at time zone $2)) as month, 
				extract(hour from (select e.start_dttm at time zone $2)) as hour, 
				extract(year from (select e.start_dttm at time zone $2)) as year, 
				extract(minute from (select e.start_dttm at time zone $2)) as minute, 
				extract(epoch from (select e.start_dttm)) as epoch,
				extract(hour from (select (e.start_dttm + e.duration) at time zone $2)) as hour_end, 
				extract(minute from (select (e.start_dttm + e.duration) at time zone $2)) as minute_end, 
				extract(epoch from (select (e.start_dttm + e.duration) at time zone $2)) as epoch_end,
				e.tz_name as tzname, 
				e.duration as duration, 
				e.name as name, 
				e.descr as descr, 
				e.location as location,
				e.uuid as uuid,
				e.reserved_user_fk as adder,
				e.type as meetingtype,
				e.contact as contact,
				e.recur_fk as recur,
				e.registration as registration,
				e.url as url,
				e.registration_url as regr_url,
				e.file as file,
				e.recur_fk as recur,
				e.isbbbmeet as bbb,
				er.pattern as pattern,
				er.num_occur as num,
				er.end_dttm as recur_end,
				extract(dow from (select er.end_dttm at time zone $2)) as day_end,
				extract(day from (select er.end_dttm at time zone $2)) as date_end, 
				extract(month from (select er.end_dttm at time zone $2)) as month_end,  
				extract(year from (select er.end_dttm at time zone $2)) as year_end,
				u.fname as fname, 
				u.lname as lname,
				pg.abbrev as abbrev 
				from event e
				left outer join event_recur er on e.recur_fk = er.id
				join public.user u on u.id = e.reserved_user_fk
				join pg_timezone_names pg on pg.name = $2
				where e.active = true
				and e.uuid = $1";
						
			$cursor = PgDatabase::psExecute($query, array($uuid, $localTz));
			$counter = 0;
			while ($row = pg_fetch_array($cursor)) {
				$event[$counter]['date'] = $row['date'];
				$event[$counter]['day'] = self::getDay($row['day']);
				$event[$counter]['month'] = self::getMonth($row['month']-1);
				$event[$counter]['year'] = $row['year'];
				$event[$counter]['hour'] = self::getHour($row['hour']);
				$event[$counter]['minute'] = self::getMinute($row['minute']);
				$event[$counter]['hour_end'] = self::getHour($row['hour_end']);
				$event[$counter]['minute_end'] = self::getMinute($row['minute_end']);
				$event[$counter]['epoch'] = $row['epoch'];
				$event[$counter]['period'] = self::getPeriod($row['hour']);
				$event[$counter]['period_end'] = self::getPeriod($row['hour_end']);
				$event[$counter]['abbrev'] = $row['abbrev'];
				$event[$counter]['purpose'] = $row['name'];
				$event[$counter]['descr'] = $row['descr'];
				$event[$counter]['location'] = $row['location'];
				$event[$counter]['uuid'] = $row['uuid'];
				$event[$counter]['mtype'] = $row['meetingtype'];
				$event[$counter]['mtypdisplay'] = self::getMeetingTypeDisplay($row['meetingtype']);
				$event[$counter]['contact'] = $row['contact'];
				$event[$counter]['registration'] = $row['registration'];
				$event[$counter]['url'] = $row['url'];
				$event[$counter]['regr_url'] = $row['regr_url'];
				$event[$counter]['fileext'] = $row['file'];
				$event[$counter]['fname'] = $row['fname'];
				$event[$counter]['lname'] = $row['lname'];
				$event[$counter]['sessionUser'] = $ssnUser;
				$event[$counter]['adder'] = $row['adder'];
				$event[$counter]['running'] = var_export(self::isBbbEventRunning($uuid), true);
				$event[$counter]['recur'] = strlen($row['recur']) > 0 ? true : false;
				$event[$counter]['recur_pattern'] = $row['pattern'];
				$event[$counter]['recur_num'] = $row['num'];
				$event[$counter]['recur_end_phrase'] = self::getDay($row['day_end']) . ", " . self::getMonth($row['month_end']-1) . " " . $row['date_end'] . " " . $row['year_end'];
				$event[$counter]['bbb'] = ($row['bbb'] === 't' ? TRUE : FALSE);
				$counter++;
			}
		}
		return $event;
	}

	public static function addEvent($dttm, $duration, $name, $reservedUserId, $groupId, $tzName, $type, $descr, $loc, $isBbb, $fileExt, $status, $url, $regUrl, $registr, $contact, $uuid, $recurId = null) {
		$query = "select abbrev from pg_timezone_names where name = $1";
		$row = pg_fetch_row(PgDatabase::psExecute($query, array($tzName)));
		$tzAbbrev = $row[0];
		if (!Utilities::validateUuid($uuid)) { 
			$uuid = Utilities:: newUuid(); 
		} else {
			self::deleteEvent($uuid);
		}
		$query = "insert into event (uuid, start_dttm, duration, name, descr, reserved_user_fk, tz_name, tz_abbrev, type, location, isBbbMeet, file, url, registration_url, registration, contact, recur_fk) values ($1, $2, $3, $4, $8, $5, $6, $7, $9, $10, $11, $12, $13, $14, $15, $16, $17) returning id";
		$row = pg_fetch_row(PgDatabase::psExecute($query, array($uuid, $dttm, $duration, $name, $reservedUserId, $tzName, $tzAbbrev, $descr, $type, $loc, $isBbb, $fileExt, $url, $regUrl, $registr, $contact, $recurId)));
		$eventId = $row[0];
		$query = "insert into event_group (event_fk, group_fk, status_fk) values ($1, $2, $3)";
		PgDatabase::psExecute($query, array($eventId, $groupId, $status));
		return $uuid;
	}	
	
	public static function getEventName($uuid) {
		$query = "select name from event where uuid = $1";
		$row = pg_fetch_row(PgDatabase::psExecute($query, array($uuid)));
		if ($row[0]) {
			return $row[0];
		} else {
			return false;
		}
	}
	
	public static function deleteEvent($uuid) {
		$query = "update event set active = false where uuid = $1";
		PgDatabase::psExecute($query, array($uuid));
		return;
	}

	public static function addEventBbb($type, $uuid) {
		if (!Utilities::validateUuid($uuid)) { 
			return FALSE;
		}
		$query = "update event set isBbbMeet=true, type=$1 where uuid=$2";
		PgDatabase::psExecute($query, array($type, $uuid));
		return TRUE;
	}
	
	public static function deleteEventBbb($uuid) {
		if (!Utilities::validateUuid($uuid)) { 
			return FALSE;
		}
		$query = "update event set isBbbMeet=false where uuid=$1";
		PgDatabase::psExecute($query, array($uuid));
		return TRUE;
	}

	public static function approveEvent($uuid) {
		$query = "update event_group set status_fk = 1 where event_fk = (select id from event where uuid = $1)";
		PgDatabase::psExecute($query, array($uuid));
		return;
	}
	
	public static function addEventRecurrence($pattern, $numOccur, $end) {
		$query = "insert into event_recur (pattern, num_occur, end_dttm) values ($1, $2, $3) returning id";
		$row = pg_fetch_row(PgDatabase::psExecute($query, array($pattern, $numOccur, $end)));
		return $row[0];
	}
	
	public static function updateDemoNowEvent() {
		$query = "update event set start_dttm = (now() - interval '5 minutes') where id = '" . Utilities::getDemoNowEvent() . "'";
		PgDatabase::psExecute($query, array());
		return;
	}
	
	public static function updateDemoFutureEvent() {
		$query = "update event set start_dttm = (start_dttm + interval '1 week') where id in (" . Utilities::getDemoFutureEvent() . ")";
		PgDatabase::psExecute($query, array());
		return;
	}
	
}


?>