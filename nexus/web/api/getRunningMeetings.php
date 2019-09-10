<?php

require_once("../src/framework/Util.php");
require_once(Utilities::getSrcRoot() . "/schedule/Event.php");

if (isset($_COOKIE['REMEMBERME'])) {
//if (true) {
	if (isset($_COOKIE['remembered_gids'])) {
	//if (false) {
		$idList = getFormattedGroupListFromCookie($_COOKIE['remembered_gids']);
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
	return "{" . $idList . "}";
}

?>

