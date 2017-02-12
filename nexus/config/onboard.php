<html>
	<head>
	</head>
	<body>
		<?php if (!isset($_GET['invitation'])) { ?>
		<form action="http://localhost/nexus/nexus/config/onboard-processor.php" method="post">
		  <input type="radio" name="account-type" value="adv"> ADV<br>
  		<input type="radio" name="account-type" value="nwm" disabled> NWM
  		<p>Parent org id: <input type="text" name="org-parent" width="10" value="13" required></p>
  		<p>Organization name: <input type="text" name="org-name" width="100" required></p>
  		<p>Network group name: <input type="text" name="org-name" width="100" required></p>
  		<p>Administrator email: <input type="email" name="org-email" width="100" required></p>
  		<p>Submit password: <input type="text" name="password" width="20" required></p>
  		<input type="submit" value="Submit">
		<form>
		<?php } else { ?>
		<p>Enroll link</p>
		<p><a href="<?php echo(Utilities::getHttpPath()); ?>/enroll.php?invitation=<?php echo($_GET['invitation']); ?>"><?php echo(Utilities::getHttpPath()); ?>/enroll.php?invitation=<?php echo($_GET['invitation']); ?></a></p>
	<?php } ?>
	</body>
</html>

<?php 
/*
When this is done, and admin user is enrolled
Use this sql to create a networ-global invitation:
insert into invitation 
(uuid, email, create_dttm, accept_dttm, network_fk, invitation_dttm, role_fk, expire_dt, issuer_fk, type, organization_fk, group_fk) 
values ('60e0ee08-3e4e-499d-b28f-32715735ed25', '', now(), NULL, 376, now(), 5, NULL, 88, 'global', 376, NULL) 
returning uuid

http://.../enroll.php?invitation=60e0ee08-3e4e-499d-b28f-32715735ed25
*/
?>