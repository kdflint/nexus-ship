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

if(isset($_GET['error']) && Util::isSafeCharacterSet($_GET['error']) {
	$cleanMessage = $_GET['error'];
} else if(isset($_GET['logout'])) { 
	$cleanMessage = "You have signed out succesfully.";
}

$logo = ""; // TODO: create a default logo
$networkName = "";		
$cleanNetworkId = "";

if(isset($_GET['network']) && Util::validateNetworkId($_GET['network'])) {
 	$cleanNetworkId = $_GET['network'];
 	$cursor = Organization::getOrganizationById($cleanNetworkId);
	$row = pg_fetch_array($cursor);
	$logo = $row['logo'];
	$networkName = $row['name'];		
}

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">
<html>
	
  <head>
  	<meta http-equiv="Content-type" content="text/html;charset=UTF-8">
  	<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Oswald:400,300|Open+Sans|Oxygen|Swanky+and+Moo+Moo">
  	<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="styles/nexus.css" type="text/css" />
    <script src="scripts/nexus.js" language="javascript"></script>
    <link rel="icon" href="images/NB_icon.png" />
    <title>Northbridge Nexus | Login</title>
    
    
	<style>
		.button {
  		border-top: 1px solid #a6c3ce;
   		background: #004d62;
		  padding: 5px 15px;
   		-webkit-border-radius: 10px;
   		-moz-border-radius: 10px;
   		border-radius: 10px;
   		text-shadow: rgba(0,0,0,.4) 0 1px 0;
   		color: #edf0de;
   		font-size: 18px;
   		text-decoration: none;
   		vertical-align: middle;
   		letter-spacing: .5px;
   		width: 100%;
   	}
   		
		.button:hover {
   		background: #a6c3ce;
   	}
   	
		.button:active {
   		background: #a6c3ce;
   	}
  </style>
  
  </head>
  
  <body>
    <div class="container">

      <div class="header">
      	<span style="float:left;padding:10px;margin-top:10px;border-radius:8px;background:#edf0de;color:#004d62;"><span style="font-family:Oswald;font-size:130%">Nexus</span><hr/>Web Conference Center</span>
      	<span style="float:left;padding:10px;margin-top:10px;">[Team Logo]</span>
      	<span style="float:right;padding:10px;margin-top:56px;">
      		<a href="#" style="color:#d27b4b;text-decoration:none;">Account</a> | 
      		<a href="#" style="color:#d27b4b;text-decoration:none;">Support</a> | 
      		<a href="#" style="color:#d27b4b;text-decoration:none;">Logout</a>
      	</span>
      	<span style="clear:left;float:left;padding:10px;">[Team Name]</span>
      	<span style="clear:right;float:right;padding:5px;margin:0px;color:#d27b4b;" class="fa fa-caret-down fa-2x" ></span>
				<span style="float:right;padding:10px;">[User Name]</span>
      </div>

			<div class="frame" >     
				<div class="something">
					<button id="contextSwitch" class="button" href="javascript:void(0)" onclick="showJoinForm();" style="float:right;width:30%;margin-top:75px;margin-left:10px;">Schedule</button>
					<button id="contextSwitch" class="button" href="javascript:void(0)" onclick="showJoinForm();" style="float:right;width:30%;margin-top:75px;margin-right:10px;">Start Now</button>
				</div> 	
      </div>
      
      <div class="footer">
        powered by<br/>
    		<a href="http://northbridgetech.org/index.php" target="_blank"><img src="http://northbridgetech.org/images/NB_horizontal_rgb.png" height="60" width="221" border="0" alt="Northbridge Technology Alliance"/></a>
			</div>
	
    </div><!-- container -->       
       
    <!-- lightboxes -->
		<div id="light_password" class="white_content">
			<a href="javascript:void(0)" onclick="document.getElementById('light_password').style.display='none';document.getElementById('fade').style.display='none'" style="float:right">Close</a>
			<form autocomplete="off" action="modules/authorization/forgotPasswordProcessor.php" method="post">
				<table cellpadding="5">
					<tr><td colspan="2"><p>No problem!</p><p>Please enter your user id so we can email you a password reset link.</p></td></tr>
					<tr><td>User Id:</td><td><input class="passed" type="text" size="15" name="uid" value=""/></td></tr>
					<tr><td><a href="javascript:void(0)" onclick="document.getElementById('light_user').style.display='block';document.getElementById('light_password').style.display='none';document.getElementById('fade').style.display='block'">Forgot your user id?</a></td><td><input type="submit" style="float:right;" value="Reset"/></td></tr>
				</table>
				<input type="hidden" name="network" value="<? echo $cleanNetworkId; ?>"> 
			</form>
		</div>
		
		<div id="light_user" class="white_content">
			<a href="javascript:void(0)" onclick="document.getElementById('light_user').style.display='none';document.getElementById('fade').style.display='none'" style="float:right">Close</a>
			<form autocomplete="off" action="modules/authorization/resendEnrollmentProcessor.php" method="post">
				<table cellpadding="5">
					<tr><td colspan="2"><p>Your User ID can be found in your original enrollment confirmation email. Can't find it?</p><p>Please enter your email address and we will resend your enrollment package.</p></td></tr>
					<tr><td>Email:</td><td><input class="passed" type="text" size="15" name="email" value=""/></td></tr>
					<tr><td colspan="2"><input type="submit" style="float:right;" value="Resend"/></td></tr>
				</table>
				<input type="hidden" name="network" value="<? echo $cleanNetworkId; ?>">
			</form>
		</div>
		<div id="fade" class="black_overlay"></div>
  	
	</body>
	
</html>




