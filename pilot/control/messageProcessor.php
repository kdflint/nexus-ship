<?php

session_start();

error_reporting(E_ALL);
ini_set( 'display_errors','1'); 

include("../model/pgDb.php");

$message = $subject = $greeting = $salutation = "";

if (isset($_POST['testMessage'])) {
		$message = "This is the test message you requested from your Nexus user profile.";
} else if (isset($_POST['message']) && strlen($_POST['message']) > 0) {
		$message = $_POST['message'];
} else {
	// We have no good message
}

if (strlen($message) > 0) {

	if (isset($_POST['names'])) {	
		// This is a real message
		foreach ($_POST['names'] as $value) {
	
    		$userId = preg_split("/::/", $value);
    		$row = pg_fetch_array(pgDb::getUserById($userId[0]));
	    	
    		// TODO: somehow make sure a field is populated if it is enabled
	    	
				if (!strcmp($row['smson'], "t")) {
					$subject = "Nexus Personal Message";
					$greeting = $row['first'] . ", ";
					$salutation = " -" . $_SESSION['fname'] . " " . $_SESSION['lname'][0] . ".";
					sendSms($row['cell'], $subject, $greeting . $message . $salutation);
				}
				
				if (!strcmp($row['emailon'], "t")) {
					$subject = "[Nexus] Personal Message";
					$greeting = $row['first'] . ", \n\n";
					$salutation = "\n\nYour colleague,\n\n" . $_SESSION['fname'] . " " . $_SESSION['lname'] . "\n" . $_SESSION['orgName'];
					sendEmail($row['email'], $subject, $greeting . $message . $salutation);
				}
		}
		
		// TODO: return to directory with correct focus and success message
		header("location:../view/nexus.php?thisPage=directory" . $_POST['pageRestore']);
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
		  sendEmail($_POST['email'], $subject, "Hello " . $_SESSION['fname'] . ",\n\n" . $message . "\n\nNexus Support Team");
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
			mail($email, $subject, $message, "From: noreply@northbridgetech.org");		
		} else {
  	}	
}

function sendEmail($email, $subject, $message) {
	
	mail($email, $subject, $message, "From: noreply@northbridgetech.org");		
	
}



?>