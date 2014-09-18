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

$logDate = date("D M j G:i:s T Y");

$pipelog = fopen("pipeLog.txt", "a");
fwrite($pipelog, "\n\n" . $logDate . "\n=====================================\n");
fwrite($pipelog, "Piped In = \n" . $messageIn . "\n");

$standardlog = fopen("standardLog.txt", "a");
fwrite($standardlog, "\n\n" . $logDate . "\n=====================================\n");

preg_match("/<reply-nexus-([0-9a-z-]{36})@triple-grove-698\.appspotmail\.com>/", $messageIn, $matches);
if (isset($matches[1])) {
	$originatingUuid = $matches[1];
} else {
	// TODO - shortcircuit this better?
	$originatingUuid = Util::newUuid();
}

$row = pg_fetch_array(pgDb::getSenderByMessageId($originatingUuid));

if ($row) {
	
	preg_match("/^Begin Original Message Data Stream$.*^Subject: (.*)$/Usm", $messageIn, $matches);
	$subject = $matches[1];
	
	//preg_match("/^From: (.*) <.*>/m", $messageIn, $matches);
	//$toName = $matches[1];
	
	// From spec on boundary syntax: http://www.w3.org/Protocols/rfc1341/7_2_Multipart.html. Apparently implementations may or may not enclose in quotes.
	preg_match("/^Content-Type: multipart.*boundary=[\"]?([0-9a-zA-Z'()+_,=\-\.\/\:\?]*)[\"]?$/Usm", $messageIn, $matches);
	$boundary = $matches[1];
	
	// Excellent debug tool at http://regex101.com.
	$regex = "/--" . Util::escapeforRegex($boundary) . ".^Content-Type: text\/plain.*$(^Content.*)*(^.*)--" . Util::escapeforRegex($boundary) . "$/Usm";
	preg_match($regex, $messageIn, $matches);
	$extractedMessage = end($matches);

		
	//TODO - Below only works for some email processors.
	//preg_match("/(.*)^On.*hit-reply@nexus\.northbridgetech\.org.*wrote:/Usm", $extractedMessage, $matches);
	//$newMessage = remove_empty_lines($matches[1]);
	$newMessage = "(response through email not captured)";
	
	$messageId = pgDb::insertMessage($row['recipientid'], $subject, $newMessage, $row['messageid']);	
	
	$newUuid = Util::newUuid();
	pgDb::insertMessageRecipient($messageId, $row['userid'], $newUuid);
	
	$row2 = pg_fetch_array(pgDb::getRecipientByMessageId($originatingUuid));
	
	$sanitizedMessage = strtr($extractedMessage, array($row2['email'] => "private address"));
	$to = $row['email'];
	$toName = $row2['fname'] . " " . $row2['lname'] . " via Nexus";
	$from =  $toName . " <hit-reply@nexus.northbridgetech.org>";
	$reply = $toName . " <reply-nexus-" . $newUuid . "@triple-grove-698.appspotmail.com>";
	$headers = "From: " . $from . "\r\n" . "Reply-To: " . $reply;

	fwrite($standardlog, "Boundary = " . $boundary . "\n");
	fwrite($standardlog, "Message regex = \n" . $regex . "\n");
	fwrite($standardlog, "Originating uuid = " . $originatingUuid . "\n");
	fwrite($standardlog, "Originating subject = " . $subject . "\n");
	fwrite($standardlog, "Originating To = " . $to . "\n");
	fwrite($standardlog, "New message headers = \n" . $headers . "\n");
	fwrite($standardlog, "Complete (Sanitized) Message = " . $sanitizedMessage . "\n");
	fwrite($standardlog, "New Portion of Message = " . $newMessage . "\n");

	mail($to, $subject, $sanitizedMessage, $headers);

} else {
	
	fwrite($standardlog, "There is no message to correspond with the input uuid.\n");
}

fclose($pipelog);
fclose($standardlog);
exit(0);

function remove_empty_lines($string){
	return preg_replace("/(^[\r\n]*|[\r\n]+)[\s\t]*[\r\n]+/", "\n", $string);
}

?>

