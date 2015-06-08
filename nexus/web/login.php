<? 
session_start();

require_once("src/framework/Util.php");
require_once(Util::getPhpRoot() . "/Validate.php");
require_once(Util::getWebRoot() . "/src/organization/Organization.php");

$cleanMessage = "";

if(isset($_GET['logout'])) {
	// destroy session data
	$_SESSION = array();
	
	// destroy session cookie if exists
	if (ini_get("session.use_cookies")) {
    $params = session_get_cookie_params();
    setcookie(session_name(), '', time() - 42000, $params["path"], $params["domain"], $params["secure"], $params["httponly"]);
	}
	
	// destroy server session
	session_destroy();
}

if(isset($_GET['error']) && Util::isSafeCharacterSet($_GET['error'])) {
	$cleanMessage = $_GET['error'];
} else if(isset($_GET['logout'])) { 
	$cleanMessage = "You have signed out succesfully.";
}

$logo = "";
$networkName = "";		
$cleanNetworkId = ""; // TODO: create default network, that includes default logo

if(isset($_GET['network']) && Util::validateNetworkId($_GET['network'])) {
 	$cleanNetworkId = $_GET['network'];		
}

$cursor = Organization::getOrganizationById($cleanNetworkId);
$row = pg_fetch_array($cursor);
$logo = $row['logo'];
$networkName = $row['name'];

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">
<html>
	
  <head>
  	<meta http-equiv="Content-type" content="text/html;charset=UTF-8">
  	<meta id="meta" name="viewport" content="width=device-width; initial-scale=1.0" />	
  	<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Oswald:400,300|Open+Sans|Oxygen|Swanky+and+Moo+Moo">
  	<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
  	<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
		<link rel="stylesheet" href="//yui.yahooapis.com/pure/0.6.0/pure-min.css">
    <link rel="stylesheet" href="styles/nexus.css" type="text/css" />
    <script src="scripts/nexus.js" language="javascript"></script>
 		<script src="//code.jquery.com/jquery-1.10.2.js"></script>
  	<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
    <link rel="icon" href="images/NB_icon.png" />
    <title>Northbridge Nexus | Login</title> 
    
    <script>
    	function toggleRememberCheckbox() {
    		var loginRemember = document.getElementById("login-remember");
    		var curState = loginRemember.checked;
    		if(curState) {
    			loginRemember.checked = false;
    		} else {
    			loginRemember.checked = true;
    		}
    	}
    	
    	function toggleFormDisplay(formId) {
    		var showForm = document.getElementById(formId);
    		document.getElementById("login-form").style.display='none';
    		document.getElementById("recover-username-form").style.display='none';
    		document.getElementById("recover-password-form").style.display='none';
    		showForm.style.display='block';
    	}
    </script>
  </head>
  
  <body>
    <div class="container" style="width:50%;min-width:550px;max-width:640px;">

      <div class="header" style="margin-top:20px;">
      	<span style="float:left;width:60%;padding:10px;margin-top:10px;border-radius:6px;background:#edf0de;color:#004d62;">
      		<span style="font-family:Oswald;font-size:130%;">Nexus</span>
      		<hr style="text-align:left;margin-left:0;width:176px;">
      		<span>Web Conference Center</span>
      	</span>
      	<span style="float:right;margin-top:80px;">
      		<a href="#">Request Access</a>
      	</span>
      </div>

			<div class="frame"> 
			  <div class="colLeft" style="width:70%;float:left;margin-top:30px;">
					<form id="login-form" class="pure-form pure-form-stacked" style="width:95%;">
	    			<fieldset>
	    				Username<span style="float:right;margin-right:25px;"><a href="javascript:void(0)" onclick="toggleFormDisplay('recover-username-form')">I forgot</a></span>
        			<input style="width:95%;margin-bottom:20px;">	        		
        			Password<span style="float:right;margin-right:25px;"><a href="javascript:void(0)" onclick="toggleFormDisplay('recover-password-form')">I forgot</a></span>
        			<input type="password" style="width:95%;margin-bottom:20px;">	
        			<a type="submit" class="pure-button pure-button-primary" style="width:45%;">Sign in</a><a class="pure-button pure-button-secondary" onclick="toggleRememberCheckbox();" style="width:45%;" ><input id="login-remember" type="checkbox" /> Remember me</a>
     				</fieldset>
     			</form>
     			
     			<form id="recover-username-form" class="pure-form pure-form-stacked" style="width:95%;display:none;" autocomplete="off" action="" method="post">
     				<fieldset>
	     				Recover Username
     					<p style="font-size:90%;">Please enter your email address and we will resend your username.</p>
     					Email
     					<input style="width:95%;margin-bottom:20px;" type="email" name="email" value="">
     					<a type="submit" class="pure-button pure-button-primary" style="width:45%;">Recover Username</a><a href="javascript:void(0)" onclick="toggleFormDisplay('login-form')" style="float:right;margin-right:25px;">Return to Login</a>
     					<input type="hidden" name="network" value="<? echo $cleanNetworkId; ?>">
     				</fieldset>
     			</form>
     			
     			<form id="recover-password-form" class="pure-form pure-form-stacked" style="width:95%;display:none;" autocomplete="off" action="" method="post">
     				<fieldset>
	     				Password Reset
     					<p style="font-size:90%;">Please enter your user id so we can email you a password reset link.</p>
     					Username<span style="float:right;margin-right:25px;"><a href="javascript:void(0)" onclick="toggleFormDisplay('recover-username-form')">I forgot</a></span>
     					<input style="width:95%;margin-bottom:20px;" type="text" name="uid" value="">
     					<a type="submit" class="pure-button pure-button-primary" style="width:45%;">Reset Password</a><a href="javascript:void(0)" onclick="toggleFormDisplay('login-form')" style="float:right;margin-right:25px;">Return to Login</a>
     				</fieldset>
     			</form>
     			
     		</div>
     		<div class="colRight" style="width:30%;float:right;margin-top:30px;">
      		<span style="float:left;padding:10px;margin-top:10px;">[Team Logo]</span>
      		<span style="clear:left;float:left;padding:10px;">[Team Name]</span>
     		</div>
      </div>
      
      <div class="footer" style="clear:both;position:relative;bottom:-40px;">
        powered by<br/>
    		<a href="http://northbridgetech.org/index.php" target="_blank"><img src="http://northbridgetech.org/images/NB_horizontal_rgb.png" height="45" width="166" border="0" alt="Northbridge Technology Alliance"/></a>
			</div>
	
    </div><!-- container -->       
		      
    <!-- lightboxes -->
    
		<div id="fade" class="black_overlay"></div>
		
		<div id="light_user" class="white_content">
			<a href="javascript:void(0)" onclick="document.getElementById('light_user').style.display='none';document.getElementById('fade').style.display='none'" style="float:right">Close</a>
			<form autocomplete="off" action="" method="post">
				<table cellpadding="5">
					<tr><td colspan="2"><p>Your User ID can be found in your original enrollment confirmation email. Can't find it?</p><p>Please enter your email address and we will resend your enrollment package.</p></td></tr>
					<tr><td>Email:</td><td><input class="passed" type="text" size="15" name="email" value=""/></td></tr>
					<tr><td colspan="2"><input type="submit" style="float:right;" value="Resend"/></td></tr>
				</table>
				<input type="hidden" name="network" value="<? echo $cleanNetworkId; ?>">
			</form>
		</div>

		<div id="light_password" class="white_content">
			<a href="javascript:void(0)" onclick="document.getElementById('light_password').style.display='none';document.getElementById('fade').style.display='none'" style="float:right">Close</a>
			<form autocomplete="off" action="" method="post">
				<table cellpadding="5">
					<tr><td colspan="2"><p>No problem!</p><p>Please enter your user id so we can email you a password reset link.</p></td></tr>
					<tr><td>User Id:</td><td><input class="passed" type="text" size="15" name="uid" value=""/></td></tr>
					<tr><td><a href="javascript:void(0)" onclick="document.getElementById('light_user').style.display='block';document.getElementById('light_password').style.display='none';document.getElementById('fade').style.display='block'">Forgot your user id?</a></td><td><input type="submit" style="float:right;" value="Reset"/></td></tr>
				</table>
				<input type="hidden" name="network" value="<? echo $cleanNetworkId; ?>"> 
			</form>
		</div>
		  	
	</body>
	
</html>




