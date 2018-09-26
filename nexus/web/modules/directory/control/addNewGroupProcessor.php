<?php

session_start();

require_once("../../../src/framework/Util.php");
require_once(Utilities::getSrcRoot() . "/group/Group.php");
require_once(Utilities::getSrcRoot() . "/user/Invitation.php");
require_once(Utilities::getSrcRoot() . "/message/ExternalMessage.php");

// TODO - put authorization checker, session checker, error handling, etc. in a central place. These should go at the top of every processor.

if (!Utilities::isSessionValid()) {
	header("location:" . Utilities::getHttpPath() . "/nexus.php");
	exit(0);
}
									
// Following works, but only populates form values that HAVE a value. Empties do not copy over.
$result = validateGroup($_POST);

if (count($result['error']) > 0) {
print_r($result);
 exit(0);
}

/* ====================================================

Use only clean input beyond this point (i.e. $clean[])

======================================================= */
if (isset($result['clean']['group-name'])) {

	$groupId = Group::addGroup($result['clean']['group-name']);
	User::addUserGroupRelation($_SESSION['uidpk'], $groupId, '4');
	$admins = Organization::getNetworkAdminIdByOrgId($_SESSION['networkId']);
	foreach ($admins as $admin) {
		User::addUserGroupRelation($admin, $groupId, '4');
	}
	if ($result['clean']['group-public'])	{
		User::addUserGroupRelationbyUsername('pUser-' . $_SESSION['orgUid'], $groupId, '5');
	}

	$inviteUuid = Invitation::addGlobalInvitation($groupId, "5", "88", $_SESSION['networkId']);
	
	Utilities::setSessionGroups($_SESSION['username']);
	
	$parentForum = Organization::getParentForumByOrgId($_SESSION['networkId'], $result['clean']['group-public']);
	
	if ($parentForum) {
		require_once(Utilities::getSrcRoot() . "/group/Forum.php");
		$return = Forum::createNewGroupAndForum($result['clean']['group-name'], $parentForum, $result['clean']['group-public'], Organization::getForumUserGroupByOrgId($_SESSION['networkId']));
		$forumUserId = Forum::getUserIdByUsername($_SESSION['username']);
		Forum::addUserToGroupById($forumUserId, $return[0][0]);
		ExternalMessage::addForumSubscription($forumUserId, $return[1][0]);
	}
}

if ((session_status() === PHP_SESSION_ACTIVE) && isset($_SESSION['nexusContext'])) {
 switch($_SESSION['nexusContext']) {
 		case "NWM":
			header("location:" . Utilities::getHttpPath() . "/nexus.php");
 			break;
 		case "ADV":
			header("location:" . Utilities::getHttpPath() . "/nexus.php");
 			break;
 		case "PUB":
 			header("location:" . Utilities::getPluginPath() . "/publicSuite.php?oid=" . $_SESSION['orgUid'] . "&context=directory");
 			break;
 		default: 			
 	}
}

	
function validateGroup($input) {
	$result = array('clean' => array(), 'error' => array());
	
	if (isset($input['group-name']) && strlen($input['group-name']) > 0) {
		$result['clean']['group-name'] = Utilities::sanitize($input['group-name']);
	}
	
	if (isset($input['group-public'])) {
		$result['clean']['group-public'] = true;
	} else {
		$result['clean']['group-public'] = false;
	}
	
	return $result;
}

?>