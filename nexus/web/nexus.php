<?php 
session_start();

require_once("src/framework/Util.php");

$demoSession = "false";
$disabled = "";

if (isset($_SESSION['demo']) && $_SESSION['demo']) {
	$demoSession = "true";
	$disabled = "disabled";
}

if (!Utilities::isSessionValid()) {
	// TODO - this should consume a sessionManager object
	$orgId="";
	if (isset($_SESSION['orgUid'])) {
		$orgId = $_SESSION['orgUid'];
	}
	if (Utilities::isSessionExpired()) {
		header("location:login.php?oid=" . $orgId . "&logout=true&expired=true");
		exit(0);	
	} else {
		header("location:login.php?oid=" . $orgId . "&logout=true");
		exit(0);	
	}
}

if ($_SESSION['nexusContext'] == "PUB") {
	header("location:login.php?oid=" . $_SESSION['orgUid']);
	exit(0);	
}	

Utilities::setSessionLastActivity();

$showProfile = "false";
$showTeam = "false";
$showFatal = "false";

if(isset($_GET['view']) && Utilities::isSafeCharacterSet($_GET['view'])) {
	switch($_GET['view']) {
		case "profile": $showProfile = "true"; break;
		case "team": $showTeam = "true"; break;
		case "fatal": $showFatal = "true"; break;
	}
}

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">
<html>
	
  <head>
		<!-- TODO - localize all scripts and stylesheets -->
  	<meta http-equiv="Content-type" content="text/html;charset=UTF-8"> 	
		<meta http-equiv="Cache-control" content="no-cache">
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv="Expires" content="0">
		<meta http-equiv="Pragma-directive" content="no-cache">				
		<meta http-equiv="Cache-directive" content="no-cache">				
  	<meta id="meta" name="viewport" content="width=device-width; initial-scale=1.0" />   

	  <link rel="icon" href="images/NB_icon.png" />
  		
  	<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Oswald:400,300|Open+Sans|Oxygen|Swanky+and+Moo+Moo">
  	<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
  	<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
		<link rel="stylesheet" href="//yui.yahooapis.com/pure/0.6.0/pure-min.css">
		<!-- TODO - grids-responsive (below) still used? -->
		<link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.6.0/grids-responsive-min.css">
    <link rel="stylesheet" href="styles/nexus.css" type="text/css" />
    <link rel="stylesheet" href="styles/modal.css" type="text/css" />
    
    <script src="scripts/nexus.js" language="javascript"></script>
  	<script src="<?php echo(Utilities::getConfigPath()); ?>/timeZoneData.js" language="javascript"></script>
  	<!-- http://www.featureblend.com/javascript-flash-detection-library.html -->
 		<script src="scripts/lib/flash_detect.js"></script>
 		<script src="//code.jquery.com/jquery-1.10.2.js"></script>
  	<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
  	<script src="//cdnjs.cloudflare.com/ajax/libs/jstimezonedetect/1.0.4/jstz.min.js"></script>
  	<!-- http://www.pinlady.net/PluginDetect/ -->
  	<script type="text/javascript" src="scripts/lib/javaDetect/scripts/PluginDetect_Java_Simple.js"></script>
  	<!-- http://logomakr.com -->
  	 	
    <title>Northbridge Nexus</title> 
    
    <script type="text/javascript">

			<!-- include in this manner instead of in a meta link so that php code inside this file will resolve prior to runtime -->
    	<?php include("scripts/techCheck.js"); ?>
    	  	
			$(document).ready(function () {
				$( '#schedule_control' ).click(function() {
					//alert("test");
	  			toggleNewEventDisplay();
	  			if (document.getElementById('join_display').style.display != 'none') {
	  				toggleJoinDisplay();
	  			}
	  			if (document.getElementById('tech_check_display').style.display != 'none') {
	  				toggleTechCheckDisplay();
	  			}
				});
				$( '#join_control' ).click(function() {
					toggleJoinDisplay();  			
	  			if (document.getElementById('new_event_display').style.display != 'none') {
	  				toggleNewEventDisplay();
	  			}
				});
				$( '#tech_check_control' ).click(function() {
					toggleTechCheckDisplay();  			
	  			if (document.getElementById('new_event_display').style.display != 'none') {
	  				toggleNewEventDisplay();
	  			}
				});
				$( '#add_user_control' ).click(function() {
	  			$( "#add_user_display" ).toggle( "blind" );
	  			$( "#add_user_control" ).toggle();
				});
				$( '#user_control' ).click(function() {
	  			$( "#user_display" ).toggle( "blind" );
				});
				$( '#profile_control' ).click(function() {
	  			$( "#profile_display" ).toggle( "blind" );
	  			$( "#profile_control_icon" ).toggleClass("fa-caret-down fa-caret-up");
	  			resetProfileForm();		
				});
				if(<?php echo $showProfile; ?>) {
					$( "#profile_control" ).click();
				}
				if(<?php echo $showTeam; ?>) {
					$( "#menu-userList" ).click();
				}	
				if(<?php echo $showFatal; ?>) {
					document.getElementById("reserveList").style.display='none';
					document.getElementById("userList").style.display='none';
					document.getElementById("fatalError").style.display='block';
				}	
				if(<?php echo $demoSession; ?>) {
					document.getElementById("profile_control_icon").className = "";
					document.getElementById("schedule-form-submit").onclick = "";
					document.getElementById("invite-form-submit").onclick = "";
					document.getElementById("index-module-name").innerHTML = "Web Meet Demo";
				}		
			});
			
			function toggleJoinDisplay() {
	  		$( "#join_display" ).toggle( "blind" );
	  		$( "#join_control" ).toggle();
	  	}		
	  	
	  	function toggleNewEventDisplay() {
	  		$( "#new_event_display" ).toggle( "blind" );
	  		$( "#schedule_control" ).toggle();
	  	}
	  	
	  	function toggleTechCheckDisplay() {
	  		$( "#tech_check_display" ).toggle( "blind" );
	  	}
	  		  	
		</script>
    
		<!--================== Schedule Module Meta ==================-->

		<link rel="stylesheet" href="modules/schedule/views/jquery.timepicker.css">
		<script src="modules/schedule/views/jquery.timepicker.js" type="text/javascript"></script>
	
    <style>
      fieldset { border: 0; }
      label { display: block; margin: 30px 0 0 0; }
      select { width: 170px; }
      .overflow { height: 200px; }
    </style>

    <script type="text/javascript">
      $(function() {
      	// schedule-form elements
        $( "#datepicker" ).datepicker({ changeMonth: true, changeYear: true });
        $( "#datepicker-end" ).datepicker({ changeMonth: true, changeYear: true });
      	$( "#schedule-form-time" ).selectmenu().selectmenu( "menuWidget" ).addClass( "overflow" );
      	$( "#schedule-form-time-end" ).selectmenu().selectmenu( "menuWidget" ).addClass( "overflow" );
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
    	var activityFlag = 1;
			document.onmousemove = function() { activityFlag = 1; };
			document.onkeyup = function() { activityFlag = 1; };
			document.onclick = function() { activityFlag = 1; };
			window.setInterval(recordActivity, 60000);
			// every 60 seconds, if there has been user activity then send a request to update the session activity timestamp		
			function recordActivity() {
				if(activityFlag) {
					var xmlhttp = getXmlHttpRequest();
					xmlhttp.onreadystatechange=function() {
	  				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {	}
  				}
					xmlhttp.open("GET","src/framework/sessionManager.php");
					xmlhttp.send();  					
				}
				activityFlag = 0;
			}
    </script>
    
  <!-- For Formilla feedback form -->
  <script type="text/javascript">
    (function () {
        var head = document.getElementsByTagName("head").item(0);
        var script = document.createElement("script");
        var src = (document.location.protocol == 'https:' ? 'https://www.formilla.com/scripts/feedback.js' : 'http://www.formilla.com/scripts/feedback.js');
        script.setAttribute("type", "text/javascript"); script.setAttribute("src", src); script.setAttribute("async", true);
        var complete = false;

        script.onload = script.onreadystatechange = function () {
            if (!complete && (!this.readyState || this.readyState == 'loaded' || this.readyState == 'complete')) {
                complete = true;
                Formilla.guid = 'd94fe060-648d-45c5-9698-2e43d5817798';
                Formilla.loadFormillaChatButton();
            }
        };

        head.appendChild(script);
    })();
  </script>
  
  </head>
  
  <body>
    <div class="container">
      <div class="header">
      	<?php    	
      		if ((session_status() === PHP_SESSION_ACTIVE) && isset($_SESSION['nexusContext'])) {
 						switch($_SESSION['nexusContext']) {
 							case "NWM":
 								include("nwmHeader.php");
 	 							break;
				 			case "ADV":
				 			 	include("advHeader.php");
	 							break;
 							default: 			
 						}
					} 
				?>			     	

      </div>

			<div class="frame" >
      	<?php 
      		if ((session_status() === PHP_SESSION_ACTIVE) && isset($_SESSION['nexusContext'])) {
 						switch($_SESSION['nexusContext']) {
 							case "NWM":
 								include("nwmFrame.php");
 	 							break;
				 			case "ADV":
				 			 	include("advFrame.php");
	 							break;
 							default: 			
 						}
					} 				
				?>
      </div>
      
      <div class="footer">
				<?php 
      		if ((session_status() === PHP_SESSION_ACTIVE) && isset($_SESSION['nexusContext'])) {
 						switch($_SESSION['nexusContext']) {
 							case "NWM":
 								include("nwmFooter.php");
 	 							break;
				 			case "ADV":
				 			 	include("nwmFooter.php");
	 							break;
 							default: 			
 						}
					} 
				?>
			</div>

    </div><!-- container -->       
  	
	</body>
	
</html>

