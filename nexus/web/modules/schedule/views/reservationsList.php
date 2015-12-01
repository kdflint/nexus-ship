<script>
	function getReservationList(referenceTime) {
		var xmlhttp = new XMLHttpRequest();
		xmlhttp.onreadystatechange=function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			 	var jsonObj = JSON.parse(xmlhttp.responseText);		 	

			 	// put row container in the now, 1 row always
			 	var nowMeeting = undefined;		 	
			 	if (jsonObj.length > 0 && jsonObj[0].epoch < referenceTime) {
			 		nowMeeting = jsonObj.shift();
			 	}
       	document.getElementById("nowTable").innerHTML = "<tr id='nowRow0'></tr>";
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

				if (nowMeeting === undefined) {
       		nowEvent =  
	       		"<td>" +
		      		"<div class='event'>" +
	       				"<span class='date'>Now</span><br/>" + 
	       			"</div>" +
       			"</td>" +
          	"<td>" +	       				
			       	"<div class='meeting'>" +
          			"<span class='purpose'>Good news! Your room is available right now.</span>" + 
          		"</div>" +
          	"</td>";	 
       	}	else {
					indicator = (Math.floor(new Date()/1000) < nowMeeting.epoch ) ? "Soon" : "Now";
					// If this is a demo session, show the session user name as the now meeting reserver instead of the placeholder name that is in the database
					reservedBy = nowMeeting.adder == <?php echo(Utilities::getDemoUidpk()); ?> ? '<?php echo($_SESSION['fname'] . " " . $_SESSION['lname']); ?>' : nowMeeting.fname + " " + nowMeeting.lname;
				 	nowEvent =  
	       		"<td>" +
		      		"<div class='event'>" +
	       				"<span class='date'>" + indicator + "</span><br/>" +
	       				"<span class='month'>" + nowMeeting.hour + ":" + nowMeeting.minute + "</span><span class='period'> " + nowMeeting.period + " " + nowMeeting.abbrev + "</span>" +
							"</div>" +
       			"</td>" +
          	"<td>" +	       				
			        "<div class='meeting'>" +
          			"<span class='purpose'>" + nowMeeting.purpose + "</span><br/>" +
          			"<p>" + nowMeeting.mtypdisplay + " reserved by " + reservedBy +
	        			((nowMeeting.adder == nowMeeting.sessionUser && nowMeeting.sessionUser != <?php echo(Utilities::getDemoUidpk()); ?>) ? "<a href='modules/schedule/control/eventDeleteProcessor.php?id=" + nowMeeting.uuid + "' onclick='return confirm(\"Please confirm this delete.\");'><span class='fa fa-trash-o' style='color:#d27b4b;margin-left:10px;'></span></a></p>" : " ") +
	        			"<p><span id='tech_check_summary' class='descr' style='font-style:italic;' ><span class='fa fa-spinner fa-spin fa-lg'></span> Checking your system compatibility... one moment</span><a href='javascript:void(0);' onclick='document.getElementById(\"tech_check_control\").click();' style='font-size:90%;margin-left:5px;'> Details</a></p>" + 
          		"</div>" +
          	"</td>";	
          document.getElementById("join_control_mode").innerHTML = "<a href='modules/meeting/control/joinMeetingProcessor.php?id=" + nowMeeting.uuid + "&type=" + nowMeeting.mtype + "' target='_blank' style='position:absolute;margin-left:648px;padding-top:8px;'><span class='fa fa-sign-in fa-3x' ></span></a>";
       	}  
       	document.getElementById("nowRow0").innerHTML = nowEvent;     					
       	
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
          			"<span class='purpose'>Click the calendar to reserve this room for a future date.</span>" + 
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
         					"<span class='descr'>" + jsonObj[i].descr + 
          					"<p>" + jsonObj[i].mtypdisplay + " reserved by " + 
          					((jsonObj[i].adder == <?php echo(Utilities::getDemoUidpk()); ?>) ? '<?php echo($_SESSION['fname']); ?>' : jsonObj[i].fname) + " " +  
          					((jsonObj[i].adder == <?php echo(Utilities::getDemoUidpk()); ?>) ? '<?php echo($_SESSION['lname']); ?>' : jsonObj[i].lname) + "</p>" +
          					((jsonObj[i].adder == jsonObj[i].sessionUser && jsonObj[i].sessionUser != <?php echo(Utilities::getDemoUidpk()); ?>) ? "<p><a href='modules/schedule/control/eventDeleteProcessor.php?id=" + jsonObj[i].uuid + "' onclick='return confirm(\"Please confirm this delete.\");'><span class='fa fa-trash-o' style='color:#d27b4b;'></span></a></p>" : " ") +
         					"</span>" +
         				"</div>" +
         			"</td>";
     				document.getElementById("reservationRow" + i).innerHTML = tableEvent;   
     			}
     		}
			}
		}
		xmlhttp.open("GET","src/framework/reservationManager.php");
		xmlhttp.send();  		
	}
</script>

<div id="join_control_mode">
	<!-- These link parameters are altered if there is a meeting currently running. See the construction of 'nowRow0' in json processing script above -->
	<a id='join_control' href='javascript:void(0);' style='position:absolute;margin-left:648px;padding-top:16px;'><span class='fa fa-circle-o-notch fa-2x' ></span></a>
</div>
<table id="nowTable" class="pure-table">
</table>

<div id="join_display" style="display:none;">
	<?php include("modules/schedule/views/joinAdd.php"); ?>
</div>

<div id="new_event_display" style="display:none;">
	<?php include("modules/schedule/views/reservationAdd.php"); ?>	
</div>
			
<div id="tech_check_display" style="display:none;">
	<?php include("modules/schedule/views/techCheck.php"); ?>	
</div>			
					
<a id='schedule_control' href='javascript:void(0);' style='position:absolute;margin-left:650px;padding-top: 20px;'></span><span style='padding:0px;' class='fa fa-calendar-o fa-2x' ></span><span style='padding-left:2px;' class='fa fa-plus' ></span></a>				
<table id="reservationTable" class="pure-table">
</table>

<table class="pure-table">
	<tr>
		<td><div class='event'><span class="fa fa-map-marker fa-2x"></span></div></td>
		<td>
			<div class="meeting">
				<span class='purpose'>Use this link to add Nexus Web Meet events to your calendar</span><br/>
				<span class='descr' style='font-size:90%;' >
					<p><?php echo Utilities::getHttpPath(); ?>/login.php?oid=<?php echo $_SESSION['orgUid']; ?></p>
					<p>Your attendees must be enrolled in Nexus Web Meet to attend a web event.</p>
				</span>
			</div>
		</td>
	</tr>
</table>

<script> getReservationList(<?php echo (time() + 15*60); ?>); </script>
	
<a id='tech_check_control' href='javascript:void(0);' style="display:none;"></a>
	