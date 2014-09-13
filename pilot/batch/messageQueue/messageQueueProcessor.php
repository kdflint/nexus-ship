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


$fdw = fopen("log.txt", "a");
fwrite($fdw, "\n\n" . date("D M j G:i:s T Y") . "\n");
fwrite($fdw, "Piped In = \n" . $messageIn . "\n");

// TODO - reply to reply to reply - this pattern does not work. See log for example.
preg_match("/^To: \"(.*)\".*<reply-nexus-([0-9a-z-]{36})@triple-grove-698\.appspotmail\.com/Usm", $messageIn, $matches);
$originatingName = $matches[1];
$originatingUuid = $matches[2];

preg_match("/^Subject: (.*)/m", $messageIn, $matches);
$subject = $matches[1];

preg_match("/^From: (.*) <.*>/m", $messageIn, $matches);
$toName = $matches[1];

preg_match("/^Content-Type: multipart.*boundary=(.*)$/m", $messageIn, $matches);
$boundary = $matches[1];
preg_match("/--" . $boundary . ".^Content-Type: text\/plain.*$(.*)--" . $boundary . "$/Usm", $messageIn, $matches);
$extractedMessage = $matches[1];

preg_match("/(.*)^On.*hit-reply@nexus\.northbridgetech\.org.*wrote:/Usm", $extractedMessage, $matches);
$newMessage = $matches[1];

$row = pg_fetch_array(pgDb::getSenderByMessageId($originatingUuid));
$messageId = pgDb::insertMessage($row['recipientid'], $subject, $newMessage, $row['messageid']);	

// TODO - what if replying to multiple??
$newUuid = Util::newUuid();
pgDb::insertMessageRecipient($messageId, $row['userid'], $newUuid);

$to = $toName . " <" . $row['email'] . ">";

$from = $originatingName . " <hit-reply@nexus.northbridgetech.org>";
$reply = $toName . " <reply-nexus-" . $newUuid . "@triple-grove-698.appspotmail.com>";
$headers = "From: " . $from . "\r\n" . "Reply-To: " . $reply;


fwrite($fdw, "Boundary = " . $boundary . "\n");
fwrite($fdw, "Originating uuid = " . $originatingUuid . "\n");
fwrite($fdw, "Originating subject = " . $subject . "\n");
fwrite($fdw, "Originating To = " . $to . "\n");
fwrite($fdw, "New message headers = \n" . $headers . "\n");
fwrite($fdw, "Complete Message = " . $extractedMessage . "\n");
fwrite($fdw, "New Portion of Message = " . $newMessage . "\n");
fclose($fdw);

mail($to, $subject, $extractedMessage, $headers);

exit(0);

?>

