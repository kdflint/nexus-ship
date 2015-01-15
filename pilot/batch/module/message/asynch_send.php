#!/usr/bin/php

<?php

require_once("../../config/env_config.php");
require_once("../../model/pgDb.php");
require_once("/home1/northbr6/php/Log.php");

$conf = array('append' => true, 'mode' => 0644, 'timeFormat' => '%X %x');
$logger = Log::singleton("file", "message_log", "", $conf, PEAR_LOG_INFO);

$logger->log("Message process started", PEAR_LOG_DEBUG);

$subject = "[Nexus] Personal Message";

$cursor1 = pgDb::getMessageByStatus("PENDING");

while ($row1 = pg_fetch_array($cursor1)) {

	$logger->log("Processing pending messages for message id " . $row1['id'], PEAR_LOG_INFO);
	$message = $row1['message'];
	$senderFname = $row1['fname'];
	$senderLname = $row1['lname'];
	$orgName = $row1['oname'];
	$counter = 0;
	
	$cursor2 = pgDb::getRecipientByPendingMessageId($row1['id']);

	while ($row2 = pg_fetch_array($cursor2)) {
			
		/*
		if (!strcmp($row2['smson'], "t")) {
			$greeting = $row2['fname'] . ", ";
			$salutation = " -" . $senderFname . " " . $senderLname[0] . ".";
			// TODO - once Inbox is implemented, turn this into an alert
			sendSms($row2['cell'], $subject, $greeting . $message . $salutation);
			$logger->log("SMS message sent to user id " . $row2['userid'] , PEAR_LOG_DEBUG);
		}
		*/
		
		if (!strcmp($row2['emailon'], "t")) {				
			$greeting = $row2['fname'] . ", \n\n";
			$salutation = "\n\nYour colleague,\n\n" . $senderFname . " " . $senderLname . "\n" . $orgName;
			$from = $senderFname . " " . $senderLname . " via Nexus " . "<hit-reply@nexus.northbridgetech.org>";
  			$reply = $senderFname . " " . $senderLname . " via Nexus " . "<reply-nexus-" . $row2['uuid'] . "@triple-grove-698.appspotmail.com>";
			sendEmail($row2['email'], $subject, $greeting . $message . $salutation, $row2['uuid'], $from, $reply);
			$logger->log("Email message sent to user id " . $row2['userid'] , PEAR_LOG_DEBUG);
		}
		
		pgDb::updateMessageStatus("SENT", $row2['uuid']);
		$counter++;
	
	}
	
	$logger->log("Message id " . $row1['id'] . " sent to " . $counter . " recipients", PEAR_LOG_INFO);
	
}

$logger->log("Message process ended", PEAR_LOG_DEBUG);
exit(0);


function sendSms($phonenum, $subject, $message) {
	
		$username = "kdflint";
		$password = "A56L9Q1X";

		if ($phonenum[0] != "1") {
			$phonenum = "1" . $phonenum;
		}
		
		// API specs: https://www.data24-7.com/wiki/doku.php?id=text_api_calls
		$url = "https://api.data24-7.com/v/2.0?api=T&user=$username&pass=$password&p1=$phonenum";
		$xml = simplexml_load_file($url) or die("feed not loading");
		$outphone = $xml->results->result[0]->number;
		$status   = $xml->results->result[0]->status;
		$email     = $xml->results->result[0]->sms_address;
		
		if (!strcmp($status, "OK")) {
			// TODO: Lock down service to ip address
			// TODO - why is this coming through with From: justhost?
			mail($email, $subject, $message, "From: noreply@northbridgetech.org");		
		} else {
  	}	
}

function sendEmail($email, $subject, $message, $uuid, $from, $reply) {
		
 	$headers = "From: " . $from  . "\r\n" . "Reply-To: " . $reply . "\r\n" . "Bcc: support@nexus.northbridgetech.org"; 	
	mail($email, $subject, $message, $headers);
		
}

?>