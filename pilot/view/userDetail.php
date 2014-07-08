<?php

session_start();

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">
<html>
	
  <head>
  	<meta http-equiv="Content-type" content="text/html;charset=UTF-8">
    <link rel="stylesheet" href="style/style.css" type="text/css" />
    <script src="script/script.js" language="javascript"></script>
  </head>
  
  <body>
  	
  	<? if (isset($_SESSION['activate'])) { ?>

  	Welcome.
  	
  	You have been invited to be the administrator...
 	
  	The network that invited you: <? echo $_SESSION['networkName']; ?><br/>
  	
  	<!-- Your organization:  ?? -->
  	
  	<? } ?>
  	
  	<form action="userProcessor.php" method="post"> 		
  		first name: <input type="text" name="fname"/><br/>
  		middle name: <input type="text" name="mname"/><br/>
  		last name: <input type="text" name="lname"/><br/>
   		username: <input type="text" name="username"/><br/>
  		password: <input type="password" name="password"/><br/>
  		email: <input type="text"  name="email" default = "<? echo $_SESSION['email']; ?>" /><br/>
   		sms: <input type="text" name="sms"/><br/>

  		<input type="submit" value="Activate Me Now | Update my Record" />
  	</form>

	</body>
</html>