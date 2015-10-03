<?php

require_once(dirname(__FILE__) . "/../framework/PgDb.php");

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
	
	private static function getMinute($in) {
		if (0 <= $in && $in < 10) {
			return "0" . $in;
		} else {
			return $in;
		}
	}
	
	private static function getPeriod($in) {
		if (0 <= $in && $in < 13) {
			return "AM";
		} else if (13 <= $in && $in < 24) {
			return "PM";
		} else {
			return "undefined";
		}
	}
	
	private static function getMeetingTypeDisplay($in) {
		// TODO - should leverage the constants defined in BbbMEeting.php. This is duplicated stringage
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
	
	public static function isValidTimeZone($in) {
		$query = "select exists (select name from pg_timezone_names where name = $1)";		
		$row = pg_fetch_row(pgDb::psExecute($query, array($in)));
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
		$query = "select exists (select uuid from event where uuid = $1)";		
		$row = pg_fetch_row(pgDb::psExecute($query, array($in)));
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
  	$row = pg_fetch_row(pgDb::psExecute($query, array($in)));
		if (!strcmp($row[0], "t")) {
			return TRUE;
		}
		return FALSE;	
	}
	
	public static function getFutureEvents($groupId, $localTz = "Greenwich", $ssnUser) {	
		$events = array();
		if (self::isValidTimeZone($localTz)) {
			$query = "select 
				extract(day from (select e.start_dttm at time zone $2)) as date, 
				extract(dow from (select e.start_dttm at time zone $2)) as day, 
				extract(month from (select e.start_dttm at time zone $2)) as month, 
				extract(hour from (select e.start_dttm at time zone $2)) as hour, 
				extract(minute from (select e.start_dttm at time zone $2)) as minute, 
				extract(epoch from (select e.start_dttm)) as epoch,
				e.tz_name as tzname, 
				e.duration as duration, 
				e.name as name, 
				e.descr as descr, 
				e.uuid as uuid,
				e.reserved_user_fk as adder,
				e.type as meetingtype,
				u.fname as fname, 
				u.lname as lname,
				pg.abbrev as abbrev 
			from event e, public.user u, pg_timezone_names pg
			where e.group_fk = $1		
			and (e.start_dttm + e.duration) > now() 
			and e.active = true
			and pg.name = $2
			and u.id = e.reserved_user_fk 
			order by e.start_dttm";
				
			$cursor = pgDb::psExecute($query, array($groupId, $localTz));
			$counter = 0;
			while ($row = pg_fetch_array($cursor)) {
				$events[$counter]['date'] = $row['date'];
				$events[$counter]['day'] = self::getDay($row['day']);
				$events[$counter]['month'] = self::getMonth($row['month']-1);
				$events[$counter]['hour'] = self::getHour($row['hour']);
				$events[$counter]['minute'] = self::getMinute($row['minute']);
				$events[$counter]['epoch'] = $row['epoch'];
				$events[$counter]['period'] = self::getPeriod($row['hour']);
				$events[$counter]['abbrev'] = $row['abbrev'];
				$events[$counter]['purpose'] = $row['name'];
				$events[$counter]['descr'] = $row['descr'];
				$events[$counter]['uuid'] = $row['uuid'];
				$events[$counter]['mtype'] = self::getMeetingTypeDisplay($row['meetingtype']);
				$events[$counter]['fname'] = $row['fname'];
				$events[$counter]['lname'] = $row['lname'];
				$events[$counter]['sessionUser'] = $ssnUser;
				$events[$counter]['adder'] = $row['adder'];
				$counter++;
			}
		}
		return $events;
	}

	public static function addEvent($dttm, $duration, $name, $reservedUserId, $groupId, $tzName, $type) {
		$query = "select abbrev from pg_timezone_names where name = $1";
		$row = pg_fetch_row(pgDb::psExecute($query, array($tzName)));
		$tzAbbrev = $row[0];
		$query = "insert into event (uuid, start_dttm, duration, name, descr, reserved_user_fk, group_fk, tz_name, tz_abbrev, type) values ($1, $2, $3, $4, $9, $5, $6, $7, $8, $10)";
		pgDb::psExecute($query, array(Util:: newUuid(), $dttm, $duration, $name, $reservedUserId, $groupId, $tzName, $tzAbbrev, "", $type));
		return;
	}	
	
	public static function deleteEvent($uuid) {
		$query = "update event set active = false where uuid = $1";
		pgDb::psExecute($query, array($uuid));
		return;
	}
}


?>