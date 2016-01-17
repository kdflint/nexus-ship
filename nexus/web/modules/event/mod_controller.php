<div class="mod_event" style="text-align:left;">

<?php

/* Note this somehow, where? Views may re-use html ids, but this should be safe because
they are only visible one at a time. So at any given time only unique ids are actually
rendered. Is there a way to enforce this? */

$session = FALSE;
$counter = 0;
while (!$session || $counter < 1000) {
	$session = (session_status() === PHP_SESSION_ACTIVE ? TRUE : FALSE);	
	$counter++;
}

if (isset($_SESSION['nexusContext'])) {
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
}

?>
</div>