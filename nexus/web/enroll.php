<?php
session_start();

require_once("src/framework/Util.php");
require_once(Util::getSrcRoot() . "/user/Invitation.php");
require_once(Util::getSrcRoot() . "/organization/Organization.php");

$inviteId = $networkname = $networlLogo = "";
$validInvitation = false;

Util::destroySession();

if (Util::validateUuid($_GET['invitation'])) {
	if (Invitation::isInvitationOpen($_GET['invitation'])) {
		$inviteId = $_GET['invitation'];
		$validInvitation = true;
	}
}

if ($validInvitation) {	
	
	$_SESSION['invitation'] = $inviteId;
	
	$cursor1 = Invitation::getOpenInvitationByUuid($inviteId);
	$row1 = pg_fetch_array($cursor1);

	$cursor2 = Organization::getOrganizationById($row1['orgid']);
	$row2 = pg_fetch_array($cursor2);
	$networkLogo = $row2['logo'];
	$networkName = $row2['name'];
		
} else {
	header("location:login.php");
	exit(0);
}


if(isset($_GET['error']) && Util::isSafeCharacterSet($_GET['error'])) {
	$cleanMessage = $_GET['error'];
	$cleanIcon = "fa fa-info-circle fa-2x";
}

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">
<html>
	
  <head>
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
  	<script src="//cdnjs.cloudflare.com/ajax/libs/jstimezonedetect/1.0.4/jstz.min.js"></script>
    <link rel="icon" href="images/NB_icon.png" />
    <title>Northbridge Nexus | Login</title> 
    
  <style>
  label {
    display: inline-block; width: 5em;
  }
  fieldset div {
    margin-bottom: 2em;
  }
  fieldset .help {
    display: inline-block;
  }
  .ui-tooltip {
    width: 210px;
  }
  </style>
  
  <script>
  $(function() {
    var tooltips = $( "[title]" ).tooltip({
      position: {
        my: "left top",
        at: "right+5 top-5"
      }
    });
    
    //$( "<button>" )
    //  .text( "Show help" )
    //  .button()
    //  .click(function() {
    //    tooltips.tooltip( "open" );
    //  })
    //  .insertAfter( "form" );
    
  });
  </script>
  
   	<script> 
			$(document).ready(function () {
				$(document).on("keyup", function (event) {
    			if (event.which == 13) {
       			document.getElementById("enroll-form-submit").click();   
    			}
				});
			});
		</script>
  </head>
  
  <body>
  	<!-- TODO - finalize container width -->
    <div class="container" style="width:550px;">

      <div class="header">
       	<img class="banner-image" src="image/nexus4.png" />
       	<span class="banner" style="width:60%">
					<span class="product-name" style="">Nexus</span><br/>
					<span class="module-name" style="">Web Meet</span>					
      	</span>  	
  	
      	<span class="controls" style="float:right;padding-bottom:10px;margin-top:30px;">
      		<a href="http://northbridgetech.org/downloads/Northbridge_web_conference_center.pdf" style="color:#d27b4b;text-decoration:none;" target="_blank">About</a>
      	</span>
      </div>

			<div class="frame"> 
				
			  <div class="loginColLeft">
			  	<noscript>
			  		<p><span class="fa fa-exclamation-triangle fa-2x" style="color:#d27b4b;float:left;margin-right:5px;"></span>To use Nexus it is necessary to enable JavaScript.</p>
			  		<p>Here are the <a href="http://www.enable-javascript.com" target="_blank"> instructions how to enable JavaScript in your web browser</a></p>
			  	</noscript>
					<form id="enroll-form" class="pure-form pure-form-stacked" autocomplete="off" action="modules/login/control/enrollProcessor.php" method="post">
	    			<fieldset>
							Choose your username*
							<input class="form-input" type="text" name="uid"  maxlength="25" title="7-25 characters. May not contain spaces"/>
										
							Choose your password*
							<input class="form-input" type="password" name="password1" maxlength="25" title="7-25 characters. Must contain at least 1 digit."/>
											
							Confirm your password*
							<input class="form-input" type="password" name="password2" maxlength="25" title="Must match previous password entry."/>
							
							Email*
     					<input class="form-input" type="email" name="email" maxlength="50" title="Required. 6-50 characters" value="">
											
							Your first name*
							<input class="form-input" type="text" name="fname" maxlength="25" title="Required. 1-25 characters."/>
										
							Your last name
							<input class="form-input" type="text" name="lname" maxlength="25" title="Optional. 0-25 characters."/>

        			<a id="enroll-form-submit" type="submit" class="pure-button pure-button-primary" style="width:45%;" href="javascript:void(0);" onclick="enrollValidateAndSubmit();">Enroll</a
        			
     				</fieldset>
     			</form>   			 			
     		</div>
     		
     		<div class="loginColRight">
      		<span style="clear:right;float:right;text-align:right;margin-top:20px;"><?php echo $networkName; ?></span>
      		<span style="clear:right;float:right;margin-top:20px;"><img <?php echo $networkLogo; ?>/></span>
     		</div>
      </div>
      
      <div class="footer" style="clear:both;position:relative;bottom:-40px;">
        powered by<br/>
    		<a href="http://northbridgetech.org/index.php" target="_blank"><img src="http://northbridgetech.org/images/NB_horizontal_rgb.png" height="45" width="166" border="0" alt="Northbridge Technology Alliance"/></a>
			</div>
	
    </div><!-- container -->       		  	
	</body>
</html>




