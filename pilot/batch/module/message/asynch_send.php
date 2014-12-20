#!/usr/bin/php

<?php

require_once("../../config/env_config.php");

$subject = "[Nexus] Personal Message";

$cursor1 = pgDb::getMessageByStatus("PENDING");

while ($row1 = pg_fetch_array($cursor1)) {

	$message = $row1['message'];
	
	$cursor2 = pgDb::getRecipientByMessageId($row1['id']);

	while ($row2 = pg_fetch_array($cursor2)) {
		
		if (!strcmp($row2['smson'], "t")) {
			$greeting = $row2['first'] . ", ";
			$salutation = " -" . $row2['first'] . " " . $row2['last'] . ".";
			sendSms($row2['cell'], $subject, $greeting . $message . $salutation);
		}
		
		if (!strcmp($row2['emailon'], "t")) {				
			$greeting = $row2['first'] . ", \n\n";
			$salutation = "\n\nYour colleague,\n\n" . $row2['first'] . " " . $row2['last'] . "\n" . $row2['oname'];
			$from = $row2['first'] . " " . $row2['last'] . " via Nexus " . "<hit-reply@nexus.northbridgetech.org>";
  			$reply = $row2['first'] . " " . $row2['last'] . " via Nexus " . "<reply-nexus-" . $row2['uuid'] . "@triple-grove-698.appspotmail.com>";
			sendEmail($row2['email'], $subject, $greeting . $message . $salutation, $row2['uuid'], $from, $reply);
		}
		
		pgDb::updateMessageStatus("SENT", $row2['uuid']);
	
	}
}


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
	
	/*
	$headers = "From: " . $_SESSION['fname'] . " " . $_SESSION['lname'] . ' \(via Nexus\) ' . "<hit-reply@nexus.northbridgetech.org>" . "\r\n" .
    "Reply-To: " . $_SESSION['fname'] . " " . $_SESSION['lname'] . ' \(via Nexus\) ' . "<reply-nexus-" . $uuid . "@triple-grove-698.appspotmail.com>" . "\r\n" .
    "Bcc: support@nexus.northbridgetech.org";
 	*/
 	
 	$headers = "From: " . $from  . "\r\n" . "Reply-To: " . $reply . "\r\n" . "Bcc: support@nexus.northbridgetech.org"; 	
	mail($email, $subject, $message, $headers);
		
}

?>