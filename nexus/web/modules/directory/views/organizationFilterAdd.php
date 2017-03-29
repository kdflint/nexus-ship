<form id="organization-form-filters" class="pure-form" action="<?php echo(Utilities::getHttpPath()); ?>/modules/directory/control/organizationFilterProcessor.php" method="post">
	<fieldset style="position:relative;width:390px;">
		<label>Organization Focus (Ctrl-click to select multiple) </label>
		<select id="directory-form-select-specialty-in" name="specialty[]" style="height:400px;width:360px;" multiple>
	    <?php include(Utilities::getPartnerCustomRoot() . "/orgfocus-" . $_SESSION['networkId'] . ".html"); ?>
    </select>
	</fieldset>
	<fieldset style="position:absolute;left:430px;width:390px;top:16px;">
		<label>Organizational Name</label>
 		<div class="form-field" style="margin-left:0px;">
 			<?php 
 				$readonly = "";
 				if (isset($_SESSION['tmp_orgeditname']) && isset($_SESSION['tmp_orgeditid'])) { 
 					$readonly = "readonly";
 				}
 			?>
			<input type="text" name="org-name" style="width:100%;" maxlength="100" placeholder="Organization Name" <?php echo($readonly); ?> value="<?php echo($_SESSION['tmp_orgeditname']); ?>"/>
			<input type="hidden" name="org-id" value="<?php echo($_SESSION['tmp_orgeditid']); ?>"/>
		</div>
		<label>Organization Type (select one) </label>
		<select id="directory-form-select-type-in" name="type">
			<option value="0" >------------</option>	
			<?php include(Utilities::getPartnerCustomRoot() . "/orgtype-" . $_SESSION['networkId'] . ".html"); ?>
		</select>
		<div style="margin-top:180px;">
			<a id="organization-form-filters-submit" class="pure-button button-menu" href="javascript:void(0)" onclick="organizationFilterValidateAndSubmit('organization-form-filters');" style="float:right;background-color:#d27b4b;width:70px;font-size:90%;margin-top:-10px;color:#e6e6e6" >Add</a>
 			<a href="#close" style="float:right;margin-right:20px;">Cancel</a>
 	</div>
	</fieldset>					
</form>