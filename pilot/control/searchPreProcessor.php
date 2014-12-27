<?php

require_once($_SESSION['appRoot'] . "model/pgDb.php");

$stickyString = $_SESSION['stickyForm']['string'];
$stickyTopic = $_SESSION['stickyForm']['topic'];
$stickyScope = $_SESSION['stickyForm']['scope'];
$stickyType = $_SESSION['stickyForm']['type'];
$stickyCount = $_SESSION['stickyForm']['resultCount'];

$groupChecked = !strcmp($stickyScope, "group") || !strcmp($stickyScope, "") ? "checked" : "";
$networkChecked = !strcmp($groupChecked, "checked") ? "" : "checked";

unset($_SESSION['stickyForm']);

$cache_life = '600'; //caching time, in seconds
$filetime_search = @filemtime($_SESSION['appRoot'] . "view/include/tmpResults/" . $_SESSION['defaultSearchId'] . ".php");  // returns FALSE if file does not exist

// only recreate default search results if it does not exist or is older than 5 minutes
if (!$filetime_search or (time() - $filetime_search >= $cache_life)){
//if (true) {

	$fileId = Util::newUuid();
	$file = fopen($_SESSION['appRoot'] . "view/include/tmpResults/" . $fileId . ".php","w") or die("Unable to open file!");
		
	foreach ($_SESSION['groups'] as $key=>$val) {
		fwrite($file, "<table cellpadding=\"2\">");
		$cursor = pgDb::getGroupMembersByGroupId($key);
		fwrite($file, "<tr><td colspan=\"3\" valign=\"top\"><a href=#>" . $val . "</a></td></tr>");	
		fwrite($file, "<tr><td><b>Message</b></td><td>&nbsp;<input type=\"button\" name=\"CheckAll\" value=\"Broadcast\" onclick=\"checkAll('nameGroup" . $key . "')\"></td><td><input type=\"button\" name=\"CheckAll\" value=\"Uncheck All\" onclick=\"uncheckAll('nameGroup" . $key . "')\"></td></tr>");
		while ($row = pg_fetch_array($cursor)) {
			$disabled = "disabled";
			if (pgDb::isUserMessageEnabled($row['id'])) {
				$disabled = "";
			}
			fwrite($file, "<tr><td valign=\"top\"><input type=\"checkbox\" name=\"names[]\" class=\"nameGroup" . $key . "\" value=\"" . $row['id'] . "::" . $row['fname'] . " " . $row['lname'] . "\" onchange=\"messageToFill()\" " . $disabled . " \></td><td valign=\"top\">
 			<a href=\"javascript:void(0)\" style=\"font-size:12px;font-weight:normal;\" onclick=\"showUser(" . $row['id'] . ")\">" . $row['lname'] . ",&nbsp;" . $row['fname'] . "</a></td><td valign=\"top\">" . $row['oname'] . "</td></tr>\n");	
		}
		fwrite($file, "</table>");
	} 	
	
	$_SESSION['defaultSearchId'] = $fileId;
}

$filetime_specialty = @filemtime($_SESSION['appRoot'] . "view/include/tmpSpecialty/" . $_SESSION['networkId'] . ".html"); 

if (!$filetime_specialty or (time() - $filetime_specialty >= $cache_life)){
	// TODO - fill in
}
	
?>

