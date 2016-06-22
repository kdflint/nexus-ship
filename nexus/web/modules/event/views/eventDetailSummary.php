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
					//console.log("Meeting refreshing...");
					//console.log("Meeting epoch = " + jsonObj[i].epoch);
					//console.log("Now epoch = " + now);
		 			tableEvent = 
       						"<span class='date'>" + jsonObj[i].purpose + "</span>" +
  					  		"<p><span>" + jsonObj[i].day + ", " + jsonObj[i].month + " " + jsonObj[i].date + "</span><br/>" +
       						"<span class='tod'>" + jsonObj[i].hour + ":" + jsonObj[i].minute + "</span><span class='period'> " + jsonObj[i].period + " </span> -" +
									"<span class='tod'>" + jsonObj[i].hour_end + ":" + jsonObj[i].minute_end + "</span><span class='period'> " + jsonObj[i].period_end + " </span>" +
									"<span class='period'> " + jsonObj[i].abbrev + "</span></p>" +
									(jsonObj[i].descr ? "<p><span>" + jsonObj[i].descr + "</span></p>" : "") + 
									(jsonObj[i].url ? "<p><span><a href='" + jsonObj[i].url + "' target='_blank'>More Information</a></span></p>" : "");
        	document.getElementById("join_control_mode").innerHTML = "<a id='public-meeting-join' href='modules/meeting/control/joinMeetingProcessor.php?id=" + jsonObj[i].uuid + "&type=" + jsonObj[i].mtype + "' target='_blank'></a>";
    			if (jsonObj[i].running == "true") {
	        	buttonLabel = "Join This Meeting";
        		document.getElementById("login-form-submit").className = "pure-button pure-button-primary";
        		// TODO - if a meeting is running, we do no more refreshes. Probably we should continue to check...?
        		MEETING_INFO_NEXT_REFRESH = 0;
        		playSound('demonstrative');
     			} else {
	     			//buttonLabel = "Not Started <span id='countdown'></span>";
	     			buttonLabel = "Not Started";
	     			MEETING_INFO_NEXT_REFRESH = (jsonObj[i].epoch > now+(70*60)) ? "300000" : "60000";
	     			//playSound('gets-in-the-way');
	     			//NEXT_MEETING_START = jsonObj[i].epoch;
	     			//window.setInterval(countdownTimer, 1000);
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
