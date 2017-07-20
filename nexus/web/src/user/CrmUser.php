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
		$query = "update civicrm_value_nexus_activation_" . Utilities::getCrmActivationTable() . 
						 " set oid_" . Utilities::getCrmActivationTableRow_Oid() . " = ?, 
						 initial_enrollment_uuid_" . getCrmActivationTableRow_Enroll() . " = ?, 
						 is_enrolled_" . Utilities::getCrmActivationTableRow_IsEnrolled() . " = false 
						 where entity_id = ?";
		$stmt = $con->prepare($query);
		$stmt->bind_param("sss", $oid, $uuid, $contrib);
		$oid = $_oid;
		$uuid = $_uuid;
		$contrib = $_contrib;
		$stmt->execute();
		MysqlDatabase::disconnect($con);
	}
	
	public static function enrollCrmUser($_contrib) {
		$con = MysqlDatabase::connect();
		$query = "update civicrm_value_nexus_activation_" . Utilities::getCrmActivationTable() . "set is_enrolled_" .  . Utilities::getCrmActivationTableRow_IsEnrolled() . " = true where entity_id = ?";
		$stmt = $con->prepare($query);
		$stmt->bind_param("s", $contrib);
		$contrib = $_contrib;
		$stmt->execute();
		MysqlDatabase::disconnect($con);
	}
	
}

?>