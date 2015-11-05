<script>
	function getEventList(referenceTime) {
		var xmlhttp = new XMLHttpRequest();
		xmlhttp.onreadystatechange=function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			 	var jsonObj = JSON.parse(xmlhttp.responseText);		 	

			 	// put row containers in the reservation table, 1 for each event
			 	var nextMeetings = undefined;
			 	var tableRows = "";
			 	for (var i = 0; i < jsonObj.length; i++) { 
			 		tableRows = tableRows + "<tr id='reservationRow" + i + "'></tr>";
			 		nextMeetings = i; 
			 	}
       	document.getElementById("reservationTable").innerHTML = tableRows;

				// write the current meeting into its row container, or default content if none
				nowEvent = "";
    	
       	// write each future event into its row container
				if (nextMeetings === undefined) {
					tableRow = "<tr id='reservationRow0'>" + 
	       		"<td>" +
		      		"<div class='event'>" +		
	       				"<span class='date'>Future</span><br/>" + 				
          		"</div>" +
          	"</td>" +
          	"<td>" +	       				
			       	"<div class='meeting'>" +
          			"<span class='purpose'>Click the calendar icon to add an event.</span>" + 
          		"</div>" +
          	"</td>" +
					"</tr>";
					document.getElementById("reservationTable").innerHTML = tableRow
				} else {
			 		for (var i = 0; i < jsonObj.length; i++) {
			 			tableEvent = 
			 				"<td>" +
	       				"<div class='event'>" +
  					  		"<span class='day'>" + jsonObj[i].day + "</span><br/>" +
 									"<span class='date'>" + jsonObj[i].date + "</span><br/>" +
 									"<span class='month'>" + jsonObj[i].month + "</span><br/>" +
 									"<span>" + jsonObj[i].hour + ":" + jsonObj[i].minute + "</span><span class='period'> " + jsonObj[i].period + " " + jsonObj[i].abbrev + "</span>" +
								"</div>" +
      					"</td>" +
         			"<td>" +
		          	"<div class='meeting'>" +
         					"<span class='purpose'>" + jsonObj[i].purpose + "</span><br/>" +
         					"<span class='descr' style='font-size:90%;width:90%;padding-right:80px;' >" + jsonObj[i].descr + 
         					((jsonObj[i].location != null) ? "<br/><span class='fa fa-map-marker'></span> " + jsonObj[i].location : "") +
		          			//"<p><span style='padding-right:5px;margin:0px;color:#d27b4b;' class='fa fa-envelope' ></span>Reserved by: " + jsonObj[i].fname + " " +  jsonObj[i].lname + "<span id='reserveLname'></span></p>" +
          					"<p>reserved by " + 
          					((jsonObj[i].adder == <?php echo(Utilities::getDemoUidpk()); ?>) ? '<?php echo($_SESSION['fname']); ?>' : jsonObj[i].fname) + " " +  
          					((jsonObj[i].adder == <?php echo(Utilities::getDemoUidpk()); ?>) ? '<?php echo($_SESSION['lname']); ?>' : jsonObj[i].lname) + 
          					((jsonObj[i].adder == jsonObj[i].sessionUser) ? "<br/><a href='<?php echo(Utilities::getHttpPath()); ?>/modules/schedule/control/eventDeleteProcessor.php?id=" + jsonObj[i].uuid + "' onclick='return confirm(\"Please confirm this delete.\");'><span class='fa fa-trash-o' style='color:#d27b4b;'></span></a></p>" : " ") +
         					"</span>" +
         				"</div>" +
         			"</td>";
     				document.getElementById("reservationRow" + i).innerHTML = tableEvent;   
     			}
     		}
			}
		}
		xmlhttp.open("GET", "<?php echo(Utilities::getHttpPath()); ?>" + "/src/framework/reservationManager.php");
		xmlhttp.send();  		
	}
</script>

<div style="width:760px;font-size:110%;">

	<div id="new_event_display" style="display:none;">
		<?php include(Utilities::getModulesRoot() . "/event/views/eventAdd.php"); ?>	
	</div>
						
	<div id="current_schedule_display" style="display:block;">
		<a id='schedule_control' href='javascript:void(0);' style='position:absolute;margin-left:690px;padding-top: 20px;'>
		<span style='padding:0px;' class='fa fa-calendar-o fa-2x' ></span>
		<span style='padding-left:2px;' class='fa fa-plus' >	</span>
		</a>				
		<table id="reservationTable" class="pure-table">
		</table>
	</div>
	
	<script> getEventList(<?php echo (time() + 15*60); ?>); </script>
	
</div>