<script>
	function getEventListFilter(referenceTime,filter) {
		var xmlhttp = getXmlHttpRequest();
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
          	"<div class='td-div'>" +
          	"</div>" + 
					"</div>";
			 	var showClipboardButton = Clipboard.isSupported();
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
		      		"<div class=''>" +		
	       				"<span class='date'></span><br/>" + 				
          		"</div>" +
          	"</div>" +
       			"<div id='nowEventDetail' class='td-div' style='position:absolute;left:140px;top:5px;height:70px;'>" +	  	       				
			       	"<div class='meeting'>" +
          			"<span class='purpose'>There are no upcoming events on the " + filter + " calendar.</span>" + 
          		"</div>" +
          	"</div>" +
					"</div>";
					document.getElementById("reservationTable").innerHTML = tableRows + tableRow
				} else {
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
       				"<div class='td-div' id='nowEventDetail' style='position:absolute;left:140px;top:5px;height:210px;width:370px;'>" + 
		          	"<div class='meeting'>" +
       			      "<a href='#openEventDetail' onclick='getEventDetail(\"" + jsonObj[i].uuid + "\");' '<span style='padding-right:10px;color:#d27b4b;' class='fa fa-plus-square'></span></a>" +
         					"<span class='purpose'>" + truncateString(jsonObj[i].purpose, '70') + "</span>" +
         						(jsonObj[i].recur ? "<p style='background-color:#dddddd;padding:4px;border-radius:5px;margin-top:3px;'>This is a multi-day event.</p>" : "") + 
										"<p style='font-size:90%'><span>Approved by: " + jsonObj[i].fname + " " + jsonObj[i].lname + "</span>" +
										(jsonObj[i].bbb ? "" : "<p style='font-size:90%'><a href='#openBbbMeetingAdd' onclick='return populateEventTypeForm(\"" + jsonObj[i].uuid + "\",\"" + jsonObj[i].purpose + "\");'>Reserve Web Meeting</a></p>") +
         					"</span>" +
         				"</div>" +
		          "</div>" +
		          "<div class='td-div' style='position:absolute;left:530px;top:-10px;'>" +
		          	(jsonObj[i].bbb 
		          		? "<p><a href='" + meetingPass + "' target='_blank'>Start/Join Web Meeting</a>" +
		          			(IS_ADMIN ? "<a href='<?php echo(Utilities::getHttpPath()); ?>/modules/schedule/control/scheduleDeleteBbbProcessor.php?uuid=" + jsonObj[i].uuid + "' onclick='return confirm(\"Please confirm this room reservation delete. (Your event will stay on the calendar.)\");' style='float:right;'><span class='fa fa-trash-o'</span></a>" : "") +
		          			"</p><p><span style='font-size:80%'><b>Guest Pass</b> (Share this link with your attendees)" + 
		          			(showClipboardButton
		          				? "<br/><button class='guest-pass-button' id='guest-pass-button0' data-clipboard-text='" + guestPass + "' onclick='' title='Click to copy'>Copy Pass to Clipboard</button>" +
				          			"&nbsp;<button onclick='alert(\"" + guestPass + "\");' title='Click to show pass'>Show Pass</button></p>"
		          				: "<br/><button onclick='alert(\"" + guestPass + "\");' title='Click to show pass'>Show Pass</button></p>"
		          			)
		          		: ""
		          	) +
		          "</div>";
       						// +
     				document.getElementById("reservationRow" + i).innerHTML = tableEvent; 
     			}
     			CLIPBOARD = new Clipboard('.guest-pass-button');
					CLIPBOARD.on('success', function(e) {
						$(".guest-pass-button").tooltip({content: ""});
						$(e.trigger).tooltip({content: "Copied!"});
  					$(e.trigger).tooltip("open");
					});
     		}
			}
		}
		xmlhttp.open("GET", "<?php echo(Utilities::getHttpPath()); ?>" + "/src/framework/reservationManager.php?filter=" + filter);
		xmlhttp.send();  		
	}
</script>
					

	