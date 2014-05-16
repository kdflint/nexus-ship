<?php

session_start();

include("pgDb.php");
include("util.php");

//temp
$_SESSION['userId'] = "3";

$cursor = array();
if (isset($_SESSION['userId'])) {
	$cursor = pgDb::getUserById($_SESSION['userId']);
}

$cursor1 = array();
if (isset($_SESSION['userId'])) {
	
	// LEFT OFF - implement this method
	$cursor1 = pgDb::getUsersByAdminId($_SESSION['userId']);
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
  	
  	<h1>User Module</h1>  	
  	<h2>VIEW: User</h2>

  	<hr/>
	  	<h3>Read User</h3>
				<table border="1" cellpadding="5">
  			<?
  				$row = pg_fetch_array($cursor, 0, PGSQL_ASSOC);
  				foreach ($row as $key=>$val) {
    				echo "<tr><td>" . $key . "</td><td>" . $val ."</td></tr>";
    			}
    		?>
  			</table>		  	


	  	<h3>Update User</h3>
  			<form action="userProcessor.php" method="post">
  				
	  			<?
  					$row = pg_fetch_array($cursor, 0, PGSQL_ASSOC);
  					foreach ($row as $key=>$val) {
	    				echo $key . ": <input type=\"text\" name=\"" . $key ."\" value=\"" . $val . "\" /><br/>";
    				}
    			?>
					<input type="hidden" name="action" value="updateProfile" />
  				<input type="submit" value="Update My Profile" />
  			</form>
  			
	  	<h3>Read Users</h3>
				<table border="1" cellpadding="5">
  			<?
  				while ($row = pg_fetch_array($cursor1)) {
    				echo "<tr><td>" . $row['fname'] . "</td><td>" . $row['lname'] . "</td><td>" . $row['roleName'] ."</td></tr>";
    			}
    		?>
  			</table>		

	  	<h3>Update Users</h3>


		  <h3>Delete User</h3>	 		  	
  </div>
  </div>
  </body>

</html>