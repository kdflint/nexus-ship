<?php

session_start();

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">
  <head>
  	<meta http-equiv="Content-type" content="text/html;charset=UTF-8">
    <link rel="stylesheet" href="style/modelViewStyle.css" type="text/css" />
    <script src="script/script.js" language="javascript"></script>
  </head>
  
  <body>
 	Current PHP Session View
  		
				<table border="1" cellpadding="5">
  			<?php
		  	  foreach ($_SESSION as $key=>$val) {
    				echo "<tr><td>" . $key . "</td><td>" . $val ."</td></tr>";
    			}
    		?>
  			</table>
  			<?php print_r($_SESSION['groups']); ?>
		  	 	
  </body>

</html>