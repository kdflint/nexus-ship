<?php

session_start();

require_once("util.php");require_once("../../../src/framework/Util.php");
require_once(Utilities::getSrcRoot() . "/message/ExternalMessage.php");
require_once(Utilities::getSrcRoot() . "/user/User.php");

$conf = array('append' => true, 'mode' => 0644, 'timeFormat' => '%X %x');
$logger = Log::singleton("file", Utilities::getLogRoot() . "web_message.log", "", $conf, PEAR_LOG_INFO);

$conf2 = array('subject' => 'Message Send Event');
$loggerEmail = Log::singleton('mail', 'kathy.flint@northbridgetech.org', 'ident', $conf2);

$message = $subject = $greeting = $salutation = "";

if (isset($_POST['testMessage'])) {
		$message = "This is the test message you requested from your Nexus user profile.";
} else if (isset($_POST['message']) && strlen($_POST['message']) > 0) {
		$message = $_POST['message'];
} else {
	// We have no good message
}

if (strlen($message) > 0) {

	// TODO - can this be set but 0 length?
	//if (isset($_POST['names'])) {	
	if (false) {
		// This is a real message
		
    $subject = "[Nexus] Personal Message";	
    $messageId = ExternalMessage::insertMessage($_SESSION['uidpk'], $subject, $message, null);	
    $counter = 0;
		
		foreach ($_POST['names'] as $value) {
    	$userId = preg_split("/::/", $value);
    	$row = pg_fetch_array(User::getUserById($userId[0]));
			$uuid = Utilities::newUuid();
			ExternalMessage::insertMessageRecipient($messageId, $userId[0], $uuid, "PENDING");
			$counter++;
	 	}
	 	
	 	$logger->log("Inserted " . $counter . " pending messages for message id " . $messageId . " (but it's possible some were dupes so don't panic).", PEAR_LOG_INFO);
	 			
		// TODO: return to directory with correct focus and success message
		header("location:../view/nexus.php?thisPage=directory" . $_POST['pageRestore'] . "&userMessage=Please allow 5 minutes for your message to be delivered.");
		exit(0);
			
	} else {
		// This is a test message	
		if (isset($_POST['phone']) && strlen($_POST['phone']) > 0) {
			$subject = "Nexus Test Message";
		  sendSms($_POST['phone'], $subject, $message);
		}	  

		if (isset($_POST['email']) && strlen($_POST['email']) > 0) {
			$subject = "[Nexus] Test Message";
			$uuid = Utilities::newUuid();
			$from = "<noreply@nexus.northbridgetech.org>";
			$reply = "";
		  sendEmail($_POST['email'], $subject, "Hello " . $_SESSION['fname'] . ",\n\n" . $message . "\n\nNexus Support Team", $uuid, $from, $reply);
		}
		header("location:" . Utilities::getHttpPath() . "/nexus.php?view=profile");
		exit(0);
	}
} else {
		// TODO: return to directory with correct focus and fail message
		header("location:" . Utilities::getHttpPath() . "/nexus.php?view=profile&error=Error");
		exit(0);
}

function sendSms($phonenum, $subject, $message) {
	
		// TODO - if results have not been stored in past 6 months, call and update
		// Pull email from database, not service
	
		$username = Utilities::getSmsServiceUsername();
		$password = Utilities::getSmsServicePassword();

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