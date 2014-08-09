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
    	<img style="float:left;vertical-align:top;margin:20px;" src="http://chicagofaithandhealth.org/imgs/logo.png" height="88" width="365" border="0" alt="Logo: The Center for Faith and Community Health Transformations"/>
   		<p style="text-align:right;color:#4b5b6e;font-size:34px;margin-right:20px;"><b>Nexus</b><br/>
   		<i><span style="text-align:right;color:#4b5b6e;font-size:16px;margin-right:20px;">Building communities that build communities</span></i></p>

      <div class="shell">

			<div class="projectsContent">      	
      	<div class="leftColumn"> 
							<p><b>Login</b></p>
							<div class="formLogin" style="border:thin solid #4b5b6e;padding:10px;border-radius:15px;">
								<form action="../control/loginProcessor.php" method="post">
									<table cellpadding="5">
								  <tr><td colspan="2"><? echo $error; ?></td></tr>
										<tr><td>User Id:</td><td><input class="passed" type="text" size="15" name="uid" value=""/></td></tr>
										<tr><td>Password:</td><td><input class="passed" type="password" size="15" name="password" value=""/></td></tr>
										<tr><td colspan="2"><input type="submit" style="float:right;" value="Login"/></td></tr>
									</table>
										<p>Trouble getting in? <a href="mailto:contact@northbridgetech.org">contact@northbridgetech.org</a></p>
										<input type="hidden" name="action" value="authenticate" />
								</form>
							</div>						
							
				</div>
							
     		<div class="rightColumn" style="border:0px;background-color:#e6ebf0;padding:10px;top:50px;height:200px;width:350px;">
									<p><b>Welcome to Nexus!</b></p>
									<p style="margin:10px;">This is your collaboration space, secure to your community of practice: The Center for Faith and Community Healthy Transformations.<br/>&nbsp;<br/>This space supports the work you do every day to strengthen communities.</p>
      	</div>
      </div>
      
      <div class="footer" style="position:absolute;top:400px;left:600px;right;color:#4b5b6e;font-size:18px;margin:20px;">
        <i>powered by</i>
    		<a href="http://northbridgetech.org/index.php"><img style="vertical-align:bottom;" src="http://northbridgetech.org/images/northbridge-logo.png" height="57" width="143" border="0" alt="NorthBridge Technology Alliance"/></a>
		</div>
	
      </div><!--shell-->
    </div><!-- container -->         	
	</body>
	
</html>




