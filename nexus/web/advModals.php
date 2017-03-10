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
	
	<div id="openDirectoryEdit" class="modalDialog">
		<div>
			<a href="#close" title="Close" class="close">X</a>
			<?php include("modules/directory/views/organizationAdd.php"); ?>
		</div>
	</div>
	
	<div id="openProfileOrg" class="modalDialog">
		<div>
			<a href="#close" title="Skip" class="close">X</a>
			<?php include("modules/directory/views/organizationProfileList.php") ?>
			<?php include("modules/directory/views/organizationLookup.php"); ?>
		</div>
	</div>
	
	<div id="openProfile" class="modalDialog">
		<div style="background:#ffffff;">
			<a href="#close" title="Close" class="close">X</a>
			<iframe id="adv-profile-frame" src="loading_placeholder.html" style="height:260px;width:100%;border:0;margin:0;padding:0;overflow:hidden;" scrolling="no"></iframe>
		</div>
	</div>

	