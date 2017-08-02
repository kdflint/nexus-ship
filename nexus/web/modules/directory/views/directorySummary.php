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
    var keywordString = document.forms[thisForm].keyword.value;
    // yuck yuck yuck. Doing below for CFCHT
		var searchString = "";
		if (document.forms[thisForm].keyword2 !== undefined) {
			searchString += document.forms[thisForm].keyword2.value;
		}
		if (document.forms[thisForm].keyword3 !== undefined) {
			searchString += " " + document.forms[thisForm].keyword3.value;
		}
		if (searchString.length > 0) {
			searchString += " " + keywordString;
		} else {
			searchString = keywordString;
		}
		var searchSpecialty = document.forms[thisForm].specialty.value;
		var searchType = document.forms[thisForm].type.value;
		var searchAffiliation = "";
		if (document.forms[thisForm].affiliation !== undefined) {
			searchAffiliation = document.forms[thisForm].affiliation.value;
		}
		var xmlhttp = getXmlHttpRequest();
		xmlhttp.onreadystatechange=function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				var stringToParse = xmlhttp.responseText;
				//var stringToParse = '{"name":"Nexus Training Organization","content":[{"contact":[""]},{"language":[""]},{"topic":[""]},{"location":[""]},{"orgid":"330"}]}';//,{"name":"Nexus Web Meet Demonstration","content":[{"contact":[""]},{"language":[""]},{"topic":[""]},{"location":[""]},{"orgid":"331"}]}';
				//console.log(stringToParse);
			 	var jsonObj = JSON.parse(stringToParse);
			 	var geoData = jsonObj.geoEntry;
	   		buildMarkerList(geoData, "NWM");  	
			 	// put row containers in the directory table, 1 for each event
			 	var tableRows = "";
			 	var n = -1;
       	document.getElementById("directory_search_count").innerHTML = jsonObj.orgEntry.length + " Records";
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
		 			if (jsonObj.orgEntry[i].content[0].programs[0].length > 0) {
		 				// Lazy way to do this because search returns updated programs that remain in database
 						thisContent = thisContent + "; Program Match";
		 			}
	 				for (var j = 0; j < jsonObj.orgEntry[i].content[2].contact.length; j++) {
	 					if (jsonObj.orgEntry[i].content[2].contact[j].length > 0) {
	 						if (j == 0) {
	 							thisContent = thisContent + "<br/>Organizational Contact: ";
	 						}
	 						thisContent = thisContent + jsonObj.orgEntry[i].content[2].contact[j];
	 						if (j < jsonObj.orgEntry[i].content[2].contact.length-1) {thisContent = thisContent + ", ";}
	 						lineHeightMultiple++;
	 					}
	 				}
	 				for (var j = 0; j < jsonObj.orgEntry[i].content[3].language.length; j++) {
	 					if (jsonObj.orgEntry[i].content[3].language[j].length > 0) {
	 						if (j == 0) {
	 							thisContent = thisContent + "<br/>Language: ";
	 						}
		 					thisContent = thisContent + jsonObj.orgEntry[i].content[3].language[j];
		 					if (j < jsonObj.orgEntry[i].content[3].language.length-1) {thisContent = thisContent + ", ";}
	 						lineHeightMultiple++;
		 				}
	 				}
	 				for (var j = 0; j < jsonObj.orgEntry[i].content[4].topic.length; j++) {
	 					if (jsonObj.orgEntry[i].content[4].topic[j].length > 0) {
	 						if (j == 0) {
	 							thisContent = thisContent + "<br/>Topic: ";
	 						}
	 						thisContent = thisContent + jsonObj.orgEntry[i].content[4].topic[j];
	 						if (j < jsonObj.orgEntry[i].content[4].topic.length-1) {thisContent = thisContent + ", ";}
	 						lineHeightMultiple++;
	 					}
	 				}
	 				for (var j = 0; j < jsonObj.orgEntry[i].content[5].location.length; j++) {
	 					if (jsonObj.orgEntry[i].content[5].location[j].length > 0) {
	 						if (j == 0) {
	 							thisContent = thisContent + "<br/>Location: ";
	 						}
	 						thisContent = thisContent + jsonObj.orgEntry[i].content[5].location[j];
	 						if (j < jsonObj.orgEntry[i].content[5].location.length-1) {thisContent = thisContent + ", ";}
	 						lineHeightMultiple++;
	 					}
	 				}
	 				if (jsonObj.orgEntry[i].content[1].people[0].length > 0) {
	 					var numPeople = jsonObj.orgEntry[i].content[1].people.length;
						var suffix = numPeople > 1 ? "es" : ""
						thisContent = thisContent + "<br/>" + numPeople + " Network Member Match" + suffix;
 						lineHeightMultiple++;
 					}
					var lineHeight = 40 + (lineHeightMultiple*20);
		 			tableItem = 
       			"<div class='td-div'>" +
       				"<div class='detail'>" +
 					  		"<a href='javascript:void(0)' onclick='showDirectoryDetail(" + jsonObj.orgEntry[i].content[6].orgid + ")'><span class='organization'>" + htmlDecode(jsonObj.orgEntry[i].name) + "</span></a>" +
 					  		"<span style='font-size:80%'>" + thisContent + "</span>" +
							"</div>" +
     				"</div>";
    			document.getElementById("directoryRow" + i).innerHTML = tableItem;   
    			document.getElementById("directoryRow" + i).style.height = lineHeight + "px";
	   		}
			}
		}
		xmlhttp.open("GET", "<?php echo(Utilities::getHttpPath()); ?>" + "/src/framework/directoryManager.php?string=" + searchString + "&specialty=" + searchSpecialty + "&type=" + searchType + "&affiliation=" + searchAffiliation, true);
		xmlhttp.send();  		
	}

</script>

<?php if ($_SESSION['nexusContext'] === "PUB") { ?>
	<span class='date detail' style="position:absolute;padding-top:14px;padding-left:14px;"><span id="directory_search_header1">Search</span> Results: <span id="directory_search_count"></span></span>
<?php } else { ?>
	<span style="position:absolute;padding-top:14px;padding-left:14px;font-size:120%;">Results: <span id="directory_search_count"></span></span>
<?php } ?>
	<?php if ($_SESSION['nexusContext'] === "PUB") { ?>
	<div style="margin-top:10px;margin-right:10px;float:right">
		<a id='map_control' href='#' onclick="initMap();">
			<span id="directory_control" class='fa fa-globe fa-3x' ></span>
		</a>	
  </div>	
	<?php } ?>

<div id="directoryTable" class="table-div directory-table" style="border:0px none !important;width:90%;padding-left:20px;padding-top:50px;">
Please enter your search term at left.
</div>

<div id="directoryMapContainer" class="table-div" style="opacity:0;z-index:-1;filter:alpha(opacity=0);width:100%;height:82%;border: 0px none !important;position:absolute;top:70px;"></div>
