<?php

require_once("Util.php");
//require_once(Utilities::getModulesRoot() . "/forum/forum_integration.php");

session_start();
//$user->session_begin();

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">
  <head>
  	<meta http-equiv="Content-type" content="text/html;charset=UTF-8">
    <link rel="stylesheet" href="style/modelViewStyle.css" type="text/css" />
    <script src="script/script.js" language="javascript"></script>
  </head>
  
  <body style="font-size:70%;">
  	<div style="width:350px;position:absolute;left:00px;">
 			<p><b>Current PHP Session View</b></p>
  		<table border="1" cellpadding="5" style="width:350px;">
  		<?php
				ksort($_SESSION);
		    foreach ($_SESSION as $key=>$val) {
    			echo "<tr><td>" . $key . "</td><td>" . $val ."</td></tr>";
    		}
    	?>
    	<tr><td>Groups Detail: </td><td><?php print_r($_SESSION['groups']); ?></td></tr>
    	<tr><td>Orgs Detail: </td><td><?php print_r($_SESSION['orgs']); ?></td></tr>
  		</table>
  	</div>
  			
		<div style="width:350px;position:absolute;left:400px;">
  		<p><b>Current phpBB Session View</b><p>
			<table border="1" cellpadding="5">
  		<?php
		    //foreach ($user->data as $key=>$val) {
    		//	echo "<tr><td>" . $key . "</td><td>" . $val ."</td></tr>";
    		//}
    	?>
  		</table>	
  	</div>   		 	
  </body>

</html>