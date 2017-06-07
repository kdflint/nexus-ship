<script>
	function getDirectoryList(thisForm) {
		clearAllMarkers();
		//document.getElementById("directory_search_count").innerHTML = "<span class='fa fa-spinner fa-spin fa-lg' style='margin-right:10px;'></span>Searching...";
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
			 	var jsonObj = JSON.parse(stringToParse);
			 	var geoData = jsonObj.geoEntry;
	   		buildMarkerList(geoData, "ADV");  	

			 	var tableRows = [];
			 	if (jsonObj.orgEntry.length == 0) {
			 		var tr = document.createElement("TR");
	 				tr.setAttribute("id", "directoryRow0");
    				var td1 = document.createElement("TD");
    					var orgId = document.createTextNode("0");
    					td1.appendChild(orgId);
	    			var td2 = document.createElement("TD");
    				var span1 = document.createElement("SPAN");
    				span1.setAttribute("class", "organization");
    				var orgContent = document.createTextNode("There are no findings for this search.");
    				span1.appendChild(orgContent);
    				td2.appendChild(span1);
    			tr.appendChild(td1);
    			tr.appendChild(td2);
    			tableRows.push(tr);
			 	} else {				
					// Show only those components returned by search.
					// Ugly as stink - will refactor this object altogether once requirements become more clear -kdf
			 		for (var i = 0; i < jsonObj.orgEntry.length; i++) {
			 			var thisContent = "";
		 				for (var j = 0; j < jsonObj.orgEntry[i].content[1].contact.length; j++) {
		 					if (jsonObj.orgEntry[i].content[1].contact[j].length > 0) {
		 						if (j == 0) {
		 							thisContent = thisContent + "; Organizational Contact: ";
		 						}
		 						thisContent = thisContent + jsonObj.orgEntry[i].content[1].contact[j];
		 						if (j < jsonObj.orgEntry[i].content[1].contact.length-1) {thisContent = thisContent + ", ";}
		 					}
		 				}
		 				for (var j = 0; j < jsonObj.orgEntry[i].content[2].language.length; j++) {
		 					if (jsonObj.orgEntry[i].content[2].language[j].length > 0) {
		 						if (j == 0) {
		 							thisContent = thisContent + "; Language: ";
		 						}
			 					thisContent = thisContent + jsonObj.orgEntry[i].content[2].language[j];
			 					if (j < jsonObj.orgEntry[i].content[2].language.length-1) {thisContent = thisContent + ", ";}
			 				}
		 				}
		 				for (var j = 0; j < jsonObj.orgEntry[i].content[3].topic.length; j++) {
		 					if (jsonObj.orgEntry[i].content[3].topic[j].length > 0) {
		 						if (j == 0) {
		 							thisContent = thisContent + "; Topic: ";
		 						}
		 						thisContent = thisContent + jsonObj.orgEntry[i].content[3].topic[j];
		 						if (j < jsonObj.orgEntry[i].content[3].topic.length-1) {thisContent = thisContent + ", ";}
		 					}
		 				}
		 				for (var j = 0; j < jsonObj.orgEntry[i].content[4].location.length; j++) {
		 					if (jsonObj.orgEntry[i].content[4].location[j].length > 0) {
		 						if (j == 0) {
		 							thisContent = thisContent + "; Location: ";
		 						}
		 						thisContent = thisContent + jsonObj.orgEntry[i].content[4].location[j];
		 						if (j < jsonObj.orgEntry[i].content[4].location.length-1) {thisContent = thisContent + ", ";}
		 					}
		 				}
		 				if (jsonObj.orgEntry[i].content[0].people[0].length > 0) {
		 					var numPeople = jsonObj.orgEntry[i].content[0].people.length;
							var suffix = numPeople > 1 ? "es" : ""
							thisContent = thisContent + "; " + numPeople + " Network Member Match" + suffix;
	 					}
	 					var tr = document.createElement("TR");
	 					tr.setAttribute("id", "directoryRow-" + i);
    					var td1 = document.createElement("TD");
    						var orgId = document.createTextNode(jsonObj.orgEntry[i].content[5].orgid);
    						td1.appendChild(orgId);
    					var td2 = document.createElement("TD");
    						var span1 = document.createElement("SPAN");
    						span1.setAttribute("class", "organization");
    						span1.setAttribute("style", "font-weight:bold;color:#d27b4b;cursor:pointer;");
    						var span2 = document.createElement("SPAN");
    						var orgName = document.createTextNode(htmlDecode(jsonObj.orgEntry[i].name));
    						var orgContent = document.createTextNode(thisContent);
    						span1.appendChild(orgName);
    						span2.appendChild(orgContent);
    						td2.appendChild(span1);
    						td2.appendChild(span2);
    				tr.appendChild(td1);	
    				tr.appendChild(td2)
			 			tableRows.push(tr);
	 	   		}
	      }
	 	   	// Initialize the org DataTable (only necessary first time, but does no harm subsequently.
	      initOrgTable();
	      ORG_TABLE.clear();
	      for (var i = 0; i < tableRows.length; i++) {     		
	      	ORG_TABLE.row.add(tableRows[i]);
	      }
	      ORG_TABLE.draw();	      
			}
		}
		xmlhttp.open("GET", "<?php echo(Utilities::getHttpPath()); ?>" + "/src/framework/directoryManager.php?string=" + searchString + "&specialty=" + searchSpecialty + "&type=" + searchType + "&affiliation=" + searchAffiliation, true);
		xmlhttp.send();  		
	}

</script>

<span style="position:absolute;padding-top:14px;padding-left:14px;font-size:120%;"><span id="directory_search_count"></span></span>
<div id="directoryDataContainer" class="directory-table">
	<table id="org-directory" class="display compact" width="90%" cellspacing="2" cellpadding="2" style="margin-left:-10px;">	
		<thead>
			<tr><th>id-hidden</th><th>Organization Name</th></tr>
		</thead>
		<tbody id="org-list-table-rows">
		</tbody>
	</table>
</div>
<div id="directoryMapContainer" class="table-div" style="opacity:0;z-index:-1;filter:alpha(opacity=0);width:90%;margin-left:20px;height:82%;border: 0px none !important;position:absolute;"></div>

