<?php

class PgDb {
	
	// get valid values for org type
	// select * from pg_enum e where enumtypid = '1569578'
	
	public static function connect() {	
		require_once(dirname(__FILE__) . "/Util.php");
		
		$db_host = Util::getDbHost(); //DB_HOST; 
		$db_user = Util::getDbUser(); //DB_USER;  
		$db_pass = Util::getDbPassword(); //DB_PASSWORD; 
		$db = Util::getDbName(); //DB_NAME;
			
		$con = pg_connect("host=$db_host dbname=$db user=$db_user password=$db_pass")
    or trigger_error("Could not connect to the database server\n", E_USER_ERROR);   
    return $con;
	}
	
	public static function disconnect($con) {
		pg_close($con);
	}
		
	public static function psExecute($query, $input) {
		$result = $prepare = FALSE;
		$con = pgDb::connect();
		$prepare = pg_prepare($con, "ps", $query);
		if (!$prepare) {
				trigger_error("Cannot prepare statement: $query\n", E_USER_ERROR);	
		}
		$result = pg_execute($con, "ps", $input);
		pgDb::disconnect($con);
		if (!$result) {
			trigger_error("Cannot execute query: $query\n", E_USER_ERROR);
		}
		return $result;
	}

}

?>
