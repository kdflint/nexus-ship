<div class="mod_event" style="text-align:left;">

<?php

// If we don't have a nexusContext by now, we'll render and empty panel
if (isset($_SESSION['nexusContext'])) {
 switch($_SESSION['nexusContext']) {
 		case "NWM":
 			// unused right now
 			break;
 		case "ADV":
 			// unused right now
 			break;
 		case "PUB":
 			include(dirname(__FILE__) . "/mod_publicEvents.php");
 			break;
 		default: 		
 	}
}

?>
</div>