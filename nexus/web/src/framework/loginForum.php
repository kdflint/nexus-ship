<?php

session_start();

require_once("Util.php");

echo("here"); exit(0);

if (Utilities::is_ajax()) {
	if (Utilities::isSessionValid() && $_SESSION['nexusContext'] == "ADV") {
		require_once(Utilities::getModulesRoot() . "/forum/forum_integration.php");
		$user->session_begin();
		Utilities::loginForum($user, $auth);
	}
}	

exit(0);

?>