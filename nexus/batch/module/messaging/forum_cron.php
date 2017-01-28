#!/usr/bin/php -q

<?php

require_once("../../Util.php");
require_once(Utilities::getSrcRoot() . "/message/ExternalMessage.php");

$conf = array('append' => true, 'mode' => 0644, 'timeFormat' => '%X %x');
$logger = Log::singleton("file", "forum_message.log", "", $conf, PEAR_LOG_DEBUG);
$logger->log("Forum external message process started", PEAR_LOG_INFO);

$notificationsDue = ExternalMessage::readForumMessagesDue();
$logger->log(count($notificationsDue) . " external messages identified", PEAR_LOG_INFO);
$logger->log(print_r($notificationsDue, TRUE), PEAR_LOG_DEBUG);

$headers = "From: kathy.flint@northbridgetech.org\r\n";

foreach($notificationsDue as $row) {
	// TopicMessage = new()...
	// TopicMessage.send($thisEmail);
	mail($row[0], $row[5] . ": New Topic", "Construct messages with link to forum topic", $headers);
	$logger->log($row[1] . ":" . $row[6], PEAR_LOG_DEBUG);
}

?>