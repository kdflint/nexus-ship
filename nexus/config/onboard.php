<?php

require_once(dirname(__FILE__) . "/../web/src/framework/Util.php");

?>

<html>
	<head>
	</head>
	<body>
		<?php if (true) { //if (!isset($_GET['invitation'])) { ?>
		<form action="<?php echo(Utilities::getConfigPath()); ?>/onboard-processor.php" method="post">
		  <input type="radio" name="account-type" value="ADV"> ADV<br>
  		<input type="radio" name="account-type" value="NWM"> NWM
  		<p>Parent org id: <input type="text" name="org-parent" width="10" value="13" required></p>
  		<p>Network name: <input type="text" name="org-name" width="100" required></p>
  		<p>Logo file name: <input type="text" name="org-logo" width="100" required></p>
  		<p>Administrator email: <input type="email" name="org-email" width="100" required></p>
  		<p>CRM Contribution id: <input type="text" name="contrib-id" width="100" required placeholder="fake value if ADV onboarding!"></p>
  		<p>CRM Contact id: <input type="text" name="contact-id" width="100" required placeholder="fake value if ADV onboarding!"></p>
  		<p>Submit password: <input type="text" name="password" width="20" required></p>
  		<input type="submit" value="Submit">
		<form>
		<?php } else { ?>
		<p>Enroll link</p>
		<p><?php echo(Utilities::getHttpPath()); ?>/enroll.php?invitation=<?php echo($_GET['invitation']); ?></p>
	<?php } ?>
	</body>
</html>

<?php 
/*
When this is done, and admin user is enrolled


Use this sql to create a network-global invitation:
insert into invitation 
(uuid, email, create_dttm, accept_dttm, network_fk, invitation_dttm, role_fk, expire_dt, issuer_fk, type, organization_fk, group_fk) 
values ('60e0ee08-3e4e-499d-b28f-32715735ed25', '', now(), NULL, 376, now(), 5, NULL, 88, 'global', 376, NULL) 
returning uuid

Use this sql to create a group-global invitation:
insert into invitation 
(uuid, email, create_dttm, accept_dttm, network_fk, invitation_dttm, role_fk, expire_dt, issuer_fk, type, organization_fk, group_fk) 
values ('053808bf-a879-48ad-8f91-2c2dd76470bf', '', now(), NULL, 376, now(), 5, (CURRENT_DATE + interval '62 days'), 88, 'global',376, 28) 
returning uuid

Use this sql to create a group-personal invitation:
insert into invitation 
(uuid, email, create_dttm, accept_dttm, network_fk, invitation_dttm, role_fk, expire_dt, issuer_fk, type, organization_fk, group_fk) 
values ('053808bf-a879-48ad-8f91-2c2dd76470bf', 'kathy.d.flint@gmail.com', now(), NULL, 376, now(), 5, (CURRENT_DATE + interval '31 days'), 88, 'single', 376, 28) 
returning uuid

http://.../enroll.php?invitation=60e0ee08-3e4e-499d-b28f-32715735ed25

*/
?>