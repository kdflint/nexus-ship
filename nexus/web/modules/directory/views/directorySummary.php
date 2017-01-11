<script>
	function getDirectoryList(thisForm) {
		clearAllMarkers();
		document.getElementById("directoryTable").innerHTML = "<div id='directoryRow0' class='tr-div viewSet0' style='position:relative;'>" +
		"<div class='td-div'>" +
       "<div class='detail'>" +
					"<span class='fa fa-spinner fa-spin fa-lg' style='margin-right:10px;'></span>Searching..." +
				"</div>" +
     	"</div>" +
    "</div>";
		var searchString = document.forms[thisForm].keyword.value;
		var searchSpecialty = document.forms[thisForm].specialty.value;
		var searchType = document.forms[thisForm].type.value;
		var xmlhttp = getXmlHttpRequest();
		xmlhttp.onreadystatechange=function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				var stringToParse = xmlhttp.responseText;
				//var stringToParse = '{"name":"Nexus Training Organization","content":[{"contact":[""]},{"language":[""]},{"topic":[""]},{"location":[""]},{"orgid":"330"}]}';//,{"name":"Nexus Web Meet Demonstration","content":[{"contact":[""]},{"language":[""]},{"topic":[""]},{"location":[""]},{"orgid":"331"}]}';
			 	var jsonObj = JSON.parse(stringToParse);
			 	var geoData = jsonObj.geoEntry;
			 	//console.log(stringToParse);
	   		addMarkers(geoData);  	
			 	// put row containers in the directory table, 1 for each event
			 	var tableRows = "";
			 	var n = -1;
			 	if (jsonObj.orgEntry.length == 0) {
			 		tableRows = tableRows + 
			 		"<div id='directoryRow0' class='tr-div viewSet0' style='position:relative;'>" +
			 			"<div class='td-div'>" +
       				"<div class='detail'>" +
 					  		"<span class='organization'>There are no findings for this search.</span>" +
							"</div>" +
     				"</div>" +
     			"</div>";
			 	} else {
			 		for (var i = 0; i < jsonObj.orgEntry.length; i++) { 
				 		// increment class name every 5 items to faciliate pagination
				 		// maybe get rid of this and use scrollbar
			 			//n = (i % viewSetSize == 0 ? n + 1 : n); 
			 			//tableRows = tableRows + "<div id='directoryRow" + i + "' class='tr-div viewSet" + n + "' style='position:relative;'></div>";
			 			tableRows = tableRows + "<div id='directoryRow" + i + "' class='tr-div' style='position:relative;'></div>";
			 		}
			 	}
       	document.getElementById("directoryTable").innerHTML = tableRows; 

				// Show only those components returned by search.
				// Ugly as stink - will refactor this object altogether once requirements become more clear -kdf
		 		for (var i = 0; i < jsonObj.orgEntry.length; i++) {
		 			var thisContent = "";
		 			var lineHeightMultiple = 0;
	 				for (var j = 0; j < jsonObj.orgEntry[i].content[0].contact.length; j++) {
	 					if (jsonObj.orgEntry[i].content[0].contact[j].length > 0) {
	 						if (j == 0) {
	 							thisContent = thisContent + "<br/>Contact: ";
	 						}
	 						thisContent = thisContent + jsonObj.orgEntry[i].content[0].contact[j];
	 						if (j < jsonObj.orgEntry[i].content[0].contact.length-1) {thisContent = thisContent + ", ";}
	 						lineHeightMultiple++;
	 					}
	 				}
	 				for (var j = 0; j < jsonObj.orgEntry[i].content[1].language.length; j++) {
	 					if (jsonObj.orgEntry[i].content[1].language[j].length > 0) {
	 						if (j == 0) {
	 							thisContent = thisContent + "<br/>Language: ";
	 						}
		 					thisContent = thisContent + jsonObj.orgEntry[i].content[1].language[j];
		 					if (j < jsonObj.orgEntry[i].content[1].language.length-1) {thisContent = thisContent + ", ";}
	 						lineHeightMultiple++;
		 				}
	 				}
	 				for (var j = 0; j < jsonObj.orgEntry[i].content[2].topic.length; j++) {
	 					if (jsonObj.orgEntry[i].content[2].topic[j].length > 0) {
	 						if (j == 0) {
	 							thisContent = thisContent + "<br/>Topic: ";
	 						}
	 						thisContent = thisContent + jsonObj.orgEntry[i].content[2].topic[j];
	 						if (j < jsonObj.orgEntry[i].content[2].topic.length-1) {thisContent = thisContent + ", ";}
	 						lineHeightMultiple++;
	 					}
	 				}
	 				for (var j = 0; j < jsonObj.orgEntry[i].content[3].location.length; j++) {
	 					if (jsonObj.orgEntry[i].content[3].location[j].length > 0) {
	 						if (j == 0) {
	 							thisContent = thisContent + "<br/>Location: ";
	 						}
	 						thisContent = thisContent + jsonObj.orgEntry[i].content[3].location[j];
	 						if (j < jsonObj.orgEntry[i].content[3].location.length-1) {thisContent = thisContent + ", ";}
	 						lineHeightMultiple++;
	 					}
	 				}
					var lineHeight = 60 + (lineHeightMultiple*20);
		 			tableItem = 
       			"<div class='td-div'>" +
       				"<div class='detail'>" +
 					  		"<a href='javascript:void(0)' onclick='showDirectoryDetail(" + jsonObj.orgEntry[i].content[4].orgid + ")'><span class='organization'>" + jsonObj.orgEntry[i].name + "</span></a>" +
 					  		"<span class='tod'>" + thisContent + "</span>" +
							"</div>" +
     				"</div>";
    			document.getElementById("directoryRow" + i).innerHTML = tableItem;   
    			document.getElementById("directoryRow" + i).style.height = lineHeight + "px";
	   		}
			}
		}
		xmlhttp.open("GET", "<?php echo(Utilities::getHttpPath()); ?>" + "/src/framework/directoryManager.php?string=" + searchString + "&specialty=" + searchSpecialty + "&type=" + searchType, true);
		xmlhttp.send();  		
	}

</script>

<span class='date detail' style="position:absolute;padding-top:14px;padding-left:14px;">Search Results</span>
	<?php if ($_SESSION['nexusContext'] === "PUB") { ?>
	<div style="margin-top:10px;margin-right:10px;float:right">
		<a id='map_control' href='#' onclick="initMap();">
			<span id="directory_control" class='fa fa-globe fa-3x' ></span>
		</a>	
  </div>	
	<?php } ?>

<div id="directoryTable" class="table-div" style="border:0px none !important;width:90%;padding-left:20px;padding-top:50px;"></div>

<div id="directoryMapContainer" class="table-div" style="opacity:0;z-index:-1;filter:alpha(opacity=0);width:100%;height:82%;border: 0px none !important;position:absolute;top:70px;"></div>

<script>
	
	var map;
	var markers = [];
	
  function initMap() {
  	var mapDiv = document.getElementById('directoryMapContainer');
    map = new google.maps.Map(mapDiv, {
    	center: {lat: 41.88, lng: -87.62},
      zoom: 9
    });
    showDirectoryMap();	
    setMapOnAll(map);
   }

	/*
	function addMarker(orgid) {
		if (geoDataCfcht[orgid]) {
			var orgGeo = geoDataCfcht[orgid][0];
	  	var marker = new google.maps.Marker({
		    position: {lat: orgGeo['lat'], lng: orgGeo['lng']},
    		map: map,
    		title: orgGeo['title']
  		});
	  	marker.addListener('click', function() {showDirectoryDetail(orgid);});
  		markers.push(marker);
  	}
	}
	*/

	function addMarkers(geoData) {
		if (geoData) {
  		for (var org in geoData) {
  			//console.log(org);	
  			//console.log(parseFloat(geoData[org]['lat']));	
  			//console.log(parseFloat(geoData[org]['lng']));
  			//console.log(geoData[org]['title']);
		  	var marker = new google.maps.Marker({
		    	position: {lat: parseFloat(geoData[org]['lat']), lng: parseFloat(geoData[org]['lng'])},
    			map: map,
    			title: geoData[org]['title']
  			});
	  		marker.addListener('click', function() {showDirectoryDetail(org);});
  			markers.push(marker);
  		}
  	}
	}
	

	function setMapOnAll(map) {
  	for (var i = 0; i < markers.length; i++) {
	    markers[i].setMap(map);
	  }
	}
	
	function clearAllMarkers() {
  	setMapOnAll(null);
  	markers = [];
	}
	
</script>
