<p>Your Linked Organizations</p>
<div style="position:relative;">
	<table style="padding:10px;">
	<?php foreach ($_SESSION['orgs'] as $org) { ?>
	<tr>
		<td style="padding:5px;width:70px;">
			<a href="<?php echo(Utilities::getHttpPath()); ?>/modules/user/control/organizationRemoveProcessor.php?id=<?php echo($org['id']); ?>" onclick="return confirm('Please confirm that you wish to unlink <?php echo $org['name'];?> from your profile.');" title="Unlink"><span class="fa fa-chain-broken" style='margin-right:10px;color:#d27b4b;'></span></a>
			<a href="javascript:void(0);" onclick="showDirectoryDetail(<?php echo $org['id'];?>, 'ADV')"><span class="fa fa-pencil" style='margin-right:10px;color:#d27b4b;' title="Edit"></span></a>
		</td>
		<td style="padding:5px;"><?php echo $org['name'];?></td>
	</tr>
	<?php } ?>
</table>
<p style="margin-left:20px;margin-top:5px;"></p>
<p style="font-size:90%;">To link an organization to your profile, begin typing in the box below. If the organization is already listed in the network directory, it will appear for your selection. If not, you can add your new organization to the network directory, pending administrative review.</p>
</div>
