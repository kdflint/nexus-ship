				<div class="frameColLeft">
					<?php include("scripts/noscript.php"); ?>				
					<div id="reserveList" style="display:block;">
						<div id="schedule_display">
							<?php include("modules/schedule/views/reservationsList.php"); ?>
						</div>
					</div>
					
					<div id="userList" style="display:none;">
						<div id="add_user_display" style="display:none;">
							<?php include("modules/user/views/userAdd.php"); ?>	
						</div>
						<div id="user_display">
							<?php include("modules/user/views/userList.php"); ?>
						</div>
					</div>
					
					<div id="recordList" style="display:none;">
						<?php include("modules/schedule/views/reservationsListRecorded.php"); ?>
					</div>
					
					<div id="fatalError" style="display:none;">
						<?php include("modules/error/views/error.php"); ?>
					</div>

      	</div>
      	
      	<div class="frameColRight">
      		<?php if ($_SESSION['environment'] != "prod") { ?>
					<form id="language-form-1">
						<span style="clear:right;float:right;margin-top:5px;font-size:90%;margin-right:-10px;">
       				<select id="language-form-lang" name="language" style="width:160px;vertical-align:middle;text-align:left;" onchange="resetSessionLanguage(this.value);">
      					<option value="xx" selected><?php echo _("Select Language"); ?></option>
        				<option value="en"><?php echo _("English"); ?></option>
        				<option value="es"><?php echo _("Spanish"); ?></option>
      				</select>
      			</span>
					</form>
					<?php } ?>
      		<span style="clear:right;float:right;text-align:right;margin-top:20px;padding-left:10px;"><?php echo $_SESSION['orgName']; ?></span>   
      		<span style="clear:right;float:right;margin-top:20px;"><img src="<?php echo(Utilities::getPartnerImageRoot()); ?><?php echo $_SESSION['logo']; ?>" /></span>   
      		<div id="profile_display" class="profile_display" style="display:none;">
						<?php include("modules/user/views/profile.php"); ?>	
					</div>	
      	</div>