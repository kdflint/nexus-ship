<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">
	
<?php
	$cacheBuster = rand();
?>

<html>
  
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	 	<meta id="meta" name="viewport" content="width=device-width; initial-scale=1.0" />	
	 	<link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Oswald:400,300|Open+Sans|Oxygen|Swanky+and+Moo+Moo">
	 	<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
		<link rel="stylesheet" href="//yui.yahooapis.com/pure/0.6.0/pure-min.css">
	  <link rel="stylesheet" href="nexus.css" type="text/css" />
	  <link rel="stylesheet" href="webinar.css" type="text/css" />
	  <title>Northbridge Nexus | Community Room</title> 
	  	
		<style>
			.not-active {
 				pointer-events: none;
 				cursor: default;
 			}
		</style>
		
		<script>
			function validateAndSubmit() {
				var joinForm = document.forms["join-form"];
				joinForm.submit();
			}
		</script>	
		
	</head>
	
	<!--
	To open the room
	
	1. Start the meeting - (go to infoWebinar.php in dev and join the room)
	2. Comment the "room closed" the user message above the form
	3. Flip the Join button
	
	-->
	
	<body>	
	  <div class="container" style="width:50%;min-width:550px;max-width:640px;">

    	<div class="header" style="margin-top:20px;">
    		
    		<img class="banner-image" src="http://northbridgetech.org/dev/new_nexus/web/image/nexus4.png" />
       	<span class="banner" style="width:60%">
					<span class="product-name" style="">Nexus</span><br/>
					<span class="module-name" style="">Web Meet</span>					
      	</span>
      	
      	<span class="controls" style="float:right;padding-bottom:10px;margin-top:30px;">
      		<a href="#" style="color:#d27b4b;text-decoration:none;">About</a>
      	</span>
    	</div>
    	
			<div class="frame"> 
			  <div class="loginColLeft">
			  	<p id="login-user-message" class="confirmation"><span class="fa fa-exclamation-triangle fa-2x" style="color:#d27b4b;float:left;margin-right:5px;"></span>The webinar room is not open at this time. It will open fifteen minutes prior to published start time.</p>
			  	<p id="login-user-message" class="confirmation"><span class="fa fa-info-circle fa-2x" style="color:#007582;float:left;margin-right:5px;margin-bottom:10px;"></span>Please join the meeting from any laptop computer, desktop computer, or Windows tablet device. (iPads and Android are incompatible.)</p>
					<form id="join-form" class="pure-form pure-form-stacked" autocomplete="off" action="webinarMeetingProcessor.php" method="post">
	    			<fieldset>
	    				Your Name
        			<input class="form-input" name="username">	        		
        			<a type="submit" class="pure-button pure-button-primary not-active" style="width:45%;float:right;margin-right:20px;" href="javascript:void(0);" onclick="return false;" disabled="disabled">Join the Webinar</a>
        			<!--<a type="submit" class="pure-button pure-button-primary" style="width:45%;float:right;margin-right:20px;" href="javascript:void(0);" onclick="validateAndSubmit();">Join the Webinar</a>-->
     				</fieldset>
     			</form>   
				</div>
     		<div class="loginColRight">
      		<span style="clear:right;float:right;text-align:right;margin-top:20px;">Northbridge Technology Alliance Informational Webinar</span>
     		</div>
      </div>
      
      <div class="footer" style="clear:both;position:relative;bottom:-40px;">
        powered by<br/>
    		<a href="http://northbridgetech.org/index.php" target="_blank"><img src="http://northbridgetech.org/images/NB_horizontal_rgb.png" height="45" width="166" border="0" alt="Northbridge Technology Alliance"/></a>
			</div>			  	
		</div>
	</body>
</html>	
	