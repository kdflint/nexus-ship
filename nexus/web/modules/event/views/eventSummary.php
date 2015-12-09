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
			 		tableRows = tableRows + "<tr id='reservationRow" + i + "' class='viewSet" + n + "'></tr>";
			 	}
       	document.getElementById("reservationTable").innerHTML = tableRows;   	

		 		for (var i = 0; i < jsonObj.length; i++) {
		 			tableEvent = 
		 				"<td>" +
       				"<div class='event'>" +
 					  		"<span class='day'>" + jsonObj[i].day + "</span><br/>" +
									"<span class='date'>" + jsonObj[i].date + "</span><br/>" +
									"<span class='month'>" + jsonObj[i].month + "</span><br/>" +
							"</div>" +
     				"</td>" +
        		"<td>" +
	          	"<div class='meeting'>" +
        					"<a href='javascript:void(0);' onclick='showEventDetail(\"" + jsonObj[i].uuid + "\");'><span class='purpose'>" + jsonObj[i].purpose + "</span></a><br/>" +
								"<span class='tod'>" + jsonObj[i].hour + ":" + jsonObj[i].minute + "</span><span class='period'> " + jsonObj[i].period + " </span> - " +
								"<span class='tod'>" + jsonObj[i].hour_end + ":" + jsonObj[i].minute_end + "</span><span class='period'> " + jsonObj[i].period_end + " </span>" +
								"<span class='period'> " + jsonObj[i].abbrev + "</span>" +
        			"</div>" +
        		"</td>";
    			document.getElementById("reservationRow" + i).innerHTML = tableEvent;   
	   		}    			
     	scrollEvents(viewSetSize,'forward');
			}
		}
		xmlhttp.open("GET", "<?php echo(Utilities::getHttpPath()); ?>" + "/src/framework/reservationManager.php");
		xmlhttp.send();  		
	}

</script>
	
<div id="current_schedule_display">	
	<div class="scroll" style="top:5px;"><a id='eventUpControl' onclick="scrollEvents(viewSetSize,'back');"><span class='fa fa-caret-up fa-3x' ></span></a></div>
	<div style="position:absolute;top:40px;"><table id="reservationTable" class="pure-table" ></table></div>
	<div class="scroll" style="top:380px;"><a id='eventDownControl' onclick="scrollEvents(viewSetSize,'forward');"><span class='fa fa-caret-down fa-3x' ></span></a></div>
	<div style="position:absolute;top:430px">
		<a id='schedule_control' href='<?php echo(Utilities::getHttpPath()); ?>/plugin/eventCalendar.php?view=add' target='_blank' style='padding:0px;'>
			<span style='margin-left:18px;margin-right:5px;float:left' class='fa fa-calendar-o fa-2x' ></span>
			<span style='float:left' class='fa fa-plus' ></span>	
			<span class='tod' style="color:#333333;margin-left:20px;">Submit a new event</span>
		</a>	
  </div>
</div>

<script> 
	getEventList(<?php echo (time() + 15*60); ?>);
	var curViewSet = -1;
	var viewSetSize = 4;
</script>
	