<p><input type="radio" id="meeting-visibility-stub-<?php echo($_SESSION['pgpk']); ?>" name="meeting-visibility-stub" onclick='updateEventGroup("Public", "<?php echo($_SESSION['pgpk']); ?>");' value="'<?php echo($_SESSION['pgpk']); ?>'"/>Public</p>
<p><input type="radio" id="meeting-visibility-stub-<?php echo($_SESSION['ngpk']); ?>" name="meeting-visibility-stub" onclick='updateEventGroup("All Network", "<?php echo($_SESSION['ngpk']); ?>");' value="'<?php echo($_SESSION['ngpk']); ?>'" checked/>All Network</p>
<?php foreach($_SESSION['groups'] as $group) { 
	if ($group['id'] != $_SESSION['pgpk'] && $group['id'] != $_SESSION['ngpk']) { ?>
 		<p style="margin-left:20px"><input type="radio" id="meeting-visibility-stub-<?php echo($group['id']); ?>" name="meeting-visibility-stub" onclick="updateEventGroup('<?php echo($group['name']); ?>', '<?php echo($group['id']); ?>');" value="'<?php echo($group['id']); ?>'"><?php echo($group['name']); ?></p>
<?php } } ?>
