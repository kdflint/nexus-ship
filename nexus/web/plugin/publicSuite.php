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
		<link rel="stylesheet" href="//yui-s.yahooapis.com/pure/0.6.0/pure-min.css">
    <link rel="stylesheet" href="../styles/nexus.css" type="text/css" />
    
    <script src="../scripts/nexus.js" language="javascript"></script>
  	<script src="<?php echo(Utilities::getConfigPath()); ?>/timeZoneData.js" language="javascript"></script>
  	<!-- Following is temporary - remove when directory refresh is done. Also remove from directoryDetail view -->
  	<script src="<?php echo(Utilities::getConfigPath()); ?>/cfchtOrgEditLinks.js" language="javascript"></script>
  	<script src="../../config/geoDataCfcht.js" language="javascript"></script>
  	<script src="//cdnjs.cloudflare.com/ajax/libs/jstimezonedetect/1.0.4/jstz.min.js" language="javascript"></script>
 		<script src="//code.jquery.com/jquery-1.10.2.js" language="javascript"></script>
  	<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js" language="javascript"></script>
 	  	
    <style>
      fieldset { border: 0; }
      label { display: block; margin: 30px 0 0 0; }
      select { width: 170px; }
      .overflow { height: 366px; }
      .overflow-short { height: 200px; }
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
			.searchQualifier { vertical-align: 15px; font-style: italic; margin-right: 3px; }
			.pure-menu-link { padding: .5em .8em; };			
		</style>

   	<script type="text/javascript">
			$(document).ready(function() {
        $( "[id^=datepicker]" ).datepicker({ changeMonth: true, changeYear: true });
      	$( "#schedule-form-time").selectmenu().selectmenu( "menuWidget" ).addClass( "overflow-short" );
      	$( "#schedule-form-time-end").selectmenu().selectmenu( "menuWidget" ).addClass( "overflow-short" );
        $( "#schedule-form-duration" ).selectmenu();
        $( "#schedule-form-country" ).selectmenu().selectmenu( "menuWidget" ).addClass( "overflow" );
        $( "#schedule-form-country" ).selectmenu({ change: function() { displayTimeZones(); } });
        $( "#schedule-form-countryTimeZones" ).selectmenu();
        $( "#schedule-form-countryTimeZones" ).selectmenu({ change: function() { setTimeZoneDisplay(document.getElementById("schedule-form-countryTimeZones").value); } });
       	$( "#directory-form-select-specialty").selectmenu().selectmenu( "menuWidget" ).addClass( "overflow" );
       	$( "#directory-form-select-specialty").selectmenu().selectmenu({
						position: { my : "left top", at: "right+25 top", of: "#directory-form" },
						width: 228
				});
       	$( "#directory-form-select-type").selectmenu().selectmenu( "menuWidget" ).addClass( "overflow" );
       	$( "#directory-form-select-type").selectmenu().selectmenu({
						position: { my : "left top", at: "right+25 top", of: "#directory-form" },
						width: 228
				});
        $( "#directory-form-select-affiliation").selectmenu().selectmenu( "menuWidget" ).addClass( "overflow" );
       	$( "#directory-form-select-affiliation").selectmenu().selectmenu({
						position: { my : "left top", at: "right+25 top", of: "#directory-form" },
						width: 228
				});
				toggleDisplay(<?php echo $viewId; ?>);
			});
		</script>
		
		<script> setPublicSession2("<?php echo $cleanNetworkId; ?>", "", "../");</script>

		<script>
							
			function toggleDisplay(displayId, selectNdx) {
				// page content
				document.getElementById("mod_event").style.display='none';
				document.getElementById("mod_directory").style.display='none';
				document.getElementById("mod_forum").style.display='none';
				var show = document.getElementById(displayId);
				show.style.display='block';
				// navigation
				var list = document.getElementById("navList").getElementsByTagName("li");
				for (var i = 0; i < list.length; i++) {
					list[i].className = 'pure-menu-item';
				}
				list[selectNdx].className = 'pure-menu-item pure-menu-selected'; 
				if (displayId === 'mod_directory') {
					document.getElementById('directory-form-submit').click();
				}
			}			
		
			function showEventDetail(eventUuid) {
				document.getElementById("show-add").style.display='none';
				document.getElementById("show-detail").style.display='block';				
				document.getElementById("show-event").style.display='block';				
				getEventDetail(eventUuid);
			}	
			
			function showEventAdd() {
				document.getElementById("show-add").style.display='block';
				document.getElementById("show-detail").style.display='none';
				document.getElementById("show-event").style.display='none';				
				toggleDisplay('mod_event', '0');
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
				
			function getDirectoryIconSize() {
				return "3x";
			}

		</script>
		
  </head>
  <body>
 	
		<script>if(<?php echo $showConfirm; ?>) {	alert("Thank you! Your meeting has been submitted for approval.\n\nAn administrator will follow up with you at <?php echo($confirmEmail); ?>"); }</script>
  	 	
		<div style="position:relative;margin:8px;height:460px;">
			<div id="public-suite-nav" style="position:relative;width:100%;height:42px;background-color:#eeeeee;font-size:100%;border-radius:8px;">
				<div class="pure-menu pure-menu-horizontal">
	    		<ul id="navList" class="pure-menu-list">
	        	<li class="pure-menu-item pure-menu-selected"><a href="#" onclick="toggleDisplay('mod_event', '0');document.getElementById('schedule-form-cancel').click();" class="pure-menu-link">Calendar</a></li>
        		<li class="pure-menu-item"><a href="#" onclick="toggleDisplay('mod_directory', '1')" class="pure-menu-link">Directory</a></li>
        		<li class="pure-menu-item"><a href="#" onclick="toggleDisplay('mod_forum', '2')" class="pure-menu-link">Forum</a></li>
        		<li class="pure-menu-item"><a id="schedule_control" href="#" onclick="showEventAdd();" class="pure-menu-link">Submit New Event</a></li>
        		<?php if ($_SESSION['username'] === "pUser-ed787a92" || $_SESSION['environment'] === "local") { 
        			//https://goo.gl/forms/NInSncEodzNEMo2G3https://goo.gl/forms/NInSncEodzNEMo2G3
        			?>
        			<li class="pure-menu-item"><a id="schedule_control" class="pure-menu-link" href="<?php echo(Utilities::getHttpPath()); ?>/nexus.php?view=profile" onclick="return confirm('To add a new organization to our directory, please visit\nyour Nexus Advantage profile and click on New Organization.\n\nDo you wish to visit Nexus Advantage?');" target="_blank">Submit New Organization</a></li>
        		<?php } ?>
						<?php if (isset($_SESSION['publicEnrollUuid'])) { ?>
							<li class="pure-menu-item"><a id="schedule_control" href="<?php echo(Utilities::getHttpPath()); ?>/enroll.php?invitation=<?php echo($_SESSION['publicEnrollUuid']); ?>" class="pure-menu-link" target="_blank" style="color:#d27b4b;">Enroll in Nexus</a></li>
						<?php } ?>
						<li class="pure-menu-item"><a id="schedule_control" href="<?php echo(Utilities::getHttpPath()); ?>/login.php?oid=<?php echo($_SESSION['orgUid']); ?>" class="pure-menu-link" target="_blank" style="color:#d27b4b;">Login to Nexus</a></li>	
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

		<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD-tLX5TYQhwxQQNx5-UF0VajixUwGGkJQ" async defer></script>
		
	</body>
</html>
			
						