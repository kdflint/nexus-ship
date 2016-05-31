<?php
session_start();

require_once("src/framework/Util.php");
require_once(Utilities::getSrcRoot() . "/organization/Organization.php");
require_once(Utilities::getSrcRoot() . "/schedule/Event.php");
// TODO - this should be handled by the autoloader in Util
require_once(Utilities::getLibRoot() . "/rememberme/rememberme/src/Rememberme/Storage/File.php");
require_once(Utilities::getLibRoot() . "/rememberme/rememberme/src/Rememberme/Authenticator.php");

use Birke\Rememberme;
// Initialize RememberMe Library with file storage
$storagePath = Utilities::getTokenRoot();
if(!is_writable($storagePath) || !is_dir($storagePath)) {
    die("'$storagePath' does not exist or is not writable by the web server.");
}
$storage = new Rememberme\Storage\File($storagePath);
$rememberMe = new Rememberme\Authenticator($storage);

if(isset($_GET['logout'])) {
	$rememberMe->clearCookie(isset($_SESSION['username']) ? $_SESSION['username'] : '');
	Utilities::destroySession();
	session_start();
}

if(isset($_GET['logoutAll'])) {
  $storage->cleanAllTriplets($_SESSION['username']);
	Utilities::destroySession();
	session_start();
}

$remembered = $enrolled = "false";
$cleanMessage = "";
$cleanIcon = "";

$enrolled = (isset($_SESSION['invitation']) && isset($_SESSION['username'])) ? "true" : "false"; 
$enrolledUsername = (isset($_SESSION['invitation']) && isset($_SESSION['username'])) ? $_SESSION['username'] : false; 

$rememberedUsername = ($rememberMe->login()) ? $rememberMe->login() : false;

if(Utilities::isSessionValid() && !Utilities::isSessionPublic()) {
	header("location:" . Utilities::getHttpPath() . "/nexus.php");
	exit(0);
} else if ($rememberedUsername) {
	$_SESSION['remembered'] = $remembered = "true";
} else if ($enrolledUsername) {
	$_SESSION['remembered'] = "true";
}

if(isset($_GET['error']) && Utilities::isSafeCharacterSet($_GET['error'])) {
	$cleanMessage = $_GET['error'];
	$cleanIcon = "fa fa-info-circle fa-2x";
} else if(isset($_GET['logout'])) {
	if(isset($_GET['expired'])) {
		$cleanMessage = "Your session has timed out.";
	} else {
		$cleanMessage = "You have signed out successfully.";
	}
	$cleanIcon = "fa fa-info-circle fa-2x";
}

$logo = "";
$disabled = "";
$networkLogo = $networkName = $cleanMeetingId = "";	
$techCheckInclude = "scripts/techCheckDummy.js";
$cleanNetworkId = "1"; // TODO: create default network in db, that includes default logo?
$demoSession = $guestPass = "false";
unset($_SESSION['demo']);

if(isset($_GET['oid']) && Organization::validateOrganizationUid($_GET['oid'])) {
 	$cleanNetworkId = $_GET['oid'];		
}

if ($cleanNetworkId == 'userdemo') {
	$demoSession = "true";
	$disabled = "disabled";
	$_SESSION['demo'] = "true";
	// TODO - react to existing session or remembered user?
}

// Toggle on CFCHT in prod, for now
$pageTitle = "Web Meet";
if ($cleanNetworkId == 'ed787a92') {
	$pageTitle = "Advantage";
}

if(isset($_GET['mid'])) {
	if (Utilities::validateUuid($_GET['mid']) && Event::isValidFutureEvent($_GET['mid'], $cleanNetworkId)) {
		Utilities::destroySession();
		// guest context overrides demo context
		$demoSession = "false";
		$disabled = "";
		$guestPass = "true";
 		$cleanMeetingId = $_GET['mid'];
 		$techCheckInclude = "scripts/techCheck.js";
 		// TODO - react to remembered user?
 	} else {
 		$cleanMessage = "Your meeting has expired.";
 		$cleanIcon = "fa fa-info-circle fa-2x";
 	}
}

$cursor = Organization::getOrganizationByUid($cleanNetworkId);
$row = pg_fetch_array($cursor);
$networkLogo = $row['logo'];
$networkName = $row['name'];

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">
<html>
	
  <head>
		<!-- TODO - localize all scripts and stylesheets -->
  	<meta http-equiv="Content-type" content="text/html;charset=UTF-8">
		<meta http-equiv="Cache-control" content="no-cache">
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv="Expires" content="0">
		<meta http-equiv="Pragma-directive" content="no-cache">				
		<meta http-equiv="Cache-directive" content="no-cache">	
  	<meta id="meta" name="viewport" content="width=device-width,initial-scale=1.0" />	
  	<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Oswald:400,300|Open+Sans|Oxygen|Swanky+and+Moo+Moo">
  	<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
  	<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
		<link rel="stylesheet" href="//yui.yahooapis.com/pure/0.6.0/pure-min.css">
    <link rel="stylesheet" href="styles/nexus.css" type="text/css" />
    <script src="scripts/nexus.js" language="javascript"></script>
  	<!-- http://www.featureblend.com/javascript-flash-detection-library.html -->
 		<script src="scripts/lib/flash_detect.js"></script>
 		<script src="//code.jquery.com/jquery-1.10.2.js"></script>
  	<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
  	<script src="//cdnjs.cloudflare.com/ajax/libs/jstimezonedetect/1.0.4/jstz.min.js"></script>
  	<!-- http://www.pinlady.net/PluginDetect/ -->
  	<script type="text/javascript" src="scripts/lib/javaDetect/scripts/PluginDetect_Java_Simple.js"></script>
    <link rel="icon" href="images/NB_icon.png" />
    <title>Northbridge Nexus | Login</title> 
   
   	<script> 
   		
   		<!-- include in this manner instead of in a meta link so that php code inside this file will resolve prior to runtime -->
			<?php include($techCheckInclude); ?>
    	
			$(document).ready(function () {
				$(document).on("keyup", function (event) {
    			if (event.which == 13) {
       			document.getElementById("login-form-submit").click();   
    			}
				});
				document.getElementById("localTz").value = getLocalTz();
				var loginForm = document.forms["login-form"];
				$( '#tech_check_control' ).click(function() {
	  			$( "#tech_check_display" ).toggle( "blind" ); 			
				});
				if (<?php echo $remembered; ?>) {
					loginForm.elements['uid'].value = <?php echo var_export($rememberedUsername); ?>;
					loginForm.elements['password'].value = "Passthru1";
					loginForm.elements['login-remember'].checked = true;
					document.getElementById("login-form-submit").click();
				}
				if (<?php echo $enrolled; ?>) {
					loginForm.elements['uid'].value = <?php echo var_export($enrolledUsername); ?>;
					loginForm.elements['password'].value = "Passthru1";
					loginForm.elements['login-remember'].checked = false;
					document.getElementById("login-form-submit").click();
				}
				if (<?php echo $demoSession; ?>) {
					loginForm.elements['password'].disabled = true;
					loginForm.elements['password'].placeholder = "demo";
					document.getElementById("username-field-label").innerHTML = "Your Name";
					document.getElementById("username-instruction-field-label").innerHTML = "";
					document.getElementById("login-form-submit").innerHTML = "View Demo";
					document.getElementById("login-form-submit").onclick = demoValidateAndSubmit;
					document.getElementById("password-form-submit").onclick = "";
					document.getElementById("username-form-submit").onclick = "";
					document.getElementById("remember-me-toggle").onclick = "";
					document.getElementById("login-module-name").innerHTML = "Web Meet Demo";
				}
				if (<?php echo $guestPass; ?>) {
					techCheck();  
				}
			});

		</script>
		
		<script type="text/javascript">(function() {var walkme = document.createElement('script'); walkme.type = 'text/javascript'; walkme.async = true; walkme.src = 'http://cdn.walkme.com/users/ab3d27eee206468794b47885dfc2df46/walkme_ab3d27eee206468794b47885dfc2df46.js'; var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(walkme, s); window._walkmeConfig = {smartLoad:true}; })();</script> 
		
		<style>
			<!-- override some default techCheck.php styles  -->
			.event {width:auto;}
			td .techCheckCol1 {font-size:90%;}
			td .techCheckCol2 {left:295px;}
			td .techCheckCol3 {left:315px;font-size:80%;}
			.move-it-up {margin-top:-50px;}
		</style>
		

		
  </head>
  
  <body>
  	<!-- TODO - finalize container width -->
    <div class="container" style="width:550px;">

      <div class="header">
       	<img class="banner-image" src="image/nexus4.png" />
       	<span class="banner" style="width:60%">
					<span class="product-name" style="">Nexus</span><br/>
					<span id="login-module-name" class="module-name" style=""><?php echo($pageTitle); ?></span>					
      	</span>  	
  	
      	<span id="walkme-login-anchor" class="controls" style="float:right;padding-bottom:10px;margin-top:30px;">
      		<a href="http://northbridgetech.org/downloads/Northbridge_web_conference_center.pdf" style="color:#d27b4b;text-decoration:none;" target="_blank">About</a> | 
      		<a href="<?php echo Utilities::getSupportUrl(); ?>" style="color:#d27b4b;text-decoration:none;" target="_blank">Support</a>
      	</span>
      </div>


			<div class="frame"> 
				
			  <div class="loginColLeft">
			  	<noscript>
			  		<p><span class="fa fa-exclamation-triangle fa-2x" style="color:#d27b4b;float:left;margin-right:5px;"></span>To use Nexus it is necessary to enable JavaScript.</p>
			  		<p>Here are the <a href="http://www.enable-javascript.com" target="_blank"> instructions how to enable JavaScript in your web browser</a></p>
			  	</noscript>
			  	<p id="login-user-message" class="confirmation"><span class="<?php echo $cleanIcon; ?>" style="color:#007582;float:left;margin-right:5px;"></span><?php echo $cleanMessage; ?></p>

					<!-- This is a standard login, possibly in demo mode -->
					<?php if ($guestPass === "false") { ?>

						<form id="login-form" class="pure-form pure-form-stacked" action="modules/login/control/loginProcessor.php" method="post">
		    			<fieldset>
	    					<span id="username-field-label">Username</span><span class="instruction form-instruction"><a href="javascript:void(0)" onclick="toggleFormDisplay('recover-username-form')"><span id="username-instruction-field-label">I forgot</span></a></span>
        				<input class="form-input" name="uid" value="" maxlength="25" autofocus>	        		
        				Password<span class="instruction form-instruction"><a href="javascript:void(0)" onclick="toggleFormDisplay('recover-password-form')">I forgot</a></span>
        				<input class="form-input" type="password" name="password" value="" maxlength="25"/>	
        				<input id="localTz" name="timezone" type="hidden" value="">
        				<a id="login-form-submit" type="submit" class="pure-button pure-button-primary" style="width:45%;" href="javascript:void(0);" onclick="loginValidateAndSubmit();">Sign In</a>
        				<a id="remember-me-toggle" class="pure-button pure-button-secondary" onclick="toggleRememberCheckbox();" style="width:45%;" <?php echo($disabled);?> ><span id="fakeCheckBox" class="fa fa-square-o" style="color:#004d62;padding-right:4px;"></span> Remember me</a>
        				<input id="login-remember" name="login-remember" type="checkbox" style="visibility:hidden;"/>        			
     					</fieldset>
     				</form>   			
     				<form id="recover-username-form" class="pure-form pure-form-stacked" style="display:none;" autocomplete="off" action="modules/login/control/recoverEnrollmentProcessor.php" method="post">
	     				<fieldset>
	     					Recover Username
     						<p style="font-size:90%;">Please enter your email address and we will resend your username.</p>
     						Email
     						<input class="form-input" type="email" name="email" value="">
     						<a id="username-form-submit" type="submit" class="pure-button pure-button-primary" style="width:45%;" href="javascript:void(0);" onclick="usernameValidateAndSubmit();" <?php echo($disabled);?> >Recover Username</a>
     						<a class="form-instruction" href="javascript:void(0)" onclick="toggleFormDisplay('login-form')">Return to Login</a>
     						<input type="hidden" name="network" value="<?php echo $cleanNetworkId; ?>">
     					</fieldset>
     				</form>
     				<form id="recover-password-form" class="pure-form pure-form-stacked" style="display:none;" autocomplete="off" action="modules/login/control/recoverPasswordProcessor.php" method="post">
	     				<fieldset>
	     					Password Reset
     						<p class="instruction">Please enter your user id so we can email you a password reset link.</p>
     						Username<span class="instruction form-instruction"><a href="javascript:void(0)" onclick="toggleFormDisplay('recover-username-form')">I forgot</a></span>
     						<input class="form-input" type="text" name="uid" value="" maxlength="25">
     						<a id="password-form-submit" type="submit" class="pure-button pure-button-primary" style="width:45%;" href="javascript:void(0);" onclick="passwordValidateAndSubmit();" <?php echo($disabled);?> >Reset Password</a>
     						<a class="form-instruction" href="javascript:void(0)" onclick="toggleFormDisplay('login-form')">Return to Login</a>
     						<input type="hidden" name="network" value="<?php echo $cleanNetworkId; ?>">
     					</fieldset>
     				</form>  
	     			
     		<!-- This is a meeting guest pass "login" -->
     		<?php } else { ?>   
 		
						<!-- 
						We set the public session two times. This one is first, because eventDetailSummary.php depends on certain values from $_SESSION.
						We do it again after the user joins (inside guestValidateAndSubmit()) so we can add the name from the form. 
						-->
     				<script> 
     					setPublicSession('<?php echo $cleanNetworkId; ?>', '', '<?php echo $cleanMeetingId; ?>', '');
     				</script>
     		
						<form id="public-join-form" class="pure-form pure-form-stacked" action="" method="post" style="width:92%;">
		    			<fieldset>
	    					<span id="username-field-label">Your Name</span>
        				<input class="form-input" name="uid" value="" maxlength="25" style="width:100%;margin-bottom:10px !important;" autofocus>
        				<span id="username-email-label">Email</span>
     						<input class="form-input" type="email" name="email" maxlength="50" style="width:100%;margin-bottom:10px !important;">
     						<p><span id='tech_check_summary' class='descr' style='font-style:italic;' ><span class='fa fa-spinner fa-spin fa-lg'></span> Checking your system compatibility...</span><a href='javascript:void(0);' onclick='document.getElementById("tech_check_control").click();' style='font-size:90%;margin-left:5px;'> Details</a></p>
        				<a id="login-form-submit" class="pure-button pure-button-primary pure-button-disabled" style="width:100%;border-radius:6px;" href="javascript:void(0);" onclick="guestValidateAndSubmit('<?php echo $cleanNetworkId; ?>', '<?php echo $cleanMeetingId; ?>');" >Fetching...</a>  
        				<input id="localTz" name="timezone" type="hidden" value="">     		
             		<?php include(Utilities::getModulesRoot() . "/event/views/eventDetailSummary.php"); ?>	
     					</fieldset>
     				</form> 
      			<a id='tech_check_control' href='javascript:void(0);' style="display:none;"></a>
						<div id="tech_check_display" style="display:none;width:560px;">
							<?php include("modules/schedule/views/techCheck.php"); ?>	
						</div>
						<div id="notification"></div>	
     				<script> 
     					// Set the refresh interval to the default for the first refresh
     					window.setTimeout(refreshEvents, MEETING_INFO_NEXT_REFRESH);
     					// Load the guest pass event
     					getEventDetail("<?php echo $cleanMeetingId; ?>");
     					function refreshEvents() {
								if(MEETING_INFO_NEXT_REFRESH) {
									// Refresh the event view and set the next refresh interval
									getEventDetail("<?php echo $cleanMeetingId; ?>");
									window.setTimeout(refreshEvents, MEETING_INFO_NEXT_REFRESH);
									//console.log(MEETING_INFO_NEXT_REFRESH)
								}
     					}
     				</script>     		  		     		
     		<?php } ?>   			
     		</div>
     		
     		<div id="customization-area" class="loginColRight">
      		<span style="clear:right;float:right;text-align:right;margin-top:20px;"><?php echo $networkName; ?></span>
      		<span style="clear:right;float:right;margin-top:20px;"><img src="<?php echo Utilities::getPartnerImageRoot(); ?><?php echo $networkLogo; ?>" /></span>
     		</div>
      </div>
      
      <div class="footer" style="clear:both;position:relative;bottom:-40px;">
        powered by<br/>
    		<a href="http://northbridgetech.org/index.php" target="_blank"><img src="http://northbridgetech.org/images/NB_horizontal_rgb.png" height="45" width="166" border="0" alt="Northbridge Technology Alliance"/></a>
			</div>
	
    </div><!-- container -->   
       		  	
	</body>
</html>




