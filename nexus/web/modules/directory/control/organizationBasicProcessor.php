<?php

session_start();

require_once("../../../src/framework/Util.php");
require_once(Utilities::getSrcRoot() . "/organization/Organization.php");

// TODO - put authorization checker, session checker, error handling, etc. in a central place. These should go at the top of every processor.

if (!Utilities::isSessionValid()) {
	header("location:" . Utilities::getHttpPath() . "/nexus.php");
	exit(0);
}
									
// Following works, but only populates form values that HAVE a value. Empties do not copy over.
$result = validateOrganization($_POST);

if (count($result['error']) > 0) {
	header('Content-Type: application/json');			
	echo json_encode($result);	
 	exit(0);
}

/* ====================================================

Use only clean input beyond this point (i.e. $clean[])

======================================================= */

$return = array();

$orgid = false;
if (isset($result['clean']['org-id']) && strlen($result['clean']['org-id']) > 0 && $result['clean']['org-id'] === $_SESSION['tmp-editorgid']  && Utilities::isSessionAdmin()) {
	$orgid = Organization::updateOrganizationName($result['clean']['org-id'], $result['clean']['org-name']);
} else {
	$orgid = Organization::getOrganizationByName($result['clean']['org-name']);
	if (!$orgid) {
		$orgid = Organization::addOrganization($result['clean']['org-name'], $_SESSION['networkId']);
		//if (Utilities::isSessionAdmin()) {
			alertAdmin();
		//}
	}
}

if ($orgid) {
	
	$return['org-name'] = $result['clean']['org-name'];
	$return['org-id'] = $orgid;
	
	Organization::addOrganizationContact($orgid, $result['clean']['org-contact-name'], $result['clean']['org-contact-title'], $result['clean']['org-contact-email'], $result['clean']['org-contact-phone'], $result['clean']['org-url']);
	
	Utilities::log("Location update? " . ($result['clean']['isLocUpdate'] ? "yes" : "no"), PEAR_LOG_DEBUG);
	if ($result['clean']['isLocUpdate']) {
		if ($result['clean']['g_status']) {
			Utilities::log($result['clean']['f_address'], PEAR_LOG_DEBUG);
			Organization::addOrganizationLocation($orgid,
				$result['clean']['f_address'],
				"",
				$result['clean']['neighborhood'],
				$result['clean']['city'],
				$result['clean']['county'],
				$result['clean']['state'],
				$result['clean']['country'],
				$result['clean']['postal'],
				$result['clean']['lat'],
				$result['clean']['long'],
				$result['clean']['placeid'] );
		} else {
			Utilities::log("Unformatted address: " . $result['clean']['address1'] . "...", PEAR_LOG_DEBUG);
			Organization::addOrganizationLocation($orgid,
				"",
				$result['clean']['address1'],
				"",
				$result['clean']['city'],
				"",
				$result['clean']['state'],
				$result['clean']['country'],
				"",
				"",
				"",
				"" );		
		}
	}
}
	
if ((session_status() === PHP_SESSION_ACTIVE) && isset($_SESSION['nexusContext'])) {
 switch($_SESSION['nexusContext']) {
 		case "ADV":
			header('Content-Type: application/json');			
			echo json_encode($return);	
 			break;
 		default: 			
 	}
}

function validateOrganization($input) {
	$result = array('clean' => array(), 'error' => array());

	if (isset($input['org-name']) && strlen($input['org-name']) > 0) {
		$result['clean']['org-name'] = $input['org-name'];
	} else {
		$result['error']['org-name'] = "error";
	}

	if (isset($input['org-id'])) {
		$result['clean']['org-id'] = $input['org-id'];
	}
	
	if (isset($input['org-url'])) {
		$result['clean']['org-url'] = $input['org-url'];
	}
	
	if (isset($input['org-contact-name'])) {
		$result['clean']['org-contact-name'] = $input['org-contact-name'];
	}	
	
	if (isset($input['org-contact-title'])) {
		$result['clean']['org-contact-title'] = $input['org-contact-title'];
	}	
	
	if (isset($input['org-contact-phone'])) {
		$result['clean']['org-contact-phone'] = $input['org-contact-phone'];
	}	
	
	if (isset($input['org-contact-email']) && Utilities::validateEmail($input['org-contact-email'])) {
		$result['clean']['org-contact-email'] = $input['org-contact-email'];
	}	else {
		$result['clean']['org-contact-email'] = "";
	}	
	
	$result['clean']['isLocUpdate'] = false;
	$result['clean']['g_status'] = false;
	if (isset($input['org-street']) && strlen($input['org-street']) > 0) {
		$result['clean']['address1'] = $input['org-street'];
		$result['clean']['isLocUpdate'] = true;
	}
	$result['clean']['city'] = $input['org-city'];
	$result['clean']['state'] = $input['org-state'];
	$result['clean']['country'] = $input['org-country'];
	$result['clean']['neighborhood'] = "";
	$result['clean']['county'] = "";
	$result['clean']['postal'] = "";

	
	// https://developers.google.com/maps/documentation/geocoding/intro#GeocodingResponses
	// See above for mapping specification. Other things are possible beside this US-centric mapping
	// See https://maps.googleapis.com/maps/api/geocode/json?address=488%20Thanon%20Srinagarindra%20Tailand&key=AIzaSyD-tLX5TYQhwxQQNx5-UF0VajixUwGGkJQ
	// Notice no locality, but several sublocalities

	if ($result['clean']['isLocUpdate']) {
		$addressString = $result['clean']['address1'] . "," . $result['clean']['city'] . "," . $result['clean']['state'] . "," . $result['clean']['country'];
		Utilities::log($addressString, PEAR_LOG_DEBUG);
	
		$response = file_get_contents('https://maps.googleapis.com/maps/api/geocode/json?address=' . urlencode($addressString) . '&key=' . Utilities::getGoogleApiKey());
		$json = json_decode(utf8_encode($response),true);
		
		if ($json['status'] === "OK") {
			Utilities::log("geocode good", PEAR_LOG_DEBUG);
			$result['clean']['g_status'] = true;
			$result['clean']['lat'] = $json['results'][0]['geometry']['location']['lat'];
    	$result['clean']['long'] = $json['results'][0]['geometry']['location']['lng'];
    	$result['clean']['f_address'] = $json['results'][0]['formatted_address'];
    	$result['clean']['placeid'] = $json['results'][0]['place_id']; 
    	foreach ($json['results'][0]['address_components'] as $address_component) {
	    	foreach ($address_component as $key => $entry) {
    			if ($key === 'types') {
	    			foreach ($entry as $type) {
    					switch($type) {
	    					case "locality": 
    							$result['clean']['city'] = isset($address_component['long_name']) ? $address_component['long_name'] : "";
    							break;
    						case "neighborhood":
	    						$result['clean']['neighborhood'] = isset($address_component['long_name']) ? $address_component['long_name'] : "";
    							break;
    						case "administrative_area_level_1":
	     						$result['clean']['state'] = isset($address_component['long_name']) ? $address_component['long_name'] : "";
    							break;
    						case "administrative_area_level_2": 
	      					$result['clean']['county'] = isset($address_component['long_name']) ? $address_component['long_name'] : "";
    							break;			
    						case "country": 
	      					$result['clean']['country'] = isset($address_component['short_name']) ? $address_component['short_name'] : "";
    							break;		
    						case "postal_code": 
	      					$result['clean']['postal'] = isset($address_component['long_name']) ? $address_component['long_name'] : "";
    							break;	
    					}
    				}
    			}
    		}
    	}
		} else {
			Utilities::log("geocode fail", PEAR_LOG_DEBUG);
			// We default to the pre-assigned user entries for street, city, state, country. No geocoding data persisted.
		}
	}

 	return $result;
	
}

function alertAdmin() {
	$headers = "From: support@northbridgetech.org\r\nBcc: kathy.flint@northbridgetech.org";
	$message = "Hello Administrator,
	
A new organization has just been added to the " . $_SESSION['networkName'] . " Organizational Directory.

You may delete or edit this organization at

" . Utilities::getHttpPath() . "/nexus.php?view=orgid-" . $_SESSION['orgUid'] . "

Sincerely,

Nexus Advantage
on behalf of
" . $_SESSION['networkName'];

	mail(Utilities::getEventApprovalList(), "[Nexus] Directory Organization Add Notification", $message, $headers);
}	


?>