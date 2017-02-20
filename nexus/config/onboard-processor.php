<?php

require_once(dirname(__FILE__) . "/../web/src/framework/Util.php");
require_once(Utilities::getSrcRoot() . "/organization/Organization.php");
require_once(Utilities::getSrcRoot() . "/group/Group.php");
require_once(Utilities::getSrcRoot() . "/user/Invitation.php");

if (isset($_POST['password']) && $_POST['password'] === "mockingbird") {
	
	// This will add a new ADV account holder that is a new organization

	$newOrgId = Organization::addOrganization($_POST['org-name'], $_POST['org-parent'], $_POST['org-logo']);
	Organization::addAdvAccountToOrganization($newOrgId);
	// Establish Network Default Group
	Group::addGroup($_POST['org-name']);
	// Establish Public Group
	$newGroupId = Group::addGroup("Public Group");
	$newOrgData = pg_fetch_array(Organization::getOrganizationById($newOrgId));
	$puserId = User::addPublicUser('pUser-' . $newOrgData['uid']);
	User::addUserGroupRelation($puserId, $newGroupId, '5');
	User::addUserOrgRelation($puserId, $newOrgId, '296', '5');
	// Create admin enrollment
	$invitationId = Invitation::addInvitation($_POST['org-email'], null, 1, 296, $newOrgId);
	
	header("location:" . "http://localhost/nexus/nexus/config/onboard.php?invitation=" . $invitationId);
	
} else {
	echo("unauthorized");
	exit(0);
}	

?>