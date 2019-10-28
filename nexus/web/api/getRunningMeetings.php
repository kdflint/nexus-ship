<?php

require_once("../src/framework/Util.php");
require_once(Utilities::getSrcRoot() . "/schedule/Event.php");

$conf = array('append' => true, 'mode' => 0644, 'timeFormat' => '%X %x');
$logger = Log::singleton("file", Utilities::getLogRoot() . "/api.log", "", $conf, PEAR_LOG_INFO);
$logger->log(print_r($_COOKIE, true), PEAR_LOG_INFO);

if (isset($_COOKIE['REMEMBERME'])) {
//if (true) {
	if (isset($_COOKIE['remembered_groups'])) {
	//if (false) {
		$idList = getFormattedGroupListFromCookie($_COOKIE['remembered_groups']);
		$data = Event::getRunningMeetingsByGroupIdList($idList);
		header('Content-Type: application/json');
		echo json_encode($data);
	} else {
		echo '{status: none}';
	}
} else {
	echo '{status: unauthenticated}';
}


function getFormattedGroupListFromCookie($groupList) {
	$idList = '';
	$groupListArray = json_decode($groupList);
	foreach ($groupListArray as $group) {
		$idList = $group->id . "," . $idList;
	}
	return "{" . rtrim($idList, ",") . "}";
}

?>
