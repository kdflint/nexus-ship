<?php

error_reporting(E_ALL);
ini_set( 'display_errors','1'); 

include("../model/pgDb.php");

$message = "";

if (isset($_POST['testMessage'])) {
		$message = "Woo hoo! This is the test message you requested from your Nexus user profile.";
} else if (isset($_POST['message']) && strlen($_POST['message']) > 0) {
		$message = $_POST['message'];
} else {
	// We have no good message
}

if (strlen($message) > 0) {

	if (isset($_POST['names'])) {	
		foreach ($_POST['names'] as $value) {
	
    		$userId = preg_split("/::/", $value);
    		$row = pg_fetch_array(pgDb::getUserById($userId[0]));
	    	
    		// TODO: somehow make sure a field is populated if it is enabled
	    	
				if (!strcmp($row['smson'], "t")) {
					sendSms($row['cell'], $message);
				}
				
				if (!strcmp($row['emailon'], "t")) {
					sendEmail($row['email'], $message);
				}
		}
		
		// TODO: return to directory with correct focus and success message
		header("location:../view/nexus.php?thisPage=directory");
		exit(0);
			
	} else {
	
		if (isset($_POST['phone']) && strlen($_POST['phone']) > 0) {
		  sendSms($_POST['phone'], $message);
		}	  

		if (isset($_POST['email']) && strlen($_POST['email']) > 0) {
		  sendEmail($_POST['email'], $message);
		}
		
		header("location:../view/nexus.php?thisPage=profile");
		exit(0);
	
	}
} else {
			
		// TODO: return to directory with correct focus and fail message
		header("location:../view/nexus.php?thisPage=directory");
		exit(0);
}
	


function sendSms($phonenum, $message) {
	
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
			// TODO: supply a real from address: nexus@northbridgetech.org
			// TODO: supply salutation
			mail($email, "", $message, "From: contact@northbridgetech.org");		
		} else {
  	}	
}

function sendEmail($email, $message) {
	
	// TODO: supply a real from address: nexus@northbridgetech.org
	// TODO: supply a subject line
	// TODO: supply salutation, signature
	mail($email, "", $message, "From: contact@northbridgetech.org");		
	
}



?>