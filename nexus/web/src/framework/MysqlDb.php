<?php

class MysqlDatabase {
	
	public static function connect() {	
		require_once(dirname(__FILE__) . "/Util.php");
		
		$db_host = Utilities::getCrmHost(); 
		$db_user = Utilities::getCrmUser();  
		$db_pass = Utilities::getCrmPassword(); 
		$db = Utilities::getCrmName();
			
		$con = new mysqli($db_host, $db_user, $db_pass, $db);

		if ($con->connect_error) {
		    trigger_error("Could not connect to the database server\n", E_USER_ERROR);
		} 
    return $con;
	}
	
	public static function disconnect($stmt, $con) {
		$stmt->close();
		$con->close();
	}
		
}

?>
