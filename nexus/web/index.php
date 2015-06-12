<? 
session_start();

require_once("src/framework/Util.php");

if (!Util::isSessionValid()) {
	header("location:login.php?logout=true");
	exit(0);	
}

$hideHere = false;
if (Util::hideInEnvironment()) {
	$hideHere = true;	
}

// select content to show based on request variable, which is supplied in navigation.php
//if (isset($_REQUEST['thisPage'])) {
//	$thisPage = $_REQUEST['thisPage'];
//} else {
//	$thisPage = "directory";
//}

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
    <link rel="stylesheet" href="styles/nexus.css" type="text/css" />
    <script src="scripts/nexus.js" language="javascript"></script>
 		<script src="//code.jquery.com/jquery-1.10.2.js"></script>
  	<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>  
	  <link rel="icon" href="images/NB_icon.png" />
    <title>Northbridge Nexus</title> 
    
    <script type="text/javascript">
			$(document).ready(function () {
				$( '#schedule_control' ).click(function() {
	  			$( "#schedule_display" ).toggle( "blind" );
				});
			});
		</script>
    
		<!--================== Schedule Module Meta ==================-->

		<link rel="stylesheet" href="modules/schedule/views/jquery.timepicker.css">
		<script src="modules/schedule/views/jquery.timepicker.js" type="text/javascript"></script>
	
    <script type="text/javascript">
      $(function() {
        $( "#datepicker" ).datepicker({
          changeMonth: true,
          changeYear: true
        });
      });
      $(function() {
        $( "#basicExample" ).timepicker();
      });
      $(function() {
        $( "#duration" ).selectmenu();
      });
    </script>
    <style>
      fieldset {
        border: 0;
      }
      label {
        display: block;
        margin: 30px 0 0 0;
      }
      select {
        width: 200px;
      }
      .overflow {
        height: 200px;
      }
    </style>
 
  </head>
  
  <body>
    <div class="container">

      <div class="header">
      	<span style="float:left;padding:10px;margin-top:10px;border-radius:6px;background:#edf0de;color:#004d62;"><span style="font-family:Oswald;font-size:130%">Nexus</span><hr/>Web Conference Center</span>
      	<span style="float:left;padding:10px;margin-top:10px;"><img <?php echo $_SESSION['logo']; ?>/></span>
      	<span style="float:right;padding:10px;margin-top:56px;">
      		<a href="#" style="color:#d27b4b;text-decoration:none;">Account</a> | 
      		<a href="#" style="color:#d27b4b;text-decoration:none;">Support</a> | 
      		<a href="login.php?logout=true" style="color:#d27b4b;text-decoration:none;">Logout</a>
      	</span>
      	<span style="clear:left;float:left;padding:10px;"><? echo $_SESSION['networkName']; ?></span>
      	<span style="clear:right;float:right;padding:5px;margin:0px;color:#d27b4b;" class="fa fa-caret-down fa-2x" ></span>
				<span style="float:right;padding:10px;">Hello <? echo $_SESSION['fname']; ?></span>
      </div>

			<div class="frame" > 
				<a id="join_control" class="pure-button button-join" href="javascript:void(0)">Enter the Room</a>    
				<a id="schedule_control" class="pure-button button-schedule" href="javascript:void(0)">Schedule a Meeting</a>
				<div id="schedule_display" style="display:none;">
					<?php include("modules/schedule/views/datePicker.html"); ?>	
				</div>
				<div id="join_display" style="display:none;"></div>
				<div class="main_display" style="text-align:left;margin-left:26px;top:210px;position:fixed;">
					<div class="pure-menu pure-menu-horizontal">
	    			<ul class="pure-menu-list">
        			<li class="pure-menu-item pure-menu-selected"><a href="#" class="pure-menu-link">Meetings</a></li>
        			<li class="pure-menu-item"><a href="#" class="pure-menu-link">Room</a></li>
        			<li class="pure-menu-item"><a href="#" class="pure-menu-link">Team</a></li>
    				</ul>
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




