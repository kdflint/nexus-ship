<? 
session_start();
$error = "";

if(isset($_GET['logout'])) {
	// Logout from Forum
	require_once '../control/forum_sso_functions.php';
	forumSignout();
	
	// Logout from NorthBridge
	$_SESSION = array();
	// TODO: Also delete session cookie? See http://php.net/manual/en/function.session-destroy.php
	session_destroy();
}

if(isset($_GET['error'])) {
	$error = $_GET['error'];
} else if(isset($_GET['logout'])) { 
	$error = "You have signed out succesfully.";
}

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">
<html>
	
  <head>
  	<meta http-equiv="Content-type" content="text/html;charset=UTF-8">
    <link rel="stylesheet" href="style/style.css" type="text/css" />
    <script src="script/script.js" language="javascript"></script>
    <link rel="shortcut icon" href="image/northbridge-ico.png" />
    <title>Nexus | Login</title>
  </head>
  
  <body>
    <div class="container">
    	<a href="http://northbridgetech.org/index.php"><img style="float:left;vertical-align:top;margin:10px;" src="http://northbridgetech.org/images/northbridge-logo.png" height="86" width="215" border="0" alt="NorthBridge Technology Alliance"/></a>
   		<p style="text-align:right;color:#57574a;font-size:22px;margin:20px;"><b>Nexus</b>, v 0.01</b><br/>
      <div class="shell">

			<div class="projectsContent">      	
      	<div class="leftColumn"> 
							<p><b>Login</b></p>
							<div class="formLogin" style="border:thin solid #da5e00;padding:10px;border-radius:15px;">
								<form action="../control/loginProcessor.php" method="post">
								  	<p><? echo $error; ?></p>
										User Id: <input class="passed" type="text" size="25" name="uid" value=""/><br/>
										Password: <input class="passed" type="text" size="25" name="password" value=""/><br/>
										<input type="hidden" name="action" value="authenticate" />
										<input type="submit" value="Login"/>
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




