<form id="organization-form-affiliation" class="pure-form modal-form" action="<?php echo(Utilities::getHttpPath()); ?>/modules/directory/control/organizationAffiliationProcessor.php" method="post">
	<fieldset>
		<label>Denomination Affil (Ctrl-click to select multiple) </label>
		<select id="directory-form-select-affiliation-in" name="affiliation[]" style="height:330px;width:360px;" multiple>
	    <?php include(Utilities::getPartnerCustomRoot() . "/orgaffiliation-" . $_SESSION['networkId'] . ".html"); ?>
    </select>
	</fieldset>
	<fieldset>
		<label>Organizational Name</label>
 		<div class="form-field" style="margin-left:0px;">
			<input type="text" name="org-name" style="width:95%;" maxlength="100" placeholder="Organization Name" value=""/>
			<input type="hidden" name="org-id" value=""/>
		</div>
		<label>Ethnicities Served (Ctrl-click to select multiple) </label>
		<select id="directory-form-select-ethnicity-in" name="ethnicity[]" style="height:200px;width:95%;" multiple>
	    <?php include(Utilities::getPartnerCustomRoot() . "/orgethnicity-" . $_SESSION['networkId'] . ".html"); ?>
    </select>
	</fieldset>					
	<fieldset>
			<a id="organization-form-affiliation-submit" class="pure-button button-menu" href="javascript:void(0)" onclick="organizationAffiliationValidateAndSubmit('organization-form-affiliation');" style="float:right;background-color:#d27b4b;width:70px;font-size:90%;margin-top:-10px;color:#e6e6e6" >Add</a>
 			<a href="#close" style="float:right;margin-right:20px;">Cancel</a>
 	</fieldset>
</form>