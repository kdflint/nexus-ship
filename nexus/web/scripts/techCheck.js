      var dspeed = null, uspeed = null, has_flash = null, has_js = null;
			window.onload = function() {
    			var dProgress = document.getElementById("dprogress");
    			dProgress.innerHTML = "<span class='fa fa-spinner fa-spin fa-2x'></span>";
    			window.setTimeout(MeasureDownConnectionSpeed, 1);
			
					var uProgress = document.getElementById("uprogress");
					uProgress.innerHTML = "<span class='fa fa-spinner fa-spin fa-2x'></span>";
        	window.setTimeout(MeasureUpConnectionSpeed, 2);
        	
        	// Result of the above is that speedchecks are being done simultaneously
				};
			
 			// This function calculates download speed relative to the northbridge web conference server
 			// Once the speed is calculated it rewrites the DOM with the calculated value. That happens inside the showDownloadResults() function.
			function MeasureDownConnectionSpeed() {
				
  			// TODO - pull this address from bbb config.php and get this resource into build/deploy cycle
  			// This file resides on jean at /var/lib/tomcat7/webapps/bigbluebutton/images
 				var imageAddr = "http://ec2-50-19-215-104.compute-1.amazonaws.com/bigbluebutton/images/speedtest-8MB.jpg"; 
				var downloadSize = 7907740; //image size in Bytes				
	    	var dProgress = document.getElementById("dprogress");
    		var startTime, endTime;
    		var download = new Image();
    		download.onload = function () {
	        	endTime = (new Date()).getTime();
        		showDownloadResults();
    			}
	   
	    	download.onerror = function (err, msg) {
	       		dProgress.innerHTML = "Error checking download speed.";
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
        	dProgress.innerHTML = "Your&nbsp;download&nbsp;speed&nbsp;is&nbsp;" + speedMbps + "&nbsp;Mbps";

		  		if (speedMbps > 5) {
				  	document.getElementById("download_speed").src =  "http://northbridgetech.org/dev/nexus/view/image/green.png";
              dspeed = true; 
		  		} else if (speedMbps > 2) {
				  	document.getElementById("download_speed").src =  "http://northbridgetech.org/dev/nexus/view/image/orange.png";
              uspeed = false;
		  		} else {
				  	document.getElementById("download_speed").src =  "http://northbridgetech.org/dev/nexus/view/image/red.png";
              uspeed = false;
		  		}

    		}
    		
			}

			// This function calculates upload speed relative to the northbridge web server
 			// Once the speed is calculated it rewrites the DOM with the calculated value. That happens inside the showUploadResults() function.
			function MeasureUpConnectionSpeed() {
				check();

    		function check() {

	    			var xhr = new XMLHttpRequest();
	    			var postSizeInMB = 4;
          	var url = 'http://northbridgetech.org/dev/nexus/control/uploadSpeedTester.php?cache=' + Math.floor( Math.random() * 10000 ); //random number prevents url caching
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
	 	  	uProgress.innerHTML = "Your&nbsp;upload&nbsp;speed&nbsp;is&nbsp;" + speedMbps + "&nbsp;Mbps";
		  	if (speedMbps > 2) {
		       document.getElementById("upload_speed").src =  "http://northbridgetech.org/dev/nexus/view/image/green.png";
           uspeed = true;
		  	} else if (speedMbps > 1) {
		       document.getElementById("upload_speed").src =  "http://northbridgetech.org/dev/nexus/view/image/orange.png";
           uspeed = false;
		  	} else {
		       document.getElementById("upload_speed").src =  "http://northbridgetech.org/dev/nexus/view/image/red.png";
           uspeed = false;
		  	}
			};
