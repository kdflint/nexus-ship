<?php

require_once("control/profilePreProcessor.php");
$error = $testEmail = $testSms = "";

if(isset($_GET['error'])) {
	$error = $_GET['error'];
}

$testSms = $_SESSION['sms'];
$testEmail = $_SESSION['email'];

?>

<div id="profile-secondary" class="secondaryControlContainer">
	<a href='#openProfileOrg' onclick="" class="secondaryControl" title="Edit Organization"><span class='fa fa-university fa-lg' ></span></a>
</div>


<div id="profile-frame" style="height:520px;">
<form action="<?php echo(Utilities::getHttpPath()); ?>/modules/user/control/profileProcessor.php" method="post" id="profile-form" class="pure-form pure-form-aligned">
	<div class="profileBlock1">
			<p><b>Your Security</b><p>
			<div class="profileFormRow" style="top:0px;">
				<span class="profileCol1">Username:</span><span class="profileCol2"><?php echo($_SESSION['username']); ?></span>
			</div>
			<div class="profileFormRow" style="top:45px;">
 				<span class="profileCol1">First<span class="required"> *</span></span>
	 			<span class="profileCol2"><input type="text" size="22" name="fname" maxlength="25" required value="<?php echo($_SESSION['fname']);?>"/></span>
	 		</div>
			<div class="profileFormRow" style="top:90px;">
 				<span class="profileCol1">Last</span>
 				<span class="profileCol2"><input type="text" size="22" name="lname" maxlength="25" value="<?php echo($_SESSION['lname']); ?>" /></span>
 			</div>
			<div class="profileFormRow" style="top:135px;">
	 			<span class="profileCol1">Reset Password</span>
	 			<span class="profileCol2"><input type="password" size="22" name="password1" title="7-25 characters. Must contain at least 1 digit."/></span>
	 		</div>
			<div class="profileFormRow" style="top:180px;">
 				<span class="profileCol1">Confirm Password:</span>
 				<span class="profileCol2"><input type="password" size="22" name="password2"/></span>
 			</div>
			<div style="margin-left:20px;margin-top:5px;display:none">
	 			A few words about you:
	 			<textarea maxlength="250" rows="4" cols="30" name="about" title="Optional, 1-250 characters. May contain accents and sentence punctuation."><?php echo $descr; ?></textarea>
	 		</div>
	</div>
	<div class="profileBlock2" style="margin-top:40px;">
		<span class="profileCol1">Your Avatar</span>
		<div style="margin-top:20px;">
			<iframe id="avatar-frame" src="<?php echo(Utilities::getForumHttpPath()); ?>/ucp.php?i=ucp_profile&mode=avatar" style="width:400px;border:0;margin:0;padding:0;position:absolute;top:20;height:400px;overflow:hidden;" scrolling="no"></iframe>
		</div>
	
	<div style="display:none;">
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
	</div>

	<div class="profileBlock3">
			<div class="profileFormRow" style="top:0px;">
				<span class="messageCol1"><b>Your Contact</b></span>
				<!--<span class="messageCol3"><a href="#" class="tooltip" title="Nexus users may send messages to this private number or address.">Enabled?</a></span>-->
				
 				<span class="messageCol3">
 					Publish?
 					<?php include("views/publishTip.html"); ?>
 				</span>
 			</div>
 
			<div class="profileFormRow" style="top:45px;left:15px;">
	 	 		<span class="messageCol1">Text Message:</span>
 				<span class="messageCol2"><input type="text" size="22" name="sms" value="<?php echo($_SESSION['sms']);?>" oninput="disableTestMessageLink('testMessageLinkSms')" /></span>
 				<!--<span class="messageCol3"><input type="checkbox" name="sms_status" <?php echo($sms_status); ?> onchange="disableTestMessageLink()" /></span>-->
 				<span class="messageCol3"><input type="checkbox" name="sms_public" <?php echo($sms_publish); ?> /></span>
 				<span class="messageCol4"><a id="testMessageLinkSms" href="javascript:post('testMessageLinkSms','<?php echo(Utilities::getHttpPath()); ?>/modules//user/control/messageProcessor.php',{testMessage:'true',phone:'<?php echo($testSms); ?>',email:''})">Test message</a></span>
 			</div>
 
			<div class="profileFormRow" style="top:90px;left:15px;">
	 			<span class="messageCol1">Email:</span>
 				<span class="messageCol2"><input type="text" size="22" name="email" value="<?php echo($_SESSION['email']);?>" oninput="disableTestMessageLink('testMessageLinkEmail')" 	/></span>
 				<!--<span class="messageCol3"><input type="checkbox" name="email_status" <?php echo($email_status); ?>  onchange="disableTestMessageLink()" /></span>-->
 				<span class="messageCol3"><input type="checkbox" name="email_public" <?php echo($email_publish); ?> /></span>
 				<span class="messageCol4"><a id="testMessageLinkEmail" href="javascript:post('testMessageLinkEmail','<?php echo(Utilities::getHttpPath()); ?>/modules//user/control/messageProcessor.php',{testMessage:'true',phone:'',email:'<?php echo($testEmail); ?>'})">Test message</a></span>
 			</div>

			<div class="profileFormRow" style="top:135px;left:15px;">
				<span class="messageCol1">Phone:</span>
 				<span class="messageCol2"><input type="text" size="22" name="phone" value="<?php echo($_SESSION['phone']);?>" /></span>
 				<!--<span class="messageCol3"><input type="checkbox" name="phone_status" disabled/></span>-->
 				<span class="messageCol3"><input type="checkbox" name="phone_public" <?php echo($phone_publish); ?> /></span>
				<a id="profile-form-submit" type="submit" class="pure-button pure-button-primary" style="float:right;" href="javascript:void(0);" onclick="profileValidateAndSubmit();">Update Your Profile</a>
 			</div>
 			
	</div>
	</form>
</div>
