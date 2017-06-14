<script>
	function getOrgMemberList(orgId, orgName) {
		var xmlhttp = getXmlHttpRequest();
		xmlhttp.onreadystatechange=function() {
			console.log(xmlhttp.readyState);
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) 	{
				console.log(xmlhttp.responseText);
			 	var jsonObj = JSON.parse(xmlhttp.responseText);		 	
			 	var tableRows = [];		 	
			 	for (var i = 0; i < jsonObj.length; i++) { 
 					var tr = document.createElement("TR");
 					tr.setAttribute("id", "org-member-list-table-row-" + i);
 						var td1 = document.createElement("TD");
    					var fname = document.createTextNode(jsonObj[i].fname);
    					td1.appendChild(fname);
 						var td2 = document.createElement("TD");
    					var lname = document.createTextNode(jsonObj[i].lname);
    					td2.appendChild(lname);
    				var td3 = document.createElement("TD");
	 						var anchor = document.createElement("A");
 							anchor.setAttribute("href", "javascript:void(0)");
 							anchor.setAttribute("style", "ont-size:12px;font-weight:normal;");
 							anchor.setAttribute("onclick", "showAdvProfile(\"" + jsonObj[i].username + "\", \"" + jsonObj[i].fname + " " + jsonObj[i].lname + "\");");
 							var span = document.createElement("SPAN");
 							span.setAttribute("class", "fa fa-plus");
 							anchor.appendChild(span);
 							td3.appendChild(anchor);
 						tr.appendChild(td1);	
    				tr.appendChild(td2);
    				tr.appendChild(td3);
    				tableRows.push(tr);
			 	}
       	// Initialize the member DataTable (only necessary first time, but does no harm subsequently.
       	// initOrgMemberTable(); - moved to document.ready
       	// Clear all rows in the member DataTable and internal memory
				RECIPIENT_LIST = [];
       	ORG_MEMBER_TABLE.clear();
       	for (var i = 0; i < tableRows.length; i++) { 
       		// Add each row to the member DataTable
       		ORG_MEMBER_TABLE.row.add(tableRows[i]);
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
	