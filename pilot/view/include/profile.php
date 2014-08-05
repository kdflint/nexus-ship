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

<p><b>You</b><p>
<hr/>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Username&nbsp;&nbsp;&nbsp;&nbsp;<? echo($_SESSION['username']); ?></p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="text" size="<? echo(strlen($_SESSION['fname'])); ?>" name="fname" value="<? echo($_SESSION['fname']);?>"/>
	<input type="text" size="<? echo(strlen($_SESSION['lname'])); ?>" name="lname" value="<? echo($_SESSION['lname']); ?>"/>

</p>

<p><b>Your Messaging</b><p>
<hr/>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Text&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" size="<? echo(strlen($_SESSION['sms'])); ?>" name="sms" value="<? echo($_SESSION['sms']);?>"/> <input type="checkbox" name="sms_status" <? echo($sms_status); ?> /><p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Email&nbsp;&nbsp;<input type="text" size="<? echo(strlen($_SESSION['email'])); ?>" name="email" value="<? echo($_SESSION['email']);?>"/> <input type="checkbox" name="email_status" <? echo($email_status); ?> /><p>
<p style="text-align:right;">
	<a href="javascript:post('../control/messageProcessor.php',{testMessage:'true',phone:'<? echo($testSms); ?>',email:'<? echo($testEmail); ?>'})">
	Send yourself a test message
	</a>
</p>


<!--
TODO: turn into link
	<form action="../control/messageProcessor.php" method="post">
   <input type="hidden" name="phone" value=<? echo $_SESSION['sms']; ?>/>
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="Test Message"/>
	</form>
-->

<p><b>Your Organizations</b><p>
<hr/>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<? echo $_SESSION['orgName'];?></p>

<p><b>Your Collaborations</b><p>
<hr/>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>

<p><b>Your Network</b><p>
<hr/>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<? echo $_SESSION['networkName']; ?> (<? echo $count; ?> affiliates)</br><p>
<p style="text-align:right;"><? echo $error; ?></p>
<input style="float: right;" type="submit" value="Update Your Profile"/>
</form>
