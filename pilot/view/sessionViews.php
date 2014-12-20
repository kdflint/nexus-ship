<?php

session_start();

require_once($_SESSION['appRoot'] . "model/pgDb.php");
require_once($_SESSION['appRoot'] . "control/util.php");

$error = "";

if(isset($_GET['logout'])) {
	$_SESSION = array();
	// TODO: Also delete session cookie? See http://php.net/manual/en/function.session-destroy.php
	session_destroy();
}

if(isset($_GET['error'])) {
	$error = $_GET['error'];
} else if(isset($_GET['logout'])) { 
	$error = "You have signed out succesfully.";
}

$cursor = array();
if (isset($_SESSION['role'])) {
	$cursor = pgDb::getPrivileges($_SESSION['role']);
}

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">
  <head>
  	<meta http-equiv="Content-type" content="text/html;charset=UTF-8">
    <link rel="stylesheet" href="style/modelViewStyle.css" type="text/css" />
    <script src="script/script.js" language="javascript"></script>
  </head>
  
  <body>
  <div class="container">  	
  <div class="shell">
  	
  	<h1>Session Module</h1>  	
  	<h2>VIEW: Authenticate</h2>

  	<hr/>
	  	<h3>Create Authentication</h3>
	  	
	  	<form action="control/sessionProcessor.php" method="post">
			  	<p><? echo $error; ?></p>
					User Id: <input class="passed" type="text" size="25" name="uid" value="grace"/><br/>
					Password: <input class="passed" type="text" size="25" name="password" value=""/><br/>
					<input type="hidden" name="action" value="authenticate" />
					<input type="submit" value="Login"/>
			</form>	

	  	<h3>Delete Authentication</h3>
			<a href="sessionViews.php?logout=true">Logout</a>

		<table cellpadding="5">
			<tr><td valign="top" width="50%">	
  			<h2>VIEW: Authorize</h2>
  			<hr/>	
		  		<h3>Read Authorizations</h3>
					<table border="1" cellpadding="5">
  				<?
						while ($row = pg_fetch_array($cursor)) {
    					echo "<tr><td>" . $row['role'] . "</td><td>" . $row['privilege'] ."</td></tr>";
    				}
    			?>
  				</table>	
  				
			</td><td valign="top" width="50%">
  			<h2>VIEW: Session</h2>	
  			<hr/>	
  			<h3>Read Session</h3>
	  		
				<table border="1" cellpadding="5">
  			<?
		  	  foreach ($_SESSION as $key=>$val) {
    				echo "<tr><td>" . $key . "</td><td>" . $val ."</td></tr>";
    			}
    		?>
  			</table>
  		</td></tr>
  	</table>
		  	 	
  </div>
  </div>
  </body>

</html>