<?php

require_once(Utilities::getSrcRoot() . "/group/Group.php");
require_once(Utilities::getSrcRoot() . "/user/User.php");

$includePath = Utilities::getIncludeRoot() . "/directory/group-tables/";

$stickyString = $_SESSION['stickyForm']['string'];
$stickyTopic = $_SESSION['stickyForm']['topic'];
$stickyScope = $_SESSION['stickyForm']['scope'];
$stickyType = $_SESSION['stickyForm']['type'];
$stickyCount = $_SESSION['stickyForm']['resultCount'];

$groupChecked = !strcmp($stickyScope, "group") || !strcmp($stickyScope, "") ? "checked" : "";
$networkChecked = !strcmp($groupChecked, "checked") ? "" : "checked";

unset($_SESSION['stickyForm']);

$cache_life = '600'; //caching time, in seconds
$filetime_search = @filemtime($includePath . $_SESSION['defaultSearchId'] . ".php");  // returns FALSE if file does not exist

// only recreate default search results if it does not exist or is older than 5 minutes
//if (!$filetime_search or (time() - $filetime_search >= $cache_life)){
if (true) {

	$fileId = $_SESSION['defaultSearchId'];
	$file = fopen($includePath . $fileId . ".php","w") or die("Unable to open file!");
	
	// if session user is in one or more groups, show the combined members of their groups
	//if (count($_SESSION['groups']) > 0) {
	if (false) {
		fwrite($file, "<table cellpadding=\"2\">");
	 	foreach ($_SESSION['groups'] as $group) {
			$result = Group::getGroupMembersByGroupId($group['id'], $_SESSION['uidpk']);
			fwrite($file, "<tr><td colspan=\"3\" valign=\"top\"><a href=#>" . $val . "</a></td></tr>");	
			fwrite($file, "<tr><td><b>Message</b></td><td>&nbsp;<input type=\"button\" name=\"CheckAll\" value=\"Broadcast\" onclick=\"checkAll('nameGroup" . $key . "')\"></td><td><input type=\"button\" name=\"CheckAll\" value=\"Uncheck All\" onclick=\"uncheckAll('nameGroup" . $key . "')\"></td></tr>");
			foreach ($result as $user) {
				$disabled = "disabled";
				if (User::isUserMessageEnabled($user['id'])) {
					$disabled = "";
				}
				fwrite($file, "<tr>
				<td valign=\"top\"><input type=\"checkbox\" name=\"names[]\" class=\"nameGroup" . $key . "\" value=\"" . $user['id'] . "::" . $user['fname'] . " " . $user['lname'] . "\" onchange=\"messageToFill()\" " . $disabled . " \></td>
				<td valign=\"top\">
 				<a href=\"javascript:void(0)\" style=\"font-size:12px;font-weight:normal;\" onclick=\"showUser(" . $user['id'] . ")\">" . $user['lname'] . ",&nbsp;" . $user['fname'] . "</a></td>
 				<td>" . $user['oname'] . "</td></tr>\n");	
			}
		}
		fwrite($file, "</table>"); 	
	// else if session user is not in a group, show all network members
	} else {
		$result = Group::getNetworkMembersbyNetworkId($_SESSION['networkId'], $_SESSION['uidpk']);	
		fwrite($file, "<table id=\"member-directory\" class=\"display\" width=\"100%\" cellspacing=\"0\">");
		fwrite($file, "<thead><tr><th>Select for Message</th><th>Show Details</th><th>First</th><th>Last</th><th>Organization</th></tr></thead>");	
		fwrite($file, "<tbody>");
		//fwrite($file, "<tr><td colspan=\"3\" valign=\"top\"><a href=#>" . $val . "</a></td></tr>");	
		//fwrite($file, "<tr><td><b>Message</b></td><td>&nbsp;<input type=\"button\" name=\"CheckAll\" value=\"Broadcast\" onclick=\"checkAll('nameGroup" . $key . "')\"></td><td><input type=\"button\" name=\"CheckAll\" value=\"Uncheck All\" onclick=\"uncheckAll('nameGroup" . $key . "')\"></td></tr>");
		
		//http://" + window.location.hostname + environ + "/nexus/web/nexus.php?view=profileuser-" + username
		
		foreach ($result as $user) {
			$disabled = "disabled";
			if (User::isUserMessageEnabled($user['id'])) {
				$disabled = "";
			}
			fwrite($file, "<tr>
			<td><input type=\"checkbox\" name=\"names[]\" value=\"" . $user['id'] . "::" . $user['fname'] . " " . $user['lname'] . "\" onchange=\"messageToFill()\" " . $disabled . " \></td>
			<td>
 			<a href=\"javascript:void(0)\" style=\"font-size:12px;font-weight:normal;\" onclick=\"showAdvProfile('" . $user['username'] . "');\"><span class=\"fa fa-plus\"></span></a></td>			
			<td>" . $user['fname'] . "</td>
 			<td>" . $user['lname'] . "</td>
 			<td>" . $user['oname'] . "</td>
 			</tr>\n");	
		}		
		fwrite($file, "</tbody>");
		fwrite($file, "</table>");
	}
	
}

$filetime_specialty = @filemtime(Utilities::getModulesRoot() . "/directory/views/include/tmpSpecialty/" . $_SESSION['networkId'] . ".html"); 

if (!$filetime_specialty or (time() - $filetime_specialty >= $cache_life)){
	// TODO - fill in
}
	
?>

