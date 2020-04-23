<?php

session_start();

require_once("src/framework/Util.php");
require_once(Utilities::getSrcRoot() . "/organization/Organization.php");
require_once(Utilities::getSrcRoot() . "/schedule/Event.php");
require_once(Utilities::getLibRoot() . '/facebook/Facebook/autoload.php' );

$fb = new Facebook\Facebook([
  'app_id' => Utilities::getFbAppId(),
  'app_secret' => Utilities::getFbAppSecret(),
  'default_graph_version' => 'v2.10'
  ]);

$helper = $fb->getRedirectLoginHelper();
$permissions = ['email'];

if (!isset($_SESSION['fb_access_token'])) {
    $fbLoginUrl = $helper->getLoginUrl(Utilities::getHttpPath() . '/modules/login/control/fb-callback.php', $permissions);
}

$liLoginUrl = Utilities::getHttpPath() . '/modules/login/control/li-callback.php?oauth_init=1';

// Initialize RememberMe Library with file storage
$storagePath = Utilities::getTokenRoot();
if ($storagePath) {
	$storage = new Birke\Rememberme\Storage\FileStorage($storagePath);
	$rememberMe = new Birke\Rememberme\Authenticator($storage);
}

if(isset($_GET['logout'])) {
    if ($_SESSION['nexusContext'] == "ADV") {
	    require_once(Utilities::getModulesRoot() . "/forum/forum_integration.php");
	    $user->session_kill();
    }
	$rememberMe->clearCookie(isset($_SESSION['username']) ? $_SESSION['username'] : '');
	unset($_COOKIE['member_transfer_oid']);
  setcookie('member_transfer_oid', null, -1, '/');
	if (isset($_SESSION['fb_access_token'])) {
	}
	Utilities::destroySession();
	session_start();
	// Note: every time this login url is generated, a different state is put in session to be compared by fb-callback.php
  $fbLoginUrl = $helper->getLoginUrl(Utilities::getHttpPath() . '/modules/login/control/fb-callback.php', $permissions);
}	

// The following method is not actually invoked. Stubbed for future use...
if(isset($_GET['logoutAll'])) {
  //$storage->cleanAllTriplets($_SESSION['username']);
	Utilities::destroySession();
	session_start();
}

Utilities::setUserLanguageEnv();

$remembered = $enrolled = $xferred = "false";
$cleanMessage = $cleanMessageLink = "";
$cleanIcon = "";
$enrolledUsername = $xferUsername = "";
$logo = "";
$disabled = "";
$networkLogo = $networkName = $cleanMeetingId = "";	
$techCheckInclude = "scripts/techCheckDummy.js";
$cleanNetworkId = "1"; // TODO: create default network in db, that includes default logo?
$demoSession = $guestPass = "false";
unset($_SESSION['demo']);

// TODO - this is definitely not right. Need to not let in a public session user that otherwise passes these tests.
if (isset($_SESSION['username']) && substr($_SESSION['username'], 0, 6 ) !== "pUser-") {
	$enrolled = (isset($_SESSION['invitation']) && (isset($_SESSION['username'])) ? "true" : "false");
	$enrolledUsername = (isset($_SESSION['invitation']) && (isset($_SESSION['username'])) ? $_SESSION['username'] : false);
}

$rememberedLoginResult = $rememberMe->login();
if ($rememberedLoginResult->isSuccess()) {
	$remembered = "true";
}	

if(isset($_GET['error']) && Utilities::isSafeCharacterSet($_GET['error'])) {
	$cleanMessage = $_GET['error'];
	if (isset($_GET['errorlink'])) {
		// Hack to serve only one case
		$cleanMessageLink = "&nbsp;&nbsp;<a href='javascript:void(0)' onclick=\"" . $_GET['errorlink'] . "\">" . _("details") . "</a>";
	}
	$cleanIcon = "fa fa-info-circle fa-2x";
} else if(isset($_GET['logout'])) {
	if(isset($_GET['expired'])) {
		$cleanMessage = _("Your session has timed out.");
	} else {
		$cleanMessage = _("You have signed out successfully.");
	}
	$cleanIcon = "fa fa-info-circle fa-2x";
}

if ($cleanMessage === "No message") {
	$cleanMessage = $cleanIcon = "";
}

if(isset($_GET['oid']) && Organization::validateOrganizationUid($_GET['oid'])) {
 	$cleanNetworkId = $_GET['oid'];	
}

if ($cleanNetworkId == 'userdemo') {
	$demoSession = "true";
	$disabled = "disabled";
	$_SESSION['demo'] = "true";
	// TODO - react to existing session or remembered user?
}

if (isset($_GET['member']) && isset($_COOKIE['member_transfer_oid'])) {
	// Use the sanitized oid from the _$GET param, not the cookie. Cookie set in Drupal view contains html markup and I can't predict how it will process across browsers... -kdf
	if (Utilities::validateOrganizationUidFormat($cleanNetworkId)) {
		$xferUsername = User::getMembershipAdminByOrgUid($cleanNetworkId);
		$xferred = "true";
		$_SESSION['xfer'] = "true";
	}
}

// Toggle on CFCHT in prod, for now
$pageTitle = "Web Meet";
if ($cleanNetworkId == 'ed787a92' || $cleanNetworkId == '2ab2f516') {
	$pageTitle = "Advantage";
}

if(isset($_GET['mid'])) {
	if (Utilities::validateUuid($_GET['mid']) && Event::isValidFutureEvent($_GET['mid'], $cleanNetworkId)) {
		// Utilities::destroySession();
		// guest context overrides demo context
 		$cleanMeetingId = $_GET['mid'];
		$demoSession = "false";
		$disabled = "";
		$guestPass = "true";
 		$techCheckInclude = "scripts/techCheckGuest.js";
 		// TODO - react to remembered user?
 	} else {
 		$cleanMessage = _("Your meeting is over.");
 		$cleanIcon = "fa fa-info-circle fa-2x";
 	}
}

$cursor = Organization::getOrganizationByUid($cleanNetworkId);
$row = pg_fetch_array($cursor);
$networkLogo = $row['logo'];
$networkName = $row['name'];

if (!isset($networkLogo) || strlen($networkLogo) < 1) {
	$networkLogo = "default-empty.png";
}

if(Utilities::isSessionValid() && !Utilities::isSessionPublic()) {
	// TODO - pass parm string into nexus.php. Reference directoryDetail.php:45-46, where we want to focus on an org if there is a good session open
	if ($guestPass === "false" ) {
		header("location:" . Utilities::getHttpPath() . "/nexus.php");
		exit(0);
	} else if ($guestPass === "true") {
		Utilities::destroySession();
	}
} else if (Utilities::isSessionValid() && Utilities::isSessionPublic() && isset($_SESSION['remembered']) && isset($_SESSION['password'])) {
	// transition a public session to authenticated session
	Utilities::setSession($_SESSION['remembered'], $_SESSION['remember'], $_SESSION['timezone'], $_SESSION['password']);
	header("location:" . Utilities::getHttpPath() . "/nexus.php");
	exit(0);
} else if ($enrolledUsername) {
	$_SESSION['remember'] = "true";
}

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">
<html>
	
  <head><meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<!-- TODO - localize all scripts and stylesheets -->
  	
		<meta http-equiv="Cache-control" content="no-cache">
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv="Expires" content="0">
		<meta http-equiv="Pragma-directive" content="no-cache">				
		<meta http-equiv="Cache-directive" content="no-cache">	
  	<meta id="meta" name="viewport" content="width=device-width,initial-scale=1.0" />	
  	<link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Oswald:400,300|Open+Sans|Oxygen|Swanky+and+Moo+Moo">
  	<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
  	<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
		<link rel="stylesheet" href="//yui-s.yahooapis.com/pure/0.6.0/pure-min.css">
    <link rel="stylesheet" href="styles/nexusCssHandler.php" type="text/css" />
    <link rel="shortcut icon" href="//northbridgetech.org/images/favicon.ico" type="image/x-icon" />
    <script src="scripts/javascriptHandler.php" type="text/javascript" ></script>
  	<!-- http://www.featureblend.com/javascript-flash-detection-library.html -->
 		<script src="scripts/lib/flash_detect.js"></script>
 		<script src="//code.jquery.com/jquery-1.12.4.js"></script>
  	<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
  	<script src="//cdnjs.cloudflare.com/ajax/libs/jstimezonedetect/1.0.4/jstz.min.js"></script>
  	<!-- http://www.pinlady.net/PluginDetect/ -->
  	<script type="text/javascript" src="scripts/lib/javaDetect/scripts/PluginDetect_Java_Simple.js"></script>
  	<!-- https://plugins.jquery.com/cookie/ -->
  	<script src="scripts/lib/jquery.cookie.js" language="javascript"></script>

    <link rel="icon" href="images/NB_icon.png" />
    <title>Nexus Login</title> 
    
   	<script> 
   		
   		<!-- include in this manner instead of in a meta link so that php code inside this file will resolve prior to runtime -->
			<?php // include($techCheckInclude); ?>
    	
			$(document).ready(function () {
				$(document).on("keyup", function (event) {
    			if (event.which == 13) {
       			document.getElementById("login-form-submit").click();   
    			}
				});
				document.getElementById("localTz").value = getLocalTz();
				setSessionTimezone("");
				var loginForm = document.forms["login-form"];
				$( '#tech_check_control' ).click(function() {
	  			$( "#tech_check_display" ).toggle( "blind" ); 			
				});
				if (<?php echo $enrolled; ?>) {
					loginForm.elements['uid'].value = <?php echo var_export($enrolledUsername); ?>;
				}
				if (<?php echo $demoSession; ?>) {
					loginForm.elements['password'].disabled = true;
					loginForm.elements['password'].placeholder = "demo";
					loginForm.elements['login-remember'].checked = false;
					//document.getElementById("username-field-label").innerHTML = "Your Name";
					document.getElementById("username-field-label").innerHTML = "<?php echo(_('demo_name')); ?>";
					document.getElementById("username-instruction-field-label").innerHTML = "";
					document.getElementById("login-form-submit").innerHTML = "<span id='view-demo'></span><?php echo(_('view_demo')); ?>";
					document.getElementById("login-form-submit").onclick = demoValidateAndSubmit;
					document.getElementById("password-form-submit").onclick = "";
					document.getElementById("username-form-submit").onclick = "";
					document.getElementById("login-module-name").innerHTML = "Web Meet Demo";
					document.getElementById("network-name").innerHTML = "<?php echo $networkName; ?> <?php echo(_('demo')); ?>";
					document.getElementById("social-logins").style.display = "none";
				}
				if (<?php echo $guestPass; ?>) {
					//techCheck();  
				}
				if (<?php echo $remembered; ?>) {
					loginForm.elements['uid'].value = "remembered";
					loginForm.elements['password'].value = "passthru1";
					loginForm.elements['login-remember'].checked = false;
					document.getElementById("login-form-submit").click();
				} else if (<?php echo $xferred; ?>){
					loginForm.elements['uid'].value = "<?php echo $xferUsername; ?>";
					loginForm.elements['password'].value = "passthru1";
					document.getElementById("login-form-submit").click();					
				}
			});

		</script>
		
		<script type="text/javascript">(function() {var walkme = document.createElement('script'); walkme.type = 'text/javascript'; walkme.async = true; walkme.src = 'https://cdn.walkme.com/users/ab3d27eee206468794b47885dfc2df46/walkme_ab3d27eee206468794b47885dfc2df46_https.js'; var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(walkme, s); window._walkmeConfig = {smartLoad:true}; })();</script> 
		
		<style>
			// override some default techCheck.php styles 
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
      	
				<?php
				// Toggle on CFCHT in prod, for now
				if ($cleanNetworkId == 'ed787a92') { ?>
      		<span class="controls" style="float:right;padding-bottom:10px;margin-top:30px;">
	      		<b>Don't have<br/>an account?<br/></b>
      			<!-- TODO - make this invitation dynamic -->
      			<a href="<?php echo Utilities::getHttpPath(); ?>/enroll.php?invitation=<?php echo("66662d1f-24c3-4c89-b974-3afaa2494eb4"); ?>" style="color:#d27b4b;text-decoration:none;">Enroll</a>
      		</span>				
				<?php } else { ?>
      		<span id="walkme-login-anchor" class="controls" style="float:right;padding-bottom:10px;margin-top:30px;">
	      		<a href="http://northbridgetech.org/downloads/Whitepaper_NexusWebMeet.pdf" style="color:#d27b4b;text-decoration:none;" target="_blank"><?php echo _("About"); ?></a> | 
      			<a href="<?php echo Utilities::getSupportUrl(); ?>" style="color:#d27b4b;text-decoration:none;" target="_blank"><?php echo _("Support"); ?></a>
      		</span>
      	<?php } ?>
      </div>


			<div class="frame"> 
				
			  <div class="loginColLeft">
			  	<?php include("scripts/noscript.php"); ?>		
			  	<p id="login-user-message" class="confirmation"><span class="<?php echo $cleanIcon; ?>" style="color:#007582;float:left;margin-right:5px;margin-bottom:30px;"></span><?php echo $cleanMessage; ?></span><?php echo ($cleanMessageLink); ?></p>

					<!-- This is a standard login, possibly in demo mode -->
					<?php if ($guestPass === "false") { ?>

						<form id="login-form" class="pure-form pure-form-stacked" action="modules/login/control/loginProcessor.php" method="post">
    					<span id="username-field-label"><?php echo(_("Username")); ?></span><span class="instruction form-instruction"><a href="javascript:void(0)" onclick="toggleFormDisplay('recover-username-form')"><span id="username-instruction-field-label"><?php echo _("I forgot"); ?></span></a></span>
       				<input class="form-input" name="uid" value="" maxlength="25" autofocus>	        		
       				<?php echo(_("Password")); ?><span class="instruction form-instruction"><a href="javascript:void(0)" onclick="toggleFormDisplay('recover-password-form')"><?php echo _("I forgot"); ?></a></span>
       			  <fieldset id="login-form-password">
       				  <input class="form-input" type="password" name="password" value="" maxlength="25"/>	
       				</fieldset>
       				<input id="localTz" name="timezone" type="hidden" value="">
       				<a id="login-form-submit" type="submit" class="pure-button pure-button-primary" style="width:94%;" href="javascript:void(0);" onclick="loginValidateAndSubmit();"><?php echo _("Sign In"); ?></a>
        			<!--<a id="remember-me-toggle" class="pure-button pure-button-secondary" onclick="toggleRememberCheckbox();" style="width:45%;" <?php echo($disabled);?> ><span id="fakeCheckBox" class="fa fa-square-o" style="color:#004d62;padding-right:4px;"></span> <?php echo _("Remember Me"); ?></a>-->
        			<input id="login-remember" name="login-remember" type="checkbox" style="visibility:hidden;" checked />      
        			<div id="social-logins"> 
    						<div class="or-separator">
	        				<span class="or-separator-label">OR</span>
     						</div>
        				<a class="pure-button pure-button-primary" href="<?php echo(htmlspecialchars($fbLoginUrl)); ?>" style="margin-top:15px;width:94%;height:37px;background-color: #3b5998 !important;"><span class="fa fa-facebook-square fa-2x" style="margin-left:10px;margin-top:-6px;"></span><span style="vertical-align:top;margin-left:20px;"><?php echo _("Sign In with"); ?> <b><?php echo _("Facebook"); ?></b></span></a><br/>
        				<a class="pure-button pure-button-primary" href="<?php echo($liLoginUrl); ?>" style="margin-top:15px;width:94%;height:37px;background-color: #0084bf !important;"><span class="fa fa-linkedin-square fa-2x" style="margin-left:0px;margin-top:-6px;"></span><span style="vertical-align:top;margin-left:20px;"><?php echo _("Sign In with"); ?> <b><?php echo _("LinkedIn"); ?></b></span></a>
        			</div>
     				</form>   			
     				<form id="recover-username-form" class="pure-form pure-form-stacked" style="display:none;" autocomplete="off" action="modules/login/control/recoverEnrollmentProcessor.php" method="post">
	     				<fieldset>
	     					<?php echo _("Recover Username"); ?>
     						<p style="font-size:90%;"><?php echo _("Please enter your email address and we will resend your username."); ?></p>
     						<?php echo _("Email"); ?>
     						<input class="form-input" type="email" name="email" value="">
     						<a id="username-form-submit" type="submit" class="pure-button pure-button-primary" style="width:45%;" href="javascript:void(0);" onclick="usernameValidateAndSubmit();" <?php echo($disabled);?> ><?php echo _("Recover Username"); ?></a>
     						<a class="form-instruction" href="javascript:void(0)" onclick="toggleFormDisplay('login-form')"><?php echo _("Return to Login"); ?></a>
     						<input type="hidden" name="network" value="<?php echo $cleanNetworkId; ?>">
     					</fieldset>
     				</form>
     				<form id="recover-password-form" class="pure-form pure-form-stacked" style="display:none;" autocomplete="off" action="modules/login/control/recoverPasswordProcessor.php" method="post">
	     				<fieldset>
	     					<?php echo _("Password Reset"); ?>
     						<p class="instruction"><?php echo _("Please enter your user id so we can email you a password reset link."); ?></p>
     						<?php echo(_("Username")); ?><span class="instruction form-instruction"><a href="javascript:void(0)" onclick="toggleFormDisplay('recover-username-form')"><?php echo _("I forgot"); ?></a></span>
     						<input class="form-input" type="text" name="uid" value="" maxlength="25">
     						<a id="password-form-submit" type="submit" class="pure-button pure-button-primary" style="width:45%;" href="javascript:void(0);" onclick="passwordValidateAndSubmit();" <?php echo($disabled);?> ><?php echo _("Reset Password"); ?></a>
     						<a class="form-instruction" href="javascript:void(0)" onclick="toggleFormDisplay('login-form')"><?php echo _("Return to Login"); ?></a>
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
	    					<span id="username-field-label">Your Meeting Display Name</span>
        				<input class="form-input" name="uid" value="" maxlength="25" style="width:100%;margin-bottom:10px !important;" autofocus>
						<!--
        				<span id="username-email-label">Email</span>
     					<input class="form-input" type="email" name="email" maxlength="50" style="width:100%;margin-bottom:20px !important;">
						-->
        				<a id="login-form-submit" class="pure-button pure-button-primary pure-button-disabled" style="width:100%;border-radius:6px;min-height:38px;" href="javascript:void(0);" onclick="guestValidateAndSubmit('<?php echo $cleanNetworkId; ?>', '<?php echo $cleanMeetingId; ?>');" >Fetching...</a>  
        				<input id="localTz" name="timezone" type="hidden" value="">  
						<input name="email" type="hidden" value="dummy@test.com">   	
                        <input name="mid" type="hidden" value="invalid">
             		<?php include(Utilities::getModulesRoot() . "/event/views/eventDetailSummary.php"); ?>	
     					</fieldset>
     				</form> 
      			<a id='tech_check_control' href='javascript:void(0);' style="display:none;"></a>
						<div id="tech_check_display" style="display:none;width:560px;">
							<?php include("modules/schedule/views/techCheckGuest.php"); ?>	
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
								}
     					}
     				</script>     		  		     		
     		<?php } ?>   			
     		</div>
     		
     		<div id="customization-area" class="loginColRight">
      		<span id="network-name" style="clear:right;float:right;text-align:right;margin-top:20px;"><?php echo $networkName; ?></span>
      		<span style="clear:right;float:right;margin-top:20px;"><img src="<?php echo Utilities::getPartnerImageRoot(); ?><?php echo $networkLogo; ?>" /></span>
      		<?php if ($cleanNetworkId === "2ab2f516") { ?>
      			<p style="clear:right;float:right;text-align:right;margin-top:20px;"><a href="http://www.idra.org/who-we-are/privacy-policy/" target="_blank" >IDRA Privacy Policy</a></p>
      			<p style="clear:right;float:right;text-align:right;margin-top:20px;"><a href="http://www.idra.org/who-we-are/idra-online-comment-and-discussion-policy/" target="_blank" >IDRA Online Comment and Discussion Policy</a></p>
      		<?php } ?>

     		</div>
      </div>
      
      <div class="footer" style="clear:both;position:relative;bottom:-40px;">
      	<?php include("nwmFooter.php"); ?>
			</div>
	
    </div><!-- container -->   

		<script>
			var stateObj = { foo: "bar" };
			history.pushState(stateObj, "", "login.php");
		</script>
       		  	
	</body>
</html>




