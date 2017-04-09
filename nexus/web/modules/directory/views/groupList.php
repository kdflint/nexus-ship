<script>
	function getGroupList(groupId, groupName) {
		var xmlhttp = getXmlHttpRequest();
		xmlhttp.onreadystatechange=function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) 	{
			 	var jsonObj = JSON.parse(xmlhttp.responseText);		 	
			 	var tableRows = "";			 	
			 	for (var i = 0; i < jsonObj.length; i++) { 
			 		tableRows = tableRows + "<tr id='group-list-table-row-" + i + "'>" +
			 			"<td><input type='checkbox' name='names[]' value='" + jsonObj[i].username + "::" + jsonObj[i].fname + " " + jsonObj[i].lname + "'  \></td>" + 
			 			"<td>" + 
			 				"<a href='javascript:void(0)' style='font-size:12px;font-weight:normal;' onclick='showAdvProfile(\"" + jsonObj[i].username + "\", \"" + jsonObj[i].fname + " " + jsonObj[i].lname + "\");'>" +
			 					"<span class='fa fa-plus'></span>" +
			 				"</a>" +
			 			"</td>" +			
						"<td>" + jsonObj[i].fname + "</td>" +
 						"<td>" + jsonObj[i].lname + "</td>" +
 						"</tr>";
			 	}
			 	//Once all the rows are generated, add the rows to the DOM
       	document.getElementById("group-list-table-rows").innerHTML = tableRows;
       	// Initialize the member DataTable (only necessary first time, but does no harm subsequently.
       	initMemberTable();
       	// Clear all rows in the member DataTable and internal memory
				RECIPIENT_LIST = [];
       	MEMBER_TABLE.clear();
       	for (var i = 0; i < jsonObj.length; i++) { 
       		var thisRow = document.getElementById("group-list-table-row-" + i);
       		// Add each row to the member DataTable
       		MEMBER_TABLE.row.add(thisRow);
       	}
       	// Draw the member DataTable
       	MEMBER_TABLE.draw();
       	document.getElementById("network_group_name").innerHTML = truncateString(groupName,70);
			}
		}
		xmlhttp.open("GET", "<?php echo(Utilities::getHttpPath()); ?>" + "/src/framework/groupListManager.php?id=" + groupId);
		xmlhttp.send();  		
	}
</script>

<form id="member-directory-form" action="#" method="post">
	<table id="member-directory" class="display compact" width="100%" cellspacing="0">	
		<thead>
			<tr><th>Select for Message</th><th>Details</th><th>First</th><th>Last</th></tr>
		</thead>
		<tbody id="group-list-table-rows">
		</tbody>
	</table>
	<input type="hidden" name="togglestate" value="0">
</form>
				
	