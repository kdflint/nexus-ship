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
		<div style="background:#ffffff;">
			<a href="#close" title="Close" class="close">X</a>
			<div id="securityProfile" style="display:none;">
				<?php 
					if ($showNwmProfileUsername === $_SESSION['username']) {
						include("modules/user/views/securityProfileAdv.html");
					} 
				?>	
			</div>
			<iframe id="adv-profile-frame" src="loading_placeholder.html" style="height:260px;width:100%;border:0;margin:0;padding:0;overflow:hidden;" scrolling="no"></iframe>
		</div>
	</div>
	
	<div id="openSecurityProfile" class="modalDialog">
		<div>
			<a href="#close" title="Close" class="close">X</a>
			<?php include("modules/user/views/profile.html"); ?>	
		</div>	
	</div>	

	