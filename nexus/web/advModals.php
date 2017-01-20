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
	
	<div id="openProfile" class="modalDialog">
		<div>
			<a href="#close" title="Close" class="close">X</a>
			<iframe id="adv-profile-frame" src="loading_placeholder.html" style="height:200px;width:100%;border:0;margin:0;padding:0;overflow:hidden;" scrolling="no"></iframe>
		</div>
	</div>
	
	<div id="openSecurityProfile" class="modalDialog" style="height:200px;">
		<div>
			<a href="#close" title="Close" class="close">X</a>
			<?php include("modules/user/views/profile.html"); ?>	
		</div>	
	</div>	

	