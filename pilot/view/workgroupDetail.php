<?php

session_start();

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">
<html>
	
  <head>
  	<meta http-equiv="Content-type" content="text/html;charset=UTF-8">
    <link rel="stylesheet" href="" type="text/css" />
    <script src="" language="javascript"></script>
    <link rel="shortcut icon" href="" />
    <title>Nexus | Pilot </title>
  </head>
  
  <body>
  	
  	Welcome.
  	
  	You have been invited to be the administrator...
  	
  	Your organization: <? echo $_SESSION['org_name']; ?><br/>
  	Your email: <? echo $_SESSION['email']; ?> <i>(You can change this value once you complete your activation.)</i>
  	
  	
  	<form action="" method="post">
  		
  		Your first name: <input type="text" /><br/>
  		Your last name: <input type="text" /><br/>
  		Your new password: <input type="password" /><br/>
  		<input type="submit" value="Activate Me Now" />
  		<input type="hidden" name="action" value="activate" />
  	</form>


	</body>
</html>