#!/usr/bin/php -q

<?php

$fd = fopen("php://stdin", "r");
/* Read the message from STDIN 
$fd = fopen("php://stdin", "r");
$saveThis = ""; // This will be the variable holding the data.
while (!feof($fd)) {
	$saveThis .= fread($fd, 1024);
}
fclose($fd);
*/

/* Saves a test message into a file */
$fdw = fopen("pipe.txt", "a+");
fwrite($fdw, "Test message");
fwrite($fdw, "");
fclose($fdw);

/*
	$headers = "From: hit-reply@nexus.northbridgetech.org>";
     	
mail('bryce.m.flint@gmail.com','Is anyone out there?','"' . $email . '"', $headers);

processor needs to

strip the uuid: To: "Test User Nine (via Nexus)" <reply-nexus-1567f647-f0d3-891f-eb7f-71c36ef67f29@triple-grove-698.appspotmail.com>

look up the real To address
include("~/path../model/pgDb.php");
$row = pg_fetch_array(pgDb::getSendingUserByMessageId($inUuid));

to = $row['email'];
from: ' \(via Nexus\) ' . "<hit-reply@nexus.northbridgetech.org>"

include("util.php");
$outUuid = Util::newUuid();
store this new uuid
add field to capture whether the message has been replied or not

Reply-To: ' \(via Nexus\) ' . "<reply-nexus-" . $uuid . "@triple-grove-698.appspotmail.com>" . "\r\n" 
Subject: <parse> Subject: Re: [Nexus] Test Message

isolate the original message and put in new message body

// split the phrase by any number of commas or space characters,
// which include " ", \r, \t, \n and \f
$parts = preg_split("/^--[0-9a-z]{28}/m", $email);
if $parts[n] starts with "/^Content-Type: text/plain;/"

$newMessage = $newMessage . substr($parts[n], 39);


*/

?>

