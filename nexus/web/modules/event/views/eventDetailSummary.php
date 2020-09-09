<script>
	function getEventDetail(eventUuid) {
		//console.log("running getEvent()");
		var xmlhttp = getXmlHttpRequest();
		var tableEvent = buttonLabel = "";
		xmlhttp.ontimeout = function () {
			MEETING_INFO_NEXT_REFRESH = "15000";
     	tableEvent = "Meeting information is unavailable at this time. Please try reloading browser page. (timeout)";
     	document.getElementById("login-form-submit").innerHTML = "Meeting Unavailable";
     	document.getElementById("eventRow0").innerHTML ="<div class='td-div'>" + tableEvent + "<div>";
  	};
		xmlhttp.onreadystatechange=function() {
			var jsonObj;
			if (xmlhttp.readyState == 4) {
				evaluate: if (xmlhttp.status == 200) {
			 		try {
				 		jsonObj = JSON.parse(xmlhttp.responseText);
			 		} catch(e) {
			 			MEETING_INFO_NEXT_REFRESH = "15000";
	     			tableEvent = "Meeting information is unavailable at this time. Please try reloading browser page.";
     				buttonLabel = "Meeting Unavailable";	
     				break evaluate;		 				 	
     			}
					var i = 0;
					var d = new Date();
					var now = Math.ceil(d.getTime()/1000);
		 			tableEvent = 
					 		"<span>Dial-in Number (US): " + (jsonObj[i].dial && jsonObj[i].bridge ? jsonObj[i].dial : "(Not yet available)") + "</span><br/>" +
							 (jsonObj[i].dial && jsonObj[i].bridge ? "<span>Dial-in PIN: " + jsonObj[i].bridge + "</span><br/>" : "") + 
       						"<p><span class='date'>" + jsonObj[i].purpose + "</span></p>" +  					  		
  					  		"<p><span>" + jsonObj[i].day + ", " + jsonObj[i].month + " " + jsonObj[i].date + "</span><br/>" +
       						"<span class='tod'>" + jsonObj[i].hour + ":" + jsonObj[i].minute + "</span><span class='period'> " + jsonObj[i].period + " </span> -" +
									"<span class='tod'>" + jsonObj[i].hour_end + ":" + jsonObj[i].minute_end + "</span><span class='period'> " + jsonObj[i].period_end + " </span>" +
									"<span class='period'> " + jsonObj[i].abbrev + "</span></p>" +
									(jsonObj[i].descr ? "<p><span>" + jsonObj[i].descr + "</span></p>" : "") + 
									(jsonObj[i].url ? "<p><span><a href='" + jsonObj[i].url + "' target='_blank'>More Information</a></span></p>" : "");
        	document.getElementById("join_control_mode").innerHTML = "<a id='public-meeting-join' href='modules/meeting/control/joinMeetingProcessor.php?id=" + jsonObj[i].uuid + "&type=" + jsonObj[i].mtype + "' target='_blank'></a>";
    			//if (jsonObj[i].running == "true") {
				if (jsonObj[i].running) {
	        	buttonLabel = "Join This Meeting Online";
        		document.getElementById("login-form-submit").className = "pure-button pure-button-primary";
                document.forms["public-join-form"]["mid"].value = jsonObj[i].uuid;
        		MEETING_INFO_NEXT_REFRESH = "60000";
        		if (!IS_NOW) {
	        		playSound('demonstrative');
	       			IS_NOW = true;
						}
     			} else {
	     			MEETING_INFO_NEXT_REFRESH = (jsonObj[i].epoch > now+(70*60)) ? "300000" : "60000";
	     			NEXT_MEETING_START = jsonObj[i].epoch-now;
	     			IS_NOW = false;
	     			var waitMessage = "Please wait for host";
	     			if (NEXT_MEETING_START < 0) {
	     				waitMessage = "Please wait for host";
	     			}
	     			buttonLabel = "<span id='not-started-message' style='position:absolute;left:20px;font-size:110%;'>" + waitMessage + "</span><span id='countdown' style='margin-left:240px;margin-top:2px;float:left;'></span>";
	     			document.getElementById("login-form-submit").className = "pure-button pure-button-primary pure-button-disabled";
					document.forms["public-join-form"]["mid"].value = "invalid";
	     			if (!IS_TIMER_INIT) {
	     				window.setInterval(countdownTimer, 1000);
 							IS_TIMER_INIT = true;
	     			}
     			}
     		} else {
     			MEETING_INFO_NEXT_REFRESH = "15000";
	     		tableEvent = "Meeting information is unavailable at this time. Please try reloading browser page. (" + xmlhttp.status + ")";
     			buttonLabel = "Meeting Unavailable";
     		}
     	document.getElementById("eventRow0").innerHTML = "<div class='td-div'>" + tableEvent + "<div>";
     	document.getElementById("login-form-submit").innerHTML = buttonLabel;
     	}
		}
		xmlhttp.open("GET", "<?php echo(Utilities::getHttpPath()); ?>" + "/src/framework/eventDetailManager.php?uuid=" + eventUuid, true);
		xmlhttp.timeout = 15000;
		xmlhttp.send();  		
	}
</script>
	
<div id="current_detail_display">	
	<div id="join_control_mode"></div>
	<div id="detailTable" class="table-div">
		<div id="eventRow0" class="tr-div">
			<div class="td-div"><span class='fa fa-spinner fa-spin fa-lg'></span> Loading meeting information...</div>
		</div>
	</div>
</div>
