<ul>
	<li<?php if ($thisPage=="directory") echo " id=\"currentpage\""; ?>><a href="nexus.php?thisPage=directory">Directory</a></li>
	<li<?php if ($thisPage=="forum") echo " id=\"currentpage\""; ?>><a href="nexus.php?thisPage=userDetail">Forum</a></li>
	<li<?php if ($thisPage=="collaborate") echo " id=\"currentpage\""; ?>><a href="nexus.php?thisPage=organizationDetail">Collaborate</a></li>
	<li<?php if ($thisPage=="profile") echo " id=\"currentpage\""; ?>><a href="nexus.php?thisPage=">Profile</a></li>
</ul>
