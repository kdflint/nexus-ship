<script>
	function getDirectoryList(thisForm) {
		var searchString = document.forms[thisForm].keyword.value;
		var searchSpecialty = document.forms[thisForm].specialty.value;
		var searchType = document.forms[thisForm].type.value;
		var xmlhttp = getXmlHttpRequest();
		xmlhttp.onreadystatechange=function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				//alert(xmlhttp.responseText);
				//var testData = '[{"name":"Nexus Training Organization","content":[{"contact":["Kathy"]},{"language":["english","spanish"]},{"topic":["hi"]},{"location":[""]},{"orgid":"330"}]}]';
			 	var jsonObj = JSON.parse(xmlhttp.responseText);	 	
			 	// put row containers in the directory table, 1 for each event
			 	var tableRows = "";
			 	var n = -1;
			 	for (var i = 0; i < jsonObj.length; i++) { 
			 		// increment class name every 5 items to faciliate pagination
			 		n = (i % viewSetSize == 0 ? n + 1 : n); 
			 		tableRows = tableRows + "<div id='directoryRow" + i + "' class='tr-div viewSet" + n + "' style='position:relative;'></div>";
			 	}
       	document.getElementById("directoryTable").innerHTML = tableRows;   	

		 		thisContent = "";
		 		for (var i = 0; i < jsonObj.length; i++) {
	 				for (var j = 0; j < jsonObj[i].content[0].contact.length; j++) {
	 					if (jsonObj[i].content[0].contact[j].length > 0) {
	 						if (j == 0) {
	 							thisContent = thisContent + "<br/>Contact: ";
	 						}
	 						thisContent = thisContent + jsonObj[i].content[0].contact[j];
	 						if (j < jsonObj[i].content[0].contact.length-1) {thisContent = thisContent + ", ";}
	 					}
	 				}
	 				for (var j = 0; j < jsonObj[i].content[1].language.length; j++) {
	 					if (jsonObj[i].content[1].language[j].length > 0) {
	 						if (j == 0) {
	 							thisContent = thisContent + "<br/>Language: ";
	 						}
		 					thisContent = thisContent + jsonObj[i].content[1].language[j];
		 					if (j < jsonObj[i].content[1].language.length-1) {thisContent = thisContent + ", ";}
		 				}
	 				}
	 				for (var j = 0; j < jsonObj[i].content[2].topic.length; j++) {
	 					if (jsonObj[i].content[2].topic[j].length > 0) {
	 						if (j == 0) {
	 							thisContent = thisContent + "<br/>Topic: ";
	 						}
	 						thisContent = thisContent + jsonObj[i].content[2].topic[j];
	 						if (j < jsonObj[i].content[2].topic.length-1) {thisContent = thisContent + ", ";}
	 					}
	 				}
	 				for (var j = 0; j < jsonObj[i].content[3].location.length; j++) {
	 					if (jsonObj[i].content[3].location[j].length > 0) {
	 						if (j == 0) {
	 							thisContent = thisContent + "<br/>Location: ";
	 						}
	 						thisContent = thisContent + jsonObj[i].content[3].location[j];
	 						if (j < jsonObj[i].content[3].location.length-1) {thisContent = thisContent + ", ";}
	 					}
	 				}
					//alert(jsonObj[i].content[4].orgid);
	
		 			tableItem = 
       			"<div class='td-div'>" +
       				"<div class='meeting'>" +
 					  		"<span class='purpose'>" + jsonObj[i].name + "</span><br/>" +
 					  		"<span class='purpose'>" + thisContent + "</span><br/>" +
							"</div>" +
     				"</div>";
    			document.getElementById("directoryRow" + i).innerHTML = tableItem;   
    			document.getElementById("directoryRow" + i).style.height = "90px";
	   		}  			
			}
		}
		xmlhttp.open("GET", "<?php echo(Utilities::getHttpPath()); ?>" + "/src/framework/directoryManager.php?string=" + searchString + "&specialty=" + searchSpecialty + "&type=" + searchType, true);
		xmlhttp.send();  		
	}

</script>
	
<div id="directoryTable" class="table-div" style="border: 0px none !important;">
	<div style="text-align:center;"></div>
</div>
	