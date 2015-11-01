<div class="mod_event" style="width:760px;font-size:110%;text-align:left;">

<?php

/* Note this somehow, where? Views may re-use html ids, but this should be safe because
they are only visible one at a time. So at any given time only unique ids are actually
rendered. Is there a way to enforce this? */

if ((session_status() === PHP_SESSION_ACTIVE) && isset($_SESSION['nexusContext'])) {
 switch($_SESSION['nexusContext']) {
 		case "NWM":
 			break;
 		case "ADV":
 			include(dirname(__FILE__) . "/views/eventList.php");
 			break;
 		default: 			
 	}
} else {
	echo "public view?" . $_SERVER['QUERY_STRING'];
	// LEFT OFF = setPluginSession??
	//include(dirname(__FILE__) . "/eventList.php");
}

?>
</div>