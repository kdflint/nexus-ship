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
       			"<div class='event'>" +
		    				"<a id='schedule_control' href='javascript:void(0);' onclick='toggleDisplay(\"show-event\");' style='padding:0px;'>"	+
		    					"<span class='fa fa-chevron-circle-left fa-2x' style='margin-right:5px;' ></span>" + 
		    				"</a>" + 
       					"<span class='date'>" + jsonObj[i].purpose + "</span><br/>" +
       					"<span>" + jsonObj[i].location + "</span><br/>" + 
       					"<span class='tod'>" + jsonObj[i].hour + ":" + jsonObj[i].minute + "</span><span class='period'> " + jsonObj[i].period + " </span> - " +
								"<span class='tod'>" + jsonObj[i].hour_end + ":" + jsonObj[i].minute_end + "</span><span class='period'> " + jsonObj[i].period_end + " </span>" +
								"<span class='period'> " + jsonObj[i].abbrev + "</span>" +
								(jsonObj[i].descr ? "<p><span>" + jsonObj[i].descr + "</span></p>" : "") + 
								(jsonObj[i].registration ? "<p><span>" + jsonObj[i].registration + "</span></p>" : "") + 
								(jsonObj[i].url ? "<p><span><a href='http://" + jsonObj[i].url + "'>More Information</a></span></p>" : "") + 
								(jsonObj[i].contact ? "<p><span>" + jsonObj[i].contact + "</span></p>" : "") +  
						"</div>" +
     			"</td>";
    		document.getElementById("eventRow0").innerHTML = tableEvent;   
     	}
		}
		xmlhttp.open("GET", "<?php echo(Utilities::getHttpPath()); ?>" + "/src/framework/eventDetailManager.php?uuid=" + eventUuid);
		xmlhttp.send();  		
	}
</script>

<div style="">
			
<div id="current_detail_display">	
	<table id="detailTable" class="pure-table">
		<tr id="eventRow0"></tr>
	</table>
</div>

</div>