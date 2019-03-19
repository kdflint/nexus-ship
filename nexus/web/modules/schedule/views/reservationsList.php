<script>
	function getReservationList(referenceTime) {
	    console.log("refreshing at " + referenceTime);
		var xmlhttp = getXmlHttpRequest();
		// TODO - move below into javascriptHandler.php and remove duplicate code in eventListFilter.php 
		CLIPBOARD = new Clipboard('.guest-pass-button');
		CLIPBOARD.on('success', function(e) {
			$(".guest-pass-button").tooltip({content: ""});
			$(e.trigger).tooltip({content: "<?php echo _('copied'); ?>!"});
  		$(e.trigger).tooltip("open");
		});
		xmlhttp.onreadystatechange=function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			 	var jsonObj = JSON.parse(xmlhttp.responseText);	
			 	var showClipboardButton = Clipboard.isSupported();
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
       	message1 = '<?php echo _("Now"); ?>';
       	message2 = '<?php echo _("Good news! Your room is available right now."); ?>';
       	console.log(message1);
				nowEvent = "";
				if (nowMeeting === undefined) {
					IS_NOW = false;
       		nowEvent =  
       			"<div class='td-div'>" +
		      		"<div class='event'>" +
	       				"<span class='date'>" + message1 + "</span><br/>" + 
	       			"</div>" +
       			"</div>" +
       			"<div id='nowEventDetail' class='td-div' style='position:absolute;left:140px;top:5px;height:70px;'>" +	       				
			       	"<div class='meeting'>" +
          			"<span class='purpose'>" + message2 + "</span>" + 
          		"</div>" +
          	"</div>";
            document.getElementById("join_control_real").className = "level1-control";
            document.getElementById("join_control_real").innerHTML = "<span class='fa fa-circle-o-notch fa-2x' ></span>";
            document.getElementById("join_control_real").href = "javascript:void(0);";
            document.getElementById("join_control_real").setAttribute('target','');
            document.getElementById("join_control_real").setAttribute('onclick',"$('#join_control').trigger('click');")
       	}	else {
       		if (!IS_NOW) {
       			playSound('demonstrative');
       			
       			IS_NOW = true;
					}
					message1 = '<?php echo _("Guest Pass"); ?>';
					message2 = '<?php echo _("Now"); ?>';
					message3 = '<?php echo _("Soon"); ?>';
					guestPass = "<?php echo Utilities::getHttpPath(); ?>/login.php?oid=<?php echo $_SESSION['orgUid']; ?>&mid=" + nowMeeting.uuid;
					indicator = (Math.floor(new Date()/1000) < nowMeeting.epoch ) ? message3 : message2;
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
       			"<div id='nowEventDetail' class='td-div' style='position:absolute;left:140px;top:5px;height:220px;'>" +     				
			        "<div class='meeting'>" +
          			"<span class='purpose'>" + nowMeeting.purpose + "</span><br/>" +
          			"<span class='descr'>" +
          				"<p>" + nowMeeting.mtypdisplay + " <?php echo _('reserved_by'); ?> " + reservedBy +
	        				(((IS_ADMIN || nowMeeting.adder == nowMeeting.sessionUser) && nowMeeting.sessionUser != <?php echo(Utilities::getDemoUidpk()); ?>) ? "<a href='modules/schedule/control/eventDeleteProcessor.php?id=" + nowMeeting.uuid + "' onclick='return confirm(\"<?php echo _('confirm_delete'); ?>\");'><span class='fa fa-trash-o' style='color:#d27b4b;margin-left:10px;'></span></a></p>" : " ") +
         					"<p style='font-size:90%;'><b>" + message1 + "</b> (<?php echo _('share_link'); ?>)</p>" +	        				
	        				
		          			(showClipboardButton
		          				? "<button id='guest-pass0' class='guest-pass-button' id='guest-pass-button0' data-clipboard-text='" + guestPass + "' onclick='' title='<?php echo _('copy_pass'); ?>'><?php echo _('copy_pass'); ?></button>" +
				          			"&nbsp;<button class='show-pass-button' onclick='alert(\"" + guestPass + "\");' title='<?php echo _('show_pass'); ?>'><?php echo _('show_pass'); ?></button></p>"
		          				: "<br/><button class='show-pass-button' onclick='alert(\"" + guestPass + "\");' title='<?php echo _('show_pass'); ?>'><?php echo _('show_pass'); ?></button></p>"	        				
	        					) +

         						// Flaw! We may have two items with id=='guest-pass0'. This accomodates WalkMe tutorials but not strictly correct :)
	        				"<p><span id='tech_check_summary' style='font-style:italic;' ><span class='fa fa-spinner fa-spin fa-lg'></span> <?php echo _('checking'); ?>... <?php echo _('One Moment'); ?></span><a href='javascript:void(0);' onclick='document.getElementById(\"tech_check_control\").click();' style='font-size:90%;margin-left:5px;'> <?php echo _('details'); ?></a></p>" + 
	        			"</span>" +
          		"</div>" +
          	"</div>";	
            document.getElementById("join_control_real").href = "modules/meeting/control/joinMeetingProcessor.php?id=" + nowMeeting.uuid + "&type=" + nowMeeting.mtype;
            document.getElementById("join_control_real").className = "join_meeting_button level1-control";
            document.getElementById("join_control_real").innerHTML = "<?php echo _('join'); ?><br/><?php echo _('meeting'); ?>";
            document.getElementById("join_control_real").setAttribute('target','_blank');
            document.getElementById("join_control_real").setAttribute('onclick','');
       	}  
       	document.getElementById("nowRow0").innerHTML = nowEvent;  
        var eventHeight = document.getElementById('nowEventDetail').style.height;
				document.getElementById('nowTable').style.height = eventHeight;    	
       	
       	// write each future event into its row container
				if (nextMeetings === undefined) {
					message1 = '<?php echo _("Future"); ?>';
					message2 = '<?php echo _("Click the calendar to reserve this room for a future date."); ?>' ;
					tableRow = "<div id='reservationRow0' class='tr-div' style='position:relative;'>" + 
       			"<div class='td-div'>" +
		      		"<div class='event'>" +		
	       				"<span class='date'>" + message1 + "</span><br/>" + 				
          		"</div>" +
          	"</div>" +
          	"<div id='futureEventDetail' class='td-div' style='position:absolute;left:140px;top:5px;height:70px;'>" +	       				
			       	"<div class='meeting' style='width:480px'>" +
          			"<span id='guest-pass0' class='purpose'>" + message2 + "</span>" + 
          		"</div>" +
          	"</div>" +
					"</div>";
					document.getElementById("reservationTable").innerHTML = tableRow;
					document.getElementById('reservationTable').style.height = "70px";
				} else {
			 		for (var i = 0; i < jsonObj.length; i++) {
			 			message1 = '<?php echo _("Guest Pass"); ?>';
			 			message2 = '<?php echo _("confirm_delete"); ?>';
			 			guestPass = "<?php echo Utilities::getHttpPath(); ?>/login.php?oid=<?php echo $_SESSION['orgUid']; ?>&mid=" + jsonObj[i].uuid;
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
          					jsonObj[i].mtypdisplay + " <?php echo _('reserved_by'); ?> " + 
          					((jsonObj[i].adder == <?php echo(Utilities::getDemoUidpk()); ?>) ? '<?php echo($_SESSION['fname']); ?>' : jsonObj[i].fname) + " " +  
          					((jsonObj[i].adder == <?php echo(Utilities::getDemoUidpk()); ?>) ? '<?php echo($_SESSION['lname']); ?>' : jsonObj[i].lname) + 
          					(((IS_ADMIN || jsonObj[i].adder == jsonObj[i].sessionUser) && jsonObj[i].sessionUser != <?php echo(Utilities::getDemoUidpk()); ?>) ? "<a href='modules/schedule/control/eventDeleteProcessor.php?id=" + jsonObj[i].uuid + "' onclick='return confirm(\"" + message2 + "\");'><span class='fa fa-trash-o' style='margin-left:10px;color:#d27b4b;'></span></a>" : " ") +
										"</p>" +
         						"<p style='font-size:90%;'><b>" + message1 + "</b> (<?php echo _('share_link'); ?>)</p>" +	
         						
         						(showClipboardButton
		          				? "<button class='guest-pass-button' id='guest-pass-button0' data-clipboard-text='" + guestPass + "' onclick='' title='<?php echo _('copy_pass'); ?>' ><?php echo _('copy_pass'); ?></button>" +
				          			"&nbsp;<button class='show-pass-button' onclick='alert(\"" + guestPass + "\");' title='<?php echo _('show_pass'); ?>'><?php echo _('show_pass'); ?></button></p>"
		          				: "<br/><button class='show-pass-button' onclick='alert(\"" + guestPass + "\");' title='<?php echo _('show_pass'); ?>'><?php echo _('show_pass'); ?></button></p>"	        				
	        					) +
         						
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
	<a id='join_control' href='javascript:void(0);' class='level1-control' style="visibility:hidden;"><span class='fa fa-circle-o-notch fa-2x' ></span></a>
	<a id='join_control_real' href='' target='' class=''></a>
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

<?php include("modules/schedule/views/one-click-join-table.php"); ?>

<script> 
	// Set the refresh interval to the default for the first refresh
	window.setTimeout(refreshEventList, MEETING_INFO_NEXT_REFRESH);
	// Load the event list (based on server time)
	getReservationList(<?php echo (time() + 21*60); ?>);
	function refreshEventList() {
		if(MEETING_INFO_NEXT_REFRESH) {
			// Refresh the event list (based on client time) and set the next refresh interval
			var d = new Date();
			var now = Math.ceil(d.getTime()/1000);
			getReservationList(now+21*60);
			window.setTimeout(refreshEventList, MEETING_INFO_NEXT_REFRESH);
		}
  }
</script> 

		
<a id='tech_check_control' href='javascript:void(0);' style="display:none;"></a>

<div id="notification"></div>	