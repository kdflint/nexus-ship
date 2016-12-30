<script>
	function getDirectoryDetail(orgId) {
		if (detailMap === undefined) { initDetailMap(); }
		clearAllDetailMarkers();
		var xmlhttp = getXmlHttpRequest();
		xmlhttp.onreadystatechange=function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			 	var jsonObj = JSON.parse(xmlhttp.responseText);		
		 		tableItem = 
		 				"<a href='javascript:void(0);' onclick='showDirectoryResults();'><span class='fa fa-chevron-circle-left fa-3x' style='margin-right:10px;'></span></a>" + 
       			"<span class='fname detail'>" + jsonObj.oname + "</span>" +
       			//(orgEditLinkData[orgId] ? "<a href='" + orgEditLinkData[orgId] + "' target='_blank' style='margin-left:20px;' >Edit this Listing</a>" : "") +
       			"<div class='detail'>" +
       					(jsonObj.url ? "<p><span class='tod'><a href='" + jsonObj.url + "' target='_blank'>" + jsonObj.url + "</a></span></p>" : "<p>&nbsp;</p>") +
       												
								(jsonObj.cname ? "<span>" + jsonObj.cname + "</span><br/>" : "") +
								(jsonObj.email ? "<span>Email: " + jsonObj.email + "</span><br/>" : "") +
								(jsonObj.phone ? "<span>Phone: " + jsonObj.phone + "</span><br/>" : "") +
								(jsonObj.fax ? "<span>Fax: " + jsonObj.fax + "</span><br/>" : "") +

       					(jsonObj.location1 ? "<span>" + jsonObj.location1 + "</span><br/>" : "") +
								(jsonObj.location2 ? "<span>" + jsonObj.location2 + "</span><br/>" : "") +
						"</div>";
    		document.getElementById("itemRow").innerHTML = "<div class='td-div'>" + tableItem + "<div>";   
    		addDetailMarker(jsonObj.orgid);
     	}
		}
		xmlhttp.open("GET", "<?php echo(Utilities::getHttpPath()); ?>" + "/src/framework/directoryDetailManager.php?id=" + orgId, true);
		xmlhttp.send();  		
	}
</script>

<div style="">
			
<div id="current_detail_display">	
	<div id="detailTable" class="table-div" style="border: 0px none !important;">
		<div id="itemRow" class="tr-div detail">
			<a href="javascript:void(0);" onclick="showDirectoryResults();"><span class='fa fa-chevron-circle-left fa-3x' style="margin-right:10px;margin-top:25px;"></span></a>
			<span class='fa fa-spinner fa-spin fa-lg' style="margin-left:10px;margin-right:10px;"></span>Loading detail...
		</div>
		<div id="detailMapContainer" style="width:300px;height:200px;border: 0px none !important;position:absolute;top:198px;left:25px;"></div>
	</div>
</div>

</div>

<script>
	
	var detailMap;
	var detailMarkers = [];
	
  function initDetailMap() {
  	var mapDiv = document.getElementById('detailMapContainer');
    detailMap = new google.maps.Map(mapDiv, {
    	center: {lat: 41.88, lng: -87.62},
      zoom: 10
    });
   }

	function addDetailMarker(orgid) {
		if (geoDataCfcht[orgid]) {
			var orgGeo = geoDataCfcht[orgid][0];
	  	var marker = new google.maps.Marker({
		    position: {lat: orgGeo['lat'], lng: orgGeo['lng']},
    		map: detailMap,
    		title: orgGeo['title']
  		});
  		detailMarkers.push(marker);
  		setDetailMapOnAll(detailMap);
  		detailMap.setCenter(marker.getPosition());
		}
	}
	
	function setDetailMapOnAll(map) {
  	for (var i = 0; i < detailMarkers.length; i++) {
	    detailMarkers[i].setMap(map);
	  }
	}
	
	function clearAllDetailMarkers() {
  	setDetailMapOnAll(null);
  	detailMarkers = [];
	}
	
</script>
