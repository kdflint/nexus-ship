<?php

require_once(dirname(__FILE__) . "/../framework/forumDb.php");
require_once(dirname(__FILE__) . "/../framework/PgDb.php");
require_once(dirname(__FILE__) . "/../framework/Util.php");

class ExternalMessage {
	
	public static function readForumMessagesDue() {

		$conf = array('append' => true, 'mode' => 0644, 'timeFormat' => '%X %x');	
		$logger = Log::singleton("file", Utilities::getLogRoot() ."/forum_message.log", "", $conf, PEAR_LOG_DEBUG);
	
		$logger->log("Hello from readForumMessagesDue", PEAR_LOG_DEBUG);
	
		$forumNotifications= array();
		
		$query = "select floor(extract('epoch' from forum_last_poll_dttm)) from forum_poll";
		$row = pg_fetch_row(PgDatabase::psExecute($query, array()));
		$lastRun = $row[0];
		
		// Get the topics that are new since last poll
		$logger->log("Searching since time epoch " . $lastRun, PEAR_LOG_DEBUG);
		$query = "select CURRENT_TIMESTAMP as now, t.topic_id, t.forum_id, t.topic_title, f.forum_name, u.username
			from phpbb_topics t, phpbb_users u, phpbb_forums f
			where t.topic_time >=  $1
			and u.user_id = t.topic_poster
			and f.forum_id = t.forum_id";		
		$results = pg_fetch_all(ForumDatabase::psExecute($query, array($lastRun)));	
		if ($results && isset($results[0]['now'])) {
			$logger->log("Hello from results", PEAR_LOG_DEBUG);
			$thisRun = $results[0]['now'];
			foreach($results as $row) {
				// Get the users watching this forum
				$logger->log("Hello from result iterate", PEAR_LOG_DEBUG);
				$logger->log(print_r($row,true), PEAR_LOG_DEBUG);
				$query = "select u.username from phpbb_forums_watch fw, phpbb_users u where u.user_id = fw.user_id and fw.forum_id = $1"; 	
				$watchers = pg_fetch_all(ForumDatabase::psExecute($query, array($row['forum_id'])));
				foreach ($watchers as $watcher) {								
					$logger->log($watcher['username'], PEAR_LOG_DEBUG);
					// Get the email address for the forum watcher
					$query = "select u.email from public.user u where u.username = $1";
					$watcherEmails = pg_fetch_all(PgDatabase::psExecute($query, array($watcher['username'])));	
					foreach ($watcherEmails as $email) {
						$logger->log($email['email'], PEAR_LOG_DEBUG);	
						array_push($forumNotifications, array($watcher['username'], $email['email'], 'topic', $row['topic_id'], $row['topic_title'], $row['forum_id'], $row['forum_name']));	
						$logger->log(print_r($forumNotifications,true), PEAR_LOG_DEBUG);				
					}
				}
			}
			$logger->log("Updating forum_last_poll_dttm to " . $thisRun, PEAR_LOG_DEBUG);
			$query = "update forum_poll set forum_last_poll_dttm = $1";
			PgDatabase::psExecute($query, array($thisRun));	
		}	
	
		return $forumNotifications;
	}

	public static function readTopicMessagesDue() {
		
		$conf = array('append' => true, 'mode' => 0644, 'timeFormat' => '%X %x');	
		$logger = Log::singleton("file", Utilities::getLogRoot() ."/forum_message.log", "", $conf, PEAR_LOG_DEBUG);

		$logger->log("Hello from readTopicMessagesDue", PEAR_LOG_DEBUG);

		$topicNotifications= array();
		
		$query = "select floor(extract('epoch' from topic_last_poll_dttm)) from forum_poll";
		$row = pg_fetch_row(PgDatabase::psExecute($query, array()));
		//$lastRun = $row[0];
		$lastRun = 1493839801;
		
		// TODO - union this with above, probably, and do all at once
		// Get the posts that are new since last poll
		$logger->log("Searching since time epoch " . $lastRun, PEAR_LOG_DEBUG);

		$query = "select CURRENT_TIMESTAMP as now, p.post_id, p.topic_id, p.forum_id, t.topic_title, p.post_subject, f.forum_name, u.username
			from phpbb_posts p, phpbb_topics t, phpbb_users u, phpbb_forums f
			where p.post_time >=  $1
			and u.user_id = p.poster_id
			and t.topic_id = p.topic_id
			and f.forum_id = p.forum_id";		
		$results = pg_fetch_all(ForumDatabase::psExecute($query, array($lastRun)));	
		
		if ($results && isset($results[0]['now'])) {
		    $logger->log("Inside results loop 1", PEAR_LOG_DEBUG);
			$thisRun = $results[0]['now'];
			foreach($results as $row) {
			    $logger->log("Inside results loop 2", PEAR_LOG_DEBUG);
				// Get the users watching this topic
				$query = "select u.username from phpbb_topics_watch tw, phpbb_users u where u.user_id = tw.user_id and tw.topic_id = $1"; 	
				$watchers = pg_fetch_all(ForumDatabase::psExecute($query, array($row['topic_id'])));
				if ($watchers) {
				    $logger->log("Inside watchers loop", PEAR_LOG_DEBUG);
					foreach($watchers as $watcher) {					
					    $logger->log("Inside row loop: " . $watcher['username'], PEAR_LOG_DEBUG);
						// Get the email address for the user
						$query = "select u.email from public.user u where u.username = $1";
						$thisEmail = pg_fetch_array(PgDatabase::psExecute($query, array($watcher['username'])));
						if ($thisEmail) {
							$logger->log("Email: " . $thisEmail[0], PEAR_LOG_DEBUG);
							array_push($topicNotifications, array($watcher['username'], $thisEmail[0], 'post', $row['post_id'], $row['post_subject'], $row['topic_id'], $row['topic_title'], $row['forum_id'], $row['forum_name']));		
						}
					}
				}
			}
			$logger->log("Updating topic_last_poll_dttm to " . $thisRun, PEAR_LOG_DEBUG);
			$query = "update forum_poll set topic_last_poll_dttm = $1";
			PgDatabase::psExecute($query, array($thisRun));	
		}	
	
		return $topicNotifications;
	}
	
	public static function readPmMessagesDue() {
		
		$conf = array('append' => true, 'mode' => 0644, 'timeFormat' => '%X %x');	
		$logger = Log::singleton("file", Utilities::getLogRoot() . "/pm_message.log", "", $conf, PEAR_LOG_INFO);
	
		$logger->log("Hello from readPmMessagesDue", PEAR_LOG_DEBUG);

		$pmNotifications= array();
		
		$query = "select floor(extract('epoch' from pm_last_poll_dttm)) from forum_poll";
		$row = pg_fetch_row(PgDatabase::psExecute($query, array()));
		$lastRun = $row[0];
		$logger->log("Searching since time epoch " . $lastRun, PEAR_LOG_DEBUG);

		$query = "select CURRENT_TIMESTAMP as now, m.msg_id, m.author_id, m.message_text, m.message_subject, m.to_address, u.username
			from phpbb_privmsgs m, phpbb_users u
			where m.message_time >= $1
			and u.user_id = m.author_id";		
		$results = pg_fetch_all(ForumDatabase::psExecute($query, array($lastRun)));	
		if ($results && isset($results[0]['now'])) {
			$logger->log("Hello from results", PEAR_LOG_DEBUG);
			$thisRun = $results[0]['now'];
			foreach($results as $message) {
				$recipients = explode(':', $message['to_address']);
				foreach($recipients as $recipient) {
					$query = "select username from phpbb_users where user_id = $1";
					$row = pg_fetch_row(ForumDatabase::psExecute($query, array(substr($recipient,2))));
					$query = "select email, fname, lname from public.user where username = $1";
					$to = pg_fetch_array(PgDatabase::psExecute($query, array($row[0])));
					$query = "select (fname || ' ' || lname) as name from public.user where username = $1";
					$from = pg_fetch_array(PgDatabase::psExecute($query, array($message['username'])));
					//$query = "";
					//$network = pg_fetch_array(PgDatabase::psExecute($query, array($message['username'])))
					array_push($pmNotifications, array($to['email'], $to['fname'], 'private message', $from['name'], $message['message_subject']));
				}
			}
			$query = "update forum_poll set pm_last_poll_dttm = $1";
			PgDatabase::psExecute($query, array($thisRun));	
		}
		return $pmNotifications;
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