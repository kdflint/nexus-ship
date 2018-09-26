	<div id="enrollmentConfirmation" class="modalDialog">
		<div style="">
			<a href="login.php?oid=<?php echo $_SESSION['orgUid']; ?>&logout=true" title="Skip" class="close">X</a>
			<p>Just one more step to complete your enrollment...</p>
			<p style="font-size:90%;">Please check your email for your enrollment confirmation notice. In that email is a confirmation code. Please enter it here.</p>
			<p style="font-size:90%;">We sent it to <?php echo($_SESSION['email']); ?>. It could take up to 15 minutes to arrive.</p>
			<?php include("modules/login/views/emailConfirmForm.php") ?>
		</div>
	</div>
	