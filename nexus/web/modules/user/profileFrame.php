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
	<!--<a href='#' onclick="alert('hello')" class="secondaryControl" title="Edit Profile"><span class='fa fa-pencil fa-lg' ></span></a>-->
</div>


<div id="profile-frame" style="height:520px;">
<form action="<?php echo(Utilities::getHttpPath()); ?>/modules/user/control/profileProcessor.php" method="post" id="profileForm" class="pure-form pure-form-aligned">
	<div class="profileBlock1">
			<!--<p style="color:#bf6030;">Error message that is fairly long, like a complete sentence.<?php echo $error; ?></p>-->
			<p><b>Your Security</b><p>
			<div class="profileFormRow" style="top:0px;">
				<span class="profileCol1">Username:</span><span class="profileCol2"><?php echo($_SESSION['username']); ?></span>
			</div>
			<div class="profileFormRow" style="top:45px;">
 				<span class="profileCol1"><a href="#" class="tooltip" title="1-25 characters. May contain letters, numbers, accents, &apos; or _">First</a></span>
	 			<span class="profileCol2"><input type="text" size="22" name="fname" value="<?php echo($_SESSION['fname']);?>"/></span>
	 		</div>
			<div class="profileFormRow" style="top:90px;">
 				<span class="profileCol1"><a href="#" class="tooltip" title="Optional, 1-25 characters. May contain letters, numbers, accents, &apos; or _">Last</a></span>
 				<span class="profileCol2"><input type="text" size="22" name="lname" value="<?php echo($_SESSION['lname']); ?>"/></span>
 			</div>
			<div class="profileFormRow" style="top:135px;">
	 			<span class="profileCol1"><a href="#" class="tooltip" title="Optional. 7-25 characters. Must contain at least 1 digit.">Reset Password</a></span>
	 			<span class="profileCol2"><input type="password" size="22" name="password1"/></span>
	 		</div>
			<div class="profileFormRow" style="top:180px;">
 				<span class="profileCol1">Confirm Password:</span>
 				<span class="profileCol2"><input type="password" size="22" name="password2"/></span>
 			</div>
			<div style="margin-left:20px;margin-top:5px;display:none">
	 			<a href="#" class="tooltip" title="Optional, 1-250 characters. May contain accents and sentence punctuation.">A few words about you:</a>
	 			<textarea maxlength="250" rows="4" cols="30" name="about" ><?php echo $descr; ?></textarea>
	 		</div>
	</div>
	<div class="profileBlock2">
		<p><b>Your Network</b><p>
		<!--TODO - $count-1 is there because of a bug-->
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
	  </p>	
	</div>

	<div class="profileBlock3">
			<p><b>Your Messaging</b> | <a id="testMessageLink" href="javascript:post('<?php echo(Utilities::getHttpPath()); ?>/modules//user/control/messageProcessor.php',{testMessage:'true',phone:'<?php echo($testSms); ?>',email:'<?php echo($testEmail); ?>'})">Send yourself a test message</a></p>

			<div class="profileFormRow" style="top:0px;">
				<span class="messageCol3"><a href="#" class="tooltip" title="Nexus users may send messages to this private number or address.">Enabled?</a></span>
 				<span class="messageCol4"><a href="#" class="tooltip" title="This number or address will be published in the directory.">Publish?</a></span>
 			</div>
 
			<div class="profileFormRow" style="top:45px;">
	 	 		<span class="messageCol1">Text Message:</span>
 				<span class="messageCol2"><input type="text" size="22" name="sms" value="<?php echo($_SESSION['sms']);?>" onchange="disableTestMessageLink()" /></span>
 				<span class="messageCol3"><input type="checkbox" name="sms_status" <?php echo($sms_status); ?> onchange="disableTestMessageLink()" /></span>
 				<span class="messageCol4"><input type="checkbox" name="sms_public" <?php echo($sms_publish); ?> /></span>
 			</div>
 
			<div class="profileFormRow" style="top:90px;">
	 			<span class="messageCol1">Email:</span>
 				<span class="messageCol2"><input type="text" size="22" name="email" value="<?php echo($_SESSION['email']);?>" onchange="disableTestMessageLink()" 	/></span>
 				<span class="messageCol3"><input type="checkbox" name="email_status" <?php echo($email_status); ?>  onchange="disableTestMessageLink()" /></span>
 				<span class="messageCol4"><input type="checkbox" name="email_public" <?php echo($email_publish); ?> /></span>
 			</div>

			<div class="profileFormRow" style="top:135px;">
				<span class="messageCol1">Phone:</span>
 				<span class="messageCol2"><input type="text" size="22" name="phone" value="<?php echo($_SESSION['phone']);?>" /></span>
 				<span class="messageCol3"><input type="checkbox" name="phone_status" disabled/></span>
 				<span class="messageCol4"><input type="checkbox" name="phone_public" <?php echo($phone_publish); ?> /></span>
				<p style="margin-right:40px;"><input style="float:right" type="submit" value="Update Your Profile"/></p>
 			</div>
 			
	</div>
	</form>
</div>
