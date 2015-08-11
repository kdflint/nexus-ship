<?php

session_start();

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">
	
<!-- 	To open the room, change the return value in roomCheck.php to "open"	-->
	
<html>
  
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	 	<meta id="meta" name="viewport" content="width=device-width; initial-scale=1.0" />	
	 	
	 	<link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Oswald:400,300|Open+Sans|Oxygen|Swanky+and+Moo+Moo">
	 	<link rel="stylesheet" type="text/css" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
		<link rel="stylesheet" type="text/css" href="//yui.yahooapis.com/pure/0.6.0/pure-min.css">
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
		
		<script>
			
			function validateAndSubmit() {
				var joinForm = document.forms["join-form"];	
				var submitButton = document.getElementById("join-form-submit");
				var usernameField = joinForm["username"];				
				var username = usernameField.value;
  			usernameField.style.backgroundColor = "white";
  			usernameField.placeholder = "";
  			var errorBackground = "rgba(247,248,239,0.6) url('') no-repeat right top";
  			if (username == null || username == "") {
    			usernameField.placeholder = "Your name is required.";
    			usernameField.style.background = errorBackground;
    			usernameField.style.borderColor = "#f68620";
    			usernameField.style.borderWidth = "2px";
    			return;
    		}				
				submitButton.disabled = true;  
 				submitButton.innerHTML = "One Moment"; 
 				submitButton.style.opacity = ".6";
				var xmlhttp;
				if (window.XMLHttpRequest) { // code for IE7+, Firefox, Chrome, Opera, Safari
  				xmlhttp = new XMLHttpRequest();
  			} else { // code for IE6, IE5
  				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
  			}
				xmlhttp.onreadystatechange=function() {
  				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {					 					
    				if (xmlhttp.responseText.indexOf('open') > -1) {
    					joinForm.submit();
							return;
    				} else {
    					alert("The training room is not yet open. It will open fifteen minutes prior to published start time.");
							submitButton.disabled = false;  
 							submitButton.innerHTML = "Join Now"; 
 							submitButton.style.opacity = "1";
 							return;
    				}
  				}
  			}
  			// TODO - put this logic in trainingMeetingProcessor.php
				xmlhttp.open("POST","roomCheck.php");
				xmlhttp.send();
			}

    	function flashCheck() {
    		if(FlashDetect.installed) {
    		 if(FlashDetect.versionAtLeast(11,2)) {
          	document.getElementById("techCheck").innerHTML = "Success!"; 
          	document.getElementById("step-1").className = "fa fa-check-square-o fa-2x";
          	document.getElementById("join-form-submit").className = "pure-button pure-button-primary training-button";
          	document.getElementById("join-form-submit").removeAttribute("disabled");
          	
        	} else {
        	  document.getElementById("techCheck").innerHTML = "Uh oh. Your Flash plugin version is too low. Flash Version 11.2 is required in order to attend this session. <a href='https://get.adobe.com/flashplayer/' target='_blank'>Upgrade Flash</a>";
        	}     
      	} else {
   		    document.getElementById("techCheck").innerHTML = "Uh oh. The Flash browser plugin is required in order to attend this session. <a href='https://get.adobe.com/flashplayer/' target='_blank'>Get Flash</a>";
      	}
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
	  <div class="container" style="width:620px;">
	  	
    	<div class="header" style="margin-top:20px;">    		
    		<img class="banner-image" src="http://northbridgetech.org/dev/new_nexus/web/image/nexus4.png" />
       	<span class="banner" style="width:67%">
					<span class="product-name" style="">Nexus</span><br/>
					<span class="module-name" style="">Web Meet Training</span>					
      	</span>    	
      	<span class="controls" style="float:right;padding-bottom:10px;margin-top:30px;">
      		<a href="javascript:void(0)" onclick="if(typeof Formilla != 'undefined'){Formilla.initFormillaChat();}"><b>Problem?</b></a> 
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
							<td>
								<span id="step-1" class="fa fa-square-o fa-2x"></span><br/>Step&nbsp;1
							</td><td>			  	
			  				<a class="pure-button pure-button-primary training-button" href="javascript:void(0);" onclick="flashCheck();">Check Now</a>
			  				<span class="confirmation">Check your internet browser compatibility</span>
			  				<p id="techCheck"></p>
							</td>
						</tr><tr>
							<td><span id="step-2" class="fa fa-square-o fa-2x"></span><br/>Step&nbsp;2
							</td><td>
								<span class="confirmation">Enter your name and join the training session</span>
								<form id="join-form" class="pure-form pure-form-stacked" autocomplete="off" style="width:105%;margin-top:10px;" action="http://northbridgetech.org/dev/new_nexus/web/modules/training/control/trainingMeetingProcessor-1a.php" method="post">
		    					<fieldset>
	    							Your Name
        						<input class="form-input" name="username">	  
     							</fieldset>
     						</form>   
								<a id="join-form-submit" type="submit" class="pure-button pure-button-primary pure-button-disabled training-button" href="javascript:void(0);" onclick="validateAndSubmit();" disabled="disabled">Join Now</a>
							</td>
						</tr>
					</table>
				</div>
     		<div class="loginColRight">
      		<span style="clear:right;float:right;text-align:right;margin-top:20px;">Nexus Web Meet<br/>Training Room</span>
     		</div>
      </div>
      
      <div class="footer">
        powered by<br/>
    		<a href="http://northbridgetech.org/index.php" target="_blank"><img src="http://northbridgetech.org/images/NB_horizontal_rgb.png" height="45" width="166" border="0" alt="Northbridge Technology Alliance"/></a>
			</div>			  	
		</div>
	</body>
</html>	

