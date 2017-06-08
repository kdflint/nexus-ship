<script>
	function getOrgProgramList(orgId) {
		CURRENT_PROG = null;
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
       					"<div class='detail' style='width:100%;top:80px;'>" +
       							(jsonObj.name ? "<p><span><b>Name: </b>" + htmlFormatParagraphs(jsonObj.name) + "</span></p>" : "<p>&nbsp;</p>") +
										(jsonObj.description ? "<p><b>Description: </b><span>" + htmlFormatParagraphs(jsonObj.description) + "</span></p>" : "") +
										(jsonObj.eligibility ? "<p><b>Who is eligible to participate? </b><span>" + htmlFormatParagraphs(jsonObj.eligibility) + "</span></p>" : "") +
										(jsonObj.services ? "<p><b>What kind of services, programs or activities do you provide? </b><span>" + htmlFormatParagraphs(jsonObj.services) + "</span></p>" : "") +
										(jsonObj.involvement ? "<p><b>What does someone have to do to get involved? </b><span>" + htmlFormatParagraphs(jsonObj.involvement) + "</span></p>" : "") +
										(jsonObj.partner_interest ? "<p><b>Are you interested in partnering with others? </b><span>" + htmlFormatParagraphs(jsonObj.partner_interest) + "</span></p>" : "") +
										(jsonObj.partner_descr ? "<p><b>What kind of partners would you like to work with? </b><span>" + htmlFormatParagraphs(jsonObj.partner_descr) + "</span></p>" : "") +
										(jsonObj.ada ? "<p><b>Is your facility accessible as defined by the Americans with Disabilities Act (ADA)? </b><span>" : "") + 
										((jsonObj.ada && jsonObj.ada === 't') ?  "Yes" : "") +
										((jsonObj.ada && jsonObj.ada === 'f') ?  "No" : "") +
										(jsonObj.ada ? "</span></p>" : "") +
										(jsonObj.hours ? "<p><b>Hours of operation? </b><span>" + htmlFormatParagraphs(jsonObj.hours) + "</span></p>" : "") +
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
			 	populateProgramForm();
			}
		}
		xmlhttp.open("GET", "<?php echo(Utilities::getHttpPath()); ?>" + "/src/framework/programDetailManager.php?id=" + orgId, true);
		xmlhttp.send();  		
	}
</script>

<div style="">
			
<div id="current_program_display" style="height:300px;overflow:auto;font-size:90%;">	
	<div id="progDetailTable" class="table-div" style="border: 0px none !important;">
		<div class="tr-div detail">
			<div id="itemCol1ProgAdv" style="overflow:auto;">
				<span class='fa fa-spinner fa-spin fa-lg' style="margin-left:10px;margin-right:10px;"></span>Loading detail...
			</div>
		</div>
	</div>
</div>

</div>

