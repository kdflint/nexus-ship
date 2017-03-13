<div style="position:relative;">
<form id="group-add" class="pure-form" action="<?php echo(Utilities::getHttpPath()); ?>/modules/directory/control/addNewGroupProcessor.php" method="post">
	<fieldset style="position:relative;width:560px;">
 		<div class="form-field">
   		<input type="text" id="group-name" type="text" name="group-name" style="width:100%;" rows="2" maxlength="100" placeholder="Create a New Group"/>
   		<p><input type="checkbox" id="group-public" name="group-public" /> Make group public-visible?<p>
   		<p style="font-size:90%;">Public-visible groups are enrolleable using your global public enroll link. Some group activity (forums, calendar, etc.) is visible on your public web site.</p>
   			<?php 
   			// TODO - make tooltip work
   			//include("publicGroupTip.html"); 
   			?>
		</div>
	</fieldset>
	<fieldset style="position:absolute;left:600px;width:200px;top:24px;">
		<div style="margin-top:0px;">
			<a id="group-add-submit" class="pure-button button-menu" href="javascript:void(0)" onclick="groupAddValidateAndSubmit();" style="float:right;background-color:#d27b4b;width:70px;font-size:90%;margin-top:-10px;color:#e6e6e6" >Add</a>
 			<a href="#close" style="float:right;margin-right:20px;">Cancel</a>
 	</div>
	</fieldset>					
</form>
</div>