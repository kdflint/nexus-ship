<form id="organization-form-basic" class="pure-form modal-form" action="<?php echo(Utilities::getHttpPath()); ?>/modules/directory/control/organizationBasicProcessor.php" method="post" style="display:block;">
	<fieldset>
		<label>Organizational Basics</label>
 		<div class="form-field">
			<input type="text" name="org-name" style="width:100%;" maxlength="100" placeholder="Organization Name" value=""/>
			<input type="hidden" name="org-id" value=""/>
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
	<fieldset>
		<label>Primary Location</label>
		<div id="organization-form-basic-faddress-readonly" class="form-field" style="display:none;">
			<span id="faddress-body"></span>
			<p>Update address using fields below:</p>
		</div>
		<input type="hidden" name="require-address" value="true"/>
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
	</fieldset>					
	<fieldset>
		<a id="organization-form-basic-submit" class="pure-button button-menu" href="javascript:void(0)" onclick="organizationBasicValidateAndSubmit('organization-form-basic');" style="float:right;background-color:#d27b4b;width:70px;font-size:90%;margin-top:-10px;color:#e6e6e6" >Add</a>			
		<a href="#close" style="float:right;margin-right:20px;">Cancel</a>
 	</fieldset>
</form>
