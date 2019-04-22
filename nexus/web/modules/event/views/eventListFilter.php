<script>
	function getEventListFilter(referenceTime,filter) {
		var xmlhttp = getXmlHttpRequest();
		CLIPBOARD = new Clipboard('.guest-pass-button');
		CLIPBOARD.on('success', function(e) {
			$(".guest-pass-button").tooltip({content: ""});
			$(e.trigger).tooltip({content: "Copied!"});
  			$(e.trigger).tooltip("open");
		});
		xmlhttp.onreadystatechange=function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			 	var jsonObj = JSON.parse(xmlhttp.responseText);		 	
			 	currentEvents = jsonObj;
			 	// put row containers in the reservation table, 1 for each event
			 	var nextMeetings = undefined;
			 	var tableRows = "<div id='headerRow' class='div-tr' style='position:relative;'>" + 
       			"<div class='td-div'>" +
		      		"<div class='event' style='border-right:0px;'>" +		
	       				"<span class='detail' style='font-size:140%;'>" + capitalize(filter) + "&nbsp;Events</span><br/>" +			
          		"</div>" +
          	"</div>" +
					"</div>" + 
					"<div id='body-rows' style='width:598px;'>";
			 	var showClipboardButton = Clipboard.isSupported();
			 	for (var i = 0; i < jsonObj.length; i++) { 
			 		tableRows = tableRows + "<div id='reservationRow" + i + "' class='div-tr' style='position:relative;'></div>";
			 		nextMeetings = i; 
			 	}
			 	tableRows = tableRows + "</div>";
       	document.getElementById("reservationTable").innerHTML = tableRows;

				// write the current meeting into its row container, or default content if none
				nowEvent = "";  	
       	// write each future event into its row container
				if (nextMeetings === undefined) {
					tableRow = "<div id='reservationRow0' class='div-tr' style='position:relative;'>" + 
       			"<div class='td-div'>" +
		      		"<div class=''>" +		
	       				"<span class='date'></span><br/>" + 				
          		"</div>" +
          	"</div>" +
       			"<div id='nowEventDetail' class='td-div' style='position:absolute;left:140px;top:5px;height:70px;'>" +	  	       				
			       	"<div class='meeting'>" +
			       	(filter === "pending"
			       	? "<span class='purpose'>All of your events have been published.</span>"
          	  : "<span class='purpose'>There are no upcoming events on the " + filter + " calendar.</span>"
          	  ) + 
          		"</div>" +
          	"</div>" +
					"</div>";
					document.getElementById("reservationTable").innerHTML = tableRows + tableRow;
				} else {
					document.getElementById('body-rows').style = "width:598px;height:350px;overflow-y:auto;";
			 		for (var i = 0; i < jsonObj.length; i++) {
			 			var meetingPass = "modules/meeting/control/joinMeetingProcessor.php?id=" + jsonObj[i].uuid + "&type=" + jsonObj[i].mtype;
			 			var guestPass = "<?php echo Utilities::getHttpPath(); ?>/login.php?oid=<?php echo $_SESSION['orgUid']; ?>&mid=" + jsonObj[i].uuid;
			 			tableEvent = 
       				"<div class='td-div'>" +
	       				"<div class='event'>" +
  					  		"<span class='day'>" + jsonObj[i].day + "</span><br/>" +
 									"<span class='date'>" + jsonObj[i].date + "</span><br/>" +
 									"<span class='month'>" + jsonObj[i].month + "</span><br/>" +
 									"<span>" + jsonObj[i].hour + ":" + jsonObj[i].minute + "</span><span class='period'> " + jsonObj[i].period + " " + jsonObj[i].abbrev + "</span>" +
								"</div>" +
      				"</div>" +
       				"<div class='td-div' id='nowEventDetail' style='position:absolute;left:140px;top:5px;width:420px;'>" + 
		          	"<div class='meeting'>" +		          	
       			      "<a href='#openEventDetail' onclick='getEventDetail(\"" + jsonObj[i].uuid + "\");' '<span style='padding-right:10px;color:#d27b4b;' class='fa fa-plus-square'></span></a>" +
         					"<span class='purpose'>" + truncateString(jsonObj[i].purpose, '70') + "</span>" +
         						(jsonObj[i].recur ? "<p style='background-color:#dddddd;padding:4px;border-radius:5px;margin-top:3px;'>This is a multi-day event.</p>" : "") + 
         						(filter === "pending"
         						? (jsonObj[i].contact ? "<p><span>Follow up with: " + jsonObj[i].contact + "</span></p>" : "") +
         						  (true ? "<a href='#openEventEdit' onclick='return populateEventForm(\"" + i + "\");' title='Approve'><p><b>Approve for " + 
         						    (jsonObj[i].group_assoc === SESSION_PGPK ? "Public" : "Network") + 
         						  " Calendar</b></a>" : " ") +
         						  (true ? "<a href='<?php echo(Utilities::getHttpPath()); ?>/modules/schedule/control/eventDeleteProcessor.php?id=" + jsonObj[i].uuid + "' onclick='return confirm(\"Please confirm this delete.\");' title='Delete'><span class='fa fa-trash-o' style='color:#d27b4b;margin-left:10px;'></span></a></p>" : " ")
										: (filter === "network" 
										  ? "<p style='font-size:90%'><span>Hosted for: " + jsonObj[i].group_name + "</span></p>" 
										  : "<p style='font-size:90%'><span>Approved by: " + jsonObj[i].fname + " " + jsonObj[i].lname + "</span></p>")
										) +
										(jsonObj[i].bbb 
										? "<p style='font-size:90%'>" +
										  (IS_ADMIN 
										  ? "<a href='<?php echo(Utilities::getHttpPath()); ?>/modules/schedule/control/scheduleDeleteBbbProcessor.php?uuid=" + jsonObj[i].uuid + "' onclick='return confirm(\"Please confirm this Nexus Web Meet room reservation deletion.\\r\\n (Your event will stay on the calendar.)\");' style='margin-right:10px;'><span class='fa fa-trash-o'</span></a>" 
										  : "") +
										  "<a href='" + meetingPass + "' target='_blank'><b>Start/Join Web Meeting</b></a>" +
										  "<span style='margin-left:20px;margin-right:20px;'><b></b></span>" +
		          			    (showClipboardButton
		          			    //(false
		          			    ? "<button class='guest-pass-button' id='guest-pass-button0' data-clipboard-text='" + guestPass + "' onclick='' title='Click to copy'>Copy Guest Pass to Clipboard</button>"
		          			    : "<button onclick='alert(\"Share this link to invite a guest to this meeting.\\r\\n\\r\\n" + guestPass + "\");' title='Click to show pass'>Show Guest Pass</button>"
		          			    ) +
		          			    "</p>"										
										: "<p style='font-size:90%'><a href='#openBbbMeetingAdd' onclick='return populateEventTypeForm(\"" + jsonObj[i].uuid + "\",\"" + jsonObj[i].purpose + "\");'>Reserve Web Meeting</a></p>"
										) +
         					"</span>" +
         				"</div>" +
		          "</div>" +
		          
		          "<div class='td-div' style='position:absolute;left:530px;top:-10px;'>" +
		          "</div>";

     				document.getElementById("reservationRow" + i).innerHTML = tableEvent; 
     			}
     		}
			};
		}
		xmlhttp.open("GET", "<?php echo(Utilities::getHttpPath()); ?>" + "/src/framework/reservationManager.php?filter=" + filter);
		xmlhttp.send();  		
	}
</script>
					

	