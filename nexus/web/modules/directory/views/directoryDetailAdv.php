<script>
	function getDirectoryDetailAdv(orgId) {
		if (detailMap === undefined) { initDetailMap(); }
		clearAllDetailMarkers();
		var xmlhttp = getXmlHttpRequest();
		xmlhttp.onreadystatechange=function() {
			if (xmlhttp.readyState == 4) {
				tableItem = "";
				if (xmlhttp.status == 200) {
			 		var jsonObj;
			 		try { jsonObj = JSON.parse(xmlhttp.responseText); } catch(err) { console.log(err); jsonObj = 'undefined';}	
			 		if ((typeof jsonObj !== 'undefined') && jsonObj !== null & jsonObj.oname !== null) { 
			 			var loc1 = jsonObj.location1 ? "<span>" + jsonObj.location1 + "</span><br/>" : "";
			 			var loc2 = jsonObj.location2 ? "<span>" + jsonObj.location2 + "</span><br/>" : "";
			 			var topicString = "";
						var languageString ="";
			 			if (jsonObj.topic) {
			 				for (var i = 0; i < jsonObj.topic.length; i++) {
			 					topicString += jsonObj.topic[i] + ", ";
			 				}
			 			}
			 			if (jsonObj.language) {
			 				for (var i = 0; i < jsonObj.language.length; i++) {
			 					languageString += jsonObj.language[i] + ", ";
			 				}
			 			}
				 		tableItem = 
       					"<span class='fname detail'>" + jsonObj.oname + "</span>" +
       					((typeof orgEditLinkData != "undefined") && orgEditLinkData[orgId] ? "<a href='" + orgEditLinkData[orgId] + "' target='_blank' style='margin-left:20px;' >Edit 	this Listing</a>" : "") +
       					"<div class='detail' style='width:390px;top:80px;'>" +
										(jsonObj.member ? "<p><span><a href='javascript:void(0)' onclick='showOrgMemberList(\"" + orgId + "\", \"" + jsonObj.oname + "\")'>" + jsonObj.member.length + " network member" + (jsonObj.member.length > 1 ? "s" : "") + "</a></span></p>" : "") +
       							(jsonObj.url ? "<p><span class='tod'><a href='" + jsonObj.url + "' target='_blank'>" + jsonObj.url + "</a></span>	</p>" : "<p>&nbsp;</p>") +
										(jsonObj.cname ? "<span>" + jsonObj.cname + "</span><br/>" : "") +
										(jsonObj.email ? "<span>Email: " + jsonObj.email + "</span><br/>" : "") +
										(jsonObj.phone ? "<span>Phone: " + jsonObj.phone + "</span><br/>" : "") +
										(jsonObj.fax ? "<span>Fax: " + jsonObj.fax + "</span>" : "") +
										(jsonObj.formatted ? "<p><span>Primary Address: " + jsonObj.formatted + "</span></p>" : "<p><span>" + loc1 + loc2 + "</span></p>") +
										(jsonObj.type ? "<p>Organization Type: " + jsonObj.type + "</p>" : "") +
										(topicString ? "<p>Focus Areas: " + truncateString(topicString.replace(/,\s*$/, ""),200) + "</p>" : "") +
										(languageString ? "<p>Languages: " + truncateString(languageString.replace(/,\s*$/, ""),200) + "</p>" : "") +
								"</div>";
			 				document.getElementById("itemCol1Adv").innerHTML = "<div class='td-div'>" + tableItem + "<div>";   
 							addDetailMarker(jsonObj);
     			} else {
	     			tableItem = 
 		 					"<span class='fa fa-spinner fa-meh-o fa-lg' style='margin-left:10px;margin-right:10px;'></span>Uh oh. There was an error retrieving this directory listing."
			 				document.getElementById("itemCol1Adv").innerHTML = "<div class='td-div'>" + tableItem + "<div>";   
     			}
     		} else {
	     		tableItem = 
 						"<span class='fa fa-spinner fa-meh-o fa-lg' style='margin-left:10px;margin-right:10px;'></span>Uh oh. There was an error retrieving this directory listing."
			 			document.getElementById("itemCol1Adv").innerHTML = "<div class='td-div'>" + tableItem + "<div>";
     		}
			}
		}
		xmlhttp.open("GET", "<?php echo(Utilities::getHttpPath()); ?>" + "/src/framework/directoryDetailManager.php?id=" + orgId, true);
		xmlhttp.send();  		
	}
</script>

<div style="">
			
<div id="current_detail_display" style="min-height:300px;">	
	<div id="detailTable" class="table-div" style="border: 0px none !important;">
		<div class="tr-div detail">
			<div id="itemCol1Adv">
				<span class='fa fa-spinner fa-spin fa-lg' style="margin-left:10px;margin-right:10px;"></span>Loading detail...
			</div>
			<div id="itemCol2Adv" style="position:absolute;top:80px;left:460px;border: 0px none !important;">
				<div id="col2Text"></div>
				<div id="detailMapContainer" style="width:320px;height:210px;"></div>
			</div>
		</div>
	</div>
</div>

</div>

<script>
	
	var detailMap;
	var detailMarkers = [];
	
  function initDetailMap() {
		console.log("map initialized");
  	var mapDiv = document.getElementById('detailMapContainer');
    detailMap = new google.maps.Map(mapDiv, {
    	center: {lat: 41.88, lng: -87.62},
      zoom: 10
    });
   }

	function addDetailMarker(org) {
		//console.log("adding detail - lat: " + parseFloat(org.lat));
		//console.log("adding detail - long: " + parseFloat(org.long));
		// TODO - verify input is json
  	var marker = new google.maps.Marker({
	    position: {lat: parseFloat(org.lat), lng: parseFloat(org.long)},
   		map: detailMap,
   		title: org.oname
 		});
 		detailMarkers.push(marker);
 		setDetailMapOnAll(detailMap);
 		detailMap.setCenter(marker.getPosition());
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
