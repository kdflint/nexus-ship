<?php

$globalNetworkEnrollLink1 = "Add user functionality coming soon.";
$globalNetworkEnrollLink2 = "";
if ($_SESSION['networkId'] == '358') {
	$globalNetworkEnrollLink1 = "Your network enrollment link is";
	$globalNetworkEnrollLink2 = "http://northbridgetech.org/apps/nexus/web/enroll.php?invitation=d321db0a-fe69-4ace-b6cd-efa3d501a7c2";
}

?>

<div id="network-secondary" class="secondaryControlContainer">
<span style="float:left;margin-left:290px;">
	<a id="compose_pm" class="pure-button pure-button-primary" href="javascript:void(0);" style="float:left;" >Compose Message</a>
	<?php if (Utilities::isSessionAdmin()) { ?>
		<a id="add_to_group" class="pure-button pure-button-primary" href="#openGroupUserAdd" style="float:left;font-size:80%;" >Add To Group</a>
		<a id="remove_from_group" class="pure-button pure-button-primary" href="#openGroupUserDelete" style="float:left;font-size:80%;" >Remove from Group</a>
	<?php } ?>	
	<!--<a id="mark_all" href="#" onclick="checkAll('member-directory-form')" style="border-left:20px;float:left;">Select All</a> -->
</span>
<span style="float:right;">
	<a id="show_directory_detail" href="#openOrganizationView" style="display:none;" ></a>
	<a id="add_new_org" href='javascript:void(0);' onclick="openOrganizationBasicForm(false);" class="secondaryControl priv-1" title="Add New Organization"><span class='fa fa-university fa-lg' ></span><span class='fa fa-plus' ></span></a>
	<?php if (Utilities::isSessionAdmin()) { ?>
		<a id="add_new_group" href='#openGroupAdd' class="secondaryControl priv-1" title="Add New Group"><span class='fa fa-users fa-lg' ></span><span class='fa fa-plus' style="margin-left:3px;"></span></a>
	<?php } ?>		
	<!-- TODO - move js controls from public to nexus.js -->
	<a id='map_control' href="#" onclick="initMap();" class="secondaryControl" title="Map View" style="display:none;"><span id="directory_control" class='fa fa-globe fa-lg'></span></a>
</span>
</div>

<div id="network-frame" style="height:420px;clear:left;">
	<div id="organizational_directory" style="display:none;">
		<div class="controlCol" style="left:15px;border-right: 1px solid #eeeeee;margin-top:-10px;">
			<?php include(Utilities::getModulesRoot() . "/directory/views/directorySearch.php"); ?>
		</div>
		<div id="show-directoryResults" class="displayCol" style="border:0px !important;width:630px;overflow:visible;font-size:80%;margin-top:40px;">
			<?php include(Utilities::getModulesRoot() . "/directory/views/directoryTableAdv.php"); ?>
		</div>
	</div>
	<div id="member_directory" style="display:block;position:relative;top:-20px;">
		<div class="controlCol" style="left:15px;border-right: 1px solid #eeeeee;margin-top:-2px;">
			<?php include(Utilities::getModulesRoot() . "/directory/views/networkSearch.php"); ?>
		</div>
		<div id="" class="displayCol" style="border:0px !important;width:630px;overflow:visible;font-size:80%;margin-top:20px;">
			<?php include(Utilities::getModulesRoot() . "/directory/views/groupList.php"); ?>
		</div>		

<!--			<div style="font-size:80%;height:480px;overflow:auto;">-->
			<?php //include("views/groupList.php"); 
			?>
<!--		</div>-->

	</div>
</div>

<span id="inbox-mode" style="visibility:hidden;">default</span>
<span id="pmRecipientList" style="visibility:hidden;"></span>
<span id="recipient-dto" style="visibility:hidden;"></span>

<script> getGroupList('-1', 'All Network'); </script>

