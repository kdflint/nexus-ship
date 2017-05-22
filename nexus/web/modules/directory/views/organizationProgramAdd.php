<form id="organization-form-program" class="pure-form" action="<?php echo(Utilities::getHttpPath()); ?>/modules/directory/control/organizationProgramProcessor.php" method="post" style="height:300px;">
	<fieldset>
		<label>Program Name(s)</label>
		<textarea name="name" rows="4" cols="70"></textarea> 
		<label>Full Program Description(s)</label>
		<textarea name="description" rows="4" cols="70"></textarea>
		<label>Who is Eligible to Participate</label>
		<textarea name="eligibility" rows="4" cols="70"></textarea>
		<label>What kind of services, programs or activities do you provide?</label>
		<textarea name="services" rows="4" cols="70"></textarea>
		<label>What does someone have to do to get involved?</label>
		<textarea name="involvement" rows="4" cols="70"></textarea>
		<label>Are you interested in partnering with others?</label>
		<textarea name="partner_interest" rows="4" cols="70"></textarea>
		<label>What kind of partners would you like to work with?</label>
		<textarea name="partner_kind" rows="4" cols="70"></textarea>
		<input type="hidden" name="org-name" value=""/>
		<input type="hidden" name="org-id" value=""/>
  </fieldset>
	<fieldset>
			<a id="organization-form-program-submit" class="pure-button button-menu" href="javascript:void(0)" onclick="organizationProgramValidateAndSubmit('organization-form-program');" style="float:right;background-color:#d27b4b;width:70px;font-size:90%;margin-top:-10px;color:#e6e6e6" >Add</a>
 			<a href="#close" style="float:right;margin-right:20px;">Cancel</a>
 	</fieldset>					
</form>
