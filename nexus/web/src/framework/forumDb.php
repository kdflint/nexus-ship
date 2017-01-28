<?php

class ForumDatabase {
	
	public static function connect() {	
		require_once(dirname(__FILE__) . "/Util.php");
		
		$db_host = Utilities::getForumHost();
		$db_user = Utilities::getForumUser();  
		$db_pass = Utilities::getForumPassword(); 
		$db = Utilities::getForumName();
			
		$con = pg_connect("host=$db_host dbname=$db user=$db_user password=$db_pass")
    or trigger_error("Could not connect to the database server\n", E_USER_ERROR);   
    return $con;
	}
	
	// TODO - this is duplicate code. See PgDb.php
	public static function disconnect($con) {
		pg_close($con);
	}
		
	public static function psExecute($query, $input) {
		$result = $prepare = FALSE;
		$con = ForumDatabase::connect();
		$prepare = pg_prepare($con, "ps", $query);
		if (!$prepare) {
				trigger_error("Cannot prepare statement: $query\n", E_USER_ERROR);	
		}
		$result = pg_execute($con, "ps", $input);
		ForumDatabase::disconnect($con);
		if (!$result) {
			trigger_error("Cannot execute query: $query\n", E_USER_ERROR);
		}
		return $result;
	}

}

?>
