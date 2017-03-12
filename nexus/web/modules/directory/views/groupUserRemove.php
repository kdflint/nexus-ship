<p>Remove <span id="selected-user-count"></span> selected users from </p>
<?php foreach($_SESSION['groups'] as $group) { ?>
	<p><a href="#" onclick="deleteUserFromGroup('<?php echo($group['id']); ?>')"><?php echo($group['name']); ?></a></p>
<?php } ?>