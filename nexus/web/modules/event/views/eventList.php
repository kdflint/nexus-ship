<script>
	function getEventList(referenceTime) {
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
	       				"<span class='date'>Now</span><br/>" + 				
          		"</div>" +
          	"</div>" +
       			"<div id='nowEventDetail' class='td-div' style='position:absolute;left:140px;top:5px;height:120px;'>" +	  	       				
			       	"<div class='meeting'>" +
          			"<span class='purpose'>There are no upcoming events on the calendar.</span>" + 
          			"</p>" +
          		 "</div>" +
          	"</div>" +
					"</div>";
					document.getElementById("reservationTable").innerHTML = tableRow
				} else {
			 		for (var i = 0; i < jsonObj.length; i++) {
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
         					"<span class='purpose'>" + jsonObj[i].purpose + "</span><br/>" +
         					"<span class='descr' style='font-size:90%;width:90%;padding-right:80px;' ><p>" + jsonObj[i].descr.replace(new RegExp( '~', 'g' ), '</p><p>') + "</p>" + 
         					((jsonObj[i].location != null) ? "<span class='fa fa-map-marker'></span> " + jsonObj[i].location : "") +
		          			//"<p><span style='padding-right:5px;margin:0px;color:#d27b4b;' class='fa fa-envelope' ></span>Reserved by: " + jsonObj[i].fname + " " +  jsonObj[i].lname + "<span id='reserveLname'></span></p>" +
          					"<p>reserved by " + 
          					((jsonObj[i].adder == <?php echo(Utilities::getDemoUidpk()); ?>) ? '<?php echo($_SESSION['fname']); ?>' : jsonObj[i].fname) + " " +  
          					((jsonObj[i].adder == <?php echo(Utilities::getDemoUidpk()); ?>) ? '<?php echo($_SESSION['lname']); ?>' : jsonObj[i].lname) + 
          					//((jsonObj[i].adder == jsonObj[i].sessionUser) ? "<a href='#openModal' onclick='return populateEditEventForm(\"" + i + "\");' title='Edit'><span class='fa fa-pencil' style='color:#d27b4b;margin-left:10px;'></span></a>" : " ") +
          					((jsonObj[i].adder == jsonObj[i].sessionUser) ? "<a href='<?php echo(Utilities::getHttpPath()); ?>/modules/schedule/control/eventDeleteProcessor.php?id=" + jsonObj[i].uuid + "' onclick='return confirm(\"Please confirm this delete.\");' title='Delete'><span class='fa fa-trash-o' style='color:#d27b4b;margin-left:10px;'></span></a></p>" : " ") +
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
		xmlhttp.open("GET", "<?php echo(Utilities::getHttpPath()); ?>" + "/src/framework/reservationManager.php");
		xmlhttp.send();  		
	}
</script>
			
	<div id="current_schedule_display" style="display:block;">		
		<div id="reservationTable" class="table-div">
		</div>
	</div>
	
	<script> getEventList(<?php echo (time() + 15*60); ?>); </script>
	
