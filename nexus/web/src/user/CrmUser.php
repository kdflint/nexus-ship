<?php

require_once(dirname(__FILE__) . "/../framework/MysqlDb.php");
require_once(dirname(__FILE__) . "/../framework/Util.php");

class CrmUser {
	
	public static function getCrmActivationTable() { return CRM_ACTIVATION_TABLE; }
	
	public static function getCrmActivationTableRow_Oid() { return CRM_ACTIVATION_ROW_OID; }
	
	public static function getCrmActivationTableRow_Enroll() { return CRM_ACTIVATION_ROW_ENROLL; }
	
	public static function getCrmActivationTableRow_IsEnrolled() { return CRM_ACTIVATION_ROW_IS_ENROLLED; }
	
	public static function onboardCrmUser($_oid, $_uuid, $_contrib, $_contact) {
		$conf = array('append' => true, 'mode' => 0644, 'timeFormat' => '%X %x');
		$logger = Log::singleton("file", Utilities::getLogRoot() . "/crm_activity.log", "", $conf, PEAR_LOG_INFO);
		$con = MysqlDatabase::connect();

		$query = "insert into civicrm_value_nexus_activation_" . Utilities::getCrmActivationTable() . 
						 "(oid_" . Utilities::getCrmActivationTableRow_Oid() . ",  
						 initial_enrollment_uuid_" . Utilities::getCrmActivationTableRow_Enroll() . ",  
						 is_enrolled_" . Utilities::getCrmActivationTableRow_IsEnrolled() . ", entity_id) 
						 values (?, ?, 0, ?)";
		$logger->log($query, PEAR_LOG_INFO);
		$stmt = $con->prepare($query);
		$stmt->bind_param("sss", $oid, $uuid, $contrib);
		$oid = $_oid;
		$uuid = $_uuid;
		$contrib = $_contrib;
		$stmt->execute();

		// Tag id 14 corresponds to "Nexus Authorization" which is id 14 in both DEV and PROD (see table civicrm_tag)
		$query = "insert into civicrm_entity_tag 
						 (entity_table, entity_id, tag_id)  
						 values ('civicrm_contact', ?, 14)";
		$logger->log($query, PEAR_LOG_INFO);
		$stmt = $con->prepare($query);
		$stmt->bind_param("s", $contact);
		$contact = $_contact;
		$stmt->execute();

		MysqlDatabase::disconnect($stmt, $con);
	}
	
	public static function enrollCrmUser($_uuid) {
		
		$conf = array('append' => true, 'mode' => 0644, 'timeFormat' => '%X %x');
		$logger = Log::singleton("file", Utilities::getLogRoot() . "/crm_activity.log", "", $conf, PEAR_LOG_INFO);
		$con = MysqlDatabase::connect();
		$query = "update civicrm_value_nexus_activation_" . Utilities::getCrmActivationTable() . " set is_enrolled_" . Utilities::getCrmActivationTableRow_IsEnrolled() . " = 1 where initial_enrollment_uuid_" . Utilities::getCrmActivationTableRow_Enroll() . " = '$_uuid'";
		$logger->log($query, PEAR_LOG_INFO);
		if ($con->query($query) === TRUE) {
    	//echo "Record updated successfully";
		} else {
    	$logger->log("Fail to update CRM enrollment", PEAR_LOG_INFO);
		}
		$con->close();
	}

	public static function getGroupOrTeamNamebyContribId($_contribId) {
		$conf = array('append' => true, 'mode' => 0644, 'timeFormat' => '%X %x');
		$logger = Log::singleton("file", Utilities::getLogRoot() . "/crm_activity.log", "", $conf, PEAR_LOG_INFO);
		$con = MysqlDatabase::connect();
		$query = "select group_or_team_name_4 from civicrm_value_service_area_1 where entity_id = ?";	
		$logger->log($query, PEAR_LOG_INFO);
		$stmt = $con->prepare($query);
		$stmt->bind_param("s", $contribId);
		$contribId = $_contribId;
		$stmt->execute();
		if ($stmt->bind_result($col1)) {
			return $col1;
		}
		return 'Look Me Up';
	}
	
}

?>