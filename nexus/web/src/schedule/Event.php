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
	
	public static function getFutureEvents($groupId) {
		$query = "select extract(day from e.start_dttm) as date, extract(dow from e.start_dttm) as day, extract(month from e.start_dttm) as month, extract(hour from e.start_dttm) as hour, extract(minute from e.start_dttm) as minute, e.tz_name as name, e.tz_abbrev as abbrev, e.duration as duration, e.name as name, e.descr as descr, u.fname as fname, u.lname as lname from event e, public.user u where e.group_fk = $1 and e.start_dttm > now() and u.id = e.reserved_user_fk order by e.start_dttm;";
		$cursor = pgDb::psExecute($query, array($groupId));
		$counter = 0;
		$events = array();
		while ($row = pg_fetch_array($cursor)) {
			$events[$counter]['date'] = $row['date'];
			$events[$counter]['day'] = self::getDay($row['day']);
			$events[$counter]['month'] = self::getMonth($row['month']-1);
			$events[$counter]['hour'] = self::getHour($row['hour']);
			$events[$counter]['minute'] = self::getMinute($row['minute']);
			$events[$counter]['period'] = self::getPeriod($row['hour']);
			$events[$counter]['abbrev'] = $row['abbrev'];
			$events[$counter]['purpose'] = $row['name'];
			$events[$counter]['descr'] = $row['descr'];
			$events[$counter]['fname'] = $row['fname'];
			$events[$counter]['lname'] = $row['lname'];
			$counter++;
		}
		return $events;
	}

	public static function addEvent($dttm, $duration, $name, $reservedUserId, $groupId, $tzName) {
		$query = "select abbrev from pg_timezone_names where name = $1";
		$row = pg_fetch_row(pgDb::psExecute($query, array($tzName)));
		$tzAbbrev = $row[0];
		$query = "insert into event (uuid, start_dttm, duration, name, descr, reserved_user_fk, group_fk, tz_name, tz_abbrev) values ($1, $2, $3, $4, $9, $5, $6, $7, $8)";
		pgDb::psExecute($query, array(Util:: newUuid(), $dttm, $duration, $name, $reservedUserId, $groupId, $tzName, $tzAbbrev, ""));
		return;
	}	
}


?>