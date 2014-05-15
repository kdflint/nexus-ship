<?php

include("pgDb.php");
include("util.php");

$networkId = Util::clean($_GET['networkId']);

$con = pgDb::connect();

$result = pgDb::getOpenInvitations($con, $networkId)

while ($row = pg_fetch_array($result)) {

    //echo 'field a: ', $row['field_a'],"\n";
    //echo 'field b: ', $row['field_b'],"\n\n";
    
		//Display row and how long waiting, how long left.
		//Show remind/renew link? Or automatic job?

}

pgDb::disconnect($con);

?>