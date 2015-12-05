<script>
	function getEventDetail(eventUuid) {
		var xmlhttp = new XMLHttpRequest();
		xmlhttp.onreadystatechange=function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			 	var jsonObj = JSON.parse(xmlhttp.responseText);		 	
				var i = 0;
				// confirm 1 item returned
				
		 		tableEvent = 
		 			"<td>" +
       			"<div class='detail'>" +
       					"<span class='date'>" + jsonObj[i].purpose + "</span><br/>" +
       					"<span>" + jsonObj[i].location + "</span><br/>" + 
       					"<span class='tod'>" + jsonObj[i].hour + ":" + jsonObj[i].minute + "</span><span class='period'> " + jsonObj[i].period + " </span> - " +
								"<span class='tod'>" + jsonObj[i].hour_end + ":" + jsonObj[i].minute_end + "</span><span class='period'> " + jsonObj[i].period_end + " </span>" +
								"<span class='period'> " + jsonObj[i].abbrev + "</span>" +
								(jsonObj[i].descr ? "<p><span>" + jsonObj[i].descr + "</span></p>" : "") + 
								(jsonObj[i].url ? "<p><span><a href='http://" + jsonObj[i].url + "' target='_blank'>More Information</a></span></p>" : "") + 							
						"</div>" +
     			"</td>";
        document.getElementById("join_control_mode").innerHTML = "<a id='public-meeting-join' href='modules/meeting/control/joinMeetingProcessor.php?id=" + jsonObj[i].uuid + "&type=" + jsonObj[i].mtype + "' target='_blank'></a>";
    		document.getElementById("eventRow0").innerHTML = tableEvent;
    		if (jsonObj[i].running == "true") {
        	document.getElementById("login-form-submit").innerHTML = "Join This Meeting";
        	document.getElementById("login-form-submit").className = "pure-button pure-button-primary";
     		}
     	}
		}
		xmlhttp.open("GET", "<?php echo(Utilities::getHttpPath()); ?>" + "/src/framework/eventDetailManager.php?uuid=" + eventUuid);
		xmlhttp.send();  		
	}
</script>
	
<div id="current_detail_display">	
	<div id="join_control_mode"></div>
	<table id="detailTable" class="pure-table">
		<tr id="eventRow0"></tr>
	</table>
</div>
