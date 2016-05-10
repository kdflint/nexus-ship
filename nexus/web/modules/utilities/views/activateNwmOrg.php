<?php
session_start();

require_once("../../../src/framework/Util.php");

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">
<html>
  <head>
  </head>
  <body>
  	<p>First - move the organization logo to the correct folder.</p>
  	<p>Next - submit this form.</p>
  	
  <!--<form action="<?php echo Utilities::getModulesRoot(); ?>/utilities/control/newOrgProcessor.php" method="POST">-->
  <form action="http://localhost/nexus/nexus/web/modules/utilities/control/newOrgProcessor.php" method="POST">
		<p>Activation Email: <input type="text" name="email" length="50"></p>
		<p>Group Name: <input type="text" name="groupName" length="50"></p>
		<p>Logo File Name: <input type="text" name="logoFileName" length="50"></p>
		<input type="submit" value="Submit">
  </form>
  </body>
</html>
