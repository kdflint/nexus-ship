<?php

require_once("control/profilePreProcessor.php");
$error = $testEmail = $testSms = "";

if(isset($_GET['error'])) {
	$error = $_GET['error'];
}

if (!strcmp($sms_status, "checked")) {
		$testSms = $_SESSION['sms'];
}

if (!strcmp($email_status, "checked")) {
		$testEmail = $_SESSION['email'];
}

?>

<div id="profile-secondary" class="secondaryControlContainer">
	<a href='#' onclick="alert('hello')" class="secondaryControl" title="Edit Profile"><span class='fa fa-pencil fa-lg' ></span></a>
</div>


<div id="profile-frame" style="height:420px;">
<form action="<?php echo(Utilities::getHttpPath()); ?>/modules/user/control/profileProcessor.php" method="post" id="profileForm" class="pure-form pure-form-aligned">
	<p><span style="color:#bf6030;margin-left:50px;"><?php echo $error; ?></span></p>
	<div style="position:relative;top:0px;width:430px;">
			<div style="margin-left:20px;margin-top:5px;">
				Username: <?php echo($_SESSION['username']); ?>
			</div>
			<div style="margin-left:20px;margin-top:5px;">
 				<a href="#" class="tooltip" title="1-25 characters. May contain letters, numbers, accents, &apos; or _">First</a>
	 			<input id="qwert"type="text" size="22" name="fname" value="<?php echo($_SESSION['fname']);?>"/>
	 		</div>
			<div style="margin-left:20px;margin-top:5px;">
 				<a href="#" class="tooltip" title="Optional, 1-25 characters. May contain letters, numbers, accents, &apos; or _">Last</a>
 				<input type="text" size="22" name="lname" value="<?php echo($_SESSION['lname']); ?>"/>
 			</div>
			<div style="margin-left:20px;margin-top:5px;">
	 			<a href="#" class="tooltip" title="Optional. 7-25 characters. Must contain at least 1 digit.">Reset Password</a>
	 			<input type="password" size="22" name="password1"/>
	 		</div>
			<div style="margin-left:20px;margin-top:5px;">
 				Confirm Password:
 				<input type="password" size="22" name="password2"/>
 			</div>
			<div style="margin-left:20px;margin-top:5px;display:none">
	 			<a href="#" class="tooltip" title="Optional, 1-250 characters. May contain accents and sentence punctuation.">A few words about you:</a>
	 			<textarea maxlength="250" rows="4" cols="30" name="about" ><?php echo $descr; ?></textarea>
	 		</div>
	</div>
	<div style="position:relative;top:-210px;left:460px;">
		<p style="margin-top:20px;"><b>Your Network</b><p>
		<!-- TODO - $count-1 is there because of a bug -->
		<p style="margin-left:20px;margin-top:5px;"><?php echo $_SESSION['networkName']; ?> (<?php echo $count-1; ?> affiliates)</br><p>
		
		<p><b>Your Organizations</b><p>
		<p style="margin-left:20px;margin-top:5px;"><?php echo $_SESSION['orgName'];?></p>
		
		<p style="margin-top:20px;"><b>Your Groups</b><p>
		<p style="margin-left:20px;margin-top:5px;">
		<?php 
			foreach ($_SESSION['groups'] as $key=>$val) {
    				echo $val . "</br>";
    	}
  	?> 
  	</br><p>
	
		<p style="margin-top:20px;"><b>Your Collaborations</b><p>
		<!--
		<div style="margin-left:20px;margin-top:5px;font-size:12px;border: 1px solid #4b5b6e;border-radius:15px;padding:10px;">
			<img src="image/comingSoon.jpg" width="57" height="57" style="float:right;"/>
			<p><b>For authorized Nexus pilot users</b></p>
			<p>Collaboration tracking will be available <b>early 2015</b></p>
		</div>
		-->
	</div>

	<div style="position:relative;width:100%;">
	<p><b>Your Messaging</b><p>
	<div style="margin-left:20px;">
		<table cellpadding="2">
			<tr>
				<td colspan="2">	
					<a id="testMessageLink" href="javascript:post('<?php echo(Utilities::getModulesRoot()); ?>/user/control/messageProcessor.php',{testMessage:'true',phone:'<?php echo($testSms); ?>',email:'<?php echo($testEmail); ?>'})">
					Send yourself a test message
					</a>
				</td>
 				<td><a href="#" class="tooltip" title="Nexus users may send messages to this private number or address.">Enabled?</a></td>
 				<td><a href="#" class="tooltip" title="This number or address will be published in the directory.">Publish?</a></td>
 			</tr>
 			<tr>
	 			<td>Text Message:</td>
 				<td><input type="text" size="22" name="sms" value="<?php echo($_SESSION['sms']);?>" onchange="disableTestMessageLink()" /></td>
 				<td><input type="checkbox" name="sms_status" <?php echo($sms_status); ?> onchange="disableTestMessageLink()" /></td>
 				<td><input type="checkbox" name="sms_public" <?php echo($sms_publish); ?> /></td>
 			</tr>
 			<tr>
	 			<td>Email:</td>
 				<td><input type="text" size="22" name="email" value="<?php echo($_SESSION['email']);?>" onchange="disableTestMessageLink()" /></td>
 				<td><input type="checkbox" name="email_status" <?php echo($email_status); ?>  onchange="disableTestMessageLink()" /></td>
 				<td><input type="checkbox" name="email_public" <?php echo($email_publish); ?> /></td>
 			</tr>
 			<tr>
	 			<td>Phone:</td>
 				<td><input type="text" size="22" name="phone" value="<?php echo($_SESSION['phone']);?>" /></td>
 				<td>&nbsp;</td>
 				<td><input type="checkbox" name="phone_public" <?php echo($phone_publish); ?> /></td>
 			</tr>
		</table>			
		<p><input style="float: right" type="submit" value="Update Your Profile"/></p>
	</div>
	</form>
</div>
</div>