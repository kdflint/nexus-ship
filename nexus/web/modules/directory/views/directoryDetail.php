<script>
	function getDirectoryDetail(orgId) {
		if (DETAIL_MAP === undefined) { initDetailMap(); }
		clearAllDetailMarkers();
		var xmlhttp = getXmlHttpRequest();
		xmlhttp.onreadystatechange=function() {
			if (xmlhttp.readyState == 4) {
				tableItem = "";
				if (xmlhttp.status == 200) {
			 		var jsonObj;
			 		try { jsonObj = JSON.parse(xmlhttp.responseText); } catch(err) { console.log(err); jsonObj = 'undefined';}	
			 		if (jsonObj !== null && (typeof jsonObj !== 'undefined') && jsonObj.oname !== null) { 
			 			var loc1 = jsonObj.location1 ? "<span>" + jsonObj.location1 + "</span><br/>" : "";
			 			var loc2 = jsonObj.location2 ? "<span>" + jsonObj.location2 + "</span><br/>" : "";
			 			var topicString = "";
						var languageString ="";
						var ethnicityString ="";
						var affiliationString ="";
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
			 			if (jsonObj.ethnicity) {
			 				for (var i = 0; i < jsonObj.ethnicity.length; i++) {
			 					ethnicityString += jsonObj.ethnicity[i] + ", ";
			 				}
			 			}
			 			if (jsonObj.affiliation) {
			 				for (var i = 0; i < jsonObj.affiliation.length; i++) {
			 					affiliationString += jsonObj.affiliation[i] + ", ";
			 				}
			 			}
				 		tableItem = 
		 						"<a href='javascript:void(0);' onclick='showDirectoryResults();'><span class='fa fa-chevron-circle-left fa-3x' 	style='margin-right:10px;'></span></a>" + 
       					"<span class='fname detail'>" + jsonObj.oname + "</span>" +
       					"<a href='<?php echo(Utilities::getHttpPath()); ?>/nexus.php?view=network' onclick=\"return confirm('To edit an organization in our directory, please login to Nexus Advantage\\n\\nDo you wish to visit Nexus Advantage?');\" target='_blank' style='margin-left:20px;' >Edit this Listing</a>" +
        					//((typeof orgEditLinkData != "undefined") && orgEditLinkData[orgId] ? "<a href='" + orgEditLinkData[orgId] + "' target='_blank' style='margin-left:20px;' >Edit 	this Listing</a>" : "") +
       					"<div class='detail' style='width:300px;top:80px;'>" +
						       	(jsonObj.program ? "<br/><span><a href='<?php echo(Utilities::getHttpPath()); ?>/login.php?oid=<?php echo($_SESSION['orgUid']); ?>&view=orgid-" + orgId + "' target='_blank'>Login</a> to view program details</a></span>" : "") +
										(jsonObj.member ? "<br/><span><a href='<?php echo(Utilities::getHttpPath()); ?>/login.php?oid=<?php echo($_SESSION['orgUid']); ?>&view=orgid-" + orgId + "' target='_blank'>Login</a> to view " + jsonObj.member.length + " network member" + (jsonObj.member.length > 1 ? "s" : "") + "</span>" : "") +
       							(jsonObj.url ? "<p><span class='tod'><a href='" + jsonObj.url + "' target='_blank'>" + jsonObj.url + "</a></span>	</p>" : "<p>&nbsp;</p>") +
										(jsonObj.cname ? "<span>" + jsonObj.cname + "</span><br/>" : "") +
										(jsonObj.email ? "<span>Email: " + jsonObj.email + "</span><br/>" : "") +
										(jsonObj.phone ? "<span>Phone: " + jsonObj.phone + "</span><br/>" : "") +
										(jsonObj.fax ? "<span>Fax: " + jsonObj.fax + "</span>" : "") +
										(jsonObj.formatted ? "<p><span>Primary Address: " + jsonObj.formatted + "</span></p>" : "<p><span>" + loc1 + loc2 + "</span></p>") +
										(jsonObj.type ? "<p>Organization Type: " + jsonObj.type + "</p>" : "") +
										(topicString ? "<p>Focus Areas: " + truncateString(topicString.replace(/,\s*$/, ""),200) + "</p>" : "") +
										(languageString ? "<p>Languages: " + truncateString(languageString.replace(/,\s*$/, ""),200) + "</p>" : "") +
										(ethnicityString ? "<p>Ethnicities Served: " + truncateString(ethnicityString.replace(/,\s*$/, ""),200) + "</p>" : "") +
										(affiliationString ? "<p>Religious Affiliation: " + truncateString(affiliationString.replace(/,\s*$/, ""),200) + "</p>" : "") +
										(jsonObj.size ? "<p>Congregation Size: " + jsonObj.size + "</p>" : "") +
								"</div>";
			 				document.getElementById("itemRow").innerHTML = "<div class='td-div'>" + tableItem + "<div>";
 							addDetailMarker(jsonObj);
     			} else {
	     			tableItem = 
 		 					"<a href='javascript:void(0);' onclick='showDirectoryResults();'><span class='fa fa-chevron-circle-left fa-3x' 	style='margin-right:10px;'></span></a>" +
 		 					"<span class='fa fa-spinner fa-meh-o fa-lg' style='margin-left:10px;margin-right:10px;'></span>Uh oh. There was an error retrieving this directory listing."
			 				document.getElementById("itemRow").innerHTML = "<div class='td-div'>" + tableItem + "<div>";   
     			}
     		} else {
	     		tableItem = 
 						"<a href='javascript:void(0);' onclick='showDirectoryResults();'><span class='fa fa-chevron-circle-left fa-3x' 	style='margin-right:10px;'></span></a>" +
 						"<span class='fa fa-spinner fa-meh-o fa-lg' style='margin-left:10px;margin-right:10px;'></span>Uh oh. There was an error retrieving this directory listing."
			 			document.getElementById("itemRow").innerHTML = "<div class='td-div'>" + tableItem + "<div>";
     		}
			}
		}
		xmlhttp.open("GET", "<?php echo(Utilities::getHttpPath()); ?>" + "/src/framework/directoryDetailManager.php?id=" + orgId, true);
		xmlhttp.send();  		
	}
</script>

<div style="">
			
<div id="current_detail_display">	
	<div id="detailTable" class="table-div" style="border: 0px none !important;">
		<div class="tr-div detail">
			<div id="itemRow">
				<a href="javascript:void(0);" onclick="showDirectoryResults();"><span class='fa fa-chevron-circle-left fa-3x' style="margin-right:10px;margin-top:25px;"></span></a>
				<span class='fa fa-spinner fa-spin fa-lg' style="margin-left:10px;margin-right:10px;"></span>Loading detail...
			</div>
			<div id="detailMapContainer" style="width:300px;height:200px;position:absolute;top:80px;left:310px;border: 0px none !important;">
			</div>
		</div>
	</div>
</div>

</div>
