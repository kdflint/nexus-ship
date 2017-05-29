<script>
	function getOrgProgramList(orgId) {
		toggleMultiPartModal('openOrganizationView', 'program')
		var xmlhttp = getXmlHttpRequest();
		xmlhttp.onreadystatechange=function() {
			if (xmlhttp.readyState == 4) {
				tableItem = "";
				if (xmlhttp.status == 200) {
			 		var jsonObj;
			 		try { jsonObj = JSON.parse(xmlhttp.responseText); } catch(err) { console.log(err); jsonObj = 'undefined';}	
			 		if (jsonObj !== null && (typeof jsonObj !== 'undefined') && jsonObj.oname !== null) { 
			 			CURRENT_PROG = jsonObj;
				 		tableItem = 
       					"<div class='detail' style='width:390px;top:80px;'>" +
       							(jsonObj.name ? "<p><span>" + jsonObj.name + "</span></p>" : "<p>&nbsp;</p>") +
										(jsonObj.description ? "<p><span>" + jsonObj.description + "</span></p>" : "") +
										(jsonObj.eligibility ? "<p><span>" + jsonObj.eligibility + "</span></p>" : "") +
										(jsonObj.services ? "<p><span>" + jsonObj.services + "</span></p>" : "") +
										(jsonObj.involvement ? "<p><span>" + jsonObj.involvement + "</span></p>" : "") +
										(jsonObj.partner_interest ? "<p><span>" + jsonObj.partner_interest + "</span></p>" : "") +
										(jsonObj.partner_descr ? "<p><span>" + jsonObj.partner_descr + "</span></p>" : "") +
								"</div>";
			 				document.getElementById("itemCol1ProgAdv").innerHTML = "<div class='td-div'>" + tableItem + "<div>";   
     			} else {
	     			tableItem = 
 		 					"<span class='fa fa-spinner fa-meh-o fa-lg' style='margin-left:10px;margin-right:10px;'></span>Uh oh. There was an error retrieving this program listing."
			 				document.getElementById("itemCol1ProgAdv").innerHTML = "<div class='td-div'>" + tableItem + "<div>";   
     			}
     		} else {
	     		tableItem = 
 						"<span class='fa fa-spinner fa-meh-o fa-lg' style='margin-left:10px;margin-right:10px;'></span>Uh oh. There was an error retrieving this program listing."
			 			document.getElementById("itemCol1ProgAdv").innerHTML = "<div class='td-div'>" + tableItem + "<div>";
     		}
			}
		}
		xmlhttp.open("GET", "<?php echo(Utilities::getHttpPath()); ?>" + "/src/framework/programDetailManager.php?id=" + orgId, true);
		xmlhttp.send();  		
	}
</script>

<div style="">
			
<div id="current_program_display" style="min-height:300px;">	
	<div id="progDetailTable" class="table-div" style="border: 0px none !important;">
		<div class="tr-div detail">
			<div id="itemCol1ProgAdv">
				<span class='fa fa-spinner fa-spin fa-lg' style="margin-left:10px;margin-right:10px;"></span>Loading detail...
			</div>
			<div id="itemCol2ProgAdv" style="position:absolute;top:80px;left:460px;border: 0px none !important;">
				<div id="col2ProgText"></div>
			</div>
		</div>
	</div>
</div>

</div>

