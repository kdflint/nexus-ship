<form id="organization-form-basic" class="pure-form" action="<?php echo(Utilities::getHttpPath()); ?>/modules/directory/control/directoryProcessor.php" method="post">
	<fieldset style="position:relative;width:390px;">
		<label>Organizational Basics</label>
 		<div class="form-field">
 			<?php 
 				$readonly = "";
 				if (isset($_SESSION['tmp_orgeditname'])) { 
 					$readonly = "readonly";
 				}
 			?>
			<input type="text" name="org-name" style="width:100%;" maxlength="100" placeholder="Organization Name" <?php echo($readonly); ?> value="<?php echo($_SESSION['tmp_orgeditname']); ?>"/>
		</div>
    <div class="form-field">
	  	<input type="text" name="org-url" style="width:100%" maxlength="100" placeholder="Organization Web Site (http://)" >
		</div>
		<label style="margin-top:20px;">Primary Contact Information</label>
		<div class="form-field">
	  	<input type="text" name="org-contact-name" style="width:100%" maxlength="200" placeholder="Full Name" >
		</div>
		<div class="form-field">
	  	<input type="text" name="org-contact-title" style="width:100%" maxlength="50" placeholder="Title" >
		</div>
		<div class="form-field">
	  	<input type="text" name="org-contact-email" style="width:100%" maxlength="50" placeholder="Email" >
		</div>
		<div class="form-field">
	  	<input type="text" name="org-contact-phone" style="width:100%" maxlength="20" placeholder="Phone" >
		</div>
	</fieldset>
	<fieldset style="position:absolute;left:430px;width:390px;top:16px;">
		<label>Primary Location</label>
    <div class="form-field">
	  	<input type="text" name="org-street" style="width:100%" maxlength="50" placeholder="Street Address" >
		</div>
    <div class="form-field">
	  	<input type="text" name="org-city" style="width:100%" maxlength="50" placeholder="City" >
		</div>
    <div class="form-field">
			<select id="organization-form-country" name="org-country" style="width:208px;">
				<!-- TODO - swap over to this list once we get state data assembled-->
				<option value="AA" selected>Country</option>
				<!--<?php include(Utilities::getModulesRoot() . "/schedule/views/timeZoneCountryOptions.html"); ?>-->
				<option value="US">United States</option>
			</select>
			<select id="organization-form-countryStates" name="org-state" style="width:158px;">
				<option selected>State</option>
			</select>
		</div>
		<div style="margin-top:180px;">
			<a id="organization-form-basic-submit" class="pure-button button-menu" href="javascript:void(0)" onclick="organizationBasicValidateAndSubmit('organization-form-basic');" style="float:right;background-color:#d27b4b;width:70px;font-size:90%;margin-top:-10px;color:#e6e6e6" >Add</a>
 			<a href="#close" style="float:right;margin-right:20px;">Cancel</a>
 	</div>
	</fieldset>					
</form>