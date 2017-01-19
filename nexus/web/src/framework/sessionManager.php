<?php

session_start();

require_once("Util.php");
		
if (Utilities::isSessionValid()) {
	if ($_SESSION['nexusContext'] === "ADV" && isset($_GET['forum'])) {
		require_once(Utilities::getModulesRoot() . "/forum/forum_integration.php");
		$user->session_begin();
		Utilities::loginForum($user, $auth);
	} else {
		Utilities::setSessionLastActivity();
	}
}
	
?>

