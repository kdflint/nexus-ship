<?php

session_start();

//error_reporting(E_ALL);
//ini_set( 'display_errors','1'); 

require_once("util.php");
require_once($_SESSION['appRoot'] . "model/pgDb.php");
require_once($_SESSION['appRoot'] . "control/error/handlers.php");
require_once(Util::getHome() . "php/Log.php");

$conf1 = array('append' => true, 'mode' => 0644, 'timeFormat' => '%X %x');
// TODO- make this path dynamic using $_SESSION['environment'] - but there is a problem setting that variable at the moment...
$logger = Log::singleton("file", Util::getHome() . "batch/dev/nexus/module/message/message_log", "", $conf1, PEAR_LOG_INFO);

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
	if (isset($_POST['names'])) {	
		// This is a real message
		
    $subject = "[Nexus] Personal Message";	
    $messageId = pgDb::insertMessage($_SESSION['uidpk'], $subject, $message, null);	
    $counter = 0;
		
		foreach ($_POST['names'] as $value) {
    	$userId = preg_split("/::/", $value);
    	$row = pg_fetch_array(pgDb::getUserById($userId[0]));
			$uuid = Util::newUuid();
			pgDb::insertMessageRecipient($messageId, $userId[0], $uuid);
			$counter++;
	 	}
	 	
	 	$logger->log("Inserted " . $counter . " pending messages for message id " . $messageId, PEAR_LOG_INFO);
	 	$loggerEmail->log("Inserted " . $counter . " pending messages for message id " . $messageId, PEAR_LOG_INFO);
	 			
		// TODO: return to directory with correct focus and success message
		header("location:../view/nexus.php?thisPage=directory" . $_POST['pageRestore'] . "&userMessage=Sent! Please allow 5 minutes for your message to be delivered.");
		exit(0);
			
	} else {
		// This is a test message
		// TODO: This decisioning should be much more betters
			
		if (isset($_POST['phone']) && strlen($_POST['phone']) > 0) {
			$subject = "Nexus Test Message";
		  sendSms($_POST['phone'], $subject, $message);
		}	  

		if (isset($_POST['email']) && strlen($_POST['email']) > 0) {
			$subject = "[Nexus] Test Message";
			$uuid = Util::newUuid();
			$from = "<noreply@nexus.northbridgetech.org>";
			$reply = "";
		  sendEmail($_POST['email'], $subject, "Hello " . $_SESSION['fname'] . ",\n\n" . $message . "\n\nNexus Support Team", $uuid, $from, $reply);
		}
		
		header("location:../view/nexus.php?thisPage=profile");
		exit(0);
	
	}
} else {
			
		// TODO: return to directory with correct focus and fail message
		header("location:../view/nexus.php?thisPage=directory" . $_POST['pageRestore']);
		exit(0);
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
		
 	$headers = "From: " . $from  . "\r\n" . "Reply-To: " . $reply . "\r\n" . "Bcc: support@nexus.northbridgetech.org"; 	
	mail($email, $subject, $message, $headers);
		
}
	

?>