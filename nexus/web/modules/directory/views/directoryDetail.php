<script>
	function getDirectoryDetail(orgId) {
		var xmlhttp = getXmlHttpRequest();
		xmlhttp.onreadystatechange=function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			 	var jsonObj = JSON.parse(xmlhttp.responseText);		 	
		 		tableItem = 
       			"<div class='detail'>" +
       					"<span class='date'>" + jsonObj.oname + "</span><br/>" +
       					(jsonObj.url ? "<p><span class='tod'><a href='" + jsonObj.url + "' target='_blank'>" + jsonObj.url + "</a></span></p>" : "") +
       												
								(jsonObj.cname ? "<span class='tod'>" + jsonObj.cname + "</span><br/>" : "") +
								(jsonObj.email ? "<span class='tod'>Email: " + jsonObj.email + "</span><br/>" : "") +
								(jsonObj.phone ? "<span class='tod'>Phone: " + jsonObj.phone + "</span><br/>" : "") +
								(jsonObj.fax ? "<span class='tod'>Fax: " + jsonObj.fax + "</span><br/>" : "") +

       					(jsonObj.location1 ? "<span class='tod'>" + jsonObj.location1 + "</span><br/>" : "") +
								(jsonObj.location2 ? "<span class='tod'>" + jsonObj.location2 + "</span><br/>" : "") +

						"</div>";
    		document.getElementById("itemRow").innerHTML = "<div class='td-div'>" + tableItem + "<div>";   
     	}
		}
		xmlhttp.open("GET", "<?php echo(Utilities::getHttpPath()); ?>" + "/src/framework/directoryDetailManager.php?id=" + orgId, true);
		xmlhttp.send();  		
	}
</script>

<div style="">
			
<div id="current_detail_display">	
	<a href="javascript:void(0);" onclick="showDirectoryResults();"><span class='fa fa-chevron-circle-left fa-3x' style="margin-right:10px;margin-top:25px;"></span></a>
	<div id="detailTable" class="table-div" style="border: 0px none !important;">
		<div id="itemRow" class="tr-div">
			<div style="text-align:center;"><span class='fa fa-spinner fa-spin fa-lg' style="margin-right:10px;margin-top:45px;"></span>Loading detail...</div>	
		</div>
	</div>
</div>

</div>