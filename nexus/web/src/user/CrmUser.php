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
						 values ('$_oid', '$_uuid', 0, '$_contrib')";
		$logger->log($query, PEAR_LOG_INFO);
		if ($con->query($query) === TRUE) {
    		//echo "Record updated successfully";
		} else {
    		$logger->log("Failed to update initial enrollment uid", PEAR_LOG_INFO);
		}

		// Tag id 14 corresponds to "Nexus Authorization" which is id 14 in both DEV and PROD (see table civicrm_tag)
		$query = "insert into civicrm_entity_tag 
						 (entity_table, entity_id, tag_id)  
						 values ('civicrm_contact', '$_contact', 14)";
		$logger->log($query, PEAR_LOG_INFO);
		if ($con->query($query) === TRUE) {
    		//echo "Record updated successfully";
		} else {
    		$logger->log("Failed to update entity id", PEAR_LOG_INFO);
		}
		$con->close();
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
		$query = "select group_or_team_name_4 from civicrm_value_service_area_1 where entity_id = '$_contribId' limit 1";	
		$logger->log($query, PEAR_LOG_INFO);
		$result = $con->query($query);
		print_r($result, true);
		if ($result->num_rows > 0) {
			$row = $result->fetch_assoc();
			print_r($row, true);
			return $row["group_or_team_name_4"];
		}
		return 'Look Me Up';
		$con->close();
	}
	
}

?>