<?php 
session_start();
$error = "";

require_once("../control/util.php");
require_once(Util::getAppRoot() . "control/enrollPreProcessor.php");

if(isset($_GET['error'])) {
	$error = $_GET['error'];
}
// Must start evey page load clean

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">
<html>
	
  <head>
  	<meta http-equiv="Content-type" content="text/html;charset=UTF-8">
    <link rel="stylesheet" href="style/style.css" type="text/css" />
    <script src="script/script.js" language="javascript"></script>
    <link rel="shortcut icon" href="image/northbridge-ico.png" />
    <title>Nexus | Enroll</title>
    
    <link rel="stylesheet" href="script/jquery-ui-1.11.1.custom/jquery-ui.css">
    <script src="script/jquery-ui-1.11.1.custom/external/jquery/jquery.js"></script>
		<script src="script/jquery-ui-1.11.1.custom/jquery-ui.js"></script>
		<script>$(function() {$( document ).tooltip();});</script>
		<style>label {display: inline-block;width: 5em;}</style>
		
  </head>
  
  <body>
    <div class="container">
   		<img style="float:left;vertical-align:top;margin:20px;" <?php echo $_SESSION['logo']; ?>  border="0" alt=""/>
   		
   		<p style="text-align:right;color:#4b5b6e;font-size:34px;margin-right:20px;"><b>Nexus</b><br/>
   		<i><span style="text-align:right;color:#4b5b6e;font-size:16px;margin-right:20px;">Building communities that build communities</span></i></p>
      <div class="shell">

			<div class="projectsContent"> 
				
				<div class="leftColumn" style="border:0px;background-color:#e6ebf0;padding:10px;height:360px;width:300px;box-shadow: 4px 4px 5px #cccccc;border-radius:15px;top:-30px;">	
					<p><b>Congratulations!</b></p>
					<p style="margin:10px;">You have been invited to enroll in the <b><?php echo $_SESSION['groupName'] ?></b> hosted by <b><?php echo $_SESSION['networkName'] ?></b></p>
					<p style="margin:10px;">This is your collaboration space, secure to your community of practice.</p>
					<p style="margin:10px;">These features will support the work you do every day to strengthen communities.</p>
					<ul>
						<li>Discussion forum</li>
						<li>Real-time chat and polls</li>
						<li>Calendar</li>
						<li>Group directory</li>
						<li>Private Text messaging</li>
						<li>Web conference room incl. whiteboard and screen share</li>
					</ul>
      	</div>
      				     	
      	<div class="rightColumn" style="border:0px;box-shadow: 0px 0px 0px #cccccc;border-radius:0px;top:-80px;"> 
							<p><b>&nbsp;</b></p>
							<div class="formLogin" style="border:thin solid #4b5b6e;padding:10px;border-radius:15px;">
								<form action="../control/enrollProcessor.php" method="post" id="enrollForm">
									<table cellpadding="5">
								  <tr><td>&nbsp;</td><td style="color:#bf6030;"><?php echo $error; ?></td></tr>
								  	<!--<p>You represent: <?php echo $_SESSION['orgName'] ?></p>-->
										<tr><td><a href="#" class="tooltip" title="7-25 characters. May contain letters, numbers, _">Choose your user name*</td><td><input class="passed" type="text" size="25" name="userid" value="<?php echo $stickyUserId; ?>"/></td></tr>
										<tr><td><a href="#" class="tooltip" title="7-25 characters. Must contain at least 1 digit.">Choose your password*</td><td><input class="passed" type="password" size="25" name="password1" value="<?php echo $stickyPassword1; ?>"/></td></tr>
										<tr><td>Confirm your password*</td><td><input class="passed" type="password" size="25" name="password2" value="<?php echo $stickyPassword2; ?>"/></td></tr>
										<tr><td><a href="#" class="tooltip" title="1-25 characters.  May contain letters, numbers, accents, &apos; or _">Your first name*</td><td><input class="passed" type="text" size="25" name="fname" value="<?php echo $stickyFname; ?>"/></td></tr>
										<tr><td><a href="#" class="tooltip" title="Optional. 1-25 characters.  May contain letters, numbers, accents, &apos; or _">Your last name</td><td><input class="passed" type="text" size="25" name="lname" value="<?php echo $stickyLname; ?>"/></td></tr>
										<tr><td valign="top"><a href="#" class="tooltip" title="2-100 characters. May contain letters, numbers, accents, spaces, &apos; or _">Your organization*</td><td><textarea class="passed"  maxlength="100" rows="4" cols="30" name="orgname" ><?php echo $stickyOrgName; ?></textarea></td></tr>
										<!-- Some or all of above data may be already completed by the invitation. -->
										<!-- Even if an invitation sets up all the prior data, a new user has to enter an email for confirmation. -->
										<tr><td>Your email*</td><td><input class="passed" type="text" size="25" name="email" value="<?php echo $stickyEmail; ?>"/></td></tr>
										<tr><td colspan="2"><input type="submit" style="float:right;" value="Enroll"/></td></tr>
									</table>
									<input type="hidden" name="invitation" value="<?php echo $inviteId; ?>" />
								</form>
							</div>									
				</div>
							

      </div>
      
      <div class="footer" style="position:absolute;top:500px;left:600px;right;color:#4b5b6e;font-size:18px;margin:20px;">
        <i>powered by</i>
    		<a href="http://northbridgetech.org/index.php"><img style="vertical-align:bottom;" src="http://northbridgetech.org/images/northbridge-logo.png" height="57" width="143" border="0" alt="NorthBridge Technology Alliance"/></a>
			</div>
      	
      </div><!--shell-->
    </div><!-- container -->         	
	</body>
	
</html>




