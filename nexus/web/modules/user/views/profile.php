<form id="profile-form" class="pure-form pure-form-stacked" style="font-size:80%" action="modules/user/control/profileProcessor.php" method="post">
	<?php echo _("First Name"); ?>
	<input name="fname" style="padding:0.2em 0.2em;width:100%;" maxlength="25" value="<?php echo $_SESSION['fname']; ?>" placeholder="<?php echo _("First Name"); ?>">	        		
	<?php echo _("Last Name"); ?>
	<input name="lname" style="padding:0.2em 0.2em;width:100%;" maxlength="25"  value="<?php echo $_SESSION['lname']; ?>" placeholder="<?php echo _("Last Name"); ?>">	 
	<?php echo _("Email"); ?>
	<input name="email" style="padding:0.2em 0.2em;width:100%;" maxlength="50" value="<?php echo $_SESSION['email']; ?>" placeholder="<?php echo _("Email"); ?>">	 
	<?php echo _("Reset Password"); ?>
	<input name="password1" type="password" minlength="7" maxlength="25" style="padding:0.2em 0.2em;width:100%;">
	<?php echo _("Confirm Password"); ?>
	<input name="password2" type="password" minlength="7" maxlength="25" style="padding:0.2em 0.2em;width:100%;">
	<a id="profile-form-submit" type="submit" class="pure-button button-menu" style="float:right;background-color:#d27b4b;width:70px;margin-top:10px;color:#e6e6e6" href="javascript:void(0);" onclick="profileValidateAndSubmit();"><?php echo _("Update"); ?></a>
  <a href="javascript:void(0);" onclick="resetProfileForm();" style="float:left;margin-right:10px;margin-top:20px;font-size:110%;"><?php echo _("Reset"); ?></a>
</form>  
