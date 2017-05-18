	<div id="openEventDetail" class="modalDialog">
		<div>
			<a href="#close" title="Close" class="close">X</a>
			<?php include("modules/event/views/eventDetail.php"); ?>
		</div>
	</div>

	<div id="openEventEdit" class="modalDialog">
		<div>
			<a href="#close" title="Close" class="close">X</a>
			<?php include("modules/event/views/eventAddAdvantage.php"); ?>
		</div>
	</div>
	
	<div id="openOrganizationName" class="modalDialog">
		<div id="openOrganizationName-part-name" class="openOrganizationName-part" style="display:block;">
			<a href="#close" title="Skip" class="close">X</a>
			<?php include("modules/directory/views/organizationProfileList.php") ?>
			<?php include("modules/directory/views/organizationLookup.php"); ?>
		</div>
		<div id="openOrganizationName-part-basic" class="openOrganizationName-part" style="display:none;">			
			<a href="#close" title="Skip" class="close">X</a>
			<?php include("modules/directory/views/organizationBasicAdd.php"); ?>		
		</div>
		<div id="openOrganizationName-part-filter" class="openOrganizationName-part" style="display:none;">			
			<a href="#close" title="Skip" class="close">X</a>
			<?php include("modules/directory/views/organizationFilterAdd.php"); ?>		
		</div>
		<div id="openOrganizationName-part-sizelang" class="openOrganizationName-part cfcht-custom" style="display:none;">			
			<a href="#close" title="Skip" class="close">X</a>
			<?php include("modules/directory/views/organizationSizeLangAdd.php"); ?>		
		</div>
		<div id="openOrganizationName-part-affil" class="openOrganizationName-part cfcht-custom" style="display:none;">			
			<a href="#close" title="Skip" class="close">X</a>
			<?php include("modules/directory/views/organizationAffiliationAdd.php"); ?>		
		</div>
	</div>
	
	<div id="openGroupUserAdd" class="modalDialog">
		<div>
			<a href="#close" title="Skip" class="close">X</a>
			<?php include("modules/directory/views/groupUserAdd.php") ?>
		</div>
	</div>

	<div id="openGroupUserDelete" class="modalDialog">
		<div>
			<a href="#close" title="Skip" class="close">X</a>
			<?php include("modules/directory/views/groupUserRemove.php") ?>
		</div>
	</div>

	<div id="openGroupAdd" class="modalDialog">
		<div>
			<a href="#close" title="Skip" class="close">X</a>
			<?php include("modules/directory/views/groupAdd.php") ?>
		</div>
	</div>
	
	<div id="openProfile" class="modalDialog">
		<div style="background:#ffffff;">
			<a href="#close" title="Close" class="close">X</a>
			<iframe id="adv-profile-frame" src="loading_placeholder.html" style="height:260px;width:100%;border:0;margin:0;padding:0;overflow:hidden;" scrolling="no"></iframe>
		</div>
	</div>

	<div id="openOrganizationView" class="modalDialog">
		<div>
			<a href="#close" title="Skip" class="close">X</a>
			<div id="openOrganizationView-part-detail" class="openOrganizationView-part" style="display:block;">
				<?php include("modules/directory/views/directoryDetailAdv.php") ?>
			</div>
			<div id="openOrganizationView-part-members" class="openOrganizationView-part" style="display:none;">
				<a href="javascript:void(0);" onclick="toggleMultiPartModal('openOrganizationView', 'detail')"><span class='fa fa-chevron-circle-left fa-2x' style="margin-right:10px;"></span>Back to detail record</a>
				<p>Network members affiliated with this organization</p>
				<?php include("modules/directory/views/orgMemberList.php") ?>
			</div>
			<div id="openOrganizationView-part-program" class="openOrganizationView-part" style="display:none;">
				<a href="javascript:void(0);" onclick="toggleMultiPartModal('openOrganizationView', 'program')"><span class='fa fa-chevron-circle-left fa-2x' style="margin-right:10px;"></span>Back to detail record</a>
				<p>Program Details for this organization</p>
				<?php include("modules/directory/views/orgProgramList.php") ?>
			</div>
		</div>
	</div>
	