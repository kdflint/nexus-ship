#!/usr/bin/php

<?php

require_once("Util.php");
require_once(Util::getSrcRoot() . "/schedule/Event.php");

Event::updateDemoNowEvent();

exit(0);

?>