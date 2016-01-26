<script>
	function getDirectoryList(thisForm) {
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
				//var testData = '[{"name":"Nexus Training Organization","content":[{"contact":["Kathy"]},{"language":["english","spanish"]},{"topic":["hi"]},{"location":[""]},{"orgid":"330"}]},{"name":"Nexus Training Organization","content":[{"contact":["Kathy"]},{"language":["english","spanish"]},{"topic":["hi"]},{"location":[""]},{"orgid":"330"}]}]';
			 	//var jsonObj = JSON.parse(testData);
			 	var jsonObj = JSON.parse(xmlhttp.responseText);	 	
			 	// put row containers in the directory table, 1 for each event
			 	var tableRows = "";
			 	var n = -1;
			 	if (jsonObj.length == 0) {
			 		tableRows = tableRows + 
			 		"<div id='directoryRow0' class='tr-div viewSet0' style='position:relative;'>" +
			 			"<div class='td-div'>" +
       				"<div class='detail'>" +
 					  		"<span class='organization'>There are no findings for this search.</span>" +
							"</div>" +
     				"</div>" +
     			"</div>";
			 	} else {
			 		for (var i = 0; i < jsonObj.length; i++) { 
				 		// increment class name every 5 items to faciliate pagination
			 			n = (i % viewSetSize == 0 ? n + 1 : n); 
			 			tableRows = tableRows + "<div id='directoryRow" + i + "' class='tr-div viewSet" + n + "' style='position:relative;'></div>";
			 		}
			 	}
       	document.getElementById("directoryTable").innerHTML = tableRows;   	

		 		for (var i = 0; i < jsonObj.length; i++) {
		 			var thisContent = "";
		 			var lineHeightMultiple = 0;
	 				for (var j = 0; j < jsonObj[i].content[0].contact.length; j++) {
	 					if (jsonObj[i].content[0].contact[j].length > 0) {
	 						if (j == 0) {
	 							thisContent = thisContent + "<br/>Contact: ";
	 						}
	 						thisContent = thisContent + jsonObj[i].content[0].contact[j];
	 						if (j < jsonObj[i].content[0].contact.length-1) {thisContent = thisContent + ", ";}
	 						lineHeightMultiple++;
	 					}
	 				}
	 				for (var j = 0; j < jsonObj[i].content[1].language.length; j++) {
	 					if (jsonObj[i].content[1].language[j].length > 0) {
	 						if (j == 0) {
	 							thisContent = thisContent + "<br/>Language: ";
	 						}
		 					thisContent = thisContent + jsonObj[i].content[1].language[j];
		 					if (j < jsonObj[i].content[1].language.length-1) {thisContent = thisContent + ", ";}
	 						lineHeightMultiple++;
		 				}
	 				}
	 				for (var j = 0; j < jsonObj[i].content[2].topic.length; j++) {
	 					if (jsonObj[i].content[2].topic[j].length > 0) {
	 						if (j == 0) {
	 							thisContent = thisContent + "<br/>Topic: ";
	 						}
	 						thisContent = thisContent + jsonObj[i].content[2].topic[j];
	 						if (j < jsonObj[i].content[2].topic.length-1) {thisContent = thisContent + ", ";}
	 						lineHeightMultiple++;
	 					}
	 				}
	 				for (var j = 0; j < jsonObj[i].content[3].location.length; j++) {
	 					if (jsonObj[i].content[3].location[j].length > 0) {
	 						if (j == 0) {
	 							thisContent = thisContent + "<br/>Location: ";
	 						}
	 						thisContent = thisContent + jsonObj[i].content[3].location[j];
	 						if (j < jsonObj[i].content[3].location.length-1) {thisContent = thisContent + ", ";}
	 						lineHeightMultiple++;
	 					}
	 				}
	
					var lineHeight = 60 + (lineHeightMultiple*20);
		 			tableItem = 
       			"<div class='td-div'>" +
       				"<div class='detail'>" +
 					  		"<span class='organization'>" + jsonObj[i].name + "</span>" +
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
	
	<span class='date detail' style="padding-left:10px;">Search Results</span>
	<div id="directoryTable" class="table-div" style="border: 0px none !important;width:90%;padding-left:20px;">

	<div style="text-align:center;"></div>
</div>
	