#!/usr/bin/php -q

<?php

require_once("../../Util.php");
require_once(Utilities::getSrcRoot() . "/message/ExternalMessage.php");

$conf = array('append' => true, 'mode' => 0644, 'timeFormat' => '%X %x');
$logger = Log::singleton("file", "pm_message.log", "", $conf, PEAR_LOG_DEBUG);
$logger->log("Pm external message process started", PEAR_LOG_DEBUG);

$pmNotificationsDue = ExternalMessage::readPmMessagesDue();
$logger->log(count($pmNotificationsDue) . " external pm messages identified", PEAR_LOG_INFO);
$logger->log(print_r($pmNotificationsDue, TRUE), PEAR_LOG_DEBUG);

//array_push($pmNotifications, array($to['email'], $to['fname'], 'private message', $from['name']), $message['message_subject']);	

foreach($pmNotificationsDue as $row) {
	$headers = "From: \"" . $row[3] . "\"<support@northbridgetech.org>\r\n";
	$message =  getNewPmMessage($row[1],$row[3],$row[4]);
	mail($row[0], "New Private Message: " . substr($row[4],0,20), $message, $headers);
	$logger->log($message . "\r\n", PEAR_LOG_DEBUG);
}


function getNewPmMessage($toName, $fromName, $subject, $oid = "ed787a92", $networkName = "The Center for Faith and Community Health Transformation") {
	$messageString = "Hello " . $toName . ",

You have received a private message from your colleague " . $fromName . ".

\"" . $subject . "\"

Please log in to your network at Nexus Advantage in order to view and respond to this message.   

" . Utilities::getHttpPath() . "/login.php?oid=" . $oid . " 

You are receiving this notification because you are subscribed to private message notifications from your community at " . $networkName . "

If you no longer wish to receive private message notifications, please reply to this email with \"unsubscribe\" in the message body or subject line.

Sincerely,

Nexus Advantage
on behalf of
" . $networkName;

	return $messageString;
}

?>