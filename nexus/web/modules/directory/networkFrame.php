<?php

$globalNetworkEnrollLink1 = "Add user functionality coming soon.";
$globalNetworkEnrollLink2 = "";
if ($_SESSION['networkId'] == '358') {
	$globalNetworkEnrollLink1 = "Your network enrollment link is";
	$globalNetworkEnrollLink2 = "http://northbridgetech.org/apps/nexus/web/enroll.php?invitation=d321db0a-fe69-4ace-b6cd-efa3d501a7c2";
}

?>

<div id="network-secondary" class="secondaryControlContainer">
<span style="float:left;">
	<a id="compose_pm" class="pure-button pure-button-primary" href="javascript:void(0);" style="float:left;" >Compose Message</a>
	<?php if (Utilities::isSessionAdmin()) { ?>
		<a id="add_to_group" class="pure-button pure-button-primary" href="#openGroupUserAdd" style="float:left;font-size:80%;" >Add To Group</a>
		<a id="remove_from_group" class="pure-button pure-button-primary" href="#openGroupUserDelete" style="float:left;font-size:80%;" >Remove from Group</a>
	<?php } ?>	
	<!--<a id="mark_all" href="#" onclick="checkAll('member-directory-form')" style="border-left:20px;float:left;">Select All</a> -->
</span>
<span style="float:right;">
	<a id='directory_view_control' href="#" onclick="switchToOrganizationView();" class="secondaryControl" title="Organizational Directory"><span class='fa fa-university fa-lg'></span></a>
	<a id='member_view_control' href="#" onclick="switchToMemberView();" class="secondaryControl" title="Member Directory" style="display:none;"><span class='fa fa-address-book-o fa-lg'></span></a>
	<?php if (Utilities::isSessionAdmin()) { ?>
		<a id="add_new_org" href='javascript:void(0);' onclick="openOrganizationBasicForm();" class="secondaryControl" title="Add New Organization" style="display:none;"><span class='fa fa-university fa-lg' ></span><span class='fa fa-plus' ></span></a>
		<!--<a id="add_new_group" href='#openGroupAdd' onclick="alert('<?php echo($globalNetworkEnrollLink1); ?>\n\n<?php echo($globalNetworkEnrollLink2); ?>')" class="secondaryControl" title="Add New Group"><span class='fa fa-users fa-lg' ></span><span class='fa fa-plus' style="margin-left:3px;"></span></a>-->
		<a id="add_new_group" href='#openGroupAdd' class="secondaryControl" title="Add New Group"><span class='fa fa-users fa-lg' ></span><span class='fa fa-plus' style="margin-left:3px;"></span></a>
	<?php } ?>
	<!-- TODO - move js controls from public to nexus.js -->
	<a id='map_control' href="#" onclick="initMap();" class="secondaryControl" title="Map View" style="display:none;"><span id="directory_control" class='fa fa-globe fa-lg'></span></a>
	<a id="secondary-network-filter"class="secondaryControl" href="#" onclick="toggleTertiary('network-tertiary');" title="Group Filter"><span class='fa fa-filter fa-lg' ></span></a>
	<!--<a id="secondary-network-edit" class="secondaryControl" href="#openDirectoryEdit" onclick="return populateDirectoryForm();" title="Edit Organization" style="display:none;"><span class='fa fa-pencil fa-lg' ></span></a>-->
	<?php if (Utilities::isSessionAdmin()) { ?>
		<a id="secondary-network-edit" class="secondaryControl" href="#" onclick="alert('Edit functionality on the way...')" title="Edit Organization" style="display:none;"><span class='fa fa-pencil fa-lg' ></span></a>
	<?php } ?>
	<div id="network-tertiary" class="tertiaryControlContainer" style="display:none;">
			<form action="#" class="pure-form">
				<p><a href="#" onclick="getGroupList('-1', 'All Network');">All Network</a></p>
				<?php foreach($_SESSION['groups'] as $group) { ?>
					<p><a href="#" onclick="getGroupList('<?php echo($group['id']); ?>', '<?php echo($group['name']); ?>')"><?php echo($group['name']); ?></a></p>
				<?php } ?>
			</form>
	</div>
</span>
<span id="network_group_name" style="clear:both;font-size:90%;color:#004d62;font-weight:bold;"></span>
</div>

<div id="network-frame" style="height:420px;clear:left;">
	<div id="organizational_directory" style="display:none;">
		<div class="controlCol" style="left:15px;border-right: 1px solid #eeeeee;margin-top:-10px;">
			<?php include(Utilities::getModulesRoot() . "/directory/views/directorySearch.php"); ?>
		</div>
		<div id="show-directoryResults" class="displayCol" style="border:0px !important;width:600px;margin-left:5px;margin-top:-20px;">
			<?php include(Utilities::getModulesRoot() . "/directory/views/directorySummary.php"); ?>
		</div>
		<div id="show-directoryDetail" class="displayCol displayDetail" style="display:none;border:0px !important;margin-left:5px;margin-top:-10px;">
			<?php include(Utilities::getModulesRoot() . "/directory/views/directoryDetail.php"); ?>
		</div>
	</div>
	<div id="member_directory" style="display:block;position:relative;top:-20px;">

			<div style="font-size:12px;height:480px;overflow:auto;">
			<?php include("views/groupList.php"); ?>
		</div>
	</div>
</div>

<span id="inbox-mode" style="visibility:hidden;">default</span>
<span id="pmRecipientList" style="visibility:hidden;"></span>
<span id="recipient-dto" style="visibility:hidden;"></span>

<script> getGroupList('-1', 'All Network'); </script>

