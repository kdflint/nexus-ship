<?php

require_once(dirname(__FILE__) . "/../framework/forumDb.php");
require_once(dirname(__FILE__) . "/../framework/PgDb.php");
require_once(dirname(__FILE__) . "/../framework/Util.php");

class ExternalMessage {
	
	public static function readForumMessagesDue() {
		
		$forumNotifications= array();
		
		$query = "select floor(extract('epoch' from forum_last_poll_dttm)) from forum_poll";
		$row = pg_fetch_row(PgDatabase::psExecute($query, array()));
		$lastRun = $row[0];
		
		// TODO - flip this back!
		$query = "select CURRENT_TIMESTAMP as now, t.topic_id, t.forum_id, t.topic_title, f.forum_name, u.username
			from phpbb_topics t, phpbb_users u, phpbb_forums f
			where t.topic_time >=  $1
			and u.user_id = t.topic_poster
			and f.forum_id = t.forum_id";		
		$results = pg_fetch_all(ForumDatabase::psExecute($query, array($lastRun)));	
		
		if ($results && isset($results[0]['now'])) {
			$thisRun = $results[0]['now'];
			foreach($results as $row) {
				$query = "select u.username from phpbb_forums_watch fw, phpbb_users u where u.user_id = fw.user_id and fw.forum_id = $1 limit 1"; 	
				$thisUser = pg_fetch_array(ForumDatabase::psExecute($query, array($row['forum_id'])));
				if ($thisUser) {
					$query = "select u.email from public.user u where u.username = $1";
					$thisEmail = pg_fetch_array(PgDatabase::psExecute($query, array($thisUser[0])));
					if ($thisEmail) {
						array_push($forumNotifications, array($thisUser[0], $thisEmail[0], 'topic', $row['topic_id'], $row['topic_title'], $row['forum_id'], $row['forum_name']));		
					}
				}
			}
			$query = "update forum_poll set forum_last_poll_dttm = $1";
			PgDatabase::psExecute($query, array($thisRun));	
		}	
	
		return $forumNotifications;
	}

}

?>