<?php

echo "
<p><b>Uh oh.</b></p>
<p>" . $_SESSION['fname'] . ", we beg your pardon! Nexus has encountered a bad error :(</p>
<p>We are unable to connect you to the resource you requested.</p>
<p>We have already raised a support ticket on your behalf and have started working this out.</p>
<p>We will follow up with you right away at " . $_SESSION['email'] . ".</p>";

?>