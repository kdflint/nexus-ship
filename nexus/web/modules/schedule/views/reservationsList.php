<script>
	function getReservationList(referenceTime) {
		var xmlhttp = getXmlHttpRequest();
		xmlhttp.onreadystatechange=function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			 	var jsonObj = JSON.parse(xmlhttp.responseText);		
			 		
			 	// put row container in the now, 1 row always
			 	var nowMeeting = undefined;		 	
			 	if (jsonObj.length > 0 && jsonObj[0].epoch < referenceTime) {
			 		nowMeeting = jsonObj.shift();
			 		techCheck();
			 	}
       	document.getElementById("nowTable").innerHTML = "<div id='nowRow0' class='tr-div' style='position:relative;'></div>";
       	
			 	// put row containers in the reservation table, 1 for each future event
			 	var nextMeetings = undefined;
			 	var tableRows = "";
			 	for (var i = 0; i < jsonObj.length; i++) { 
			 		tableRows = tableRows + "<div id='reservationRow" + i + "' class='tr-div' style='position:relative;'></div>";
			 		nextMeetings = i; 
			 	}
       	document.getElementById("reservationTable").innerHTML = tableRows;       	

       	// write the current meeting into its row container, or default content if none
				nowEvent = "";
				if (nowMeeting === undefined) {
       		nowEvent =  
       			"<div class='td-div'>" +
		      		"<div class='event'>" +
	       				"<span class='date'>Now</span><br/>" + 
	       			"</div>" +
       			"</div>" +
       			"<div id='nowEventDetail' class='td-div' style='position:absolute;left:140px;top:5px;height:70px;'>" +	       				
			       	"<div class='meeting'>" +
          			"<span class='purpose'>Good news! Your room is available right now.</span>" + 
          		"</div>" +
          	"</div>";	 
       	}	else {
					indicator = (Math.floor(new Date()/1000) < nowMeeting.epoch ) ? "Soon" : "Now";
					// If this is a demo session, show the session user name as the now meeting reserver instead of the placeholder name that is in the database
					reservedBy = nowMeeting.adder == <?php echo(Utilities::getDemoUidpk()); ?> ? '<?php echo($_SESSION['fname'] . " " . $_SESSION['lname']); ?>' : nowMeeting.fname + " " + nowMeeting.lname;
				 	nowEvent =  
       			"<div class='td-div'>" +
		      		"<div class='event'>" +
	       				"<span class='date'>" + indicator + "</span><br/>" +
	       				"<span class='month'>" + nowMeeting.hour + ":" + nowMeeting.minute + "</span><span class='period'> " + nowMeeting.period + " -</span><br/>" +
	       				"<span class='month'>" + nowMeeting.hour_end + ":" + nowMeeting.minute_end + "</span><span class='period'> " + nowMeeting.period_end + " " + nowMeeting.abbrev + "</span>" +
							"</div>" +
       			"</div>" +
       			"<div id='nowEventDetail' class='td-div' style='position:absolute;left:140px;top:5px;height:210px;'>" +     				
			        "<div class='meeting'>" +
          			"<span class='purpose'>" + nowMeeting.purpose + "</span><br/>" +
          			"<span class='descr'>" +
          				"<p>" + nowMeeting.mtypdisplay + " reserved by " + reservedBy +
	        				((nowMeeting.adder == nowMeeting.sessionUser && nowMeeting.sessionUser != <?php echo(Utilities::getDemoUidpk()); ?>) ? "<a href='modules/schedule/control/eventDeleteProcessor.php?id=" + nowMeeting.uuid + "' onclick='return confirm(\"Please confirm this delete.\");'><span class='fa fa-trash-o' style='color:#d27b4b;margin-left:10px;'></span></a></p>" : " ") +
         					"<p>Guest Pass:</p>" +
         						// Flaw! We may have two items with id=='guest-pass0'. This accomodates WalkMe tutorials but not strictly correct :)
         						"<span id='guest-pass0' class='descr'><p><?php echo Utilities::getHttpPath(); ?>/login.php?oid=<?php echo $_SESSION['orgUid']; ?>&mid=" + nowMeeting.uuid + "</p></span>" +
	        				"<p><span id='tech_check_summary' style='font-style:italic;' ><span class='fa fa-spinner fa-spin fa-lg'></span> Checking your system compatibility... one moment</span><a href='javascript:void(0);' onclick='document.getElementById(\"tech_check_control\").click();' style='font-size:90%;margin-left:5px;'> Details</a></p>" + 
	        			"</span>" +
          		"</div>" +
          	"</div>";	
          document.getElementById("join_control_mode").innerHTML = "<a href='modules/meeting/control/joinMeetingProcessor.php?id=" + nowMeeting.uuid + "&type=" + nowMeeting.mtype + "' target='_blank'  class='level1-control'><span class='fa fa-sign-in fa-3x' ></span></a>";
       	}  
       	document.getElementById("nowRow0").innerHTML = nowEvent;  
        var eventHeight = document.getElementById('nowEventDetail').style.height;
				document.getElementById('nowTable').style.height = eventHeight;    			
       	
       	// write each future event into its row container
				if (nextMeetings === undefined) {
					tableRow = "<div id='reservationRow0' class='tr-div' style='position:relative;'>" + 
       			"<div class='td-div'>" +
		      		"<div class='event'>" +		
	       				"<span class='date'>Future</span><br/>" + 				
          		"</div>" +
          	"</div>" +
          	"<div id='futureEventDetail' class='td-div' style='position:absolute;left:140px;top:5px;height:70px;'>" +	       				
			       	"<div class='meeting'>" +
          			"<span id='guest-pass0' class='purpose'>Click the calendar to reserve this room for a future date.</span>" + 
          		"</div>" +
          	"</div>" +
					"</div>";
					document.getElementById("reservationTable").innerHTML = tableRow;
					document.getElementById('reservationTable').style.height = "70px";
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
      				// TODO - multiple items with same id - wrong
       				"<div id='futureEventDetail' class='td-div' style='position:absolute;left:140px;top:5px;height:180px;'>" + 
		          	"<div class='meeting'>" +
         					"<span class='purpose'>" + jsonObj[i].purpose + "</span><br/>" +
         					"<span class='descr'>" + jsonObj[i].descr + 
          					"<p>" + 
          					jsonObj[i].mtypdisplay + " reserved by " + 
          					((jsonObj[i].adder == <?php echo(Utilities::getDemoUidpk()); ?>) ? '<?php echo($_SESSION['fname']); ?>' : jsonObj[i].fname) + " " +  
          					((jsonObj[i].adder == <?php echo(Utilities::getDemoUidpk()); ?>) ? '<?php echo($_SESSION['lname']); ?>' : jsonObj[i].lname) + 
          					((jsonObj[i].adder == jsonObj[i].sessionUser && jsonObj[i].sessionUser != <?php echo(Utilities::getDemoUidpk()); ?>) ? "<a href='modules/schedule/control/eventDeleteProcessor.php?id=" + jsonObj[i].uuid + "' onclick='return confirm(\"Please confirm this delete.\");'><span class='fa fa-trash-o' style='margin-left:10px;color:#d27b4b;'></span></a>" : " ") +
										"</p>" +
         						"<p>Guest Pass:</p>" +
         						"<span id='guest-pass" + i + "' class='descr'><p><?php echo Utilities::getHttpPath(); ?>/login.php?oid=<?php echo $_SESSION['orgUid']; ?>&mid=" + jsonObj[i].uuid + "</p></span>" +
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
		xmlhttp.open("GET","src/framework/reservationManager.php", true);
		xmlhttp.send();  		
	}
</script>

<div id="join_control_mode">
	<!-- These link parameters are altered if there is a meeting currently running. See the construction of 'nowRow0' in json processing script above -->
	<a id='join_control' href='javascript:void(0);' class='level1-control'><span class='fa fa-circle-o-notch fa-2x' ></span></a>
</div>
<div id="nowTable" class="table-div">
</div>

<div id="join_display" style="display:none;">
	<?php include("modules/schedule/views/joinAdd.php"); ?>
</div>

<div id="new_event_display" style="display:none;">
	<?php include("modules/schedule/views/reservationAdd.php"); ?>	
</div>
			
<div id="tech_check_display" style="display:none;">
	<?php include("modules/schedule/views/techCheck.php"); ?>	
</div>			
					
<a id='schedule_control' href='javascript:void(0);' class='level1-control'></span><span style='padding:0px;' class='fa fa-calendar-o fa-2x' ></span><span style='padding-left:2px;' class='fa fa-plus' ></span></a>				
<div id="reservationTable" class="table-div">
</div>

<table class="pure-table">
	<tr>
		<td><div class='event'><span class="fa fa-map-marker fa-2x"></span></div></td>
		<td>
			<div class="meeting">
				<span class='purpose'>Team Pass:</span><br/>
				<span class='descr' style='font-size:90%;' >
					<p id="team-pass"><?php echo Utilities::getHttpPath(); ?>/login.php?oid=<?php echo $_SESSION['orgUid']; ?></p>
					<p>Your enrolled team members can use that link to schedule and attend any Nexus Web Meet event.</p>
				</span>
			</div>
		</td>
	</tr>
</table>

<script> getReservationList(<?php echo (time() + 21*60); ?>); </script>
	
<a id='tech_check_control' href='javascript:void(0);' style="display:none;"></a>
	