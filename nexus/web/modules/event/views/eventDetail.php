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
       					"<span>" + jsonObj[i].location + "</span><br/>" + 
       					"<span class='tod'>" + jsonObj[i].hour + ":" + jsonObj[i].minute + "</span><span class='period'> " + jsonObj[i].period + " </span> - " +
								"<span class='tod'>" + jsonObj[i].hour_end + ":" + jsonObj[i].minute_end + "</span><span class='period'> " + jsonObj[i].period_end + " </span>" +
								"<span class='period'> " + jsonObj[i].abbrev + "</span>" +
								(jsonObj[i].descr ? "<p><span>" + jsonObj[i].descr + "</span></p>" : "") + 
								(jsonObj[i].url ? "<p><span><a href='http://" + jsonObj[i].url + "' target='_blank'>More Information</a></span></p>" : "") + 
								(jsonObj[i].registration ? "<p><span>" + jsonObj[i].registration + "</span></p>" : "") + 
								(jsonObj[i].regr_url ? "<p><span><a href='http://" + jsonObj[i].regr_url + "' target='_blank'>Register Online</a></span></p>" : "") + 
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
	<div id="detailTable" class="table-div">
		<div id="eventRow0" class="tr-div"></div>
	</div>
</div>

</div>