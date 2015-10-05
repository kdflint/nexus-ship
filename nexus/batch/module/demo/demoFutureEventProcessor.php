<?php

require_once("Util.php");
require_once(Util::getSrcRoot() . "/schedule/Event.php");

Event::updateFutureNowEvent();

exit(0);

?>