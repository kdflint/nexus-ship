<script>
	function getEventListPublic(referenceTime) {
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
	       				"<span class='date'>Upcoming</span><br/>" + 				
          		"</div>" +
          	"</div>" +
       			"<div id='nowEventDetail' class='td-div' style='position:absolute;left:140px;top:5px;height:70px;'>" +	  	       				
			       	"<div class='meeting'>" +
          			"<span class='purpose'>There are no upcoming events on the public calendar.</span>" + 
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
       			      "<a href='#openEventDetail' onclick='getEventDetail(\"" + jsonObj[i].uuid + "\");' '<span style='padding-right:10px;color:#d27b4b;' class='fa fa-plus-square'></span></a>" +
         					"<span class='purpose'>" + truncateString(jsonObj[i].purpose, '70') + "</span>" +
         						(jsonObj[i].recur ? "<p style='background-color:#dddddd;padding:4px;border-radius:5px;margin-top:3px;'>This is a multi-day event.</p>" : "") + 
         						//((jsonObj[i].location != null) ? "<p><span class='fa fa-map-marker'></span> " + jsonObj[i].location : "</p>") +
										//(jsonObj[i].contact ? "<p><span>Original submission by public user: " + jsonObj[i].contact + "</span></p>" : "") +
										"<p><span>Approved by: " + jsonObj[i].fname + " " + jsonObj[i].lname + "</span>" +
										((true) ? "<a href='#openEventEdit' onclick='return populateEventForm(\"" + i + "\");' title='Edit'><span class='fa fa-pencil' style='color:#d27b4b;margin-left:10px;'></span></a>" : "") + 
										((true) ? "<a href='<?php echo(Utilities::getHttpPath()); ?>/modules/schedule/control/eventDeleteProcessor.php?id=" + jsonObj[i].uuid + "' onclick='return confirm(\"Please confirm this delete.\");' title='Delete''><span class='fa fa-trash-o' style='color:#d27b4b;margin-left:10px;'></span></a></p>" : "") +
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
		xmlhttp.open("GET", "<?php echo(Utilities::getHttpPath()); ?>" + "/src/framework/reservationManagerPublic.php");
		xmlhttp.send();  		
	}
</script>
					

	