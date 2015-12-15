<div class="mod_event" style="text-align:left;">

<?php

/* Note this somehow, where? Views may re-use html ids, but this should be safe because
they are only visible one at a time. So at any given time only unique ids are actually
rendered. Is there a way to enforce this? */

if ((session_status() === PHP_SESSION_ACTIVE) && isset($_SESSION['nexusContext'])) {
 switch($_SESSION['nexusContext']) {
 		case "NWM":
 			// unused right now
 			break;
 		case "ADV":
 			include(dirname(__FILE__) . "/views/eventList.php");
 			break;
 		case "PUB":
 			include(dirname(__FILE__) . "/mod_publicEvents.php");
 			break;
 		default: 			
 	}
} else {
	include(dirname(__FILE__) . "/mod_publicEvents.php");
}

?>
</div>