<?php

error_reporting(E_ALL);
ini_set( 'display_errors','1'); 

$username = "kdflint";
$password = "A56L9Q1X";

if (isset($_POST['phone']) && strlen($_POST['phone']) > 0) {
  $phonenum = $_POST['phone'];
  
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
		mail($email, "", "Woo hoo! This is the test message you requested from your Nexus user profile.", "From: contact@northbridgetech.org");		
	}
		
} else {

}

if (isset($_POST['email']) && strlen($_POST['email']) > 0) {
  $email = $_POST['email'];
	
	// TODO: supply a real from address: nexus@northbridgetech.org
	mail($email, "", "Woo hoo! This is the test message you requested from your Nexus user profile.", "From: contact@northbridgetech.org");		
		
} else {

}


header("location:../view/nexus.php?thisPage=profile");
exit(0);

?>