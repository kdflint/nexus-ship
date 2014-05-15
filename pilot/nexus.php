<?
session_start();

// select content to show based on request variable, which is supplied in navigation.php
if (isset($_REQUEST['thisPage'])) {
	$thisPage = $_REQUEST['thisPage'];
} else {
	$thisPage="userDetail";
}

?>

<!DOCTYPE html> 

<html>
  <head>  	
  	
    <!-- For Google Map -->
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCw8wGNP_YbytpUxZCfgxhtqKG6izDixN0&sensor=false"></script>
    <!-- End Google stuff -->
  	
  	<meta http-equiv="Content-type" content="text/html;charset=UTF-8">
    <link rel="stylesheet" href="style/style.css" type="text/css" />
    <script src="script/script.js" language="javascript"></script>
    <link rel="shortcut icon" href="images/northbridge-ico.png" />
    <title>Nexus Home</title>
  </head>

  <body>
  	<p><img src='http://northbridge.websitetoolbox.com/register/dologin?authtoken="<? echo($_SESSION['authtoken']); ?>"' border='0' width='1' height='1' alt='' /></p>
    <div class="container">
    	
    <table>
    	<tr>
    	<td><img style="float:left;vertical-align:top;margin:20px;" src="images/demo.jpg" height="100" width="100" border="0" alt="Demo Organization Logo"/></a></td>
    	<td width="30%"><p style="text-align:left;color:#57574a;font-size:24px;margin:20px;"><b><? echo($_SESSION['network']); ?></b></p></td>
    	<td><p style="text-align:right;color:#c9c9a7;font-size:18px;margin:20px;"><b><? echo($_SESSION['affiliation']); ?></b></p>
    <p style="text-align:right;margin:20px;"><b>Hello <? echo($_SESSION['fname']); ?></b><br/>
    <a href="login.php?logout=true">Logout</a> | <a href="#">My Account</a> | <a href="#">Help</a></p></td>
    	</tr>
    </table>	
    	
      <div class="shell">
      	
				<div class="navigation">
      		<? include 'navigation.php'; ?>
 		  	</div>

				<div class="projectsContent">				
			 	<?
			   $contentFile=$thisPage . ".php";
			   include $contentFile; 
			 	?>
			 	</div>
			 			 		
      </div><!--shell-->
    </div><!-- container -->
    
	</body>
</html>

