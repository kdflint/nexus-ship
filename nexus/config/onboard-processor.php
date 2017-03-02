<?php

require_once(dirname(__FILE__) . "/../web/src/framework/Util.php");
require_once(Utilities::getSrcRoot() . "/organization/Organization.php");
require_once(Utilities::getSrcRoot() . "/group/Group.php");
require_once(Utilities::getSrcRoot() . "/user/Invitation.php");

$pw = Utilities::getAdminPassword();
$adderId = Utilities::getEnvName() === "local" ? '296' : '88';
	
if (isset($_POST['password']) && $_POST['password'] === $pw && isset($_POST['account-type'])) {
	
	if ($_POST['account-type'] === "ADV") {
	
		// This will add a new ADV account holder that is a new organization

		$newOrgId = Organization::addOrganization($_POST['org-name'], $_POST['org-parent'], $_POST['org-logo']);
		Organization::addAdvAccountToOrganization($newOrgId);
		Organization::addOrganizationParent($newOrgId, $newOrgId);
		$newOrgData = pg_fetch_array(Organization::getOrganizationById($newOrgId));
		// Establish Network Default Group
		$newGroupId = Group::addGroup("Network Group");
		$nuserId = User::addNetworkUser('nUser-' . $newOrgData['uid']);
		User::addUserGroupRelation($nuserId, $newGroupId, '5');
		User::addUserOrgRelation($nuserId, $newOrgId, $adderId, '5');
		// Establish Public Group
		$newGroupId = Group::addGroup("Public Group");
		$puserId = User::addPublicUser('pUser-' . $newOrgData['uid']);
		User::addUserGroupRelation($puserId, $newGroupId, '5');
		User::addUserOrgRelation($puserId, $newOrgId, $adderId, '5');
		// Create admin enrollment
		$invitationId = Invitation::addNetworkAdminInvitation($_POST['org-email'], null, 1, $adderId, $newOrgId);
		echo("Enrollment link: " . Utilities::getHttpPath() . "/enroll.php?invitation=" . $invitationId);
		exit(0);
	
	} else if ($_POST['account-type'] === "NWM") {

		// This will add a new NWM account holder
	
		$newOrgId = Organization::addOrganization($_POST['org-name'], $_POST['org-parent'], $_POST['org-logo']);
		Organization::addNwmAccountToOrganization($newOrgId);
		Organization::addOrganizationParent($newOrgId, $newOrgId);
		$newGroupId = Group::addGroup($_POST['org-name']);
		$invitationId = Invitation::addNetworkAdminInvitation($_POST['org-email'], $newGroupId, 4, $adderId, $newOrgId);
		echo("Enrollment link: " . Utilities::getHttpPath() . "/enroll.php?invitation=" . $invitationId);
		exit(0);
		
	} else {
		echo("Unknown account type: " . $_POST['account-type']);
		exit(0);
	}
	
} else {
	echo("unauthorized");
	exit(0);
}	

?>