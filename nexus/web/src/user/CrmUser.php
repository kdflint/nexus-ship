<?php

require_once(dirname(__FILE__) . "/../framework/MysqlDb.php");
require_once(dirname(__FILE__) . "/../framework/Util.php");

class CrmUser {
	
	public static function getCrmActivationTable() { return CRM_ACTIVATION_TABLE; }
	
	public static function getCrmActivationTableRow_Oid() { return CRM_ACTIVATION_ROW_OID; }
	
	public static function getCrmActivationTableRow_Enroll() { return CRM_ACTIVATION_ROW_ENROLL; }
	
	public static function getCrmActivationTableRow_IsEnrolled() { return CRM_ACTIVATION_ROW_IS_ENROLLED; }
	
	public static function onboardCrmUser($_oid, $_uuid, $_contrib) {
		$con = MysqlDatabase::connect();
		$query = "insert into civicrm_value_nexus_activation_" . Utilities::getCrmActivationTable() . 
						 "(oid_" . Utilities::getCrmActivationTableRow_Oid() . ",  
						 initial_enrollment_uuid_" . Utilities::getCrmActivationTableRow_Enroll() . ",  
						 is_enrolled_" . Utilities::getCrmActivationTableRow_IsEnrolled() . ", entity_id) 
						 values (?, ?, 0, ?)";
		$stmt = $con->prepare($query);
		$stmt->bind_param("sss", $oid, $uuid, $contrib);
		$oid = $_oid;
		$uuid = $_uuid;
		$contrib = $_contrib;
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
	
}

?>