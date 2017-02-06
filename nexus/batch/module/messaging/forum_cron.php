#!/usr/bin/php -q

<?php

require_once("../../Util.php");
require_once(Utilities::getSrcRoot() . "/message/ExternalMessage.php");

$conf = array('append' => true, 'mode' => 0644, 'timeFormat' => '%X %x');
$logger = Log::singleton("file", "forum_message.log", "", $conf, PEAR_LOG_DEBUG);
$logger->log("Forum external message process started", PEAR_LOG_DEBUG);

$headers = "From: kathy.flint@northbridgetech.org\r\n";

// TODO - weed out poster

$forumNotificationsDue = ExternalMessage::readForumMessagesDue();
$logger->log(count($forumNotificationsDue) . " external forum messages identified", PEAR_LOG_INFO);
$logger->log(print_r($forumNotificationsDue, TRUE), PEAR_LOG_DEBUG);

foreach($forumNotificationsDue as $row) {
	mail($row[1], $row[6] . ": New Topic", getNewTopicMessage($row[6],$row[4],$row[5]), $headers);
	$logger->log($row[1] . ":" . $row[6], PEAR_LOG_DEBUG);
}

$topicNotificationsDue = ExternalMessage::readTopicMessagesDue();
$logger->log(count($topicNotificationsDue) . " external topic messages identified", PEAR_LOG_INFO);
$logger->log(print_r($topicNotificationsDue, TRUE), PEAR_LOG_DEBUG);

foreach($topicNotificationsDue as $row) {
	mail($row[1], $row[6] . ": New Post", getNewPostMessage($row[8],$row[6],$row[7],$row[5]), $headers);
	$logger->log($row[1] . ":" . $row[6], PEAR_LOG_DEBUG);
}

function getNewTopicMessage($forumName, $topicName, $forumId) {
	// TODO - pesonalize with topic poster, message recipient fname, network name, etc.
	$messageString = "Hello,

You are receiving this notification because you are watching the forum \"". $forumName . "\". This forum has received a new topic since your last visit: \"" . $topicName . "\" 

Use this link to view the forum:   

" . Utilities::getForumHttpPath() . "/viewforum.php?f=" . $forumId . " 

If you no longer wish to watch this forum, please reply to this email with \"unsubscribe\" in the message body or subject line.

Sincerely,

The Nexus Advantage Team";

	return $messageString;
}

function getNewPostMessage($forumName, $topicName, $forumId, $topicId) {
	// TODO - pesonalize with topic poster, message recipient fname, network name, etc.
	$messageString = "Hello,

You are receiving this notification because you are watching the topic \"" . $topicName . "\" within the discussion forum \"" . $forumName . "\". This topic has received new posts since your last visit.

Use this link to view the topic:   

" . Utilities::getForumHttpPath() . "/viewtopic.php?f=" . $forumId . "&t=" . $topicId . "

If you no longer wish to watch this topic, please reply to this email with \"unsubscribe\" in the message body or subject line.

Sincerely,

The Nexus Advantage Team";

	return $messageString;
}


?>