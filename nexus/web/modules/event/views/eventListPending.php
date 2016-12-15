<script>
	function getEventListPending(referenceTime) {
		var xmlhttp = getXmlHttpRequest();
		xmlhttp.onreadystatechange=function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			 	var jsonObj = JSON.parse(xmlhttp.responseText);		 	
			 	currentEvents = jsonObj;
			 	// put row containers in the reservation table, 1 for each event
			 	var nextMeetings = undefined;
			 	var tableRows = "";
			 	for (var i = 0; i < jsonObj.length; i++) { 
			 		tableRows = tableRows + "<div id='reservationRow" + i + "' class='div-tr' style='position:relative;'></div>";
			 		nextMeetings = i; 
			 	}
       	document.getElementById("reservationTable").innerHTML = tableRows;

				// write the current meeting into its row container, or default content if none
				nowEvent = "";
    	
       	// write each future event into its row container
				if (nextMeetings === undefined) {
					tableRow = "<div id='reservationRow0' class='div-tr' style='position:relative;'>" + 
       			"<div class='td-div'>" +
		      		"<div class='event'>" +		
	       				"<span class='date'>Pending</span><br/>" + 				
          		"</div>" +
          	"</div>" +
       			"<div id='nowEventDetail' class='td-div' style='position:absolute;left:140px;top:5px;height:70px;'>" +	  	       				
			       	"<div class='meeting'>" +
          			"<span class='purpose'>All of your events have been published to your public calendar.</span>" + 
          		"</div>" +
          	"</div>" +
					"</div>";
					document.getElementById("reservationTable").innerHTML = tableRow
				} else {
			 		for (var i = 0; i < jsonObj.length; i++) {
			 		//for (var i = 0; i < 1; i++) {
			 			tableEvent = 
       				"<div class='td-div'>" +
	       				"<div class='event'>" +
  					  		"<span class='day'>" + jsonObj[i].day + "</span><br/>" +
 									"<span class='date'>" + jsonObj[i].date + "</span><br/>" +
 									"<span class='month'>" + jsonObj[i].month + "</span><br/>" +
 									"<span>" + jsonObj[i].hour + ":" + jsonObj[i].minute + "</span><span class='period'> " + jsonObj[i].period + " " + jsonObj[i].abbrev + "</span>" +
								"</div>" +
      				"</div>" +
       				"<div id='nowEventDetail' class='td-div' style='position:absolute;left:140px;top:5px;height:210px;'>" + 
		          	"<div class='meeting'>" +
         					"<span class='purpose'>" + jsonObj[i].purpose + "</span>" +
         						((jsonObj[i].location != null) ? "<p><span class='fa fa-map-marker'></span> " + jsonObj[i].location : "</p>") +
										(jsonObj[i].contact ? "<p><span>Follow up with: " + jsonObj[i].contact + "</span></p>" : "") +
          					((true) ? "<a href='#openEventEdit' onclick='return populateEventForm(\"" + i + "\");' title='Approve'><p><b>Approve for Public Calendar</b></a>" : " ") +
          					((true) ? "<a href='<?php echo(Utilities::getHttpPath()); ?>/modules/schedule/control/eventDeleteProcessor.php?id=" + jsonObj[i].uuid + "' onclick='return confirm(\"Please confirm this delete.\");' title='Delete'><span class='fa fa-trash-o' style='color:#d27b4b;margin-left:10px;'></span></a></p>" : " ") +								
          					/*"<p><a href='<?php echo(Utilities::getHttpPath()); ?>/modules/schedule/control/eventApproveProcessor.php?id=" + jsonObj[i].uuid + "'><b>Approve for Public Calendar</b></a> | " +*/
         					"</span>" +
         				"</div>" +
         			"</div>"; 
     				document.getElementById("reservationRow" + i).innerHTML = tableEvent; 
     				document.getElementById("reservationRow" + i).style.height = "180px";
     			}
     			document.getElementById('reservationTable').style.height = (180 * jsonObj.length) + "px";
     		}
			}
		}
		xmlhttp.open("GET", "<?php echo(Utilities::getHttpPath()); ?>" + "/src/framework/reservationManagerPending.php");
		xmlhttp.send();  		
	}
</script>
					
	