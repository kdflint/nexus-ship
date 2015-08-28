<table style="border:2px solid #a6c3ce !important;background: #EDF0DE none repeat scroll 0% 0%;" class="pure-table">
	<tr>
  	<td>
  		<div class="user">
  			<span class="date">New</span><br/>
  			<span>User</span>
			</div>
		</td>
    <td>
			<form id="invite-form" class="pure-form" action="modules/user/control/userAddProcessor.php" method="post">
				<fieldset>
      		<div>
      			An enrollment packet will be emailed to this new user.
      		</div>
					<div style="margin-top:10px;">
	      		<input type="text" name="fname" style="width:48%;" maxlength="50" placeholder="First Name" required>
						<a class="pure-button pure-button-secondary" onclick="toggleAdminCheckbox();" style="width:48%;" ><span id="fakeCheckBox2" class="fa fa-square-o" style="color:#004d62;padding-right:4px;"></span> Administrator?</a>
        		<input id="new-user-admin" name="admin" type="checkbox" style="visibility:hidden;"/>
					</div>
					<div style="margin-top:10px;">
						<input class="form-input" type="email" style="width:97%" name="email" placeholder="Email" value="" required>
					</div>
				</fieldset>
			</form>  
		</td>
    <td>
    	<a href="javascript:void(0);" onclick="document.getElementById('add_user_control').click();" style="float:right;margin-right:6px;">Cancel</a><br/>
      <a id="invite-form-submit" class="pure-button button-menu" href="javascript:void(0)" onclick="inviteValidateAndSubmit();" style="float:right;background-color:#d27b4b;width:70px;font-size:90%;margin-top:45px;color:#e6e6e6">Enroll</a>
 		</td>
	</tr>
</table> 

<!--
Pretty sure this should be deleted
<?php if (!isset($_SESSION['timezone']) || $_SESSION['timezone'] == "undefined") { ?>
	<script>
	  showTimeZoneDisplay('tz-select');
	</script> 
<?php } ?>
-->

