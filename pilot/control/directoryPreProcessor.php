<?php

include("../model/pgDb.php");
include("../control/util.php");

if (isset($_GET['newSearch'])) {


	$title = "Search Results";
	
	// TODO: Seriously?? Perhaps must return an standard data type from pgDb so I can make copies??
	$cursor1 = pgDb::freeSearch($_GET['newSearch']);
	$cursor2 = pgDb::freeSearch($_GET['newSearch']);
	$cursor3 = pgDb::freeSearch($_GET['newSearch']);
	$cursor4 = pgDb::freeSearch($_GET['newSearch']);
	
	$results = array();

	// TODO: solve for 2 orgs with same name
	// TODO split newSearch string on spaces up to three terms

	while ($pass1 = pg_fetch_array($cursor1)) { 
		if (!strcmp($pass1['type'], "Organization")) {
				$results[$pass1['name']] = array(
					"Programs" => array(),
					"People" =>  array(),
					"Language" => array()
				);
		}
	}
	
	while ($pass2 = pg_fetch_array($cursor2)) { 
		if (!strcmp($pass2['type'], "Person")) {
			$innerCursor2 = pgDb::getUserOrgRelationsByUserId($pass2['id']);
			while ($inner2 = pg_fetch_array($innerCursor2)) {
				if (array_key_exists($inner2['name'], $results)) {
					array_push($results[$inner2['name']]["People"], $pass2['name']);
				} else {
					$results[$inner2['name']] = array(
						"Programs" => array(),
						"People" => array($pass2['name']),
						"Language" => array()
					);
				}
			}
		}
	}

	while ($pass3 = pg_fetch_array($cursor3)) { 
		if (!strcmp($pass3['type'], "Language")) {
			$innerCursor3 = pgDb::getOrgByLanguageId($pass3['id']);
			while ($inner3 = pg_fetch_array($innerCursor3)) {
				if (array_key_exists($inner3['name'], $results)) {
					array_push($results[$inner3['name']]["Language"], $pass3['name']);
				} else {
					$results[$inner3['name']] = array(
						"Programs" => array(),
						"People" => array(),
						"Language" => array($pass3['name'])
					);
				}
			}
		}
	}
	
	while ($pass4 = pg_fetch_array($cursor4)) { 
		if (!strcmp($pass4['type'], "Program")) {
			$innerCursor4 = pgDb::getOrgByProgramId($pass4['id']);
			while ($inner4 = pg_fetch_array($innerCursor4)) {
				if (array_key_exists($inner4['name'], $results)) {
					array_push($results[$inner4['name']]["Programs"], $pass4['name']);
				} else {
					$results[$inner4['name']] = array(
						"Programs" => array($pass4['name']),
						"People" => array(),
						"Language" => array()
					);
				}
			}
		}
	}

}


/*

$results2 = array (

	"Illinois Masonic" => array(
			"Programs" => array(
					"CPE" => array(
							"People" => array("Kirsten Peachey", "Kathy Flint"),	
							"Language" => array("English", "Spanish")						
					),
					"Another Worthy Program" => array(
							"People" => array(),	
							"Language" => array("Urdu")						
					),
					
			),
			"People" => array("Michelle Obama"),
			"Language" => array("English", "Spanish")
		),

	"Aging Gracefully" => array(
			"Programs" => array(
					"BAM" => array(
							"People" => array(),
							"Language" => array()
					)
			),
			"People" => array("Barack Obama", "Paul Simon"),
			"Language" => array()
	),
	
	"What Will Happen?" => array(
			"Programs" => array(),
			"People" => array(),
			"Language" => array()
	)
);

*/

?>

