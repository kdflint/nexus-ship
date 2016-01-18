<?php

//error_reporting(E_ALL);
//ini_set( 'display_errors','1'); 

session_start();

//require_once '../control/xmpp-prebind-php/lib/XmppPrebind.php';
require_once("../control/util.php");
require_once("../migration/Util.php");

// Force migration
//if (!Util::isSessionValid()) {
	header("location:login.php?logout=true");
	exit(0);	
//}

require_once($_SESSION['appRoot'] . "control/error/handlers.php");

$hideHere = false;
if (Util::hideInEnvironment()) {
	$hideHere = true;	
}

// LEFT OFF - put in session timeout code - or not?

// select content to show based on request variable, which is supplied in navigation.php
if (isset($_REQUEST['thisPage'])) {
	$thisPage = $_REQUEST['thisPage'];
} else {
	$thisPage = "directory";
}

?>

<!DOCTYPE html> 

<html>
  <head>  	
  		
    <!-- For Google Map 
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCw8wGNP_YbytpUxZCfgxhtqKG6izDixN0&sensor=false"></script>
     End Google stuff -->
  	
  	<meta http-equiv="Content-type" content="text/html;charset=UTF-8">
 		<link rel="stylesheet" href="//yui.yahooapis.com/pure/0.6.0/pure-min.css">
  	<link rel="stylesheet" type="text/css" href="../../new_nexus/web/modules/event/mod_style.css" />
	  <link rel="stylesheet" type="text/css" href="style/style.css" />
	  <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">


	  <!--<link rel="stylesheet" type="text/css" media="screen" href="style/converse.min.css">-->
    <script src="../../new_nexus/web/scripts/nexus.js" language="javascript"></script>
 		<script src="script/script.js" language="javascript"></script>
		<!--<script src="script/converse.min.js"></script>-->
    <link rel="shortcut icon" href="image/northbridge-ico.png" />
    <title>Nexus Home</title>

  	<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">  
    <!--<link rel="stylesheet" href="script/jquery-ui-1.11.1.custom/jquery-ui.css">-->
    <script src="script/jquery-ui-1.11.1.custom/external/jquery/jquery.js"></script>
		<script src="script/jquery-ui-1.11.1.custom/jquery-ui.js"></script>
		
		<script>$(function() {$( document ).tooltip();});</script>
		<style>label {display: inline-block;width: 5em;}</style>	
		
    <script type="text/javascript">
			$(document).ready(function () {
				$( '#schedule_control' ).click(function() {
	  			$( "#new_event_display" ).toggle( "blind" );
	  			$( "#current_schedule_display" ).toggle( "blind" );
				});
			});
		</script>	
		
		<!--================== Schedule Module Meta ==================-->

		<link rel="stylesheet" href="<?php echo(Utilities::getHttpPath()); ?>/modules/schedule/views/jquery.timepicker.css">
		<script src="<?php echo(Utilities::getHttpPath()); ?>/modules/schedule/views/jquery.timepicker.js" type="text/javascript"></script>
	
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

  </head>
  
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
                
  
  <body>
    <div class="container">
    	
    <table width="100%">
    	<tr>
    	<td>
    		<img style="float:left;vertical-align:top;margin:20px;" src="<?php echo(Utilities::getPartnerImageRoot()); ?><?php echo $_SESSION['logo']; ?>" border="0" alt=""/>
    	</td>
    	<td>
    		<p style="text-align:right;color:#c9c9a7;font-size:18px;margin:20px;"><b><?php echo($_SESSION['orgName']); ?></b></p>
    		<p style="text-align:right;margin:20px;color:#4b5b6e"><b>Hello <?php echo($_SESSION['fname']); ?></b><br/>
    		<!-- <a id="chatControlLink" href="javascript:toggleChat('chatControl')">Chat</a> |  -->
				<a href="include/download/help.pdf">Help</a> | <a href="javascript:void(0)" onclick="if(typeof Formilla != 'undefined'){Formilla.initFormillaChat();}">Problem?</a> | <a href="../control/resetForumSession.php">Support Forum</a> | <a href="login.php?logout=true&network=<?php echo $_SESSION['networkId']; ?>">Logout</a></p>
			</td>
    	</tr>
    </table>	
        	
      <div class="shell">
      	
				<div class="navigation">
      		<?php include($_SESSION['appRoot'] . "view/include/navigation.php"); ?>
 		  	</div>

				<div class="projectsContent">						
			 	<?php
			   $contentFile = $_SESSION['appRoot'] . "view/include/" . $thisPage . ".php";
			   include($contentFile); 
			 	?>
			 	</div>
			 				
					<!--<div id="chatControl" style="display:block;">-->
			 		<!--	<div id="conversejs"></div> -->
			 		<!--</div>-->
			 			 		
      </div><!--shell-->
    </div><!-- container -->
		<div id="fade" class="black_overlay"></div>    
	</body>
	




</html>

