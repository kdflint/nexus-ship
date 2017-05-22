<?php 

session_start();

require_once("../../../src/framework/Util.php");
require_once(Utilities::getSrcRoot() . "/user/User.php");

$cleanCode = "";
$success = "false";
$successUrl = Utilities::getHttpPath() . "/nexus.php?view=profile";
$errorUrl = Utilities::getHttpPath() . "/login.php?error=" . Utilities::RESET_ERROR;

// TODO - use this method in enroll
if (isset($_GET['resetCode']) && Utilities::validateUuid($_GET['resetCode'])) {
			$cleanCode = $_GET['resetCode'];
}

if ($cleanCode) {	
	$cursor = User::getUserPasswordResetActivityByUuid($cleanCode);
	if (!$cursor) {
		returnToLoginWithMessage(Utilities::RESET_ERROR);
	} else {
		$result = pg_fetch_array($cursor);
		if (isset($result['uidpk']) && isset($result['username']) && isset($result['id'])) {
			Utilities::setSession($result['username'], false, "undefined");
			//Utilities::setSession($result['username'], false, "America/Chicago");
			Utilities::setLogin($_SESSION['uidpk']);
			User::updateUserPasswordResetActivityById($result['id']);
			$success = "true";
		} else {
			returnToLoginWithMessage(Utilities::RESET_ERROR);
		}
	}
} else {
	returnToLoginWithMessage(Utilities::RESET_ERROR);
}

function returnToLoginWithMessage($message) {
	header("location:" . Utilities::getHttpPath() . "/login.php?error=" . $message);
	exit(0);
}

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">
<html>
  <head>
    <script src="../../../scripts/nexus.js" language="javascript"></script>
  	<script src="//cdnjs.cloudflare.com/ajax/libs/jstimezonedetect/1.0.4/jstz.min.js"></script>
  </head>
  <body>
  	<script>
			// Must get local timezone from client, in this case after the reset work has been done.
			// Use ajax to update SESSION, then forward request to nexus
			if(<?php echo $success; ?>) {
				// This is a synchronous call
				setSessionTimezone("../../../");
				window.location = '<?php echo($successUrl); ?>';		
			} else { 
				window.location = '<?php echo($errorUrl); ?>';
			}
		</script>		
  </body>
</html>


