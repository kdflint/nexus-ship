<script>
	function getUserList(ssnRole) {
		var xmlhttp = getXmlHttpRequest();
		xmlhttp.onreadystatechange=function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			 	var jsonObj = JSON.parse(xmlhttp.responseText);
			 	
			 	// put row containers in the table, 1 for each user
			 	var tableRows = "";
			 	for (var i = 0; i < jsonObj.length; i++) { 
			 		//tableRows = tableRows + "<tr id='userRow" + i + "'></tr>"; 
			 		tableRows = tableRows + "<div id='userRow" + i + "' class='tr-div'></div>";
			 	}
       	document.getElementById("userTable").innerHTML = tableRows;
       	if (jsonObj.length > 9) {
       		document.getElementById('add_user_control_icon').className = "";
       	}
       	
       	// write each event into its row container
			 	for (var i = 0; i < jsonObj.length; i++) { 
			 		var processor = "modules/user/control/userDeleteProcessor.php";
			 		var firstName = ((jsonObj[i].uidpk == <?php echo(Utilities::getDemoUidpk()); ?>) ? '<?php echo($_SESSION['fname']); ?>' : jsonObj[i].fname);
			 		var firstNameStyle  = "fname";
			 		if (jsonObj[i].status == "pending") {
			 			processor = "modules/user/control/invitationDeleteProcessor.php";
			 		}
			 		if (firstName.length < 9) {
			 			firstNameStyle  = "fname";
			 		} else if (firstName.length < 11) {
			 			firstNameStyle  = "fname125";
			 		} else if (firstName.length < 15) {
			 			firstNameStyle  = "fname110";
			 		} else {
			 			firstNameStyle = "fname90";
			 		}
			 		var tableUser = 
			 			"<span class='td-div' style='display:inline-block;'>" +
	       			"<div class='user'>" +
  							"<span class='" + firstNameStyle + "'>" + firstName + "</span><br/>" +
  							"<span class='lname'>" + ((jsonObj[i].uidpk == <?php echo(Utilities::getDemoUidpk()); ?>) ? '<?php echo($_SESSION['lname']); ?>' : jsonObj[i].lname) + "</span>" +
							"</div>" +
       			"</span>" + 
       			"<span class='td-div' style='position:absolute;display:inline-block;'>" +
	          	"<div class='meeting'>" +
          			"<span class='descr' style='font-size:90%;' >" + jsonObj[i].email + "</span>" +
	          		"<p>" + 
	          		((jsonObj[i].role == "admin") ? "<span class='fa fa-key' style='color:#004d62;padding-right:10px;'></span>" : "") +
	          		((IS_ADMIN && jsonObj[i].sessionUser != jsonObj[i].uidpk) ? "<a href='" + processor + "?id=" + jsonObj[i].uidpk + "' onclick='return confirm(\"Please confirm this delete of " + jsonObj[i].fname + " " + jsonObj[i].lname + ".\");'><span class='fa fa-trash-o' style='color:#d27b4b;padding-right:10px;'></span></a>" : "") +
	          		"</p>" +
          		"</div>" +
          	"</span>";
       		document.getElementById("userRow" + i).innerHTML = tableUser;
				}       	
			}
		}
		xmlhttp.open("GET","src/framework/userManager.php", true);
		xmlhttp.send();  		
	}
	
	/*
	Right now demo users are not showing correctly alphebetized in users list because query is managing the order by
	Something like this would re-sort jsonObj, but I don't want to add the complexity at this time. -kdf
	 
	function sortUsers(data) {
    var sorted = [];
    Object.keys(data).sort(function(a,b){
        return data[a].fname < data[b].fname ? -1 : 1
    }).forEach(function(key){
        sorted.push(data[key]);
    });
    return sorted;
	}
	*/
</script>

<a id='add_user_control' href='javascript:void(0);' style='position:absolute;margin-left:650px;padding-top: 20px;'></span><span id="add_user_control_icon" style='padding:0px;' class='fa fa-user-plus fa-2x' ></span></a>			
<div id="userTable" class="table-div">
	<script> getUserList('<?php echo $_SESSION['role']; ?>'); </script>
</div>
