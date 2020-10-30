#!/usr/bin/php -q

<?php

require_once("../Util.php");
require_once(Utilities::getSrcRoot() . "/organization/Organization.php");
require_once(Utilities::getSrcRoot() . "/group/Group.php");
require_once(Utilities::getSrcRoot() . "/user/Invitation.php");
require_once(Utilities::getSrcRoot() . "/user/CrmUser.php");

$sourceFile = 'civiout.txt';
$inputFile = '_civiout.txt';
$input = '';
$result = 'Provision not attempted';
$keepGoing = true;
$date = date("D M j G:i:s T Y");
$log = fopen("provisionLog.txt", "a");

fwrite($log, $date . "\n");

if ( file_exists($sourceFile) ) {
    rename($sourceFile, $inputFile);
    //copy($sourceFile, $inputFile);
    if (($in = fopen($inputFile, "r")) !== false ) {
        while (!feof($in)) {
        	$input .= fread($in, 1024);
        }
        fclose($in);   
    }
} else {
    $keepGoing = false;
    $input = "Source file $sourceFile was not available to process.";
}

fwrite($log, "Input: " . $input . "\n");

if ($keepGoing) {
    try {
        $inputOrg = json_decode($input);
        $orgParent = 13;
        $orgLogo = 'default-empty.png';
        $orgEmail = $inputOrg->contactEmail;
        $contribId = $inputOrg->contributionId;
        $contactId = $inputOrg->contactId;
        $oid = 'undefined';
        $adderId = Utilities::getEnvName() === "local" ? '296' : '88';
        $orgName = $inputOrg->orgName;
        if (Utilities::getEnvName() === "prod") {
            $orgName = CrmUser::getGroupOrTeamNamebyContribId($contribId);
        }
        fwrite($log, "Fetch orgName: " . $orgName . "\n");
    
        $newOrgId = Organization::addOrganization($orgName, $orgParent, $orgLogo);
        Organization::addNwmAccountToOrganization($newOrgId);
        Organization::addOrganizationParent($newOrgId, $newOrgId);
        $newGroupId = Group::addGroup($orgName);
        $invitationId = Invitation::addNetworkAdminInvitation($orgEmail, $newGroupId, 4, $adderId, $newOrgId);
        $oid = Organization::getOidByOrgId($newOrgId);
        if (Utilities::getEnvName() === "prod") {
            CrmUser::onboardCrmUser($oid, $invitationId, $contribId, $contactId);
        }
        
        fwrite($log, 'Enrollment link: ' . Utilities::getHttpPath() . '/enroll.php?invitation=' . $invitationId . "\n");
        $result = 'Success for organization: ' . $oid;
    } catch (Exception $e) {
        $result = 'Caught exception: ' . $e->getMessage();
    }
}

fwrite($log, $result . "\n\n");
fclose($log);
unlink($inputFile);
exit(0);

?>

