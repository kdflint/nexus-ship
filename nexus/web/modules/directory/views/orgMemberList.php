<script>
	function getOrgMemberList(orgId, orgName) {
		var xmlhttp = getXmlHttpRequest();
		xmlhttp.onreadystatechange=function() {
			console.log(xmlhttp.readyState);
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) 	{
			//if (false) {
				console.log(xmlhttp.responseText);
			 	var jsonObj = JSON.parse(xmlhttp.responseText);		 	
			 	var tableRows = "";			 	
			 	for (var i = 0; i < jsonObj.length; i++) { 
			 		tableRows = tableRows + "<tr id='org-member-list-table-row-" + i + "'>" +
			 			"<td>" + jsonObj[i].fname + "</td>" +
 						"<td>" + jsonObj[i].lname + "</td>" +
			 			"<td>" + 
			 				"<a href='javascript:void(0)' style='font-size:12px;font-weight:normal;' onclick='showAdvProfile(\"" + jsonObj[i].username + "\", \"" + jsonObj[i].fname + " " + jsonObj[i].lname + "\");'>" +
			 					"<span class='fa fa-plus'></span>" +
			 				"</a>" +
			 			"</td>" +			
 						"</tr>";
			 	}
			 	//Once all the rows are generated, add the rows to the DOM
			 	document.getElementById("orgDetailNameForBlahBlah").innerHTML = orgName;
       	document.getElementById("org-member-list-table-rows").innerHTML = tableRows;
       	// Initialize the member DataTable (only necessary first time, but does no harm subsequently.
       	initOrgMemberTable();
       	// Clear all rows in the member DataTable and internal memory
				RECIPIENT_LIST = [];
       	ORG_MEMBER_TABLE.clear();
       	for (var i = 0; i < jsonObj.length; i++) { 
       		var thisRow = document.getElementById("org-member-list-table-row-" + i);
       		// Add each row to the member DataTable
       		ORG_MEMBER_TABLE.row.add(thisRow);
       	}
       	// Draw the member DataTable
       	ORG_MEMBER_TABLE.draw();
			}
		}
		xmlhttp.open("GET", "<?php echo(Utilities::getHttpPath()); ?>" + "/src/framework/orgMemberListManager.php?id=" + orgId);
		xmlhttp.send();  		
	}
</script>

<table id="org-member-directory" class="display compact" width="100%" cellspacing="0">	
	<thead>
		<tr><th>First</th><th>Last</th><th>Profile</th></tr>
	</thead>
	<tbody id="org-member-list-table-rows">
	</tbody>
</table>
	