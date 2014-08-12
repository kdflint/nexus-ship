<ul>
	<li<?php if ($thisPage=="directory") echo " id=\"currentpage\""; ?>><a href="nexus.php?thisPage=directory">Directory</a></li>
	<!--<li<?php if ($thisPage=="forum") echo " id=\"currentpage\""; ?>><a href="nexus.php?thisPage=forum">Forum</a></li>-->
	<li<?php if ($thisPage=="forum") echo " id=\"currentpage\""; ?>><a href="../control/resetForumSession.php">Forum</a></li>
	<li<?php if ($thisPage=="chat") echo " id=\"currentpage\""; ?>><a href="nexus.php?thisPage=chat">Collaborate</a></li>
	<li<?php if ($thisPage=="profile") echo " id=\"currentpage\""; ?>><a href="nexus.php?thisPage=profile">Profile</a></li>
</ul>
