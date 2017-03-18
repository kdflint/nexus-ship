<form id="organization-form-filters" class="pure-form" action="<?php echo(Utilities::getHttpPath()); ?>/modules/directory/control/directoryFilterProcessor.php" method="post">
	<fieldset style="position:relative;width:390px;">
		<label>Organization Focus (Ctrl-click to select multiple) </label>
		<select id="directory-form-select-specialty-in" name="specialty" style="height:400px;width:360px;" multiple>
	    <?php include(Utilities::getPartnerCustomRoot() . "/orgfocus-" . $_SESSION['networkId'] . ".html"); ?>
    </select>
	</fieldset>
	<fieldset style="position:absolute;left:430px;width:390px;top:16px;">
		<label>Organization Type (select one) </label>
		<select id="directory-form-select-type-in" name="type">
			<?php include(Utilities::getPartnerCustomRoot() . "/orgtype-" . $_SESSION['networkId'] . ".html"); ?>
		</select>

		<div style="margin-top:180px;">
			<a id="organization-form-filter-submit" class="pure-button button-menu" href="javascript:void(0)" onclick="organizationFilterValidateAndSubmit('organization-form-basic');" style="float:right;background-color:#d27b4b;width:70px;font-size:90%;margin-top:-10px;color:#e6e6e6" >Add</a>
 			<a href="#close" style="float:right;margin-right:20px;">Cancel</a>
 	</div>
	</fieldset>					
</form>