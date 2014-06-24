<?php

session_start();

include("../model/pgDb.php");
include("../control/util.php");

//temp
$_SESSION['userId'] = "3";

$cursor = array();
if (isset($_SESSION['userId'])) {
	$cursor = pgDb::getUserById($_SESSION['userId']);
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
  			
		  <h3>Delete User</h3>	 		  	
  			<form action="userProcessor.php" method="post">
					<input type="hidden" name="action" value="inactivateProfile" />
  				<input type="submit" value="Inactivate" />		 
  			</form>
  			
		  <h3>Undelete User</h3>	 		  	
  			<form action="userProcessor.php" method="post">
					<input type="hidden" name="action" value="reactivateProfile" />
  				<input type="submit" value="Reactivate" />		 
  			</form>  			 
		  
  </div>
  </div>
  </body>

</html>