<?php 
session_start();

$readonly = "";

if (isset($_SESSION['traineeName'])) {
	$readonly_value = "readonly";
}

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">
	
<!-- 	To open the room, change the return value in roomCheck.php to "open"	-->
	
<html>
  
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	 	<meta id="meta" name="viewport" content="width=device-width; initial-scale=1.0" />	
	 	
	 	<link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Oswald:400,300|Open+Sans|Oxygen|Swanky+and+Moo+Moo">
	 	<link rel="stylesheet" type="text/css" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
		<link rel="stylesheet" type="text/css" href="//yui-s.yahooapis.com/pure/0.6.0/pure-min.css">
	  <link rel="stylesheet" type="text/css" href="http://northbridgetech.org/dev/new_nexus/web/styles/nexus.css" type="text/css" />
	  
  	<!-- 	http://www.featureblend.com/javascript-flash-detection-library.html -->
 		<script src="http://northbridgetech.org/dev/nexus/view/script/flash_detect.js"></script>
 		<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>

	  <title>Northbridge Nexus | Training Room</title> 
	  	
		<style>
			.confirmation {margin-right:10px;}
			.training-button {float:right;margin-right:0px;width:114px;}
			.footer {clear:both;position:relative;bottom:-40px;}
 			td {padding:10px;}
 			td:first-child {text-align:center;}	
 			td:first-child span {color:#007582};
		</style>
				
	</head>
	
	<body>	
	  <div class="container" style="width:620px;">
	  	
    	<div class="header" style="margin-top:20px;">    		
    		<img class="banner-image" src="http://northbridgetech.org/dev/new_nexus/web/image/nexus4.png" />
       	<span class="banner" style="width:67%">
					<span class="product-name" style="">Nexus</span><br/>
					<span class="module-name" style="">Web Meet Training</span>					
      	</span>    	
      	<span class="controls" style="float:right;padding-bottom:10px;margin-top:30px;">
      		<a href="http://northbridgetech.org/downloads/Northbridge_web_conference_center.pdf" style="color:#d27b4b;text-decoration:none;" target="_blank"><b>About</b></a>
      	</span>
    	</div>
    	
			<div class="frame"> 
			  <div class="loginColLeft">
			  	<noscript>
			  		<p><span class="fa fa-exclamation-triangle fa-2x" style="color:#d27b4b;float:left;margin-right:5px;"></span>To use Nexus it is necessary to enable JavaScript.</p>
			  		<p>Here are the <a href="http://www.enable-javascript.com" target="_blank"> instructions how to enable JavaScript in your web browser</a></p>
			  	</noscript>
					<table>
						<tr>
							<td><span id="step-nplus1" class="fa fa-check-square-o fa-3x"></span></td>
							<td><span class="confirmation" style="font-size:200%;">Training Complete!</span></td>
						</tr>
						<tr><td>&nbsp;</td><td>You will receive Nexus activation instructions on the schedule that your trainer explained.</td></tr>
						<tr><td>&nbsp;</td><td><a href="http://northbridgetech.org">Northbridge Technology Alliance</a></td></tr>
					</table>
				</div>
     		<div class="loginColRight">
      		<span style="clear:right;float:right;text-align:right;margin-top:20px;">Nexus Web Meet<br/>Training Room</span>
     		</div>
      </div>
      
      <div class="footer">
        powered by<br/>
    		<a href="http://northbridgetech.org/index.php" target="_blank"><img src="https://northbridgetech.org/images/NB_horizontal_rgb.png" height="45" width="166" border="0" alt="Northbridge Technology Alliance"/></a>
			</div>			  	
		</div>
	</body>
</html>	

