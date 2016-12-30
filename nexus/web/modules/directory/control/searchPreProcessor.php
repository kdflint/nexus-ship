<?php

require_once(Utilities::getSrcRoot() . "/group/Group.php");
require_once(Utilities::getSrcRoot() . "/user/User.php");

$stickyString = $_SESSION['stickyForm']['string'];
$stickyTopic = $_SESSION['stickyForm']['topic'];
$stickyScope = $_SESSION['stickyForm']['scope'];
$stickyType = $_SESSION['stickyForm']['type'];
$stickyCount = $_SESSION['stickyForm']['resultCount'];

$groupChecked = !strcmp($stickyScope, "group") || !strcmp($stickyScope, "") ? "checked" : "";
$networkChecked = !strcmp($groupChecked, "checked") ? "" : "checked";

unset($_SESSION['stickyForm']);

$cache_life = '600'; //caching time, in seconds
$filetime_search = @filemtime(Utilities::getModulesRoot() . "/directory/views/include/tmpResults/" . $_SESSION['defaultSearchId'] . ".php");  // returns FALSE if file does not exist

// only recreate default search results if it does not exist or is older than 5 minutes
if (!$filetime_search or (time() - $filetime_search >= $cache_life)){
//if (true) {

	$fileId = $_SESSION['defaultSearchId'];
	$file = fopen(Utilities::getModulesRoot() . "/directory/views/include/tmpResults/" . $fileId . ".php","w") or die("Unable to open file!");
		
	foreach ($_SESSION['groups'] as $key=>$val) {
		fwrite($file, "<table cellpadding=\"2\">");
		$result = Group::getGroupMembersByGroupId($key, $_SESSION['uidpk']);
		fwrite($file, "<tr><td colspan=\"3\" valign=\"top\"><a href=#>" . $val . "</a></td></tr>");	
		fwrite($file, "<tr><td><b>Message</b></td><td>&nbsp;<input type=\"button\" name=\"CheckAll\" value=\"Broadcast\" onclick=\"checkAll('nameGroup" . $key . "')\"></td><td><input type=\"button\" name=\"CheckAll\" value=\"Uncheck All\" onclick=\"uncheckAll('nameGroup" . $key . "')\"></td></tr>");
		foreach ($result as $user) {
			$disabled = "disabled";
			if (User::isUserMessageEnabled($user['id'])) {
				$disabled = "";
			}
			fwrite($file, "<tr><td valign=\"top\"><input type=\"checkbox\" name=\"names[]\" class=\"nameGroup" . $key . "\" value=\"" . $user['id'] . "::" . $user['fname'] . " " . $user['lname'] . "\" onchange=\"messageToFill()\" " . $disabled . " \></td><td valign=\"top\">
 			<a href=\"javascript:void(0)\" style=\"font-size:12px;font-weight:normal;\" onclick=\"showUser(" . $user['id'] . ")\">" . $user['lname'] . ",&nbsp;" . $user['fname'] . "</a></td><td valign=\"top\">" . $user['oname'] . "</td></tr>\n");	
		}
		fwrite($file, "</table>");
	} 	
	
}

$filetime_specialty = @filemtime(Utilities::getModulesRoot() . "/directory/views/include/tmpSpecialty/" . $_SESSION['networkId'] . ".html"); 

if (!$filetime_specialty or (time() - $filetime_specialty >= $cache_life)){
	// TODO - fill in
}
	
?>

