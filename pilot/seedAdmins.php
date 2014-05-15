<?php

include("pgDb.php");
include("util.php");

$con = pgDb::connect();

// parse input emails
$in = array();
$networkId = Util::clean($_GET['networkId']);

foreach ($in as $email) {
		//generate uuid?
    pgDb::insertAdminInvitation($con, $uuid, $email, $networkId);   
}

$result = pgDb::getOpenInvitations($con)

while ($row = pg_fetch_array($result)) {

    //echo 'field b: ', $row['field_b'],"\n\n";
    
		//Send email
		
		pgDb::setInvitationSent($con, $uuid);

}

pgDb::disconnect($con);

//header to pendingStatus.php

?>