<script>
	function getDirectoryDetailAdv(orgId) {
		if (DETAIL_MAP === undefined) { initDetailMap(); }
		clearAllDetailMarkers();
		var xmlhttp = getXmlHttpRequest();
		xmlhttp.onreadystatechange=function() {
			if (xmlhttp.readyState == 4) {
				tableItem = "";
				if (xmlhttp.status == 200) {
			 		var jsonObj;
			 		try { jsonObj = JSON.parse(xmlhttp.responseText); } catch(err) { console.log(err); jsonObj = 'undefined';}	
			 		if ((typeof jsonObj !== 'undefined') && jsonObj !== null & jsonObj.oname !== null) { 
			 			CURRENT_ORG = jsonObj;
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
       					"<span class='fname detail'>" + htmlEntities(jsonObj.oname) + "</span>" +
       					"<a id='secondary-network-edit' class='secondaryControl priv-1' href='javascript:void(0)' onclick='return populateDirectoryFormBasic();' title='Edit Organization'><span class='fa fa-pencil fa-lg' ></span></a>" +
       					//((typeof orgEditLinkData != "undefined") && orgEditLinkData[orgId] ? "<a href='" + orgEditLinkData[orgId] + "' target='_blank' style='margin-left:20px;' >Edit 	this Listing</a>" : "") +
       					"<div class='detail' style='width:390px;top:80px;'>" +
										(jsonObj.member ? "<p><span><a href='javascript:void(0)' onclick='showOrgMemberList(\"" + orgId + "\", \"" + htmlEntities(jsonObj.oname) + "\")'>" + jsonObj.member.length + " network member" + (jsonObj.member.length > 1 ? "s" : "") + "</a></span></p>" : "") +
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

