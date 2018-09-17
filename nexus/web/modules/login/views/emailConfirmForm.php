<form id="emailConfirmForm" class="pure-form" action="" method="">
	<fieldset>
	 	<div class="form-field">
			<!--<input name="email" style="width:100%;" maxlength="50" value="<?php echo $_SESSION['email']; ?>"/>-->
			<input name="confirm-code" style="width:80%;" maxlength="50" value="" placeholder="Confirmation Code"/>
 			<a id="" class="pure-button button-menu" href="javascript:void(0);" onclick="confirmEmail();" style="float:right;background-color:#d27b4b;width:70px;font-size:90%;margin-top:10px;color:#e6e6e6" >Confirm</a>		
			<p><a href="javascript:void(0)" onclick="if(typeof Formilla != 'undefined'){Formilla.initFormillaChat();}" title="Help" style="float:right;">Didn't get it? We can help...</a></p>
		</div>

	</fieldset>
</form>  
