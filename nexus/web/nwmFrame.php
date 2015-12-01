				<div class="loginColLeft" style="width:80%;">
			  	<noscript>
			  		<p><span class="fa fa-exclamation-triangle fa-2x" style="color:#d27b4b;float:left;margin-right:5px;"></span>To use Nexus it is necessary to enable JavaScript.</p>
			  		<p>Here are the <a href="http://www.enable-javascript.com" target="_blank"> instructions how to enable JavaScript in your web browser</a></p>
			  	</noscript>					
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
					
					<div id="fatalError" style="display:none;">
						<?php include("modules/error/views/error.php"); ?>
					</div>

      	</div>
      	
      	<div class="loginColRight" style="width:20%;">
      		<span style="clear:right;float:right;text-align:right;margin-top:20px;"><?php echo $_SESSION['orgName']; ?></span>   
      		<span style="clear:right;float:right;margin-top:20px;"><img src="<?php echo(Utilities::getPartnerImageRoot()); ?><?php echo $_SESSION['logo']; ?>" /></span>   
      		<div id="profile_display" style="display:none;">
						<?php include("modules/user/views/profile.html"); ?>	
					</div>	
      	</div>