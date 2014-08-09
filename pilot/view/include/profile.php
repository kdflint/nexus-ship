<?
include '../control/profilePreProcessor.php';

$error = $testEmail = $testSms = "";

if(isset($_GET['error'])) {
	$error = $_GET['error'];
}

if (!strcmp($sms_status, "checked")) {
		$testSms = Util::stripPhone($_SESSION['sms']);
}

if (!strcmp($email_status, "checked")) {
		$testEmail = $_SESSION['email'];
}

?>

<form action="../control/profileProcessor.php" method="post">

<div class="leftColumn">
	<p><b>You</b><p>
	<div style="margin-left:20px;margin-top:5px;">
			<table cellpadding="5">
				<tr><td>Username:</td><td><? echo($_SESSION['username']); ?></td></tr>
 			<tr><td>First:</td><td>
	 			<input type="text" size="<? echo(strlen($_SESSION['fname'])); ?>" name="fname" value="<? echo($_SESSION['fname']);?>"/>
	 		</td></tr>
 			<tr><td>Last:</td><td>	 		
 				<input type="text" size="<? echo(strlen($_SESSION['lname'])); ?>" name="lname" value="<? echo($_SESSION['lname']); ?>"/>
 			</td></tr>
 			<tr><td>Password:</td><td><input type="text" size="" name="password" value="<? echo($_SESSION['password']); ?>"/></td></tr>
		</table>
	</div>

	<p><b>Your Messaging</b><p>
	<div style="margin-left:20px;">
		<table cellpadding="5">
			<tr>
				<td colspan="2">	
					<a id="testMessageLink" href="javascript:post('../control/messageProcessor.php',{testMessage:'true',phone:'<? echo($testSms); ?>',email:'<? echo($testEmail); ?>'})">
					Send yourself a test message
					</a>
				</td>
 				<td>Enabled?</td>
 			</tr>
 			<tr>
	 			<td>Text:</td>
 				<td><input type="text" size="22" name="sms" value="<? echo($_SESSION['sms']);?>" onchange="disableTestMessageLink()" /></td>
 				<td><input type="checkbox" name="sms_status" <? echo($sms_status); ?> onchange="disableTestMessageLink()" /></td>
 			</tr>
 			<tr>
	 			<td>Email:</td>
 				<td><input type="text" size="22" name="email" value="<? echo($_SESSION['email']);?>" onchange="disableTestMessageLink()" /></td>
 				<td><input type="checkbox" name="email_status" <? echo($email_status); ?>  onchange="disableTestMessageLink()" /></td>
 			</tr>
 			<tr><td colspan="2"><? echo $error; ?></td><td><input style="float: right;" type="submit" value="Update Your Profile"/></td></tr>
		</table>			
	</div>
	</form>
</div> <!-- leftColumn -->

<div class="rightColumnPlain">

	<p><b>Your Organizations</b><p>
	<p style="margin-left:20px;margin-top:5px;"><? echo $_SESSION['orgName'];?></p>
	

	<p style="margin-top:20px;"><b>Your Network</b><p>
	<p style="margin-left:20px;margin-top:5px;"><? echo $_SESSION['networkName']; ?> (<? echo $count-1; ?> affiliates)</br><p>

	
	<p style="margin-top:20px;"><b>Your Collaborations</b><p>
	<div style="margin-left:20px;margin-top:5px;font-size:12px;border: 1px solid #4b5b6e;border-radius:15px;padding:10px;">
		<img src="image/comingSoon.jpg" width="57" height="57" style="float:right;"/>
		<p><b>For authorized Nexus pilot users</b></p>
		<p>Collaboration tracking and workgroups will be available <b>October 2014</b></p>
	</div>
</div> <!-- rightColumn -->