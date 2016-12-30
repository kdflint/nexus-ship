<script>
	function getEventList(referenceTime) {
		var xmlhttp = getXmlHttpRequest();
		xmlhttp.onreadystatechange=function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			 	var jsonObj = JSON.parse(xmlhttp.responseText);	 	
			 	// put row containers in the reservation table, 1 for each event
			 	var tableRows = "";
			 	var n = -1;
			 	for (var i = 0; i < jsonObj.length; i++) { 
			 		// increment class name every 5 items to faciliate pagination
			 		n = (i % viewSetSize == 0 ? n + 1 : n); 
			 		tableRows = tableRows + "<div id='reservationRow" + i + "' class='tr-div viewSet" + n + "' style='position:relative;'></div>";
			 	}
       	document.getElementById("reservationTable").innerHTML = tableRows;   	

				// TODO - this will break if not displayed with a view that implements showEventDetail()
				
				if (jsonObj.length > 0) {
					/// TODO - will document certainly be loaded with this method? Not liking these two views coupled like this...
					showEventDetail(jsonObj[0].uuid);
				}

		 		for (var i = 0; i < jsonObj.length; i++) {
		 			tableEvent = 
       			"<div class='td-div'>" +
       				"<div class='event'>" +
 					  		"<span class='day'>" + jsonObj[i].day + "</span><br/>" +
									"<span class='date'>" + jsonObj[i].date + "</span><br/>" +
									"<span class='month'>" + jsonObj[i].month + "</span><br/>" +
							"</div>" +
     				"</div>" +
       			"<div class='td-div' style='position:absolute;left:90px;top:5px;height:90px;'>" + 
	          	"<div class='meeting'>" +
        				"<a href='javascript:void(0);' onclick='showEventDetail(\"" + jsonObj[i].uuid + "\");'><span class='purpose'>" + truncateString(jsonObj[i].purpose) + "</span></a><br/>" +
        				(
        					jsonObj[i].recur 
        					?
        					"<span class='tod' style='background-color:#dddddd;position:absolute;width:120px;padding:4px;border-radius:5px;margin-top:3px;'>multi-day event</span>"
        					: 
									"<span class='tod'>" + jsonObj[i].hour + ":" + jsonObj[i].minute + "</span><span class='period'> " + jsonObj[i].period + " </span> - " +
									"<span class='tod'>" + jsonObj[i].hour_end + ":" + jsonObj[i].minute_end + "</span><span class='period'> " + jsonObj[i].period_end + " </span>" +
									"<span class='period'> " + jsonObj[i].abbrev + "</span>"
									) +
        			"</div>" +
        		"</div>";
    			document.getElementById("reservationRow" + i).innerHTML = tableEvent;   
    			document.getElementById("reservationRow" + i).style.height = "90px";
	   		}    			
	   	//document.getElementById('reservationTable').style.height = (180 * jsonObj.length) + "px";
     	scrollEvents(viewSetSize,'forward');
			}
		}
		xmlhttp.open("GET", "<?php echo(Utilities::getHttpPath()); ?>" + "/src/framework/reservationManager.php", true);
		xmlhttp.send();  		
	}

</script>
	
<div id="current_schedule_display">	
	<div class="scroll" style="top:-10px;z-index:10;"><a id='eventUpControl' onclick="scrollEvents(viewSetSize,'back');" style="display:none;"><span class='fa fa-caret-up fa-3x' ></span></a></div>
	<div style="position:absolute;top:20px;width:100%;">
		<div id="reservationTable" class="table-div" style="border: 0px none !important;">
			<div style="text-align:center;"><span class='fa fa-spinner fa-spin fa-lg' style="margin-right:10px;"></span>Loading calendar...</div></div>
	</div>
	<div class="scroll" style="top:365px;z-index:10;"><a id='eventDownControl' onclick="scrollEvents(viewSetSize,'forward');" style="display:none;"><span class='fa fa-caret-down fa-3x' ></span></a></div>
</div>

<script> 
	getEventList(<?php echo (time() + 15*60); ?>);
	var curViewSet = -1;
	var viewSetSize = 4;
</script>
	