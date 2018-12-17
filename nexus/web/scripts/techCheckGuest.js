      var browserKeysWhite = ["MSIE", "Trident", "Firefox", "Safari", "Chrome", "Edge"];
			var browserNames = ["IE", "IE", "Firefox", "Safari", "Chromium", "Microsoft Edge", "Safari iPad", "Safari Mobile"];
      var dspeed, uspeed, brake, has_flash = null, has_java = null;
			var minVersion = "1,7,0,35";
 			var jarfile = "lib/javaDetect/files/getJavaInfo.jar";
			var verifyTags = null;
				
			function techCheck() {		
				
					startSpeedChecks();

					var browserId = getBrowserId();
					if (browserId > -1 && browserId < 6) {
						document.getElementById("browser_status").src = "<?php echo(Utilities::getHttpImagePath()); ?>/fa-check-square-o_16_486326.png";
						document.getElementById("browser_version").innerHTML = browserNames[getBrowserId()] + " is a compatible browser."; 
					} else if (browserId == 6 || browserId == 7) {
						document.getElementById("browser_status").src = "<?php echo(Utilities::getHttpImagePath()); ?>/fa-exclamation-triangle_16_f64620.png";
						document.getElementById("browser_version").innerHTML = browserNames[getBrowserId()] + " is not compatible." +
						"<a href='javascript:void(0);' onclick='toggleTooltip(\"browserTip\");' class='tooltip'>" + 
							"<span id='browserTip' style='width:250px;'>" +
        			"	<img class='callout' src='image/callout.gif' />	" +
        			"	<table>" +
        			"		<tr><td>" + 
        			"			<p>For the fullest feature set, Northbridge recommends using Firefox, Safari Desktop or Internet Explorer on a laptop or desktop computer.</p>" + 
        			"			<p><a href='http://www.mozilla.org/firefox' target='_blank'>Download Firefox</a></p>" +
        			"			</td></tr>" +
        			"	 </table>" +
    					"	</span>" +
							"<span style='padding:5px;vertical-align:top;' class='fa fa-info-circle' ></span>" + 
						"</a>";
					}	 else {
						document.getElementById("browser_status").src = "<?php echo(Utilities::getHttpImagePath()); ?>/fa-question_16_f68620.png";
						document.getElementById("browser_version").innerHTML = "Your browser is unconfirmed." +
						"<a href='javascript:void(0);' onclick='toggleTooltip(\"browserTip\");' class='tooltip'>" + 
							"<span id='browserTip' style='width:250px;'>" +
        			"	<img class='callout' src='image/callout.gif' />	" +
        			"	<table>" +
        			"		<tr><td>" + 
        			"			<p>For the fullest feature set, Northbridge recommends using Firefox, Safari Desktop or Internet Explorer on a laptop or desktop computer.</p>" + 
        			"			<p><a href='http://www.mozilla.org/firefox' target='_blank'>Download Firefox</a></p>" +
        			"			</td></tr>" +
        			"	 </table>" +
    					"	</span>" +
							"<span style='padding:5px;vertical-align:top;' class='fa fa-info-circle' ></span>" + 
						"</a>";
					}												
        	
        	if(FlashDetect.installed && FlashDetect.versionAtLeast(11,2)) {
        		document.getElementById("flash_status").src = "<?php echo(Utilities::getHttpImagePath()); ?>/fa-check-square-o_16_486326.png"; 
        		document.getElementById("flash_version").innerHTML = "You are running Flash version " + FlashDetect.major + "." + FlashDetect.minor; 
        		has_flash = true;  
        	} else {
   		   		document.getElementById("flash_status").src = "<?php echo(Utilities::getHttpImagePath()); ?>/fa-exclamation-triangle_16_f64620.png";
      			document.getElementById("flash_version").innerHTML = "You do not have Flash 11.2 or higher." +
						"<a href='javascript:void(0);' onclick='toggleTooltip(\"flashTip\");' class='tooltip'>" + 
							"<span id='flashTip' style='width:250px;'>" +
        			"	<img class='callout' src='image/callout.gif' />	" +
        			"	<table>" +
        			"		<tr><td>" + 
        			"			<p>For the fullest feature set, Flash version 11.2 or higher is recommended</p>" + 
        			"			<p><a href='https://helpx.adobe.com/flash-player.html' target='_blank'>Get Flash</a></p>" +
        			"			<p>Note: Most desktop and laptop browsers are compatible with Flash but some tablet and phone-based browsers are not.</p>" +
        			"			</td></tr>" +
        			"	 </table>" +
    					"	</span>" +
							"<span style='padding:5px;vertical-align:top;' class='fa fa-info-circle' ></span>" + 
						"</a>";
          	has_flash = false;
      		}   		
								
					PluginDetect.onDetectionDone("Java", displayJavaResults, jarfile, verifyTags);
    		    		
					displayCheckSummary();
					       	
				};	
				
			function refreshCheckSummary() {
				document.getElementById("tech_check_summary").innerHTML = "<span class='fa fa-spinner fa-spin fa-lg'></span> Checking your system compatibility... one moment</span>";
				startSpeedChecks();
				displayCheckSummary();
			}
									

			function displayCheckSummary() {
      	var id = setInterval(function() {
      		if (dspeed && uspeed && has_flash) {
        		if (has_java) {
         			document.getElementById("tech_check_summary").innerHTML = "<span class='fa fa-check-square-o fa-lg' style='margin-right:10px;color:#486326;'></span>Your system is compatible to participate in this meeting.";
         		} else {
         			document.getElementById("tech_check_summary").innerHTML = "<span class='fa fa-check-square-o fa-lg' style='margin-right:10px;color:#486326;'></span>Your system is compatible to participate in this meeting.";
						}
         		clearInterval(id);
        	} else {
        		if (has_flash === false) {
         			document.getElementById("tech_check_summary").innerHTML = "<span class='fa fa-check-square-o fa-lg' style='margin-right:10px;color:#486326;'></span>Your system is compatible to participate in this meeting.";
         			clearInterval(id);
         		} else if (dspeed === false || uspeed === false) {
         			document.getElementById("tech_check_summary").innerHTML = "<span class='fa fa-check-square-o fa-lg' style='margin-right:10px;color:#f68620;'></span>Your system may show connection quality limitations.";
         			clearInterval(id);     			
         		}
         	}
       		if (brake > 30) {
       			document.getElementById("tech_check_summary").innerHTML = "<span class='fa fa-check-square-o fa-lg' style='margin-right:10px;color:#f68620;'></span>Your system may show connection quality limitations.";
       			clearInterval(id);
       		}
       		brake++;
     		}, 1000);
      }

			// https://developer.mozilla.org/en-US/docs/Web/API/Window/navigator
			// http://www.javascriptkit.com/javatutors/navigator.shtml
			// http://www.useragentstring.com/pages/useragentstring.php
			function getBrowserId () {
   			var usrAgent = navigator.userAgent;
   			var ndexWhite = browserKeysWhite.length - 1;
   			for (ndexWhite; ndexWhite > -1 && usrAgent.indexOf(browserKeysWhite[ndexWhite]) === -1; ndexWhite--);
   			if (ndexWhite == 3) {
   				if (usrAgent.indexOf("iPad") > -1) { return 6; }
   				if (usrAgent.indexOf("Trident") > -1) { return -1; }
   				if (usrAgent.indexOf("Android") > -1) { return -1; }
   				if (usrAgent.indexOf("Mobile") > -1) { return 7; }
   			}
   			if (ndexWhite == 4) {
   				if (usrAgent.indexOf("Android") > -1) { return -1; }
   				if (usrAgent.indexOf("OPR") > -1) { return -1; }
   			}
   			return ndexWhite;
			}

			function displayJavaResults() {
				var javaStatus = PluginDetect.isMinVersion("Java", minVersion);
				if (javaStatus == 1) {
      		document.getElementById("java_status").src = "<?php echo(Utilities::getHttpImagePath()); ?>/fa-check-square-o_16_486326.png";
      		document.getElementById("java_version").innerHTML = "You are running Java version " + PluginDetect.getVersion("Java").replace(/,/g,".");
      		has_java = true;
				} else {
					document.getElementById("java_version").innerHTML = " Java is not enabled in your browser" +
					"<a href='javascript:void(0);' onclick='toggleTooltip(\"javaTip\");' class='tooltip'>" + 
						"<span id='javaTip' style='width:250px;'>" +
        		"	<img class='callout' src='image/callout.gif' />	" +
        		"	<table>" +
        		"		<tr><td>" + 
        		"			<p>Java is required if you want to share your desktop.</p>" + 
        		"			<p>Note: Java is not supported in the Chromium or Edge browser.</p>" +
        		"			<p>Desktop sharing means showing meeting participants a conference room tile that contains a real-time view of your running desktop.</p>" +
        		"			<p>If you wish to use this feature, please install a current version of Java at <a href='http://java.com' target='_blank'>http://java.com</a></p>" +
        		"			</td></tr>" +
        		"	 </table>" +
    				"	</span>" +
						"<span style='padding:5px;vertical-align:top;' class='fa fa-info-circle' ></span>" + 
						"</a>";

					has_java = false;
				}
			}

			function startSpeedChecks() {
				
				dspeed = uspeed = null;
				brake = 0;
				 
    		var dProgress = document.getElementById("dprogress");
    		dProgress.innerHTML = "<span class='fa fa-spinner fa-spin fa-lg'></span>";
    		window.setTimeout(MeasureDownConnectionSpeed, 1);
			
				// TODO - uncomment these three lines to bring upload speed back after http problem is solved 
				// (source of problem is link in MeasureUpConnectionSpeed)
				// Also see techCheck.php, lines 30-34
				var uProgress = document.getElementById("uprogress");
				uProgress.innerHTML = "<span class='fa fa-spinner fa-spin fa-lg'></span>";
        window.setTimeout(MeasureUpConnectionSpeed, 2);
        	
			}
			
 			// This function calculates download speed relative to the northbridge web conference server
 			// Once the speed is calculated it rewrites the DOM with the calculated value. That happens inside the showDownloadResults() function.
			function MeasureDownConnectionSpeed() {
				
  			// TODO - pull this address from bbb config.php and get this resource into build/deploy cycle
  			// This file resides on jean at /var/lib/tomcat7/webapps/bigbluebutton/images, also, renamed from .jpg to .png to get around web server url filter
 				//var imageAddr = "http://ec2-50-19-215-104.compute-1.amazonaws.com/bigbluebutton/images/speedtest-8MB.png"; 
				var imageAddr = "https://northbridgetech.org/images/speedtest-8MB.png"; 
				var downloadSize = 7907740; //image size in Bytes				
	    	var dProgress = document.getElementById("dprogress");
	    	var dImage = document.getElementById("download_speed");
    		var startTime, endTime;
    		var download = new Image();
    		download.onload = function () {
	        	endTime = (new Date()).getTime();
        		showDownloadResults();
    			}
	   
	    	download.onerror = function (err, msg) {
	       		dProgress.innerHTML = "Undetermined (server error)";
	       		dImage.src =  "<?php echo(Utilities::getHttpImagePath()); ?>/fa-question_16_f68620.png"
  	  		}
	    
    		startTime = (new Date()).getTime();
    		var cacheBuster = "?nnn=" + startTime;
    		download.src = imageAddr + cacheBuster;
	    
    		function showDownloadResults() {
	        var duration = (endTime - startTime) / 1000;
        	var bitsLoaded = downloadSize * 8;
        	var speedbps = (bitsLoaded / duration).toFixed(2);
        	var speedKbps = (speedbps / 1024).toFixed(2);
        	var speedMbps = (speedKbps / 1024).toFixed(1);

		  		if (speedMbps > 2) {
				  	dImage.src =  "<?php echo(Utilities::getHttpImagePath()); ?>/fa-check-square-o_16_486326.png";
				  	dProgress.innerHTML = "Your&nbsp;download&nbsp;speed&nbsp;is&nbsp;" + speedMbps + "&nbsp;Mbps";
              dspeed = true; 
		  		} else if (speedMbps > 1) {
				  	dImage.src =  "<?php echo(Utilities::getHttpImagePath()); ?>/fa-check-square-o_16_f68620.png";
		  			dProgress.innerHTML = "Your&nbsp;download&nbsp;speed&nbsp;is&nbsp;" + speedMbps + "&nbsp;Mbps" +
		  			"<a href='javascript:void(0);' onclick='toggleTooltip(\"downSpeedTip\");' class='tooltip'>" + 
						"<span id='downSpeedTip' style='width:250px;'>" +
        		"	<img class='callout' src='image/callout.gif' />	" +
        		"	<table>" +
        		"		<tr><td>" + 
        		"			<p>Your download speed meets basic recommendations</p>" +
        		"			<p>If there is fluctuation in your download speed, you may experience some connectivity problems.</p>" +
        		"			<p>For best results, avoid a public wifi connection as these tend to be sporadic in quality. Consider using a wired connection, if possible.</p>" +
        		"			</td></tr>" +
        		"	 </table>" +
    				"	</span>" +
						"<span style='padding:5px;vertical-align:top;' class='fa fa-info-circle' ></span>" + 
						"</a>";
              dspeed = true;
		  		} else {
				  	dImage.src =  "<?php echo(Utilities::getHttpImagePath()); ?>/fa-exclamation-triangle_16_f64620.png";
		  			dProgress.innerHTML = "Your&nbsp;download&nbsp;speed&nbsp;is&nbsp;" + speedMbps + "&nbsp;Mbps" +
		  			"<a href='javascript:void(0);' onclick='toggleTooltip(\"downSpeedTip\");' class='tooltip'>" + 
						"<span id='downSpeedTip' style='width:250px;'>" +
        		"	<img class='callout' src='image/callout.gif' />	" +
        		"	<table>" +
        		"		<tr><td>" + 
        		"			<p>Your download speed is slower than recommended.</p>" + 
        		"			<p>You will probably experience connectivity problems.</p>" +
        		"			<p>For best results, avoid a public wifi connection as these tend to be sporadic in quality. Consider using a wired connection, if possible.</p>" +
        		"			</td></tr>" +
        		"	 </table>" +
    				"	</span>" +
						"<span style='padding:5px;vertical-align:top;' class='fa fa-info-circle' ></span>" + 
						"</a>";
              dspeed = false;
		  		}

    		}
    		
			}

			// This function calculates upload speed relative to the northbridge web server
 			// Once the speed is calculated it rewrites the DOM with the calculated value. That happens inside the showUploadResults() function.
			function MeasureUpConnectionSpeed() {
				check();

    		function check() {

	    			var xhr = getXmlHttpRequest();
	    			var postSizeInMB = 4;
          	var url = 'https://northbridgetech.org/apps/nexus/web/modules/schedule/control/uploadSpeedTester.php?cache=' + Math.floor( Math.random() * 10000 ); //random number prevents url caching
          	// TODO - the below POST to a random jsp page throws an http 500 error. Why? Is this harmful? We should create a POST-able page just for this purpose.
          	// Leaving the resource path to Northbridge web server for now because results seem very comparable, unlike download speed results.
          	//var url = 'http://ec2-50-19-215-104.compute-1.amazonaws.com/demo/demo1.jsp?cache=' + Math.floor( Math.random() * 10000 );
          	var data = getRandomString(postSizeInMB); // 1 MB POST size
          	var startTime;
          	var speed = 0;
	
        		xhr.onreadystatechange = function (event) {
	            if( xhr.readyState == 4 ) {
              	Bps = Math.round( (postSizeInMB * 1048576) / ( ( new Date() - startTime ) / 1000 ) ); // divide num bytes uploaded by num seconds elapsed
              	showUploadResults(Bps);
            	};
        		};
	
       			xhr.open( 'POST', url, true );
        		startTime = new Date();
        		xhr.send( data );
    			};

    		function getRandomString(sizeInMB) {
	    		var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789~!@#$%^&*()_+`-=[]\{}|;':,./<>?"; //random data prevents gzip effect
       		var bytes = sizeInMB * 1024 * 1024; // get byte conversion for input
        	var result = '';
        	for( var index = 0; index < bytes; index++ ) {
          	result += chars.charAt( Math.floor( Math.random() * chars.length ) );  // 1 char = 1 byte
        	};     
        	return result;
    		};
			};

			function showUploadResults(Bps) {
		  	speedMbps = ((Bps * 8) / 1048576).toFixed(1);
		  	var uProgress = document.getElementById("uprogress");
		  	var uImage = document.getElementById("upload_speed");
		  	if (speedMbps > 1) {
		      uImage.src =  "<?php echo(Utilities::getHttpImagePath()); ?>/fa-check-square-o_16_486326.png";
	 	  		uProgress.innerHTML = "Your&nbsp;upload&nbsp;speed&nbsp;is&nbsp;" + speedMbps + "&nbsp;Mbps";
          uspeed = true;
		  	} else if (speedMbps > .5) {
		      uImage.src =  "<?php echo(Utilities::getHttpImagePath()); ?>/fa-check-square-o_16_f68620.png";
	 	  		uProgress.innerHTML = "Your&nbsp;upload&nbsp;speed&nbsp;is&nbsp;" + speedMbps + "&nbsp;Mbps" +
		  			"<a href='javascript:void(0);' onclick='toggleTooltip(\"upSpeedTip\");' class='tooltip'>" + 
						"<span id='upSpeedTip' style='width:250px;'>" +
        		"	<img class='callout' src='image/callout.gif' />	" +
        		"	<table>" +
        		"		<tr><td>" + 
        		"			<p>Your upload speed meets basic recommendations</p>" +
        		"			<p>If there is fluctuation in your upload speed, you may experience some connectivity problems.</p>" +
        		" 		<p>Consider limiting your media connection to microphone-only (no camera)</p>" +
        		"			<p>For best results, avoid a public wifi connection as these tend to be sporadic in quality. Consider using a wired connection, if possible.</p>" +
        		"			</td></tr>" +
        		"	 </table>" +
    				"	</span>" +
						"<span style='padding:5px;vertical-align:top;' class='fa fa-info-circle' ></span>" + 
						"</a>";;
          uspeed = true;
		  	} else {
		      uImage.src =  "<?php echo(Utilities::getHttpImagePath()); ?>/fa-exclamation-triangle_16_f64620.png";
	 	  		uProgress.innerHTML = "Your&nbsp;upload&nbsp;speed&nbsp;is&nbsp;" + speedMbps + "&nbsp;Mbps" +
		  			"<a href='javascript:void(0);' onclick='toggleTooltip(\"upSpeedTip\");' class='tooltip'>" + 
						"<span id='upSpeedTip' style='width:250px;'>" +
        		"	<img class='callout' src='image/callout.gif' />	" +
        		"	<table>" +
        		"		<tr><td>" + 
        		"			<p>Your upload speed is slower than recommended.</p>" + 
        		"			<p>You will probably experience connectivity problems.</p>" +
        		"			<p>Consider limiting your media connection to listen-only.</p>" +
        		"			<p>For best results, avoid a public wifi connection as these tend to be sporadic in quality. Consider using a wired connection, if possible.</p>" +
        		"			</td></tr>" +
        		"	 </table>" +
    				"	</span>" +
						"<span style='padding:5px;vertical-align:top;' class='fa fa-info-circle' ></span>" + 
						"</a>";
          uspeed = false;
		  	}
			};


 			// This function calculates download speed relative to the northbridge web conference server
 			// Once the speed is calculated it rewrites the DOM with the calculated value. That happens inside the showDownloadResults() function.
			function MeasureDownConnectionSpeedByPost() {
				
	    	var dProgress = document.getElementById("dprogress");
	    	var dImage = document.getElementById("download_speed");
	    	var starttime, endTime;
				var xhr = getXmlHttpRequest();
        var url = 'http://ec2-50-19-215-104.compute-1.amazonaws.com/bigbluebutton/images/speedtest-8MB.png';
        var speed = 0;
				xhr.open( 'GET', url, true );
				// LEFT OFF - why is this not working? see chrome request headers, these do not exist. aargh... 
				// reverting to MeasureDownConnectionSpeed for production (line 163)
				xhr.setRequestHeader('Cache-Control', 'no-cache');
				xhr.setRequestHeader('Pragma', 'no-cache');
				xhr.setRequestHeader('Expires', '0');
				xhr.setRequestHeader('Pragma-directive', 'no-cache');				
				xhr.setRequestHeader('Cache-directive', 'no-cache');	
				startTime = new Date();
				xhr.send();
											
        xhr.onreadystatechange = function (event) {
	         if( xhr.readyState == 4 ) {
           	Bps = Math.round( (8 * 1048576) / ( ( new Date() - startTime ) / 1000 ) ); // divide num bytes uploaded by num seconds elapsed
           	showDownloadResultsByPost(Bps);
         	};
        };
				
				//===============================================
				
  			// TODO - pull this address from bbb config.php and get this resource into build/deploy cycle
  			// This file resides on jean at /var/lib/tomcat7/webapps/bigbluebutton/images, also, renamed from .jpg to .png to get around web server url filter
 				//var imageAddr = "http://ec2-50-19-215-104.compute-1.amazonaws.com/bigbluebutton/images/speedtest-8MB.png"; 
				//var downloadSize = 7907740; //image size in Bytes				
	    	//var dProgress = document.getElementById("dprogress");
	    	//var dImage = document.getElementById("download_speed");
    		//var startTime, endTime;
    		//var download = new Image();
    		//download.onload = function () {
	        //	endTime = (new Date()).getTime();
        		//showDownloadResults();
    			//}
	   
	    	//download.onerror = function (err, msg) {
	      // 		dProgress.innerHTML = "Undetermined (server error)";
	      // 		dImage.src =  "<?php echo(Utilities::getHttpImagePath()); ?>/fa-question_16_f68620.png"
  	  	//	}
	    
    		//startTime = (new Date()).getTime();
    		//var cacheBuster = "?nnn=" + startTime;
    		//download.src = imageAddr + cacheBuster;
    		
    		//===================================================
	    
    		function showDownloadResultsByPost(Bps) {
	        //var duration = (endTime - startTime) / 1000;
        	//var bitsLoaded = downloadSize * 8;
        	//var speedbps = (bitsLoaded / duration).toFixed(2);
        	//var speedKbps = (speedbps / 1024).toFixed(2);
        	//var speedMbps = (speedKbps / 1024).toFixed(1);
        	var bps = Bps * 8;
        	var speedKbps = (bps / 1024).toFixed(2);
        	var speedMbps = (speedKbps / 1024).toFixed(1);

		  		if (speedMbps > 2) {
				  	dImage.src =  "<?php echo(Utilities::getHttpImagePath()); ?>/fa-check-square-o_16_486326.png";
				  	dProgress.innerHTML = "Your&nbsp;download&nbsp;speed&nbsp;is&nbsp;" + speedMbps + "&nbsp;Mbps";
              dspeed = true; 
		  		} else if (speedMbps > 1) {
				  	dImage.src =  "<?php echo(Utilities::getHttpImagePath()); ?>/fa-check-square-o_16_f68620.png";
		  			dProgress.innerHTML = "Your&nbsp;download&nbsp;speed&nbsp;is&nbsp;" + speedMbps + "&nbsp;Mbps" +
		  			"<a href='javascript:void(0);' onclick='toggleTooltip(\"downSpeedTip\");' class='tooltip'>" + 
						"<span id='downSpeedTip' style='width:250px;'>" +
        		"	<img class='callout' src='image/callout.gif' />	" +
        		"	<table>" +
        		"		<tr><td>" + 
        		"			<p>Your download speed meets basic recommendations</p>" +
        		"			<p>If there is fluctuation in your download speed, you may experience some connectivity problems.</p>" +
        		"			<p>For best results, avoid a public wifi connection as these tend to be sporadic in quality. Consider using a wired connection, if possible.</p>" +
        		"			</td></tr>" +
        		"	 </table>" +
    				"	</span>" +
						"<span style='padding:5px;vertical-align:top;' class='fa fa-info-circle' ></span>" + 
						"</a>";
              dspeed = true;
		  		} else {
				  	dImage.src =  "<?php echo(Utilities::getHttpImagePath()); ?>/fa-exclamation-triangle_16_f64620.png";
		  			dProgress.innerHTML = "Your&nbsp;download&nbsp;speed&nbsp;is&nbsp;" + speedMbps + "&nbsp;Mbps" +
		  			"<a href='javascript:void(0);' onclick='toggleTooltip(\"downSpeedTip\");' class='tooltip'>" + 
						"<span id='downSpeedTip' style='width:250px;'>" +
        		"	<img class='callout' src='image/callout.gif' />	" +
        		"	<table>" +
        		"		<tr><td>" + 
        		"			<p>Your download speed is slower than recommended.</p>" + 
        		"			<p>You will probably experience connectivity problems.</p>" +
        		"			<p>For best results, avoid a public wifi connection as these tend to be sporadic in quality. Consider using a wired connection, if possible.</p>" +
        		"			</td></tr>" +
        		"	 </table>" +
    				"	</span>" +
						"<span style='padding:5px;vertical-align:top;' class='fa fa-info-circle' ></span>" + 
						"</a>";
              dspeed = false;
		  		}

    		}
    		
			}