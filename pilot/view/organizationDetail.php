<?php

session_start();

include("organizationPreProcessor.php");
include("util.php");

$org="";

if (isset($_REQUEST['orgId'])) {
	$org = Util::clean($_REQUEST['orgId']);
	populateForm($org);
}

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">
<html>
	
  <head>
  	<meta http-equiv="Content-type" content="text/html;charset=UTF-8">
    <link rel="stylesheet" href="style/style.css" type="text/css" />
    <script src="script/script.js" language="javascript"></script>
  </head>
  
  <body>
  	  	
  	<form action="organizationProcessor.php" method="post" class="basic-grey"> 		
  		<label><span>Name</span><input type="text" name="orgName" placeholder="<? echo("Previous value"); ?>"/></label>
  		<label><span>EIN</span><input type="text" name="ein" placeholder="<? echo("Previous value"); ?>"/></label>
  		<label><span>Federally Tax Exempt?</span><input type="checkbox" name="exempt" value="true"></label>
  		<label><span>Corporate Structure</span> 
  		<select name="structure">
				<option value="state" selected>State Incorporated Nonprofit/Charitable</option>
				<option value="activist">Individual Activist</option>
				<option value="other">Other</option>
			</select></label>
   		<label><span>Address</span><input type="text" name="address" placeholder="<? echo("Previous value"); ?>"/></label>
 			<label><span>Phone</span><input type="text" name="phone" placeholder="<? echo("Previous value"); ?>" /></label>
  		<label><span>Mission</span><textarea name="mission" placeholder="<? echo("Previous value"); ?>"></textarea></label>
   		<label><span>Program Description</span><input type="text" name="program" placeholder="<? echo("Previous value"); ?>"/></label>
   		<label><span>Primary Network Contact</span><? echo "Name here"; ?></label>
  		<label><span>&nbsp;</span><input type="botton" class="button" value="Create New Record" /></label>
  	</form>

	</body>
</html>