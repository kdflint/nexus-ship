<?php

session_start();

require_once("../src/framework/Util.php");
require_once(Utilities::getSrcRoot() . "/organization/Organization.php");

$cleanNetworkId;
if(isset($_GET['oid']) && Organization::validateOrganizationUid($_GET['oid'])) {
 	$cleanNetworkId = $_GET['oid'];		
} else {
	exit(0);
}

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">
<html>
	
  <head>
  	<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Open+Sans|Oxygen|">
  	<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="../styles/nexus.css" type="text/css" />
    <script src="../scripts/nexus.js" language="javascript"></script>
  	<script src="../scripts/timeZoneData.js" language="javascript"></script>
  	<script src="//cdnjs.cloudflare.com/ajax/libs/jstimezonedetect/1.0.4/jstz.min.js"></script>
  </head>
  
  <style>
  	table { border: 0px !important; margin-bottom: 0px; width: auto; }
		body { min-width:180px; }
		.pure-table td { padding: .5em !important; }
	</style>

  <body>
  	
  	<!-- TODO - check if javascript is supported -->
  	
  	<!-- set php.ini timeout -->
   	
	<?php	
		Utilities::setPublicSession($cleanNetworkId, "America/Chicago");	
		include(Utilities::getModulesRoot() . "/event/mod_controller.php"); 
	?>

	</body>
</html>