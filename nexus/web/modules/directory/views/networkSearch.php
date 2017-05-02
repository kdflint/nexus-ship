<span class='detail' style="font-size:140%;">Network Directory</span>	<a id='directory_view_control' href="#" onclick="switchToOrganizationView();" class="secondaryControl" title="Organizational Directory"><span class='fa fa-university fa-lg'></span></a>

<form class="pure-form" action="" method="post" id="networkForm">
	<div style="margin-top:10px;">
		<p style="font-size:80%;margin-left:36px;">A keyword may be part of a first or last name.</p>
		<span class="fa fa-search" style="margin-right:18px;"></span><input id="datatable-input" type="text" name="" 	style="width:86%;" placeholder="Keywords"/>
	</div>
	
	<div style="margin-top:10px;">
		<span class="searchQualifier">and</span> <a id="secondary-network-filter" href="#" onclick="toggleTertiary('network-tertiary');" title="Group Filter" style="float:right;"><img class="" src="image/group_is_fake_dropdown.png" /></a>
		<div id="network-tertiary" class="tertiaryControlContainer" style="display:none;margin-top:0px;width:230px;">
			<form action="#" class="pure-form">
				<a href="#" onclick="getGroupList('-1', 'All Network');">All Network</a>
				<?php foreach($_SESSION['groups'] as $group) { ?>
					<p><a href="#" onclick="getGroupList('<?php echo($group['id']); ?>', '<?php echo($group['name']); ?>')"><?php 	echo($group['name']); ?></a></p>
				<?php } ?>
			</form>
		</div>
	</div>
</form>
