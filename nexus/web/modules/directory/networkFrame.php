<?php

require_once("control/searchPreProcessor.php");

$userMessage = "Select recipients from right";

if(isset($_GET['userMessage'])) {
	$userMessage = $_GET['userMessage'];
}

?>

<script>
	function switchToOrganizationView() {
		document.getElementById('member_view_control').style.display = "block";
		document.getElementById('directory_view_control').style.display = "none";
		document.getElementById('map_control').style.display = "block";
		document.getElementById('compose_pm').style.display = "none";
		document.getElementById('mark_all').style.display = "none";
		document.getElementById("organizational_directory").style.display = "block";
		document.getElementById("member_directory").style.display = "none";
		var addNewOrg = document.getElementById('add_new_org');
		var addNewMember = document.getElementById('add_new_member');
		if (addNewOrg && addNewMember) {
			addNewOrg.style.display = "block";
			addNewMember.style.display = "none";
		}
	}
	
	function switchToMemberView() {
		document.getElementById('member_view_control').style.display = "none";
		document.getElementById('directory_view_control').style.display = "block";
		document.getElementById('map_control').style.display = "none";
		document.getElementById('compose_pm').style.display = "block";
		document.getElementById('mark_all').style.display = "block";
		document.getElementById("organizational_directory").style.display = "none";
		document.getElementById("member_directory").style.display = "block";
		var addNewOrg = document.getElementById('add_new_org');
		var addNewMember = document.getElementById('add_new_member');
		if (addNewOrg && addNewMember) {
			addNewOrg.style.display = "none";
			addNewMember.style.display = "block";
		}
	}
</script>

<div id="network-secondary" class="secondaryControlContainer">
	<a id="compose_pm" class="pure-button pure-button-primary" href="javascript:void(0);" onclick="goToInboxCompose();" >Compose Message</a>
	<a id="mark_all" href="#" onclick="checkAll('member-directory-form')" style="border-left:20px;">Select All</a> 
	<?php if (Utilities::isSessionAdmin()) { ?>
		<a id="add_new_org" href='#openDirectoryEdit' onclick="return resetDirectoryForm();" class="secondaryControl" title="Add New Organization" style="display:none;"><span class='fa fa-university fa-lg' ></span><span class='fa fa-plus' ></span></a>
		<a id="add_new_member" href='#' onclick="" class="secondaryControl" title="Invite New Member"><span class='fa fa-user-plus fa-lg' ></span></a>
	<?php } ?>
	<!-- TODO - move js controls from public to nexus.js -->
	<a id='directory_view_control' href="#" onclick="switchToOrganizationView();" class="secondaryControl" title="Organizational Directory"><span class='fa fa-university fa-lg'></span></a>
	<a id='member_view_control' href="#" onclick="switchToMemberView();" class="secondaryControl" title="Member Directory" style="display:none;"><span class='fa fa-address-book-o fa-lg'></span></a>
	<a id='map_control' href="#" onclick="initMap();" class="secondaryControl" title="Map View" style="display:none;"><span id="directory_control" class='fa fa-globe fa-lg'></span></a>
	<a id="secondary-network-filter"class="secondaryControl" href="#" onclick="toggleTertiary('network-tertiary');" title="Group Filter"><span class='fa fa-filter fa-lg' ></span></a>
	<!--<a id="secondary-network-edit" class="secondaryControl" href="#openDirectoryEdit" onclick="return populateDirectoryForm();" title="Edit Organization" style="display:none;"><span class='fa fa-pencil fa-lg' ></span></a>-->
	<?php if (Utilities::isSessionAdmin()) { ?>
		<a id="secondary-network-edit" class="secondaryControl" href="#" onclick="alert('Edit functionality on the way...')" title="Edit Organization" style="display:none;"><span class='fa fa-pencil fa-lg' ></span></a>
	<?php } ?>
	<div id="network-tertiary" class="tertiaryControlContainer" style="display:none;">
			<form action="#" class="pure-form">
				<p>Group filter coming soon...</p>
			</form>
	</div>
</div>

<div id="network-frame" style="height:420px;">
	<div id="organizational_directory" style="display:none;">
		<div class="controlCol" style="left:15px;border-right: 1px solid #eeeeee;">
			<?php //echo "Sticky count " . $stickyCount; ?>
			<?php //echo "Search string " . $stickyString; ?>
			<?php include(Utilities::getModulesRoot() . "/directory/views/directorySearch.php"); ?>
		</div>
		<div id="show-directoryResults" class="displayCol" style="border:0px !important;width:600px;margin-left:5px;margin-top:-10px;">
			<?php include(Utilities::getModulesRoot() . "/directory/views/directorySummary.php"); ?>
		</div>
		<div id="show-directoryDetail" class="displayCol displayDetail" style="display:none;border:0px !important;margin-left:5px;margin-top:-10px;">
			<?php include(Utilities::getModulesRoot() . "/directory/views/directoryDetail.php"); ?>
		</div>
	</div>
	<div id="member_directory" style="display:block;">
			<div style="font-size:12px;height:480px;overflow:auto;">
			<?php include($includePath . $_SESSION['defaultSearchId'] . ".php"); ?>
		</div>
	</div>
</div>

<span id="inbox-mode" style="visibility:hidden;">default</span>
<span id="pmRecipientList" style="visibility:hidden;"></span>
<span id="recipient-dto" style="visibility:hidden;"></span>



