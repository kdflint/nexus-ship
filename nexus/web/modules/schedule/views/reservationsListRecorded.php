<script>
	function getEventListRecorded() {
		var xmlhttp = getXmlHttpRequest();
		xmlhttp.onreadystatechange=function() {	
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				var jsonObj = JSON.parse(xmlhttp.responseText);
			 	var nextRecording = undefined;
			 	var tableRows = "";
			 	for (var i = 0; i < jsonObj.length; i++) { 
			 		tableRows = tableRows + "<div id='recordingRow" + i + "' class='div-tr' style='position:relative;'></div>";
			 		nextRecording = i; 
			 	}
			 	document.getElementById("recordingsTable").innerHTML = tableRows;
				if (nextRecording === undefined) {
					message1 = '<?php echo _("Recordings"); ?>';
					message2 = '<?php echo _("There are no recordings available."); ?>';
					tableRow = "<div id='reservationRow0' class='div-tr' style='position:relative;'>" + 
       			"<div class='td-div' style='height:70px;'>" +
		      		"<div class='event'>" +		
	       				"<span class='date' style='font-size:140%;'>" + message1 + "</span><br/>" + 				
          		"</div>" +
          	"</div>" +
       			"<div id='nowEventDetail' class='td-div' style='position:absolute;left:140px;top:5px;height:70px;'>" +	  	       				
			       	"<div class='meeting'>" +
          			"<span class='purpose'>" + message2 + "</span>" + 
          		"</div>" +
          	"</div>" +
					"</div>";
					document.getElementById("recordingsTable").innerHTML = tableRow
				} else {
			 		for (var i = 0; i < jsonObj.length; i++) {
			 			message1 = '<?php echo _("Attendees"); ?>';
			 			var d = new Date(parseInt(jsonObj[i].start[0]));
			 			var d_parts = d.toLocaleString().split(',');
			 			var playHtmlString = 
			 				(jsonObj[i].published[0] ?
			 					"<a href='" + jsonObj[i].url[0] + "' target='_blank'><span class='fa fa-play-circle fa-2x'></span></a> " : 
			 					"<span class='fa fa-play-circle fa-2x' style='color:#cccccc;'></span> "
			 				);
			 			tableEvent = 
       				"<div class='td-div'>" +
	       				"<div class='event'>" +
  					  		"<span class='day'>" + d_parts[0] + "<br/>" + d_parts[1] + "</span><br/>" +
								"</div>" +
      				"</div>" +
      				 
       				"<div id='nowEventDetail' class='td-div' style='position:absolute;left:140px;top:5px;height:70px;'>" +	  	       				
				       	"<div class='meeting'>" +
          				"<span class='day'>" + playHtmlString + jsonObj[i].name + //" | " + message1 + ": " + jsonObj[i].participants[0] +
          				"</span>" +
          			"</div>" +
          		"</div>";
      			document.getElementById("recordingRow" + i).innerHTML = tableEvent;	
      		}      		
      	}		 			
			}
		}
				
		xmlhttp.open("GET", "<?php echo(Utilities::getHttpPath()); ?>" + "/src/framework/recordingManagerNew.php");
		xmlhttp.send();  		
	}
</script>

<div id="recordingsTable" class="table-div">
	<script> getEventListRecorded(); </script>
</div>
					

