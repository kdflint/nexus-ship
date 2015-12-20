<script>
	function getEventDetail(eventUuid) {
		var xmlhttp = getXmlHttpRequest();
		xmlhttp.onreadystatechange=function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			 	var jsonObj = JSON.parse(xmlhttp.responseText);		 	
				var i = 0;		
		 		tableEvent = 
       			"<div class='detail'>" +
		    				//"<a id='schedule_control' href='javascript:void(0);' onclick='toggleDisplay(\"show-event\");' style='padding:0px;'>"	+
		    				//	"<span class='fa fa-chevron-circle-left fa-2x' style='margin-right:5px;' ></span>" + 
		    				//"</a>" + 
       					"<span class='date'>" + jsonObj[i].purpose + "</span><br/>" +
       					"<span class='tod'>" + jsonObj[i].location + "</span><br/>" + 
       					"<span class='tod'>" + jsonObj[i].hour + ":" + jsonObj[i].minute + "</span><span class='period'> " + jsonObj[i].period + " </span> - " +
								"<span class='tod'>" + jsonObj[i].hour_end + ":" + jsonObj[i].minute_end + "</span><span class='period'> " + jsonObj[i].period_end + " </span>" +
								"<span class='period'> " + jsonObj[i].abbrev + "</span>" +
								(jsonObj[i].descr ? "<p><span class=''>" + jsonObj[i].descr + "</span></p>" : "") + 
								(jsonObj[i].url ? "<p><span><a href='http://" + jsonObj[i].url + "' target='_blank'>More Information</a></span></p>" : "") + 
								(jsonObj[i].registration ? "<p><span class='tod'>" + jsonObj[i].registration + "</span></p>" : "") + 
								(jsonObj[i].regr_url ? "<p><span><a href='http://" + jsonObj[i].regr_url + "' target='_blank'>Registration</a></span></p>" : "") + 
								(jsonObj[i].contact ? "<p><span>" + jsonObj[i].contact + "</span></p>" : "") +  
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
		<div style="margin-top:10px;margin-right:10px;float:right">
			<a id='schedule_control' href='#' onclick="showEventAdd();">
				<span style='' class='fa fa-calendar-o fa-2x' ></span>
				<span style='' class='fa fa-plus' ></span>
				<p style="font-size:90%;">Submit<br/>New Event</p>
			</a>	
  	</div>
		<div id="eventRow0" class="tr-div">
			<div style="text-align:center;"><span class='fa fa-spinner fa-spin fa-lg' style="margin-right:10px;margin-top:45px;"></span>Loading detail...</div>	
		</div>
	</div>
</div>

</div>