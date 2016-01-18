<div class="mod_event" style="text-align:left;">

<?php

// If we don't have a nexusContext by now, we'll render and empty panel
if (isset($_SESSION['nexusContext'])) {
 switch($_SESSION['nexusContext']) {
 		case "NWM":
 			// unused right now
 			break;
 		case "ADV":
 			if (Utilities::getEnvName() == "prod") {
 				include(dirname(__FILE__) . "/views/eventListPending.php");
 			} else {
 				include(dirname(__FILE__) . "/views/eventList.php");
 			}
 			break;
 		case "PUB":
 			include(dirname(__FILE__) . "/mod_publicEvents.php");
 			break;
 		default: 		
 	}
}

?>
</div>