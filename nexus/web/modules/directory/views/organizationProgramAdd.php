<form id="organization-form-program" class="pure-form modal-form" action="<?php echo(Utilities::getHttpPath()); ?>/modules/directory/control/organizationProgramProcessor.php" method="post">
	<label>Program Information (scroll down)</label>
	<fieldset style="overflow-x:hidden;overflow-y:auto;height:275px;font-size:90%;margin-top:10px;width:100%;">
		<label>Program Name(s)</label>
		<textarea name="name" rows="1" style="width:95%;" maxlength="50"></textarea> 
		<label>Full Program Description(s)</label>
		<textarea name="description" rows="3" style="width:95%;" maxlength="1000"></textarea>
		<label>Who is Eligible to Participate</label>
		<textarea name="eligibility" rows="3" style="width:95%;" maxlength="250"></textarea>
		<label>What kind of services, programs or activities do you provide?</label>
		<textarea name="services" rows="3" style="width:95%;" maxlength="1000"></textarea>
		<label>What does someone have to do to get involved?</label>
		<textarea name="involvement" rows="3" style="width:95%;" maxlength="250"></textarea>
		<label>Are you interested in partnering with others?</label>
		<textarea name="partner_interest" rows="1" style="width:95%;" maxlength="250"></textarea>
		<label>What kind of partners would you like to work with?</label>
		<textarea name="partner_kind" rows="3" style="width:95%;" maxlength="250"></textarea>
			
		<label>Is your facility accessible to people with disabilities as defined by the Americans with Disabilities Act (ADA)?</label>
		<input type="radio" name="ada" value="yes" style="margin:5px;">Yes <input type="radio" name="ada" value="no" style="margin:5px;">No

		<label>Hours of Operation</label>
		<textarea name="hours" rows="1" style="width:95%;" maxlength="50"></textarea>

		<input type="hidden" name="org-name" value=""/>
		<input type="hidden" name="org-id" value=""/>
  </fieldset>
	<fieldset></fieldset>
	<fieldset style="">
			<a id="organization-form-program-submit" class="pure-button button-menu" href="javascript:void(0)" onclick="organizationProgramValidateAndSubmit('organization-form-program');" style="float:right;background-color:#d27b4b;width:70px;font-size:90%;margin-top:-10px;color:#e6e6e6" >Add</a>
 			<a href="#close" style="float:right;margin-right:20px;">Cancel</a>
 	</fieldset>					
</form>
