<? 
session_start();

require_once("src/framework/Util.php");
require_once(Util::getSrcRoot() . "/organization/Organization.php");

$cleanMessage = "";
$cleanIcon = "";

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
	$cleanIcon = "fa fa-info-circle fa-2x";
} else if(isset($_GET['logout'])) { 
	$cleanMessage = "You have signed out succesfully.";
	$cleanIcon = "fa fa-info-circle fa-2x";
}

$logo = "";
$networkLogo = $networkName = "";		
$cleanNetworkId = "123"; // TODO: create default network in db, that includes default logo

if(isset($_GET['network']) && Organization::validateNetworkId($_GET['network'])) {
 	$cleanNetworkId = $_GET['network'];		
}

$cursor = Organization::getOrganizationById($cleanNetworkId);
$row = pg_fetch_array($cursor);
$networkLogo = $row['logo'];
$networkName = $row['name'];

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">
<html>
	
  <head>
		<!-- TODO - localize all scripts and stylesheets -->
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
  </head>
  
  <body>
  	<!-- TODO - finalize container width -->
    <div class="container" style="width:50%;min-width:550px;max-width:640px;">

      <div class="header" style="margin-top:20px;">
      	<span style="float:left;width:60%;padding:10px;margin-top:10px;border-radius:6px;background:#edf0de;color:#004d62;">
      		<span style="font-family:Oswald;font-size:130%;">Nexus</span>
      		<hr style="text-align:left;margin-left:0;width:176px;">
      		<span>Web Conference Center</span>
      	</span>
      	<span style="float:right;margin-top:20px;">
      		<a href="#">About</a>
      	</span>
      </div>

			<div class="frame"> 
				
			  <div class="loginColLeft">
			  	<p id="login-user-message" class="confirmation"><span class="<? echo $cleanIcon; ?>" style="color:#007582;float:left;margin-right:5px;"></span><? echo $cleanMessage; ?></p>
					<form id="login-form" class="pure-form pure-form-stacked" autocomplete="off" action="modules/login/control/loginProcessor.php" method="post">
	    			<fieldset>
	    				Username<span class="instruction form-instruction"><a href="javascript:void(0)" onclick="toggleFormDisplay('recover-username-form')">I forgot</a></span>
        			<input class="form-input" name="uid" value="" maxlength="25" minlength="7">	        		
        			Password<span class="instruction form-instruction"><a href="javascript:void(0)" onclick="toggleFormDisplay('recover-password-form')">I forgot</a></span>
        			<input class="form-input" type="password" name="password" value="" />	
        			<a id="login-form-submit" type="submit" class="pure-button pure-button-primary" style="width:45%;" href="javascript:void(0);" onclick="loginValidateAndSubmit();">Sign In</a>
        			<a class="pure-button pure-button-secondary" onclick="toggleRememberCheckbox();" style="width:45%;" ><input id="login-remember" type="checkbox" /> Remember me</a>
     				</fieldset>
     			</form>   			
     			<form id="recover-username-form" class="pure-form pure-form-stacked" style="display:none;" autocomplete="off" action="modules/login/control/recoverEnrollmentProcessor.php" method="post">
     				<fieldset>
	     				Recover Username
     					<p style="font-size:90%;">Please enter your email address and we will resend your username.</p>
     					Email
     					<input class="form-input" type="email" name="email" value="">
     					<a id="username-form-submit" type="submit" class="pure-button pure-button-primary" style="width:45%;" href="javascript:void(0);" onclick="usernameValidateAndSubmit();">Recover Username</a>
     					<a class="form-instruction" href="javascript:void(0)" onclick="toggleFormDisplay('login-form')">Return to Login</a>
     					<input type="hidden" name="network" value="<? echo $cleanNetworkId; ?>">
     				</fieldset>
     			</form>
     			<form id="recover-password-form" class="pure-form pure-form-stacked" style="display:none;" autocomplete="off" action="modules/login/control/recoverPasswordProcessor.php" method="post">
     				<fieldset>
	     				Password Reset
     					<p class="instruction">Please enter your user id so we can email you a password reset link.</p>
     					Username<span class="instruction form-instruction"><a href="javascript:void(0)" onclick="toggleFormDisplay('recover-username-form')">I forgot</a></span>
     					<input class="form-input" type="text" name="uid" value="" maxlength="25">
     					<a id="password-form-submit" type="submit" class="pure-button pure-button-primary" style="width:45%;" href="javascript:void(0);" onclick="passwordValidateAndSubmit();">Reset Password</a>
     					<a class="form-instruction" href="javascript:void(0)" onclick="toggleFormDisplay('login-form')">Return to Login</a>
     					<input type="hidden" name="network" value="<? echo $cleanNetworkId; ?>">
     				</fieldset>
     			</form>     			
     		</div>
     		
     		<div class="loginColRight">
      		<span style="clear:right;float:right;text-align:right;margin-top:20px;"><? echo $networkName; ?></span>
      		<span style="clear:right;float:right;margin-top:20px;"><img <?php echo $networkLogo; ?>/></span>
     		</div>
      </div>
      
      <div class="footer" style="clear:both;position:relative;bottom:-40px;">
        powered by<br/>
    		<a href="http://northbridgetech.org/index.php" target="_blank"><img src="http://northbridgetech.org/images/NB_horizontal_rgb.png" height="45" width="166" border="0" alt="Northbridge Technology Alliance"/></a>
			</div>
	
    </div><!-- container -->       		  	
	</body>
</html>




