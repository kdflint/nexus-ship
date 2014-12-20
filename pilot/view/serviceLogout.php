<?

//error_reporting(E_ALL);
//ini_set( 'display_errors','1'); 

session_start();

require_once("../control/util.php");
require_once(Util::getAppRoot() . "control/error/handlers.php");

if (!Util::isSessionValid()) {
	header("location:login.php?logout=true");
	exit(0);	
}

?>

<!DOCTYPE html> 

<html>
  <head>  	  		
  	<meta http-equiv="Content-type" content="text/html;charset=UTF-8">
	  <link rel="stylesheet" type="text/css" href="style/style.css" />
 		<script src="script/script.js" language="javascript"></script>
    <link rel="shortcut icon" href="image/northbridge-ico.png" />
    <title>Nexus</title>    	
  </head>      
  
  <body>
    <div class="container">
    	
    <table width="100%">
    	<tr>
    	<td>
    		<img style="float:left;vertical-align:top;margin:20px;" <? echo $_SESSION['logo']; ?> border="0" alt=""/>
    	</td>
    	<td>
    		<p style="text-align:right;color:#c9c9a7;font-size:18px;margin:20px;"><b><? echo($_SESSION['orgName']); ?></b></p>
    		<p style="text-align:right;margin:20px;color:#4b5b6e"><b>Hello <? echo($_SESSION['fname']); ?></b><br/>
			</td>
    	</tr>
    </table>	
        	
      <div class="shell">
      	
				<div class="projectsContent">						
					You are logged out of your Community Conference Room.
			 	</div>
			 							 			 		
      </div><!--shell-->
    </div><!-- container -->
    
	</body>
	




</html>

