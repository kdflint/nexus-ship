<script>
	function getEventList(referenceTime) {
		var xmlhttp = new XMLHttpRequest();
		xmlhttp.onreadystatechange=function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			 	var jsonObj = JSON.parse(xmlhttp.responseText);		 	

			 	// put row containers in the reservation table, 1 for each event
			 	var tableRows = "";
			 	for (var i = 0; i <= jsonObj.length; i++) { 
			 		tableRows = tableRows + "<tr id='reservationRow" + i + "'></tr>";
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
        					"<span class='purpose'>" + jsonObj[i].purpose + "</span><br/>" +
								"<span>" + jsonObj[i].hour + ":" + jsonObj[i].minute + "</span><span class='period'> " + jsonObj[i].period + " </span> - " +
								"<span>" + jsonObj[i].hour_end + ":" + jsonObj[i].minute_end + "</span><span class='period'> " + jsonObj[i].period_end + " </span>" +
								"<span class='period'> " + jsonObj[i].abbrev + "</span>" +
        			"</div>" +
        		"</td>";
    			document.getElementById("reservationRow" + i).innerHTML = tableEvent;   
	   		}
     			
     		var lastRow = jsonObj.length;
     		tableEvent =
	      	"<td>" +
		    		"<div class='event'>" +	
		    		"<a id='schedule_control' href='javascript:void(0);' style='padding:0px;'>"	+
		    			"<span style='padding:0px;' class='fa fa-calendar-o fa-2x' ></span>" + 
							"<span style='padding-left:2px;' class='fa fa-plus' ></span>" +
						"</a>	" +				
        		"</div>" +
        	"</td>" +
        	"<td>" +	       				
			     	"<div class='meeting'>" +
        			"<span class='purpose'>Click the calendar icon to submit a new event.</span>" + 
         		"</div>" +
         	"</td>";
				document.getElementById("reservationRow" + lastRow).innerHTML = tableEvent;    			
     	}
		}
		xmlhttp.open("GET", "<?php echo(Utilities::getHttpPath()); ?>" + "/src/framework/reservationManager.php");
		xmlhttp.send();  		
	}
</script>

<div style="">
			
<div id="current_schedule_display">	
	<table id="reservationTable" class="pure-table">
	</table>
</div>

<script> getEventList(<?php echo (time() + 15*60); ?>); </script>
	
</div>