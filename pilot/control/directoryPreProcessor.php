<?php

include("../model/pgDb.php");
include("../control/util.php");

$title = "Search Results";
$terms = "";
$results = array();

if (isset($_GET['newSearch'])) {
	
	// TODO: This seems to leave intact leading spaces, resulting in a bad search term which is matching the entire directory
	$terms = trim($_GET['newSearch']);
}

// If we have free search terms, process the first three.
if (strlen($terms) > 0) {

	$searchTerms = preg_split("/[\s,]+/", $_GET['newSearch']);
	$counter = 0;
	
	// TODO: weed out search terms < 2 chars
	// TODO: solve for 2 orgs with same name
	
	while ($counter < 3 && isset($searchTerms[$counter])) {
		
		// TODO: Seriously?? Seems that iterating a cursor dismantles a cursor... Perhaps must return a standard data type from pgDb so I can make copies?? 
		$cursor1 = pgDb::freeSearch($searchTerms[$counter], $_SESSION['networkId']);
		$cursor2 = pgDb::freeSearch($searchTerms[$counter], $_SESSION['networkId']);
		$cursor3 = pgDb::freeSearch($searchTerms[$counter], $_SESSION['networkId']);
		$cursor4 = pgDb::freeSearch($searchTerms[$counter], $_SESSION['networkId']);
		
		while ($pass1 = pg_fetch_array($cursor1)) { 
			if (!strcmp($pass1['type'], "Organization")) {
				if (array_key_exists($pass1['name'], $results)) {
					// do nothing - we already have an index for this org in the data set
				} else {
					$results[$pass1['name']] = array(
						"Programs" => array(),
						"People" =>  array(),
						"Language" => array(),
						"OrgId" => $pass1['id']
				);
				}
				
			}
		}
		
		while ($pass2 = pg_fetch_array($cursor2)) { 
			if (!strcmp($pass2['type'], "Person")) {
				$innerCursor2 = pgDb::getUserOrgRelationsByUserId($pass2['id']);
				while ($inner2 = pg_fetch_array($innerCursor2)) {
					if (array_key_exists($inner2['name'], $results)) {
						if (!in_array($pass2['name'], $results[$inner2['name']]["People"])) {
							array_push($results[$inner2['name']]["People"], $pass2['name']);
						}
					} else {
						$results[$inner2['name']] = array(
							"Programs" => array(),
							"People" => array($pass2['name']),
							"Language" => array(),
							"OrgId" => $inner2['id']
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
						if (!in_array($pass3['name'], $results[$inner3['name']]["Language"])) {
							array_push($results[$inner3['name']]["Language"], $pass3['name']);
						}
					} else {
						$results[$inner3['name']] = array(
							"Programs" => array(),
							"People" => array(),
							"Language" => array($pass3['name']),
							"OrgId" => $inner3['id']
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
						if (!in_array($pass4['name'], $results[$inner4['name']]["Programs"])) {
							array_push($results[$inner4['name']]["Programs"], $pass4['name']);
						}
					} else {
						$results[$inner4['name']] = array(
							"Programs" => array($pass4['name']),
							"People" => array(),
							"Language" => array(),
							"OrgId" => $inner4['id']
						);
					}
				}
			}
		}

		$counter++;
	}

	// On top of the free search term results, no layer the filter if we have one
	if (isset($_GET['filter']) && $_GET['filter'] > 1) {
		foreach ($results as $key=>$val) {
			$row = pg_fetch_row(pgDb::orgTopicExists($val['OrgId'], $_GET['filter']));
			$topicMatch = $row[0];
			if (strcmp($topicMatch, "t")) {
				unset($results[$key]);
			}
		}	
	}
	
// We get here if there are no free search terms. So, run a simple filter search if one exists
} else if (isset($_GET['filter']) && $_GET['filter'] > 1) {
	$cursor = pgDb::getOrgByTopicIds($_GET['filter'], "14"); // $_SESSION['networkId']);
	while ($row = pg_fetch_array($cursor)) {
		$results[$row['name']] = array(
			"Programs" => array(),
			"People" =>  array(),
			"Language" => array(),
			"OrgId" => $row['id']
		);
	}
	
} else {
	// We only get here if we had no free search terms or filter. 
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

