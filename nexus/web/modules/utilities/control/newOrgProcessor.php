<?php

require_once("../../../src/framework/Util.php");
require_once(Utilities::getSrcRoot() . "/organization/Organization.php");
require_once(Utilities::getSrcRoot() . "/group/Group.php");
require_once(Utilities::getSrcRoot() . "/user/Invitation.php");
require_once(Utilities::getSrcRoot() . "/user/User.php");

$result = Organization::addOrganization_NWM($_POST['groupName'], $_POST['logoFileName']);

$groupId = Group::addGroup($_POST['groupName']);

$uuid = Invitation::addInvitation($_POST['email'], $groupId, '4', '88', $result[0]);

$userId = User::addPublicUser('pUser-' . $result[1]);

User::addUserGroupRelation($userId, Utilities::getPublicGroupId(), '4');

User::addUserOrgRelation($userId, $result[0], '88', '4');

echo "OID = " . $result[1] . "
Enroll Id = " . $uuid;

?>
