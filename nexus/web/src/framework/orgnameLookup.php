<?php

session_start();

require_once("Util.php");
require_once(Utilities::getSrcRoot() . "/organization/Organization.php");

$term = $_GET[ "term" ];
$networkOrgs = array();

if (Utilities::isSessionValid() && $_SESSION['nexusContext'] != "PUB") {
	$cursor = Organization::getOrganizationsByNetworkId($_SESSION['networkId']);
	while($row = pg_fetch_array($cursor)) {
		if (strtoupper($row['name']) != strtoupper($_SESSION['networkName'])) {
			//$thisOrg = array( "label" => $row['name'], "value" => $row['id']);
			$thisOrg = array( "label" => $row['name'], "value" => $row['name']);
			array_push($networkOrgs, $thisOrg);
		}
	}
}

$result = array();
foreach ($networkOrgs as $org) {
   $orgName = $org[ 'label' ];
   if ( strpos( strtoupper($orgName), strtoupper($term) )!== false ) {
      array_push( $result, $org );
   }
}

echo json_encode( $result );

?>



