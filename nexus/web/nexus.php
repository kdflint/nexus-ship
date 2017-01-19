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

if ($_SESSION['nexusContext'] == "ADV") {
	require_once(Utilities::getModulesRoot() . "/forum/forum_integration.php");
	$user->session_begin();
	Utilities::loginForum($user, $auth);
	// Login the user to the forum if there is not already a forum session matching this username
	/*
	if ($user->data['username'] !== $_SESSION['username']) {
		// TODO - how to manage existing and unknown passwords in prod? must auto-enroll at login...
		$forumPassword = ($_SESSION['environment'] === "prod") ? $_SESSION['username'] : $_SESSION['password'];
		$result = $auth->login($_SESSION['username'], $forumPassword);
		$auth->acl($user->data);
		$user->setup();	
		$user->data['user_timezone'] = $clean['tz'];
	}
	*/
}	
	
Utilities::setSessionLastActivity();

$showProfile = "false";
$showTeam = "false";
$showFatal = "false";
$showOrganizationDetail = "false";
$showOrgDetailId = "";

// TODO - add the NWM/ADV check to these
if(isset($_GET['view']) && strlen($_GET['view']) > 0 && Utilities::isSafeCharacterSet($_GET['view'])) {
	switch($_GET['view']) {
		case "profile": $showProfile = "true"; break;
		case "team": $showTeam = "true"; break;
		case "fatal": $showFatal = "true"; break;
		// We have ensured that $_GET['view'] will evaluate to true, that's why below works
		case "orgid":
			echo $_GET['view'];
			echo strpos($_GET['view'], 'orgid-') === 0 ? "true" : "false";
			exit(0);
		case (strpos($_GET['view'], 'orgid-') === 0 ? true : false):
			$showOrganizationDetail = "true"; $showOrgDetailId = substr($_GET['view'], 6);
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
  	<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  	<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
		<link rel="stylesheet" href="//yui.yahooapis.com/pure/0.6.0/pure-min.css">
		<!-- TODO - grids-responsive (below) still used? -->
		<link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.6.0/grids-responsive-min.css">
    <link rel="stylesheet" href="styles/nexus.css" type="text/css" />
    <link rel="stylesheet" href="styles/modal.css" type="text/css" />
       
    <!-- New way to include font awesome - why?? -->
    <!--<script src="https://use.fontawesome.com/2eef5e944e.js"></script>-->
    <script src="scripts/nexus.js" language="javascript"></script>
  	<script src="<?php echo(Utilities::getConfigPath()); ?>/timeZoneData.js" language="javascript"></script>
  	<script src="<?php echo(Utilities::getConfigPath()); ?>/geoDataCfcht.js" language="javascript"></script>
  	<script src="<?php echo(Utilities::getConfigPath()); ?>/stateData.js" language="javascript"></script>
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
		
    	// TODO - create a global js init script - can format this as a php file that parses into javascript, look for example...
			DEFAULT_FORUM = "<?php echo $_SESSION['defaultForumId']; ?>";
			HTTP_WEB_PATH = "<?php echo Utilities::getHttpPath(); ?>";
			HTTP_FORUM_PATH = "<?php echo Utilities::getForumHttpPath(); ?>";

			<!-- include in this manner instead of in a meta link so that php code inside this file will resolve prior to runtime -->
    	<?php include("scripts/techCheck.js"); ?>
    	  	
			$(document).ready(function () {
				$( '#schedule_control' ).click(function() {
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
	  			$( "#profile_control_icon" ).toggleClass("fa-minus-square");
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
					document.getElementById("training-register1").href = "javascript:void(0)";
					document.getElementById("training-register2").href = "javascript:void(0)";
					document.getElementById("training-register1").setAttribute("target", "");
					document.getElementById("training-register2").setAttribute("target", "");
					document.getElementById("index-module-name").innerHTML = "Web Meet Demo";
					document.getElementById("get-nexus-link").innerHTML = "<a href='http://northbridgetech.org/apps/waterwheel/module/core/index.php?view=apply' target='_blank'>Get Nexus</a>";
				}		
				
				if(<?php echo $showOrganizationDetail; ?>) {
					$( "#adv-menu-network" ).click();
					showDirectoryDetail("<?php echo $showOrgDetailId; ?>");	
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
        $( "#now-form-duration" ).selectmenu();
        $( "#now-form-type" ).selectmenu();
        $( "#directory-form-select-specialty").selectmenu().selectmenu( "menuWidget" ).addClass( "overflow" );
       	$( "#directory-form-select-type").selectmenu().selectmenu( "menuWidget" ).addClass( "overflow" );
       	$( "#organization-form-country" ).selectmenu().selectmenu( "menuWidget" ).addClass( "overflow" );
        $( "#organization-form-country" ).selectmenu({ change: function() { displayStates(); } });
        $( "#organization-form-countryStates" ).selectmenu().selectmenu( "menuWidget" ).addClass( "overflow" );
      });
    </script> 
       
    <script>  	
			document.onmousemove = function() { ACTIVITY_FLAG = 1; };
			document.onkeyup = function() { ACTIVITY_FLAG = 1; };
			document.onclick = function() { ACTIVITY_FLAG = 1; };
			window.setInterval(recordActivity, 60000);
			// every 60 seconds, if there has been user activity then send a request to update the session activity timestamp		
			function recordActivity() {
				if(ACTIVITY_FLAG) {
					var xmlhttp = getXmlHttpRequest();
					xmlhttp.onreadystatechange=function() {
	  				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {	}
  				}
					xmlhttp.open("GET","src/framework/sessionManager.php");
					xmlhttp.send();  					
				}
				ACTIVITY_FLAG = 0;
			}
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
      </div>
    </div><!-- container -->       

  <?php 
  	if ((session_status() === PHP_SESSION_ACTIVE) && isset($_SESSION['nexusContext'])) {
 			switch($_SESSION['nexusContext']) {
				case "ADV":
				 	include("advModals.php");
	 				break;
 				default: 			
 				}
			} 				
	?>

	<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD-tLX5TYQhwxQQNx5-UF0VajixUwGGkJQ" async defer></script>

	<script>
		var stateObj = { foo: "bar" };
		history.pushState(stateObj, "", "nexus.php#close");
	</script>
	
	</body>
	
</html>

