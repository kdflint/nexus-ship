<form id="organization-form-filters" class="pure-form modal-form" action="<?php echo(Utilities::getHttpPath()); ?>/modules/directory/control/organizationFilterProcessor.php" method="post">
	<fieldset>
		<label>Organization Focus (Ctrl-click to select multiple) </label>
		<select id="directory-form-select-specialty-in" name="specialty[]" style="height:330px;width:360px;" multiple>
	    <?php include(Utilities::getPartnerCustomRoot() . "/orgfocus-" . $_SESSION['networkId'] . ".html"); ?>
    </select>
	</fieldset>
	<fieldset>
		<label>Organizational Name</label>
 		<div class="form-field" style="margin-left:0px;">
			<input type="text" name="org-name" style="width:100%;" maxlength="100" placeholder="Organization Name" value=""/>
			<input type="hidden" name="org-id" value=""/>
		</div>
		<label>Organization Type (select one) </label>
		<select id="directory-form-select-type-in" name="type">
			<option value="0" >------------</option>	
			<?php include(Utilities::getPartnerCustomRoot() . "/orgtype-" . $_SESSION['networkId'] . ".html"); ?>
		</select>
	</fieldset>					
	<fieldset>
		<a id="organization-form-filters-submit" class="pure-button button-menu" href="javascript:void(0)" onclick="organizationFilterValidateAndSubmit('organization-form-filters');" style="float:right;background-color:#d27b4b;width:70px;font-size:90%;margin-top:-10px;color:#e6e6e6" >Add</a>
		<a href="#close" style="float:right;margin-right:20px;">Cancel</a>
 	</fieldset>
</form>