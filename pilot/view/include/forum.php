<?php

if (isset($_SESSION['forumSessionError']) && strcmp($_SESSION['forumSessionError'], "noError")) {
	echo "<p><b>Oops!</b> Something has gone wrong connecting you to your community forum.</p>";
	echo "<p>Would you please try closing and re-opening your browser window?</p>";
	echo "<p>If that does not work, please contact the support desk using the \"Report a Problem\" link so we can set things right.</p>";
	
} else {

?>

	<iframe src="http://northbridge.websitetoolbox.com/register/dologin?authtoken=<? echo($_SESSION['authtoken']); ?>" height="550" width="800"></iframe>

<? } ?>

<script>
	
	 function keepForumAlive() {
		 http_request = new XMLHttpRequest();
     http_request.open('GET', "http://northbridge.websitetoolbox.com/register/dologin?authtoken=<? echo($_SESSION['authtoken']); ?>");
     http_request.send(null);
	 };

	 function init() {
    	window.setInterval("keepForumAlive()", 60000);
	 }

	 window.onload = init;

</script>



