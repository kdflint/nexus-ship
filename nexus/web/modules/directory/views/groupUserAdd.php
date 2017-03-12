<p>Add <span id="selected-user-count"></span> selected users to </p>
<?php foreach($_SESSION['groups'] as $group) { ?>
	<p><a href="#" onclick="addUserToGroup('<?php echo($group['id']); ?>')"><?php echo($group['name']); ?></a></p>
<?php } ?>