<?

require '../model/pgDb.php';
require '../control/util.php';

$cleanId="";

echo("<a href=\"javascript:void(0)\" onclick=\"document.getElementById('light_userprofile').style.display='none';document.getElementById('fade').style.display='none'\" style=\"float:right\">Close</a>");

if(Util::validateUserId($_REQUEST['id'])) {
	$cleanId = $_REQUEST['id'];
} else {
	trigger_error("Invalid user id\n", E_USER_ERROR);
}

$cursor = pgDb::getUserById($cleanId);
while ($row = pg_fetch_array($cursor)) {
	echo("<p><b>" . $row['first'] . " " . $row['last'] . "</b></p>");
	echo("<p><b>" . $row['descr'] . "</b></p><hr/>");
	if (!strcmp($row['emailpub'], "t")) {
		echo("<p>Email: <a style=\"font-weight:normal;\" href=\"mailto:" . $row['email'] . "\">" . $row['email'] . "</a></p>");
	}
	if (!strcmp($row['smspub'], "t")) {
		echo("<p>Text Message: " . Util::prettyPrintPhone($row['cell']) . "</p>");
	}
	if (!strcmp($row['phonepub'], "t")) {
		echo("<p>Phone: " . Util::prettyPrintPhone($row['phone']) . "</p>");
	}

}

$groups = pgDb::getUserGroupsByUserId($cleanId);
foreach ($groups as $key=> $val) {
	echo("<p>Group : " . $val);
}

	
$cursor = pgDb::getUserOrgRelationsByUserId($cleanId);
while ($row = pg_fetch_array($cursor)) {
	echo("<p>Organization: " . $row['name']);
}

?>
                           