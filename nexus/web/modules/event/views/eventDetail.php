<script>
	function getEventDetail(eventUuid) {
		var xmlhttp = getXmlHttpRequest();
		xmlhttp.onreadystatechange=function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			 	var jsonObj = JSON.parse(xmlhttp.responseText);		 	
				var i = 0;	
		 		tableEvent = 
       			"<div class='detail'>" +
       					(IS_ADMIN ? "<a href='#openEventEdit' onclick='populateEventFormByUuid(\"" + eventUuid + "\");' title='Edit Event' style='float:right;'><span class='fa fa-pencil fa-lg' style='margin-left:10px;'></span></a>" : "") +
      					"<a class='secondaryControl priv-1' href='<?php echo(Utilities::getHttpPath()); ?>/modules/schedule/control/eventDeleteProcessor.php?id=" + eventUuid + "' onclick='return confirm(\"Please confirm this delete of event " + jsonObj[i].purpose + ".\");' title='Delete Event' style='float:right;'><span class='fa fa-trash fa-lg' ></span></a>" +
       					"<span class='date'>" + jsonObj[i].purpose + "</span><br/>" +
       					"<span class='tod'>" + jsonObj[i].location + "</span><br/>" + 
       					"<span class='tod'>" + jsonObj[i].day + ", " + jsonObj[i].month + " " + jsonObj[i].date + " " + jsonObj[i].year + " </span></br>" +
       					(jsonObj[i].epoch_end - jsonObj[i].epoch < 86400 ?
     						"<span class='tod'>" + jsonObj[i].hour + ":" + jsonObj[i].minute + "</span><span class='period'> " + jsonObj[i].period + " </span> - " +
								"<span class='tod'>" + jsonObj[i].hour_end + ":" + jsonObj[i].minute_end + "</span><span class='period'> " + jsonObj[i].period_end + " </span>" +
								"<span class='period'> " + jsonObj[i].abbrev + "</span>" : "All Day Event") +
						        (jsonObj[i].recur ? "<p style='background-color:#dddddd;padding:4px;border-radius:5px;margin-top:3px;'>Occurs " + jsonObj[i].recur_pattern + " through " + jsonObj[i].recur_end_phrase + "</p>" : "") + 
								(jsonObj[i].bbb ? "<p><span><a href='<?php echo Utilities::getHttpPath(); ?>/login.php?oid=<?php echo $_SESSION['orgUid']; ?>&mid=" + jsonObj[i].uuid + "' target='_blank'>Online Meeting Link</a></span></p>" : "") +
								(jsonObj[i].descr ? "<span class=''><p>" + htmlFormatParagraphs(jsonObj[i].descr) + "</p><span>" : "") + 
								(jsonObj[i].url ? "<p><span><a href='" + jsonObj[i].url + "' target='_blank'>Web Information Link</a></span></p>" : "") + 
								(jsonObj[i].fileext ? "<p><span><a href='<?php echo(Utilities::getPartnerFileUrl()); ?>/event-" + jsonObj[i].uuid + "." + jsonObj[i].fileext + "' target='_blank'>Flyer</a></span></p>" : "") + 
								(jsonObj[i].registration ? "<p><span class='tod'>" + jsonObj[i].registration + "</span></p>" : "") + 
								(jsonObj[i].regr_url ? "<p><span><a href='" + jsonObj[i].regr_url + "' target='_blank'>Registration Link</a></span></p>" : "") + 
						"</div>";
    		document.getElementById("eventRow0").innerHTML = "<div class='td-div'>" + tableEvent + "<div>";   
     	}
		}
		xmlhttp.open("GET", "<?php echo(Utilities::getHttpPath()); ?>" + "/src/framework/eventDetailManager.php?uuid=" + eventUuid, true);
		xmlhttp.send();  		
	}
		
</script>

<div style="">
			
<div id="current_detail_display">	
	<div id="detailTable" class="table-div" style="border: 0px none !important;">
		<div id="eventRow0" class="tr-div">
			<div style="text-align:center;"><span class='fa fa-spinner fa-spin fa-lg' style="margin-right:10px;margin-top:45px;"></span>Loading detail...</div>	
		</div>
	</div>
</div>

</div>