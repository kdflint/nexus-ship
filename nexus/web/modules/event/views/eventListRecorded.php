<script>
	function getEventListRecorded() {
		var xmlhttp = getXmlHttpRequest();
		xmlhttp.onreadystatechange=function() {	
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				console.log(xmlhttp.responseText);
				var jsonObj = JSON.parse(xmlhttp.responseText);
			 	var nextRecording = undefined;
			 	var tableRows = "";
			 	var showClipboardButton = Clipboard.isSupported();
			 	//for (var i = 0; i < jsonObj.length; i++) { 
			 	for (var i = 0; i <= jsonObj.length; i++) { 
			 		tableRows = tableRows + "<div id='recordingRow" + i + "' class='div-tr' style='position:relative;'></div>";
			 		nextRecording = i; 
			 	}
			 	document.getElementById("reservationTable").innerHTML = tableRows;
				if (nextRecording === undefined) {
					tableRow = "<div id='reservationRow0' class='div-tr' style='position:relative;'>" + 
       			"<div class='td-div'>" +
		      		"<div class='event'>" +		
	       				"<span class='date'>Recordings</span><br/>" + 				
          		"</div>" +
          	"</div>" +
       			"<div id='nowEventDetail' class='td-div' style='position:absolute;left:140px;top:5px;height:70px;'>" +	  	       				
			       	"<div class='meeting'>" +
          			"<span class='purpose'>There are no recordings available.</span>" + 
          		"</div>" +
          	"</div>" +
					"</div>";
					document.getElementById("reservationTable").innerHTML = tableRow
				} else {
			 		for (var i = 0; i < jsonObj.length; i++) {
			 			var d = new Date(parseInt(jsonObj[i].start[0]));
			 			tableEvent = 
       				"<div class='td-div'>" +
	       				"<div class='event'>" +
  					  		"<span class='day'>" + d.toLocaleString() + "</span><br/>" +
								"</div>" +
      				"</div>" +
      				 
       				"<div id='nowEventDetail' class='td-div' style='position:absolute;left:140px;top:5px;height:70px;'>" +	  	       				
				       	"<div class='meeting'>" +
          				"<span class='day'>Participants: " + jsonObj[i].participants[0] + " | " +
          				(jsonObj[i].state[0] == 'published' ? "<a href='" + jsonObj[i].url[0] + "' target='_blank'>View Presentation</a>" : "Presentation link pending") +
          				"</span>" +
          			"</div>" +
          		"</div>";
      			document.getElementById("recordingRow" + i).innerHTML = tableEvent;	
      		}      		
      	}		 			
			}
		}
				
		xmlhttp.open("GET", "<?php echo(Utilities::getHttpPath()); ?>" + "/src/framework/recordingManager.php");
		xmlhttp.send();  		
	}
</script>
					

	