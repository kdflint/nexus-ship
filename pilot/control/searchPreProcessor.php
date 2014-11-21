<?php

include("../model/pgDb.php");

$stickyString = $_SESSION['stickyForm']['string'];
$stickyTopic = $_SESSION['stickyForm']['topic'];
$stickyScope = $_SESSION['stickyForm']['scope'];
$stickyType = $_SESSION['stickyForm']['type'];
$stickyCount = $_SESSION['stickyForm']['resultCount'];

$groupChecked = !strcmp($stickyScope, "group") || !strcmp($stickyScope, "") ? "checked" : "";
$networkChecked = !strcmp($groupChecked, "checked") ? "" : "checked";

unset($_SESSION['stickyForm']);

$cache_life = '600'; //caching time, in seconds
$filetime_search = @filemtime("../view/include/tmpResults/" . $_SESSION['defaultSearchId'] . ".php");  // returns FALSE if file does not exist

// only recreate default search results if it does not exist or is older than 5 minutes
//if (!$filetime_search or (time() - $filetime_search >= $cache_life)){
if (true) {

	$cursor = pgDb::getGroupMembersByUserId($_SESSION['uidpk']);
	
	$fileId = Util::newUuid();
	$file = fopen("../view/include/tmpResults/" . $fileId . ".php","w") or die("Unable to open file!");
	
	fwrite($file, "<table cellpadding=\"2\">");	
	fwrite($file, "<tr><td colspan=\"3\" valign=\"top\"><a href=#>Workgroup: " . reset($_SESSION['groups']) . "</a></td></tr>");	
	while ($row = pg_fetch_array($cursor)) {
		$disabled = "disabled";
		if (pgDb::isUserMessageEnabled($row['id'])) {
			$disabled = "";
		}
		fwrite($file, "<tr><td valign=\"top\"><input type=\"checkbox\" name=\"names[]\" value=\"" . $row['id'] . "::" . $row['fname'] . " " . $row['lname'] . "\" onchange=\"messageToFill()\" " . $disabled . " \></td><td valign=\"top\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 		<a href=\"javascript:void(0)\" style=\"font-size:12px;font-weight:normal;\" onclick=\"showUser(" . $row['id'] . ")\">" . $row['lname'] . ",&nbsp;" . $row['fname'] . "</a></td><td>" . $row['oname'] . "</td></tr>\n");	
	}	
	fwrite($file, "</table>");
	
	$_SESSION['defaultSearchId'] = $fileId;
}

$filetime_specialty = @filemtime("../view/include/tmpSpecialty/" . $_SESSION['networkId'] . ".html"); 

if (!$filetime_specialty or (time() - $filetime_specialty >= $cache_life)){
	// TODO - fill in
}
	
?>

