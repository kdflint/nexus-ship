<?php

include("../model/pgDb.php");

$cache_life = '600'; //caching time, in seconds
$filemtime = @filemtime("../view/include/tmpResults/" . $_SESSION['defaultSearchId'] . ".php");  // returns FALSE if file does not exist

// only recreate default search results if it does not exist or is older than 5 minutes
if (!$filemtime or (time() - $filemtime >= $cache_life)){

	$cursor = pgDb::getGroupMembersByUserId($_SESSION['uidpk']);
	
	$fileId = Util::newUuid();
	$file = fopen("../view/include/tmpResults/" . $fileId . ".php","w") or die("Unable to open file!");
	
	fwrite($file, "<table cellpadding=\"2\">");	
	fwrite($file, "<tr><td colspan=\"3\" valign=\"top\"><a href=#>Workgroup: " . $_SESSION['groups']['1'] . "</a></td></tr>");	
	while ($row = pg_fetch_array($cursor)) {
		$disabled = "disabled";
		if (pgDb::isUserMessageEnabled($row['id'])) {
			$disabled = "";
		}
		fwrite($file, "<tr><td valign=\"top\"><input type=\"checkbox\" name=\"names[]\" value=\"" . $row['id'] . "::" . $row['fname'] . " " . $row['lname'] . "\" onchange=\"messageToFill()\" " . $disabled . " \></td><td valign=\"top\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" . $row['lname'] . ",&nbsp;" . $row['fname'] . "</td><td>" . $row['oname'] . "</td></tr>\n");
	
	}	
	fwrite($file, "</table>");
	
	$_SESSION['defaultSearchId'] = $fileId;
}
	
?>

