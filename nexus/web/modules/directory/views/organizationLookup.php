<div style="position:relative;">
<form id="organization-name-lookup" class="pure-form" action="<?php echo(Utilities::getHttpPath()); ?>/modules/directory/control/organizationNameProcessor.php" method="post">
	<fieldset style="position:relative;width:560px;">
 		<div class="form-field">
   		<input type="text" id="organization-name-autocomplete" type="text" name="org-name" style="width:100%;" rows="2" maxlength="100" placeholder="Add an Organization to your profile"/>
   		<!--<input type="hidden" id="organization-id-autocomplete" name="org-id" value="" />-->
		</div>
	</fieldset>
	<fieldset style="position:absolute;left:600px;width:200px;top:24px;">
		<div style="margin-top:0px;">
			<a id="organization-name-lookup-submit" class="pure-button button-menu" href="javascript:void(0)" onclick="organizatonNameValidateAndSubmit('organization-name-lookup');" style="float:right;background-color:#d27b4b;width:70px;font-size:90%;margin-top:-10px;color:#e6e6e6" >Add</a>
 			<a href="#close" style="float:right;margin-right:20px;">Cancel</a>
 	</div>
	</fieldset>					
</form>
</div>