<script>
	function getEventDetail(eventUuid) {
		var xmlhttp = getXmlHttpRequest();
		xmlhttp.onreadystatechange=function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			 	var jsonObj = JSON.parse(xmlhttp.responseText);		 	
				var i = 0;	
		 		tableEvent = 
       			"<div class='detail'>" +
       					"<span class='date'>" + jsonObj[i].purpose + "</span><br/>" +
       					"<span class='tod'>" + jsonObj[i].location + "</span><br/>" + 
       					"<span class='tod'>" + jsonObj[i].hour + ":" + jsonObj[i].minute + "</span><span class='period'> " + jsonObj[i].period + " </span> - " +
								"<span class='tod'>" + jsonObj[i].hour_end + ":" + jsonObj[i].minute_end + "</span><span class='period'> " + jsonObj[i].period_end + " </span>" +
								"<span class='period'> " + jsonObj[i].abbrev + "</span>" +
								(jsonObj[i].descr ? "<span class=''><p>" + htmlFormatEmail(htmlFormatAnchors(htmlFormatParagraphs(jsonObj[i].descr))) + "</p><span>" : "") + 
								(jsonObj[i].url ? "<p><span><a href='http://" + jsonObj[i].url + "' target='_blank'>Web Link</a></span></p>" : "") + 
								(jsonObj[i].fileext ? "<p><span><a href='<?php echo(Utilities::getPartnerFileUrl()); ?>/event-" + jsonObj[i].uuid + "." + jsonObj[i].fileext + "' target='_blank'>Flyer</a></span></p>" : "") + 
								(jsonObj[i].registration ? "<p><span class='tod'>" + jsonObj[i].registration + "</span></p>" : "") + 
								(jsonObj[i].regr_url ? "<p><span><a href='http://" + jsonObj[i].regr_url + "' target='_blank'>Registration Link</a></span></p>" : "") + 
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