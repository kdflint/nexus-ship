<?php 

require_once("src/framework/Util.php");
require_once(Utilities::getModulesRoot() . "/forum/forum_integration.php");

session_start();
$user->session_begin();

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
}	

Utilities::setSessionLastActivity();

$showProfile = "false";
$showProfileAdv = "false";
$showTeam = "false";
$showFatal = "false";
$showNetwork = "false";
$showOrganizationDetail = "false";
$showAdvProfile = "false";
$showAdvIm = "false";
$showOrgDetailId = "";
$showAdvProfileUsername = "";
$showAdvImUsername = "";
$showOrganizationEditBasic = "false";
$showOrgEditDetailId = "";

// TODO - add the NWM/ADV check to these
if(isset($_GET['view']) && strlen($_GET['view']) > 0 && Utilities::isSafeCharacterSet($_GET['view'])) {
	switch($_GET['view']) {
		case "profile": $showProfile = "true"; break;
		case "team": $showTeam = "true"; break;
		case "fatal": $showFatal = "true"; break;
		case "network": $showNetwork = "true"; break;
		// We have ensured that $_GET['view'] will evaluate to true, that's why below is viable
		case (strpos($_GET['view'], 'orgid-') === 0 ? true : false):
			$showOrganizationDetail = "true"; $showOrgDetailId = substr($_GET['view'], 6);
		case (strpos($_GET['view'], 'orgeditid-') === 0 ? true : false):
			$showOrganizationEditBasic = "true"; $showOrgEditDetailId = substr($_GET['view'], 10);
		case (strpos($_GET['view'], 'profileuser-') === 0 ? true : false):
			$showAdvProfile = "true"; $showAdvProfileUsername = substr($_GET['view'], 12);		
		case (strpos($_GET['view'], 'imuser-') === 0 ? true : false):
			$showAdvIm = "true"; $showAdvImUsername = substr($_GET['view'], 7);		
	}
}

$zeroOrgs = "false";
if (count($_SESSION['orgs']) < 1) {
		$zeroOrgs = "true";
}	

$isAdmin = "false";
if (Utilities::isSessionAdmin()) {
	$isAdmin = "true";
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
    <!--<link rel="stylesheet" href="//cdn.datatables.net/1.10.13/css/jquery.dataTables.min.css" type="text/css" />-->
    <!-- LEFT OFF - lost arrows - I think they are white -->
		<!--<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.13/r-2.1.1/rr-1.2.0/datatables.min.css"/>		-->

    <link rel="stylesheet" href="styles/datatables.css" type="text/css" />

    <!-- New way to include font awesome - why?? -->
    <!--<script src="https://use.fontawesome.com/2eef5e944e.js"></script>-->
    <script src="scripts/nexus.js" language="javascript"></script>
  	<script src="<?php echo(Utilities::getConfigPath()); ?>/timeZoneData.js" language="javascript"></script>
  	<script src="<?php echo(Utilities::getConfigPath()); ?>/geoDataCfcht.js" language="javascript"></script>
  	<script src="<?php echo(Utilities::getConfigPath()); ?>/stateData.js" language="javascript"></script>
  	<!-- http://www.featureblend.com/javascript-flash-detection-library.html -->
 		<script src="scripts/lib/flash_detect.js"></script>
 		<!--<script src="//code.jquery.com/jquery-1.10.2.js"></script>-->
 		<script src="//code.jquery.com/jquery-1.12.4.js"></script>
  	<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
  	<script src="//cdnjs.cloudflare.com/ajax/libs/jstimezonedetect/1.0.4/jstz.min.js"></script>
  	<!-- http://www.pinlady.net/PluginDetect/ -->
  	<script type="text/javascript" src="scripts/lib/javaDetect/scripts/PluginDetect_Java_Simple.js"></script>
  	<!-- https://plugins.jquery.com/cookie/ -->
  	<script src="scripts/lib/jquery.cookie.js" language="javascript"></script>
  	<!-- http://logomakr.com -->
  	<!-- https://datatables.net -->
		<script type="text/javascript" src="//cdn.datatables.net/1.10.13/js/jquery.dataTables.min.js" charset="utf8"></script>
		<!--<script type="text/javascript" src="//cdn.datatables.net/v/dt/dt-1.10.13/b-1.2.4/datatables.min.js"></script>-->
		<!--<script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.10.13/b-1.2.4/se-1.2.0/datatables.min.js"></script>-->

  	 	 	
    <title>Northbridge Nexus</title> 

    <script type="text/javascript">
		
    	// TODO - create a global js init script - can format this as a php file that parses into javascript, look for example...
			NETWORK_ID = "<?php echo $_SESSION['networkId']; ?>";
			DEFAULT_FORUM = "<?php echo $_SESSION['defaultForumId']; ?>";
			HTTP_WEB_PATH = "<?php echo Utilities::getHttpPath(); ?>";
			HTTP_FORUM_PATH = "<?php echo Utilities::getForumHttpPath(); ?>";
			HTTP_PARTNER_FILE_PATH = "<?php echo Utilities::getPartnerFileUrl(); ?>";
			FORUM_SESSION_REFRESH_COUNTER = 0;
			INBOX_FOCUS = DEFAULT_INBOX_FOCUS;
			RECIPIENT_LIST = [];
			ZERO_ORGS = <?php echo $zeroOrgs; ?>;
			
			<!-- include in this manner instead of in a meta link so that php code inside this file will resolve prior to runtime -->
    	<?php include("scripts/techCheck.js"); ?>
    	  	
			$(document).ready(function () {	
								
				if ( $.cookie('nexusadv_lastvisit') !== 'undefined' ) {
					loadPreviousTab($.cookie('nexusadv_lastvisit'));
				} else {
					// default view implemented by tab style load settings
				}
				
				$( "#organization-name-autocomplete" ).autocomplete({
					source: "<?php echo(Utilities::getHttpPath()); ?>/src/framework/orgnameLookup.php",
					minLength: 3,
        });
										
				$('#group-list-table-rows').on( 'click', 'tr', function (event) {
    			if (event.target.type !== 'checkbox') {
    				$(':checkbox', this).trigger('click');
    			} else if ($(':checkbox', this).prop('checked')==true) {
						var keyval = $(':checkbox', this).val().split("::");
						if (keyval.length == 2) {
							var dto = new Object();	
							dto.username = keyval[0];
							dto.fullname = keyval[1];	
							RECIPIENT_LIST.push(dto);	
	  				}    	
			    } else {
						var keyval = $(':checkbox', this).val().split("::");
						if (keyval.length == 2) {
				    	RECIPIENT_LIST.splice( RECIPIENT_LIST.indexOf(keyval[0]), 1 );
			    	}
		    	}
				} );
				
				$('#org-list-table-rows').on( 'click', 'tr', function (event) {
					showDirectoryDetail(ORG_TABLE.row( this ).data()[0], "ADV")
				} );
				
				$('#datatable-input').on( 'keyup', function () {
					filterMemberTable(this.value);
				} );
				
				$('#compose_pm').click( function() {
         	document.getElementById("recipient-dto").innerHTML = JSON.stringify(RECIPIENT_LIST);
        	document.getElementById("inbox-mode").innerHTML = "compose";
					$( "#adv-menu-inbox" ).click();	
    		} );		
						
				$('#add_to_group').click( function() {
					document.getElementById("selected-user-count").innerHTML = RECIPIENT_LIST.length;
    		} );
    		
				$('#remove_from_group').click( function() {
					document.getElementById("selected-user-count-2").innerHTML = RECIPIENT_LIST.length;
    		} );
				
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
    			$( "#adv-menu-profile" ).click();
				}
				if(<?php echo $showTeam; ?>) {
					$( "#menu-userList" ).click();
				}	
				if(<?php echo $showFatal; ?>) {
					document.getElementById("reserveList").style.display='none';
					document.getElementById("userList").style.display='none';
					document.getElementById("fatalError").style.display='block';
				}	
				if(<?php echo $showNetwork; ?>) {
					$( "#adv-menu-network" ).click();
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
				if(<?php echo $showOrganizationEditBasic; ?>) {
					showDirectoryEditBasic("<?php echo $showOrgEditDetailId; ?>");	
				}			
				if(<?php echo $showOrganizationDetail; ?>) {
					$( "#adv-menu-network" ).click();
					showDirectoryDetail("<?php echo $showOrgDetailId; ?>", "NWM");	
				}
				if(<?php echo $showAdvProfile; ?>) {
					showAdvProfile("<?php echo($showAdvProfileUsername); ?>");
				}
				if(<?php echo $showAdvIm; ?>) {
					INBOX_FOCUS = "/ucp.php?i=pm&mode=compose&username=<?php echo($showAdvImUsername); ?>";
					$( "#adv-menu-inbox" ).click();					
				}
				if (<?php echo $isAdmin; ?>) {
					// TODO - this is far from perfect! Keep working on it...
					showPriv1();
				} else {
					hidePriv1();
				}
				
				switchToOrganizationView();	
				
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
	  	
		  $(function() {
    		var tooltips = $( "#profile-form :input" ).tooltip({
      		position: {
        		my: "left top",
        		at: "right+5 top-5"
      		},
      		effect: "fade"
    		});    
  		});

			// We call these initialization when ajax delivery of initial table contents is complete
			function initMemberTable() {
				MEMBER_TABLE = $('#member-directory').DataTable( {
					"retrieve": true,
					"pageLength": 10,
					"lengthChange": false,
					"order": [[2, 'asc']],
					"dom": 'tip',
					"columns": [
	   				{ "orderable": false },
   					{ "orderable": false },
   					null,
   					null
					]
				} );
			}
			
			function initOrgMemberTable() {
				ORG_MEMBER_TABLE = $('#org-member-directory').DataTable( {
					"retrieve": true,
					"pageLength": 5,
					"lengthChange": false,
					"searching": false,
					"order": [[1, 'asc']],
					"columns": [
   					null,
   					null,
   					{ "orderable": false }
					]
				} );
			}
			
			function initOrgTable() {
				ORG_TABLE = $('#org-directory').DataTable( {
					"retrieve": true,
					"pageLength": 10,
					"lengthChange": false,
					"searching": false,
					"info": true,
					"order": [[1, 'asc']],
 				  "columnDefs": [
    				{ "visible": false, "targets": 0 }
  				]
				} );
			}
			
			function filterMemberTable(term) {
				if (MEMBER_TABLE) {
					MEMBER_TABLE.search( term ).draw();
				}
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
      .overflow-tall { height: 320px; }
    </style>

    <script type="text/javascript">
      $(function() {
      	// schedule-form elements
        $( "#datepicker" ).datepicker({ changeMonth: true, changeYear: true });
        $( "#datepicker-end" ).datepicker({ changeMonth: true, changeYear: true });
        $( "#now-form-duration" ).selectmenu();
        $( "#now-form-type" ).selectmenu();
      	$( "#schedule-form-time" ).selectmenu().selectmenu( "menuWidget" ).addClass( "overflow" );
      	$( "#schedule-form-time-end" ).selectmenu().selectmenu( "menuWidget" ).addClass( "overflow" );
        $( "#schedule-form-duration" ).selectmenu();
        $( "#schedule-form-type" ).selectmenu();
        $( "#schedule-form-country" ).selectmenu().selectmenu( "menuWidget" ).addClass( "overflow" );
        $( "#schedule-form-country" ).selectmenu({ change: function() { displayTimeZones(); } });
        $( "#schedule-form-countryTimeZones" ).selectmenu();
        $( "#schedule-form-countryTimeZones" ).selectmenu({ change: function() { setTimeZoneDisplay(document.getElementById("schedule-form-countryTimeZones").value); } });
        $( "#directory-form-select-specialty").selectmenu().selectmenu( "menuWidget" ).addClass( "overflow-tall" );
       	$( "#directory-form-select-specialty").selectmenu().selectmenu({
						position: { my : "left+50 top", at: "right top-85" },
						width: 228
				});
       	$( "#directory-form-select-type").selectmenu().selectmenu( "menuWidget" ).addClass( "overflow-tall" );
       	$( "#directory-form-select-type").selectmenu().selectmenu({
						position: { my : "left+50 top", at: "right top-135" },
						width: 228
				});
       	$( "#directory-form-select-type-in").selectmenu();
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

                            
<script type="text/javascript">
    (function () {
        var head = document.getElementsByTagName("head").item(0);
        var script = document.createElement("script");
        
        var src = (document.location.protocol == 'https:' 
            ? 'https://www.formilla.com/scripts/feedback.js' 
            : 'http://www.formilla.com/scripts/feedback.js');
        
        script.setAttribute("type", "text/javascript"); 
        script.setAttribute("src", src); script.setAttribute("async", true);        

        var complete = false;
        
        script.onload = script.onreadystatechange = function () {
            if (!complete && (!this.readyState 
                    || this.readyState == 'loaded' 
                    || this.readyState == 'complete')) {
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
		if(window.location.hash) {
			// In everything but FF, a processor return "location:" value that uses a hash to display a modal 
			// gets ignored for some reason due to history pushState. Not sure why, but this is an example 
			// of what doesn't work, from organizationRemoveProcessor.php: 
			// header("location:" . Utilities::getHttpPath() . "/nexus.php#openOrganizationName");
			// What we want is response to reveal that modal, but it doesn't
			// So we only pushState when location url does not contain a hash value
		} else {
			// In general we do this to eliminate confusion because this is such a js driven site, back button 
			// feels arbitrary and unintuitive. Revisit at some point... 
			history.pushState(stateObj, "", "nexus.php#close");
		}

	</script>
	
	</body>
	
</html>

