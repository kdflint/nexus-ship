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
		
		// Get the topics that are new since last poll
		$query = "select CURRENT_TIMESTAMP as now, t.topic_id, t.forum_id, t.topic_title, f.forum_name, u.username
			from phpbb_topics t, phpbb_users u, phpbb_forums f
			where t.topic_time >=  $1
			and u.user_id = t.topic_poster
			and f.forum_id = t.forum_id";		
		$results = pg_fetch_all(ForumDatabase::psExecute($query, array($lastRun)));	
		
		if ($results && isset($results[0]['now'])) {
			$thisRun = $results[0]['now'];
			foreach($results as $row) {
				// Get the users watching this topic
				$query = "select u.username from phpbb_forums_watch fw, phpbb_users u where u.user_id = fw.user_id and fw.forum_id = $1"; 	
				$watchers = pg_fetch_array(ForumDatabase::psExecute($query, array($row['forum_id'])));
				if ($watchers) {
					foreach($watchers as $row) {
						// Get the email address for the forum watcher
						$query = "select u.email from public.user u where u.username = $1";
						$thisEmail = pg_fetch_array(PgDatabase::psExecute($query, array($row[0])));
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

	public static function readTopicMessagesDue() {
		
		$topicNotifications= array();
		
		$query = "select floor(extract('epoch' from topic_last_poll_dttm)) from forum_poll";
		$row = pg_fetch_row(PgDatabase::psExecute($query, array()));
		$lastRun = $row[0];
		
		// TODO - union this with above, probably, and do all at once
		// Get the posts that are new since last poll
		$query = "select CURRENT_TIMESTAMP as now, p.post_id, p.topic_id, p.forum_id, t.topic_title, p.post_subject, f.forum_name, u.username
			from phpbb_posts p, phpbb_topics t, phpbb_users u, phpbb_forums f
			where p.post_time <=  $1
			and u.user_id = p.poster_id
			and t.topic_id = p.topic_id
			and f.forum_id = p.forum_id";		
		$results = pg_fetch_all(ForumDatabase::psExecute($query, array($lastRun)));	
		
		if ($results && isset($results[0]['now'])) {
			$thisRun = $results[0]['now'];
			foreach($results as $row) {
				// Get the users watching this topic
				$query = "select u.username from phpbb_topics_watch tw, phpbb_users u where u.user_id = tw.user_id and tw.topic_id = $1"; 	
				$watchers = pg_fetch_array(ForumDatabase::psExecute($query, array($row['topic_id'])));
				if ($watchers) {
					foreach($watchers as $row) {					
						// Get the email address for the user
						$query = "select u.email from public.user u where u.username = $1";
						$thisEmail = pg_fetch_array(PgDatabase::psExecute($query, array($row[0])));
						if ($thisEmail) {
							array_push($topicNotifications, array($thisUser[0], $thisEmail[0], 'post', $row['post_id'], $row['post_subject'], $row['topic_id'], $row['topic_title'], $row['forum_id'], $row['forum_name']));		
						}
					}
				}
			}
			$query = "update forum_poll set topic_last_poll_dttm = $1";
			PgDatabase::psExecute($query, array($thisRun));	
		}	
	
		return $topicNotifications;
	}
	
	public static function addForumSubscription($userId, $forumId) {
		$query = "insert into phpbb_forums_watch (forum_id, user_id) values ($2, $1)";
		ForumDatabase::psExecute($query, array($userId, $forumId));
	}
	
	public static function insertMessage($uidpk, $subject, $message, $replyTo) {
		$query = "insert into message (sender_fk, subject, message, reply_to_fk, create_dttm) values ($1, $2, $3, $4, now()) returning id";
		$result = PgDatabase::psExecute($query, array($uidpk, $subject, $message, $replyTo));
		$row = pg_fetch_row($result);
		return $row[0];
	}

	public static function insertMessageRecipient($messageId, $recipientId, $uuid, $status) {
		$query = "select exists (select true from message_recipient where message_fk = $1 and recipient_fk = $2)";
		$row = pg_fetch_row(PgDb::psExecute($query, array($messageId, $recipientId)));
		if (strcmp($row[0], "t")) {
			$query = "insert into message_recipient (message_fk, recipient_fk, uuid, status) values ($1, $2, $3, $4)";
			return PgDb::psExecute($query, array($messageId, $recipientId, $uuid, $status));
		}
		return FALSE;
	}		

}

?>