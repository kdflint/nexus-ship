<div class="mod_directory" style="text-align:left;">

<?php

/* Note this somehow, where? Views may re-use html ids, but this should be safe because
they are only visible one at a time. So at any given time only unique ids are actually
rendered. Is there a way to enforce this? */

if (isset($_SESSION['nexusContext'])) {
//if (true) {
 switch($_SESSION['nexusContext']) {
 		case "NWM":
 			break;
 		case "ADV":
 			break;
 		case "PUB":
 			include(dirname(__FILE__) . "/mod_publicDirectory.php");
 			break;
 		default: 
 		    include(dirname(__FILE__) . "/mod_publicDirectory.php");
 	}
}

?>
</div>