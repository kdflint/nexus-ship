<?php
session_start();

require_once("src/framework/Util.php");
require_once(Util::getSrcRoot() . "/organization/Organization.php");

if(isset($_GET['error']) && Util::isSafeCharacterSet($_GET['error'])) {
	$cleanMessage = $_GET['error'];
	$cleanIcon = "fa fa-info-circle fa-2x";
} else if(isset($_GET['logout'])) {
	if(isset($_GET['expired'])) {
		$cleanMessage = "Your session has timed out.";
	} else {
		$cleanMessage = "You have signed out succesfully.";
	}
	$cleanIcon = "fa fa-info-circle fa-2x";
}

$logo = "";
$networkLogo = $networkName = "";		
$cleanNetworkId = "1"; // TODO: create default network in db, that includes default logo

if(isset($_GET['oid']) && Organization::validateOrganizationUid($_GET['oid'])) {
 	$cleanNetworkId = $_GET['oid'];		
}

$cursor = Organization::getOrganizationByUid($cleanNetworkId);
$row = pg_fetch_array($cursor);
$networkLogo = $row['logo'];
$networkName = $row['name'];

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
  	<script src="//cdnjs.cloudflare.com/ajax/libs/jstimezonedetect/1.0.4/jstz.min.js"></script>
    <link rel="icon" href="images/NB_icon.png" />
    <title>Northbridge Nexus | Login</title> 
   
   	<script> 
			$(document).ready(function () {
				$(document).on("keyup", function (event) {
    			if (event.which == 13) {
       			document.getElementById("login-form-submit").click();   
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
			  	<p id="login-user-message" class="confirmation"><span class="<?php echo $cleanIcon; ?>" style="color:#007582;float:left;margin-right:5px;"></span><?php echo $cleanMessage; ?></p>
					<form id="login-form" class="pure-form pure-form-stacked" autocomplete="off" action="modules/login/control/loginProcessor.php" method="post">
	    			<fieldset>
	    				Username<span class="instruction form-instruction"><a href="javascript:void(0)" onclick="toggleFormDisplay('recover-username-form')">I forgot</a></span>
        			<input class="form-input" name="uid" value="" maxlength="25" >	        		
        			Password<span class="instruction form-instruction"><a href="javascript:void(0)" onclick="toggleFormDisplay('recover-password-form')">I forgot</a></span>
        			<input class="form-input" type="password" name="password" value="" maxlength="25" />	
        			<input id="localTz" name="timezone" type="hidden" value="">
        			<a id="login-form-submit" type="submit" class="pure-button pure-button-primary" style="width:45%;" href="javascript:void(0);" onclick="loginValidateAndSubmit();">Sign In</a>
        			<a class="pure-button pure-button-secondary" onclick="toggleRememberCheckbox();" style="width:45%;" ><span id="fakeCheckBox" class="fa fa-square-o" style="color:#004d62;padding-right:4px;"></span> Remember me</a>
        			<input id="login-remember" name="login-remember" type="checkbox" style="visibility:hidden;"/>
        			
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




