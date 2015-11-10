<?php

session_start();

require_once("../src/framework/Util.php");
require_once(Utilities::getSrcRoot() . "/organization/Organization.php");

$addView = "false";
if(isset($_GET['view']) && $_GET['view'] == "add") {
 	if (Utilities::isSessionValid()) {
 		$addView = "true";
 	}	
}

$cleanNetworkId = "";
if(isset($_GET['oid']) && Organization::validateOrganizationUid($_GET['oid'])) {
 	$cleanNetworkId = $_GET['oid'];	
 	$addView = "false";	
} else if (Utilities::isSessionValid()) {
	$cleanNetworkId = $_SESSION['orgUid'];
} else {
	echo("unauthorized");
	exit(0);
}

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">
<html>
	
  <head>
  	<meta http-equiv="Content-type" content="text/html;charset=UTF-8">
  	
  	<link rel="stylesheet" href="//fonts.googleapis.com/css?family=Open+Sans|Oxygen|">
  	<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
   	<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
		<link rel="stylesheet" href="//yui.yahooapis.com/pure/0.6.0/pure-min.css">
    <link rel="stylesheet" href="../styles/nexus.css" type="text/css" />
		<link rel="stylesheet" href="../modules/schedule/views/jquery.timepicker.css">
    
    <script src="../scripts/nexus.js" language="javascript"></script>
  	<script src="../scripts/timeZoneData.js" language="javascript"></script>
		<script src="../modules/schedule/views/jquery.timepicker.js" language="javascript"></script>
  	<script src="//cdnjs.cloudflare.com/ajax/libs/jstimezonedetect/1.0.4/jstz.min.js" language="javascript"></script>
 		<script src="//code.jquery.com/jquery-1.10.2.js" language="javascript"></script>
  	<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js" language="javascript"></script>
  	
    <style>
      fieldset { border: 0; }
      label { display: block; margin: 30px 0 0 0; }
      select { width: 170px; }
      .overflow { height: 200px; }
    </style>
  
  <style>
  	table { border: 0px !important; margin-bottom: 0px; width: auto; }
		body { min-width: 215px; min-height: 440px;}
		.pure-table td { padding: 10px 0px !important; }
		.pure-table td:first-child { width: auto; }
		.event { width: auto; padding-right: 8px; }
		.date { font-size: 130%; }
		.meeting { font-size: 90%; padding-left: 8px; }
		.tod { font-size: 90%; }
		.period { font-size: 85%; }
		.instruction { font-size: 95%; }
		.scroll { text-align: right; padding-left: 195px; position:absolute; }
	</style>


    <script type="text/javascript">
      $(function() {
      	// schedule-form elements
        $( "#datepicker" ).datepicker({ changeMonth: true, changeYear: true });
      	$( "#schedule-form-time" ).selectmenu().selectmenu( "menuWidget" ).addClass( "overflow" );
        $( "#schedule-form-duration" ).selectmenu();
        $( "#schedule-form-type" ).selectmenu();
        $( "#schedule-form-country" ).selectmenu().selectmenu( "menuWidget" ).addClass( "overflow" );
        $( "#schedule-form-country" ).selectmenu({ change: function() { displayTimeZones(); } });
        $( "#schedule-form-countryTimeZones" ).selectmenu();
        $( "#schedule-form-countryTimeZones" ).selectmenu({ change: function() { setTimeZoneDisplay(document.getElementById("schedule-form-countryTimeZones").value); } });
        // now-form elements
        $( "#now-form-duration" ).selectmenu();
        $( "#now-form-type" ).selectmenu();
      });
    </script>
	
	<script>
			
		function scrollEvents(setSize, direction) {
			if (direction == "forward") {
				curViewSet = curViewSet+1;
			} else if (direction == "back") {
				curViewSet = curViewSet-1;
			}	
			var allRows = document.getElementById("reservationTable").rows;
			var showRows = document.getElementsByClassName("viewSet" + curViewSet);
			for (i = 0; i < allRows.length; i++) { allRows[i].style.display = "none"; }
			for (i = 0; i < showRows.length; i++) { showRows[i].style.display = "block"; }
			// viewSet starts count at 0
			x = Math.ceil(allRows.length/setSize)
			var upDisplayValue, downDisplayValue;
			if (curViewSet <= 0) {
				if (x <= 1) {
					upDisplayValue = downDisplayValue = "none";
				} else {
					upDisplayValue = "none";
					downDisplayValue = "block";
				}
			} else {
				if (x > curViewSet+1) {
					upDisplayValue = downDisplayValue = "block";
				} else if (x <= curViewSet+1) {
					upDisplayValue = "block";
					downDisplayValue = "none";
				}
			}					
			document.getElementById("eventUpControl").style.display = upDisplayValue;
			document.getElementById("eventDownControl").style.display = downDisplayValue;
		}
		
		function setPublicSession() {
			var xmlhttp = new XMLHttpRequest();
			xmlhttp.onreadystatechange=function() {
				if (xmlhttp.readyState == 4) {
					if (xmlhttp.status != 200) { /* do something? */ }
				}
			}
			xmlhttp.open("GET", "<?php echo(Utilities::getHttpPath()); ?>" + "/plugin/setPublicSession.php?oid=" + "<?php echo($cleanNetworkId); ?>" + "&timezone=" + getLocalTz());
			xmlhttp.send();
		}

		function toggleDisplay(displayId) {
			document.getElementById("show-event").style.display='none';
			document.getElementById("show-detail").style.display='none';
			document.getElementById("add-event").style.display='none';
			document.getElementById(displayId).style.display='block';
		}			
		
		function showEventDetail(eventUuid) {
			getEventDetail(eventUuid);
			toggleDisplay("show-detail");
		}	
				
	</script>

   <script type="text/javascript">
		$(document).ready(function () {
			if(<?php echo $addView; ?>) {
				toggleDisplay("add-event");
			}
		});
	</script>
  
  </head>
  <body>
 	
  	<!-- TODO - check if javascript is supported -->
  	
  	<!-- set php.ini timeout? -->

	<script> setPublicSession(); </script>
   	
	<div id="show-event" style="display:block;">
		<?php	
			// Block until we have a valid session. Wait 10 seconds then bail. 	
			$timer = 0;
			while (!Utilities::isSessionValid() && $timer < 10) { sleep(1); $timer++; }
			include(Utilities::getModulesRoot() . "/event/mod_controller.php"); 
		?>
	</div>
	
	<div id="add-event" style="display:none;">
		<span style="text-align:center">
			<img src="<?php echo(Utilities::getPartnerImageRoot()); ?><?php echo $_SESSION['logo']; ?>" />
			Use this form to submit a new event to the <?php echo($_SESSION['networkName']); ?> public calendar.
		</span>
		<?php include(Utilities::getModulesRoot() . "/event/views/eventAdd.php"); ?>
	</div>
	
	<div id="show-detail" style="display:none;">
		<?php include(Utilities::getModulesRoot() . "/event/views/eventDetail.php"); ?>
	</div>
	
	</body>
</html>