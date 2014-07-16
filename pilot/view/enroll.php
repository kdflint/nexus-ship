<? 
session_start();
$error = "";

include '../control/enrollPreProcessor.php';

if(isset($_GET['error'])) {
	$error = $_GET['error'];
}

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">
<html>
	
  <head>
  	<meta http-equiv="Content-type" content="text/html;charset=UTF-8">
    <link rel="stylesheet" href="style/style.css" type="text/css" />
    <script src="script/script.js" language="javascript"></script>
    <link rel="shortcut icon" href="image/northbridge-ico.png" />
    <title>Nexus | Enroll</title>
  </head>
  
  <body>
    <div class="container">
    	<a href="http://northbridgetech.org/index.php"><img style="float:left;vertical-align:top;margin:10px;" src="http://northbridgetech.org/images/northbridge-logo.png" height="86" width="215" border="0" alt="NorthBridge Technology Alliance"/></a>
   		<p style="text-align:right;color:#57574a;font-size:22px;margin:20px;"><b>Nexus</b>, v 0.01</b><br/>
      <div class="shell">

			<div class="projectsContent">      	
      	<div class="leftColumn"> 
							<p><b>Enroll in <? echo $_SESSION['networkName'] ?></b></p>
							<div class="formLogin" style="border:thin solid #da5e00;padding:10px;border-radius:15px;">
								<form action="../control/enrollProcessor.php" method="post">
								  	<p><? echo $error; ?></p>
								  	<p>You represent: <? echo $_SESSION['orgName'] ?></p>
										Choose your user name: <input class="passed" type="text" size="25" name="userid" value=""/><br/>
										Choose your password: <input class="passed" type="text" size="25" name="password" value=""/><br/>
										<input type="hidden" name="invitation" value="<? echo $_SESSION['inviteId']; ?>" />
										<input type="submit" value="Enroll"/>
										<p>Trouble getting in? <a href="mailto:contact@northbridgetech.org">contact@northbridgetech.org</a></p>
								</form>
							</div>						
							
				</div>
							
     		<div class="rightColumn" style="border:0px;background-color:#e6e6d5;padding:10px;top:50px;height:200px;">
									<p><b>Welcome to Nexus!</b></p>
									<p style="margin:10px;">This is a collaboration tool designed to help nonprofit organizations work together in an extremelely affordable way in order to improve conditions in their communities.</p>
      	</div>
      </div>
      	
      </div><!--shell-->
    </div><!-- container -->         	
	</body>
	
</html>




