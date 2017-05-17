<script>
	function getGroupList(groupId, groupName) {
		var xmlhttp = getXmlHttpRequest();
		xmlhttp.onreadystatechange=function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) 	{
			 	var jsonObj = JSON.parse(xmlhttp.responseText);		 	
			 	var tableRows = [];		 	
			 	for (var i = 0; i < jsonObj.length; i++) { 
 					var tr = document.createElement("TR");
 					tr.setAttribute("id", "group-list-table-row-" + i);
 						var td1 = document.createElement("TD");
 							var input = document.createElement("INPUT");
 							input.setAttribute("type", "checkbox");
 							input.setAttribute("name", "names[]");
 							input.setAttribute("value", jsonObj[i].username + "::" + jsonObj[i].fname + " " + jsonObj[i].lname);
 							td1.appendChild(input);
 						var td2 = document.createElement("TD");
 							var anchor = document.createElement("A");
 							anchor.setAttribute("href", "javascript:void(0)");
 							anchor.setAttribute("style", "font-size:12px;font-weight:normal;");
 							anchor.setAttribute("onclick", "showAdvProfile(\"" + jsonObj[i].username + "\", \"" + jsonObj[i].fname + " " + jsonObj[i].lname + "\");");
 							var span = document.createElement("SPAN");
 							span.setAttribute("class", "fa fa-plus");
 							anchor.appendChild(span);
 							td2.appendChild(anchor);
 						var td3 = document.createElement("TD");
 							var fnameContent = document.createTextNode(jsonObj[i].fname);
 							td3.appendChild(fnameContent);
 						var td4 = document.createElement("TD");
 							var lnameContent = document.createTextNode(jsonObj[i].lname);
 							td4.appendChild(lnameContent);
 						tr.appendChild(td1);	
    				tr.appendChild(td2);
 						tr.appendChild(td3);	
    				tr.appendChild(td4);
			 			tableRows.push(tr);
			 	}
       	// Initialize the member DataTable (only necessary first time, but does no harm subsequently.
       	initMemberTable();
       	// Clear all rows in the member DataTable and internal memory
				RECIPIENT_LIST = [];
       	MEMBER_TABLE.clear();
       	for (var i = 0; i < tableRows.length; i++) { 
       		// Add each row to the member DataTable
       		MEMBER_TABLE.row.add(tableRows[i]);
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
	<p style="font-size:120%;font-weight:bold;margin-left:38px;">Group: <span id="network_group_name" style="clear:both;font-size:90%;color:#004d62;font-weight:bold;"></span></p>
	<table id="member-directory" class="display compact" width="100%" cellspacing="0">	
		<thead>
			<tr><th>Mark for Action</th><th>Details</th><th>First</th><th>Last</th></tr>
		</thead>
		<tbody id="group-list-table-rows">
		</tbody>
	</table>
	<input type="hidden" name="togglestate" value="0">
</form>
				
	