<ul>
	<li<?php if ($thisPage=="directory") echo " id=\"currentpage\""; ?>><a href="nexus.php?thisPage=directory">Directory</a></li>
	<li<?php if ($thisPage=="profile") echo " id=\"currentpage\""; ?>><a href="nexus.php?thisPage=userDetail">My Profile</a></li>
	<li<?php if ($thisPage=="profile") echo " id=\"currentpage\""; ?>><a href="nexus.php?thisPage=organizationDetail">My Organizations</a></li>
	<li<?php if ($thisPage=="profile") echo " id=\"currentpage\""; ?>><a href="nexus.php?thisPage=">My Workgroups</a></li>
</ul>
