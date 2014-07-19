<!--<iframe src="http://northbridge.websitetoolbox.com/register/dologin?authtoken=<? echo($_SESSION['authtoken']); ?>" height="550" width="800"></iframe>-->
	
<?php
	
if (!strcmp($_SESSION['forumSessionError'], "true")) {
	echo "Something went wrong. Call someone.";
	echo $_SESSION['forumSessionError'];
	
} else {

?>

	<iframe src="http://northbridge.websitetoolbox.com/register/dologin?authtoken=<? echo($_SESSION['authtoken']); ?>" height="550" width="800"></iframe>

<? } ?>

