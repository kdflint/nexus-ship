<?

error_reporting(E_ALL);
ini_set( 'display_errors','1'); 

require_once ("pgDb.php");

$counter = 45;

while ($counter < 278) {

	echo "18" . ":" . $counter . ":" . "parent\n";
	pgDb::insertOrgOrgRelation("18", $counter, "parent");
	$counter++;

}

?>