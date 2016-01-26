<?php

session_start();

require_once("../src/framework/Util.php");
require_once(Utilities::getSrcRoot() . "/organization/Organization.php");

$viewId = "'mod_event', '0'";
if(isset($_GET['context']) && strlen($_GET['context']) > 0) {
	switch(strtolower($_GET['context'])) {
 		case "directory":
 			$viewId = "'mod_directory', '1'";
 			break;
 		case "forum":
 			$viewId = "'mod_forum', '2'";
 			break;
 		default: 				
	}
}

$cleanNetworkId = "";
if(isset($_GET['oid']) && Organization::validateOrganizationUid($_GET['oid'])) {
 	$cleanNetworkId = $_GET['oid'];	
 	$addView = "false";	
} else {
	echo("unauthorized");
	exit(0);
}

$showConfirm = "false";
$confirmEmail = "";
if(isset($_GET['confirm']) && Utilities::validateEmail($_GET['confirm'])) {
	$showConfirm = "true";
	$confirmEmail = $_GET['confirm'];
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
    
    <script src="../scripts/nexus.js" language="javascript"></script>
  	<script src="../scripts/timeZoneData.js" language="javascript"></script>
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
			.event { width: 80px; padding-right: 8px; }
			.date { font-size: 130%; }
			.organization { font-size: 115%; }
			.meeting { font-size: 90%; padding-left: 8px; }
			.tod { font-size: 90%; }
			.period { font-size: 85%; }
			.instruction { font-size: 95%; }
			.detail { color: #004d62;}
			.scroll { text-align: right; padding-left: 220px; position:absolute; }
			.searchQualifier { vertical-align:15px;font-style:italic;margin-right:3px; }
		</style>

   	<script type="text/javascript">
			$(document).ready(function () {
				toggleDisplay(<?php echo $viewId; ?>);
			});
		</script>
		
		<script> setPublicSession2("<?php echo $cleanNetworkId; ?>", "", "../");</script>

    <script type="text/javascript">
      $(function() {
      	// schedule-form elements
        $( "[id^=datepicker]" ).datepicker({ changeMonth: true, changeYear: true });
      	$( "[id^=schedule-form-time]").selectmenu().selectmenu( "menuWidget" ).addClass( "overflow" );
        $( "#schedule-form-country" ).selectmenu().selectmenu( "menuWidget" ).addClass( "overflow" );
        $( "#schedule-form-country" ).selectmenu({ change: function() { displayTimeZones(); } });
        $( "#schedule-form-countryTimeZones" ).selectmenu();
        $( "#schedule-form-countryTimeZones" ).selectmenu({ change: function() { setTimeZoneDisplay(document.getElementById("schedule-form-countryTimeZones").value); } });
       	$( "[id^=directory-form-select]").selectmenu().selectmenu( "menuWidget" ).addClass( "overflow" );
      });
    </script>
	
		<script>
			
			function toggleDisplay(displayId, selectNdx) {
				document.getElementById("mod_event").style.display='none';
				document.getElementById("mod_directory").style.display='none';
				document.getElementById("mod_forum").style.display='none';
				var list = document.getElementById("navList").getElementsByTagName("li");
				var show = document.getElementById(displayId);
				for (var i = 0; i < list.length; i++) {
					list[i].className = 'pure-menu-item';
				}
				show.style.display='block';
				list[selectNdx].className = 'pure-menu-item pure-menu-selected'; 
			}			
		
			function showEventDetail(eventUuid) {
				document.getElementById("show-add").style.display='none';
				document.getElementById("show-detail").style.display='block';				
				getEventDetail(eventUuid);
			}	
			
			function showEventAdd() {
				document.getElementById("show-add").style.display='block';
				document.getElementById("show-detail").style.display='none';
			}
				
			function scrollEvents(setSize, direction) {
				if (direction == "forward") {
					curViewSet = curViewSet+1;
				} else if (direction == "back") {
					curViewSet = curViewSet-1;
				}	
	
				// Following is compatible with IE8			
				var table = document.getElementById("reservationTable");
				var allRows = [];
				var showRows = [];
				for (var i = 0; i < table.childNodes.length; i++) {
		    	if (table.childNodes[i].className.indexOf("tr-div") > -1) {
	      		allRows.push(table.childNodes[i]);
  	  		}
	    		if (table.childNodes[i].className.indexOf("viewSet" + curViewSet) > -1) {
		      	showRows.push(table.childNodes[i]);
  	  		}
				}			
				//var showRows = document.getElementsByClassName("viewSet" + curViewSet);
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
				
		</script>
		
  </head>
  <body>
 	
		<script>if(<?php echo $showConfirm; ?>) {	alert("Thank you! Your meeting has been submitted for approval.\n\nAn administrator will follow up with you at <?php echo($confirmEmail); ?>"); }</script>
  	 	
		<div style="position:relative;margin:8px;height:460px;">
			<div id="public-suite-nav" style="position:relative;width:100%;height:42px;background-color:#eeeeee;font-size:110%;">
				<div class="pure-menu pure-menu-horizontal">
	    		<ul id="navList" class="pure-menu-list">
	        	<li class="pure-menu-item pure-menu-selected"><a href="#" onclick="toggleDisplay('mod_event', '0')" class="pure-menu-link">Calendar</a></li>
        		<li class="pure-menu-item"><a href="#" onclick="toggleDisplay('mod_directory', '1')" class="pure-menu-link">Directory</a></li>
        		<li class="pure-menu-item"><a href="#" onclick="toggleDisplay('mod_forum', '2')" class="pure-menu-link">Forum</a></li>
        		<!--<div style="cursor:not-allowed;"></div>-->
    			</ul>
				</div>
			</div>

			<?php 
			// On first page load the session may not be ready as it's being accomplished by async ajax call from head
			// If session is not valid or the context is not PUB
			if (!Utilities::isSessionValid() || $_SESSION['nexusContext'] != "PUB") { ?>
				<script> location.reload(); </script>
			<?php } ?>
			
			<div id="mod_event"><?php include(Utilities::getModulesRoot() . "/event/mod_controller.php"); ?></div>
			<div id="mod_directory"><?php include(Utilities::getModulesRoot() . "/directory/mod_controller.php"); ?></div>
			<div id="mod_forum"><?php include(Utilities::getModulesRoot() . "/forum/mod_controller.php"); ?></div>		
		</div>

	</body>
</html>
			
						