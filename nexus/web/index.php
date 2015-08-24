<?php 
session_start();

require_once("src/framework/Util.php");

if (!Util::isSessionValid()) {
	// TODO - this should consume a sessionManager object
	if (Util::isSessionExpired()) {
		header("location:login.php?oid=" . $_SESSION['orgId'] . "&logout=true&expired=true");
		exit(0);	
	} else {
		header("location:login.php?oid=" . $_SESSION['orgId'] . "&logout=true");
		exit(0);	
	}
}

Util::setSessionLastActivity();

$showProfile = "false";

if(isset($_GET['view']) && Util::isSafeCharacterSet($_GET['view'])) {
	switch($_GET['view']) {
		case "profile": $showProfile = "true";
	}
}

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">
<html>
	
  <head>
		<!-- TODO - localize all scripts and stylesheets -->
  	<meta http-equiv="Content-type" content="text/html;charset=UTF-8">
  	<meta id="meta" name="viewport" content="width=device-width; initial-scale=1.0" />   	
  	<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Oswald:400,300|Open+Sans|Oxygen|Swanky+and+Moo+Moo">
  	<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
  	<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
		<link rel="stylesheet" href="//yui.yahooapis.com/pure/0.6.0/pure-min.css">
		<link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.6.0/grids-responsive-min.css">
    <link rel="stylesheet" href="styles/nexus.css" type="text/css" />
    <script src="scripts/nexus.js" language="javascript"></script>
  	<script src="scripts/timeZoneData.js" language="javascript"></script>
 		<script src="//code.jquery.com/jquery-1.10.2.js"></script>
  	<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>  
  	<script src="//cdnjs.cloudflare.com/ajax/libs/jstimezonedetect/1.0.4/jstz.min.js"></script>
	  <link rel="icon" href="images/NB_icon.png" />
    <title>Northbridge Nexus</title> 
    
    <script type="text/javascript">
			$(document).ready(function () {
				$( '#schedule_control' ).click(function() {
	  			toggleNewEventDisplay();
	  			if (document.getElementById('join_display').style.display != 'none') {
	  				toggleJoinDisplay();
	  			}
				});
				$( '#join_control' ).click(function() {
					toggleJoinDisplay();  			
	  			if (document.getElementById('new_event_display').style.display != 'none') {
	  				toggleNewEventDisplay();
	  			}
				});
				$( '#add_user_control' ).click(function() {
	  			$( "#add_user_display" ).toggle( "blind" );
	  			$( "#add_user_control" ).toggle();
				});
				$( '#techcheck_control' ).click(function() {
	  			$( "#techcheck_display" ).toggle( "blind" );
				});
				$( '#user_control' ).click(function() {
	  			$( "#user_display" ).toggle( "blind" );
				});
				$( '#profile_control' ).click(function() {
	  			$( "#profile_display" ).toggle( "blind" );
				});
				if(<?php echo $showProfile; ?>) {
					$( "#user_display" ).toggle( "blind" );
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
	  	
		</script>
    
		<!--================== Schedule Module Meta ==================-->

		<link rel="stylesheet" href="modules/schedule/views/jquery.timepicker.css">
		<script src="modules/schedule/views/jquery.timepicker.js" type="text/javascript"></script>
	
    <style>
      fieldset {
        border: 0;
      }
      label {
        display: block;
        margin: 30px 0 0 0;
      }
      select {
        width: 170px;
      }
      .overflow {
        height: 200px;
      }
    </style>

    <script type="text/javascript">
      $(function() {
        $( "#datepicker" ).datepicker({
          changeMonth: true,
          changeYear: true
        });
      });
      $(function() {
        $( "#schedule-form-time" ).selectmenu().selectmenu( "menuWidget" ).addClass( "overflow" );
      });
      $(function() {
        $( "#schedule-form-duration" ).selectmenu();
      });
      $(function() {
        $( "#now-form-duration" ).selectmenu();
      });
      $(function() {
        $( "#now-form-type" ).selectmenu();
      });
      $(function() {
        $( "#country" ).selectmenu().selectmenu( "menuWidget" ).addClass( "overflow" );
        $( "#country" ).selectmenu({ change: function() { displayTimeZones(); } });
      });
      $(function() {
        $( "#countryTimeZones" ).selectmenu();
        $( "#countryTimeZones" ).selectmenu({ change: function() { setTimeZoneDisplay(document.getElementById("countryTimeZones").value); } });
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
					var xmlhttp = new XMLHttpRequest();
					xmlhttp.onreadystatechange=function() {
	  				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {	}
  				}
					xmlhttp.open("GET","src/framework/sessionManager.php");
					xmlhttp.send();  					
				}
				activityFlag = 0;
			}
    </script>
  </head>
  
  <body>
    <div class="container">
      <div class="header">
       	<img class="banner-image" src="image/nexus4.png" />
       	<span class="banner">
					<span class="product-name" style="">Nexus</span><br/>
					<span class="module-name" style="">Web Meet</span>					
					<a id="menu-userList" class="pure-button button-menu" href="javascript:void(0)" onclick="toggleFrameDisplay('userList')" style="float:right;background-color:rgba(210, 123, 75, 1);" >TEAM</a>
					<a id="menu-reserveList" class="pure-button button-menu" href="javascript:void(0)" onclick="toggleFrameDisplay('reserveList')" style="float:right;background-color:rgba(137, 157, 112, 1);margin-right:-7px;">ROOM</a> 
      	</span>  	
  	
      	<span class="controls" style="float:right;padding-bottom:10px;margin-top:30px;">
      		<a href="http://northbridgetech.org/downloads/Northbridge_web_conference_center.pdf" style="color:#d27b4b;text-decoration:none;" target="_blank">About</a> | 
      		<a href="login.php?oid=<?php echo $_SESSION['orgId']; ?>&logout=true" style="color:#d27b4b;text-decoration:none;">Logout</a>
      	</span>
      	<a id="profile_control" href="javascript:void(0);"><span style="clear:right;float:right;padding-top:4px;margin:0px;color:#d27b4b;" class="fa fa-caret-down fa-2x" ></span></a>
				<span style="float:right;padding:10px;">Hello <?php echo $_SESSION['fname']; ?></span> 	
      </div>

			<div class="frame" >
				<div class="loginColLeft" style="width:80%;">
			  	<noscript>
			  		<p><span class="fa fa-exclamation-triangle fa-2x" style="color:#d27b4b;float:left;margin-right:5px;"></span>To use Nexus it is necessary to enable JavaScript.</p>
			  		<p>Here are the <a href="http://www.enable-javascript.com" target="_blank"> instructions how to enable JavaScript in your web browser</a></p>
			  	</noscript>					
					<div id="reserveList" style="display:block;">
						<div id="schedule_display">
							<?php include("modules/schedule/views/reservationsList.html"); ?>
						</div>
					</div>
					
					<div id="userList" style="display:none;">
						<div id="add_user_display" style="display:none;">
							<?php include("modules/user/views/userAdd.php"); ?>	
						</div>
						<div id="user_display">
							<?php include("modules/user/views/userList.html"); ?>
						</div>
					</div>

      	</div>
      	
      	<div class="loginColRight" style="width:20%;">
      		<span style="clear:right;float:right;text-align:right;margin-top:20px;"><?php echo $_SESSION['orgName']; ?></span>   
      		<span style="clear:right;float:right;margin-top:20px;"><img <?php echo $_SESSION['logo']; ?>/></span>   
      		<div id="techcheck_display" style="display:none;">
						<?php include("modules/techcheck/views/details.html"); ?>	
					</div>		
      		<div id="profile_display" style="display:none;">
						<?php include("modules/user/views/profile.html"); ?>	
					</div>	
      	</div>
      </div>
      
      <div class="footer">
        powered by<br/>
    		<a href="http://northbridgetech.org/index.php" target="_blank"><img src="http://northbridgetech.org/images/NB_horizontal_rgb.png" height="60" width="221" border="0" alt="Northbridge Technology Alliance"/></a>
			</div>

    </div><!-- container -->       
  	
	</body>
	
</html>




