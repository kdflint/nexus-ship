<?php

session_start();

include("pgDb.php");
include("util.php");

$action = Util::clean($_POST['action']);

$inviteId = $_SESSION['inviteId'];
$grantor = $_SESSION['grantorId'];
$orgId = $_SESSION['orgId'];
$orgName = Util::clean($_POST['orgName']);
// TODO: strip hyphens
$ein = Util::clean($_POST['ein']); 
$email = Util::clean($_POST['email']);

if ($action == "createInvitation") {
	if (Util::authenticate($_SESSION['uid'])) {
		// Normally the second argument for orgId will come from the authenticated user
		pgDb::insertOpenAdminInvitation(newUuid(), "1");
	}
	header("location:registrationViews.php");
	exit(0);
}

if ($action == "createRegistration") {

	$dupeOrg = pgDb::orgEinExists($ein);
	$dupeEmail = pgDb::userEmailExists($email);
	
	// TODO: Make transactional?
	
	if ($dupeOrg == "true") { 	
		error_log("dupeOrg true",0);
		if ($dupeEmail == "false") {
			error_log("     dupeEmail false",0);
			pgDb::insertActiveUser(newUuid(), $email);
			pgDb::insertAdminUserOrgRelation($email, $orgId, $grantor);
		} else {
				error_log("     dupeEmail true",0);
				if (pgDb::userOrgRelationExists($orgId, $email) == "true") { 
					error_log("     relation",0);
					$uuid = pgDb::insertSingleAdminInvitation(newUuid(), $orgId, $email, $grantor);
					sendEmail1(); 			
				} else {
					if (pgDb::countUserEmail($email) == 1) {
						error_log("     no relation, count = 1",0);
						pgDb::insertAdminUserOrgRelation($email, $orgId, $grantor);
					} else {
						error_log("     no relation, count > 1",0);
						sendEmail2();
					}
				}
		}
	} else if ($dupeEmail == "true") {
		error_log("dupeOrg false",0);
		error_log("     dupeEmail true",0);
		$id = pgDb::insertOrganization($orgName, $ein);
		if (pgDb::countUserEmail($email) == 1) {
			pgDb::insertAdminUserOrgRelation($email, $orgId, $grantor);
		} else {
			sendEmail4();
		}
	} else {
		error_log("dupeOrg false",0);
		error_log("     dupeEmail false",0);
		pgDb::insertActiveUser(newUuid(), $email);
		$id = pgDb::insertOrganization($orgName, $ein);
		pgDb::insertAdminUserOrgRelation($email, $orgId, $grantor);
		sendEmail3();
	}

	// TODO: tie invitation response to a single user
	// TODO: is this the right spot for this logic?
	pgDb::insertInvitationResponse($orgId, $inviteId);

	header("location:registrationViews.php");
	exit(0);
}

function newUuid() { 
    $s = strtolower(md5(uniqid(rand(),true))); 
    $guidText = 
        substr($s,0,8) . '-' . 
        substr($s,8,4) . '-' . 
        substr($s,12,4). '-' . 
        substr($s,16,4). '-' . 
        substr($s,20); 
    return $guidText;
}

function sendEmail1() {
	// TODO
	// this email is already in the system registered to name *** 
	// If you are name, please log in ...
	// If you can't remember your password, please the network administrator who issued you this invitation
	// If you are not name but this is a shared email account for your organization, click here to set up a new username under this email
	// show link with new invitation specific to this email
}

function sendEmail2() {
	// TODO
	// Your organization and several matching email address are already in the system
	// check with your network admin to give rights to the correct user
}

function sendEmail3() {
	// You are set up and happy
}

function sendEmai14() {
	// TODO
	// Several matching email address are already in the system
	// check with your network admin to give rights to the correct user
}

?>