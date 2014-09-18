<? 
session_start();
$error = "";

include '../control/enrollPreProcessor.php';

if(isset($_GET['error'])) {
	$error = $_GET['error'];
}
// Must start evey page load clean
// TODO - how to handle sticky form values?

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
    	<!--<img style="float:left;vertical-align:top;margin:20px;" src="http://chicagofaithandhealth.org/imgs/logo.png" height="88" width="365" border="0" alt="Logo: The Center for Faith and Community Health Transformations"/>-->
   		<img style="float:left;vertical-align:top;margin:20px;" <? echo $_SESSION['logo']; ?>  border="0" alt=""/>
   		
   		<p style="text-align:right;color:#4b5b6e;font-size:34px;margin-right:20px;"><b>Nexus</b><br/>
   		<i><span style="text-align:right;color:#4b5b6e;font-size:16px;margin-right:20px;">Building communities that build communities</span></i></p>
      <div class="shell">

			<div class="projectsContent"> 
				
				<div class="leftColumn" style="border:0px;background-color:#e6ebf0;padding:10px;height:360px;width:300px;box-shadow: 4px 4px 5px #cccccc;border-radius:15px;">	
					<p><b>Congratulations!</b></p>
					<p style="margin:10px;">You have been invited to enroll in the <b><? echo $_SESSION['groupName'] ?></b> hosted by <b><? echo $_SESSION['networkName'] ?></b></p>
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
				     	
      	<div class="rightColumn" style="border:0px;box-shadow: 0px 0px 0px #cccccc;border-radius:0px;top:-50px;"> 
							<p><b>&nbsp;</b></p>
							<div class="formLogin" style="border:thin solid #4b5b6e;padding:10px;border-radius:15px;">
								<form action="../control/enrollProcessor.php" method="post">
									<table cellpadding="5">
								  <tr><td>&nbsp;</td><td><? echo $error; ?></td></tr>
								  	<!--<p>You represent: <? echo $_SESSION['orgName'] ?></p>-->
										<tr><td>Choose your user name*</td><td><input class="passed" type="text" size="25" name="userid" value=""/></td></tr>
										<tr><td>Choose your password*</td><td><input class="passed" type="text" size="25" name="password" value=""/></td></tr>
										<tr><td>Your first name*</td><td><input class="passed" type="text" size="25" name="fname" value=""/></td></tr>
										<tr><td>Your last name</td><td><input class="passed" type="text" size="25" name="lname" value=""/></td></tr>
										<tr><td valign="top">Your organization*</td><td><textarea class="passed"  maxlength="100" rows="4" cols="30" name="orgname" value=""></textarea></td></tr>
										<!-- Some or all of above data may be already completed by the invitation. -->
										<!-- Even if an invitation sets up all the prior data, a new user has to enter an email for confirmation. -->
										<tr><td>Your email*</td><td><input class="passed" type="text" size="25" name="email" value=""/></td></tr>
										<tr><td colspan="2"><input type="submit" style="float:right;" value="Welcome!"/></td></tr>
									</table>
									<input type="hidden" name="invitation" value="<? echo $_GET['invitation']; ?>" />
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




