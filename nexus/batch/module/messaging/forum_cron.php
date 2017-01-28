#!/usr/bin/php -q

<?php

require_once("../../Util.php");
require_once(Utilities::getSrcRoot() . "/message/ExternalMessage.php");

$conf = array('append' => true, 'mode' => 0644, 'timeFormat' => '%X %x');
$logger = Log::singleton("file", "forum_message.log", "", $conf, PEAR_LOG_DEBUG);
$logger->log("Forum external message process started", PEAR_LOG_INFO);

$headers = "From: kathy.flint@northbridgetech.org\r\n";

// TODO - weed out poster

$forumNotificationsDue = ExternalMessage::readForumMessagesDue();
$logger->log(count($forumNotificationsDue) . " external forum messages identified", PEAR_LOG_INFO);
$logger->log(print_r($forumNotificationsDue, TRUE), PEAR_LOG_DEBUG);

foreach($forumNotificationsDue as $row) {
	mail($row[1], $row[6] . ": New Topic", "Construct messages with link to forum topic", $headers);
	$logger->log($row[1] . ":" . $row[6], PEAR_LOG_DEBUG);
}

$topicNotificationsDue = ExternalMessage::readTopicMessagesDue();
$logger->log(count($topicNotificationsDue) . " external topic messages identified", PEAR_LOG_INFO);
$logger->log(print_r($topicNotificationsDue, TRUE), PEAR_LOG_DEBUG);

foreach($topicNotificationsDue as $row) {
	mail($row[1], $row[6] . ": New Post", "Construct messages with link to topic post", $headers);
	$logger->log($row[1] . ":" . $row[6], PEAR_LOG_DEBUG);
}


?>