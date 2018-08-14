<form id="organization-form-size-lang" class="pure-form modal-form" action="<?php echo(Utilities::getHttpPath()); ?>/modules/directory/control/organizationSizeLangProcessor.php" method="post">
	<fieldset>
		<label>Religious Affil (Ctrl-click to select multiple) </label>
		<select id="directory-form-select-affiliation-in" name="affiliation[]" style="height:330px;width:360px;" multiple>
	    <?php include(Utilities::getPartnerCustomRoot() . "/orgaffiliation-" . $_SESSION['networkId'] . ".html"); ?>
    </select>
  </fieldset>
	<fieldset>
		<label>Organizational Name</label>
 		<div class="form-field" style="margin-left:0px;">
			<input type="text" name="org-name" style="width:100%;" maxlength="100" placeholder="Organization Name" value=""/>
			<input type="hidden" name="org-id" value=""/>
		</div>
		<label>Congregation Size (select one) </label>
		<select id="directory-form-select-size-in" name="size" style="height:200px;width:100%;" size="6">
			<?php include(Utilities::getPartnerCustomRoot() . "/orgsize-" . $_SESSION['networkId'] . ".html"); ?>
		</select>
	</fieldset>
	<fieldset>
			<a id="organization-form-size-lang-submit" class="pure-button button-menu" href="javascript:void(0)" onclick="organizationSizeLangValidateAndSubmit('organization-form-size-lang');" style="float:right;background-color:#d27b4b;width:70px;font-size:90%;margin-top:-10px;color:#e6e6e6" >Add</a>
 			<a href="#close" style="float:right;margin-right:20px;">Cancel</a>
 	</fieldset>					
</form>

