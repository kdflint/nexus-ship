<script>
	function getEventList(referenceTime) {
		var xmlhttp = getXmlHttpRequest();
		xmlhttp.onreadystatechange=function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			 	var jsonObj = JSON.parse(xmlhttp.responseText);		 	
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
			 		//for (var i = 0; i < jsonObj.length; i++) {
			 		for (var i = 0; i < 1; i++) {
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
         					"<span class='descr' style='font-size:90%;width:90%;padding-right:80px;' >" + jsonObj[i].descr + 
         						((jsonObj[i].location != null) ? "<br/><span class='fa fa-map-marker'></span> " + jsonObj[i].location : "") +
										(jsonObj[i].url ? "<p><span><a href='http://" + jsonObj[i].url + "' target='_blank'>Web Link</a></span></p>" : "") +
										(jsonObj[i].fileext ? "<p><span><a href='<?php echo(Utilities::getPartnerFileUrl()); ?>/event-" + jsonObj[i].uuid + "." + jsonObj[i].fileext + "' target='_blank'>Flyer</a></span></p>" : "") + 
										(jsonObj[i].registration ? "<p><span class='tod'>" + jsonObj[i].registration + "</span></p>" : "") + 
										(jsonObj[i].regr_url ? "<p><span><a href='http://" + jsonObj[i].regr_url + "' target='_blank'>Registration Link</a></span></p>" : "") + 
										(jsonObj[i].contact ? "<p><span>Follow up with: " + jsonObj[i].contact + "</span></p>" : "") +
										
          					"<p><a href='<?php echo(Utilities::getHttpPath()); ?>/modules/schedule/control/eventApproveProcessor.php?id=" + jsonObj[i].uuid + "'><b>Approve for Public Calendar</b></a> | " +
										"<a href='<?php echo(Utilities::getHttpPath()); ?>/modules/schedule/control/eventDeleteProcessor.php?id=" + jsonObj[i].uuid + "' onclick='return confirm(\"Please confirm this delete.\");'><b>Delete</b></a></p>" +
         					"</span>" +
         				"</div>" +
         			"</div>"; 
     				document.getElementById("reservationRow" + i).innerHTML = tableEvent; 
     				document.getElementById("reservationRow" + i).style.height = "200px";
     			}
     			document.getElementById('reservationTable').style.height = (200 * jsonObj.length) + "px";
     		}
			}
		}
		xmlhttp.open("GET", "<?php echo(Utilities::getHttpPath()); ?>" + "/src/framework/reservationManagerPending.php");
		xmlhttp.send();  		
	}
</script>

<!--<div style="width:760px;font-size:110%;">-->

	<div id="new_event_display" style="display:none;">
		<?php include(Utilities::getModulesRoot() . "/event/views/eventAddAdvantage.php"); ?>	
	</div>
						
	<div id="current_schedule_display" style="display:block;">
		<!--
		<a id='schedule_control' href='javascript:void(0);' class='level1-control'>
		<span style='padding:0px;' class='fa fa-calendar-o fa-2x' ></span>
		<span style='padding-left:2px;' class='fa fa-plus' >	</span>
		</a>	
		-->			
		<div id="reservationTable" class="table-div" style="border:0px !important;">
		</div>
	</div>
	
	<script> getEventList(<?php echo (time() + 15*60); ?>); </script>
	
<!--</div>-->