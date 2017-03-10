<p>Your Organizations</p>
<div style="position:relative;width:560px;">
	<?php foreach ($_SESSION['orgs'] as $org) { ?>
		<p style="margin-left:20px;margin-top:5px;"><?php echo $org['name'];?>
			<a href="<?php echo(Utilities::getHttpPath()); ?>/modules/user/control/organizationRemoveProcessor.php?id=<?php echo($org['id']); ?>" onclick='return confirm(\"Please confirm this delete.\");'>
				<span class="fa fa-trash-o" style='margin-left:10px;color:#d27b4b;'></span>
			</a>
		</p>
	<?php } ?>
</div>
