#!/usr/bin/php -q

<?php

require_once("pgDb.php");
require_once("util.php");

//$in = fopen("testIn.txt", "r");
$in = fopen("php://stdin", "r");
$messageIn = "";
while (!feof($in)) {
	$messageIn .= fread($in, 1024);
}
fclose($in);


$log = fopen("log.txt", "a");
fwrite($log, "\n\n" . date("D M j G:i:s T Y") . "=====================================\n");
fwrite($log, "Piped In = \n" . $messageIn . "\n");

// TODO - reply to reply to reply - this pattern does not work. See log for example.

preg_match("/<reply-nexus-([0-9a-z-]{36})@triple-grove-698\.appspotmail\.com>/", $messageIn, $matches);
$originatingUuid = $matches[1];

$row = pg_fetch_array(pgDb::getSenderByMessageId($originatingUuid));

preg_match("/^Subject: (.*)/m", $messageIn, $matches);
$subject = $matches[1];

preg_match("/^From: (.*) <.*>/m", $messageIn, $matches);
$toName = $matches[1];

preg_match("/^Content-Type: multipart.*boundary=(.*)$/m", $messageIn, $matches);
$boundary = $matches[1];

preg_match("/--" . $boundary . ".^Content-Type: text\/plain.*$(.*)--" . $boundary . "$/Usm", $messageIn, $matches);
$extractedMessage = $matches[1];

preg_match("/(.*)^On.*hit-reply@nexus\.northbridgetech\.org.*wrote:/Usm", $extractedMessage, $matches);
$newMessage = remove_empty_lines($matches[1]);

$messageId = pgDb::insertMessage($row['recipientid'], $subject, $newMessage, $row['messageid']);	

$newUuid = Util::newUuid();
pgDb::insertMessageRecipient($messageId, $row['userid'], $newUuid);

$to = $toName . " <" . $row['email'] . ">";

$from = $row['fname'] . " " . $row['lname'] . " <hit-reply@nexus.northbridgetech.org>";
$reply = $toName . " <reply-nexus-" . $newUuid . "@triple-grove-698.appspotmail.com>";
$headers = "From: " . $from . "\r\n" . "Reply-To: " . $reply;


fwrite($log, "Boundary = " . $boundary . "\n");
fwrite($log, "Originating uuid = " . $originatingUuid . "\n");
fwrite($log, "Originating subject = " . $subject . "\n");
fwrite($log, "Originating To = " . $to . "\n");
fwrite($log, "New message headers = \n" . $headers . "\n");
fwrite($log, "Complete Message = " . $extractedMessage . "\n");
fwrite($log, "New Portion of Message = " . $newMessage . "\n");
fclose($log);

mail($to, $subject, $extractedMessage, $headers);

exit(0);

function remove_empty_lines($string){
	return preg_replace("/(^[\r\n]*|[\r\n]+)[\s\t]*[\r\n]+/", "\n", $string);
}

?>

