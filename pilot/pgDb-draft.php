<?php

class pgDb {
	
	public static function connect() {
		$host = "localhost"; 
		$user = ""; 
		$pass = ""; 
		$db = "northbr6_nbnexus";		
		
		$con = pg_connect("host=$host dbname=$db user=$user password=$pass")
    or die ("Could not connect to server\n"); 
    
    return $con;
	}
	
	public static function disconnect($con) {
		pg_close($con);
	}
		
	// create new network:
	// insert into organization set name = $name, handle = $handle, ein = $ein, structure = $structure, activate_dttm = create_dttm = now()

	public static insertAdminInvitation($con, $uuid, $email, $networkId) {
			$query = "insert into invitation set uuid = $uuid, email = $email, organization_fk = $networkId, role = 'administrative'";
			execute($con, $query);
	}
	
	public static setInvitationSent($con, $uuid) {
			$query = "update invitation set invitation_dttm = now() where uuid = $uuid";
			execute($con, $query);
	}
	
	public static setInvitationClosed($con, $uuid) {
			$query = "update invitation set accept_dttm = now() where uuid = $uuid";
			execute($con, $query);
	}
	
	public static getOpenInvitations($con, $networkId) {
		$query = "select email, uuid, [age] from invitation where networkId = $networkId and accept_dttm = null and create_dttm < [some age value]"; 
		$result = pg_query($con, $query) or die("Cannot execute query: $query\n"); 
		return $result;
	}
	
	public static getOpenInvitation($con, $uuid) {
		$query = "select 
			i.email, o.name as networkName
			from invitation i, organization o 
			where i.uuid = $uuid
			and i.organization_fk = o.id
			"; 
		$result = pg_query($con, $query) or die("Cannot execute query: $query\n"); 
		return $result;
	}
	
	public static activateAdminUser($con, $uuid) {	
		$query = "insert into users set ...";
		$result = pg_query($con, $query) or die("Cannot execute query: $query\n");
		// confirm count and return count
	}
	
	public static updateUser($con, $id) {	
		$query = "update users set ... where id = $id";
		$result = pg_query($con, $query) or die("Cannot execute query: $query\n");
	}

	public static getUserByKey($con, $key) {
		$query = "
			select u.id, u.email, u.fname, u.lname, o1.handle, o1.name as affiliation, ur.role, o2.name as network
			from user u, user_organization uo, user_role ur, organization_organization oo, organization o1, organization o2
			where u.id = $key
			and u.id = uo.user_fk
			and uo.organization_fk = o1.id
			and ur.user_fk = u.id
			and ur.organization_fk = o1.id
			and oo.organization_to_fk = o1.id
			and oo.organization_from_fk = o2.id
			";
		$result = execute($con, $query);
	}
	
	private static execute($con, $query) {
		$result = pg_query($con, $query) or die("Cannot execute query: $query\n");
		return $result;
	}
	
}

?>
