<?php

session_start();

include("../model/pgDb.php");
include("../control/util.php");

//temp
$_SESSION['userId'] = "3";
$orgId = "1";

$cursor = array();
if (isset($orgId)) {
	$cursor = pgDb::getOrganizationById($orgId);
}

$cursor1 = array();
if (isset($orgId)) {
	$cursor1 = pgDb::getOrganizationUsersById($orgId);
}

$cursor2 = array();
if (isset($_REQUEST['term'])) {
	$cursor2 = pgDb::freeSearch($_REQUEST['term'], $_SESSION['networkId']);
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
  	
  	<h1>Organization Module</h1>  	
  	<table><tr><td valign="top" width="50%">
  	
  	<h2>VIEW: Organization</h2>
  	<hr/>	
  	
  		<h3>Read Organization</h3>
  			<table border="1" cellpadding="5">
  			<?
  				$row = pg_fetch_array($cursor, 0, PGSQL_ASSOC);
  				foreach ($row as $key=>$val) {
    				echo "<tr><td>" . $key . "</td><td>" . $val ."</td></tr>";
    			}
    		?>
  			</table>		 
  		
  		<h3>Update Organization</h3>
  		  <form action="organizationProcessor.php" method="post">
  				
	  			<?
  					$row = pg_fetch_array($cursor, 0, PGSQL_ASSOC);
  					foreach ($row as $key=>$val) {
	    				echo $key . ": <input type=\"text\" name=\"" . $key ."\" value=\"" . $val . "\" /><br/>";
    				}
    			?>
					<input type="hidden" name="action" value="updateOrganization" />
  				<input type="submit" value="Update My Profile" />
  			</form>

		  <h3>Delete Organization</h3>	 		  	
  			<form action="organizationProcessor.php" method="post">
					<input type="hidden" name="action" value="inactivateOrganization" />
					<input type="hidden" name="orgId" value="<? echo($orgId); ?>" />
  				<input type="submit" value="Inactivate" />		 
  			</form>
  			
		  <h3>Undelete Organization</h3>	 		  	
  			<form action="organizationProcessor.php" method="post">
					<input type="hidden" name="action" value="reactivateOrganization" />
					<input type="hidden" name="orgId" value="<? echo($orgId); ?>" />
  				<input type="submit" value="Reactivate" />		 
  			</form> 
  		
  	</td><td valign="top" width="50%">
  	<h2>VIEW: Organization Users</h2>
  	<hr/>	  
  		
	  	<h3>Read All Users</h3>

  			<?
  				$row = pg_fetch_array($cursor1, 0, PGSQL_ASSOC);
  				foreach ($row as $key=>$val) {
    				echo $val . " | ";
    			}
    		?>

  	<h2>VIEW: Directory</h2>
  	<hr/>	  
  		
	  	<h3>Read Directory</h3>
  		  <form action="organizationProcessor.php" method="post">
  		  	<input type="text" name="term" value="<? echo($_REQUEST['term']); ?>" />
					<input type="hidden" name="action" value="searchDirectory" />
  				<input type="submit" value="Search Directory" />
  			</form>
  			<?
					while ($row = pg_fetch_array($cursor2)) {
    				echo $row['table'] . " | " . $row['id'] . "<br/>";
    			}
    			// TODO: iterate - select directory listing for each org and user represented. Figure out record format...
    		?>
    		
    		<!-- LEFT OFF: filter search, geo search -->

		  
		</td></tr></table>
  </div>
  </div>
  </body>

</html>