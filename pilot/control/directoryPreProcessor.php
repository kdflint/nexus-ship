<?php

include("../model/pgDb.php");
include("../control/util.php");

if (isset($_GET['newSearch'])) {
	// TODO split newSearch string on spaces up to three terms
	// for each
	//   query and collect results in memory
	// compile results
	// if there is a topic search, limit by results
	
	// assign master results to $cursor and throw back to page
	// that's all :)
	
	// TODO: Seriously?? Perhaps must return an standard data type from pgDb so I can make copies??
	$cursor1 = pgDb::freeSearch($_GET['newSearch']);
	$cursor2 = pgDb::freeSearch($_GET['newSearch']);
	$cursor3 = pgDb::freeSearch($_GET['newSearch']);
	$cursor4 = pgDb::freeSearch($_GET['newSearch']);
	$title = "Search Results";
} else {
	$cursor1 = null;
	$title = "Your Recent Searches";
}

$results = array();

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
		$cursor2 = pgDb::getUserOrgRelationsByUserId($pass2['id']);
		while ($inner2 = pg_fetch_array($cursor2)) {
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

/* LEFT OFF HERE
while ($pass3 = pg_fetch_array($cursor3)) { 
	if (!strcmp($pass3['type'], "Language")) {
		$cursor2 = pgDb::getUserOrgRelationsByUserId($pass3['id']);
		while ($inner2 = pg_fetch_array($cursor2)) {
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
*/


/*

Organization		Match On		

[0] variable table name
[1] id
[2] name

program

	pull name using id
	pull org names(s) by using org_program
	
	if row['table'] == "Program"
		select name
		from organization o, organization_program op
		where o.id = op.organization_fk
		and op.program_fk = row['id']

language

	pull language using id
	pull org names by using org_language
	
	if row['table'] == "Language"
		select name
		from organization o, organization_language ol
		where o.id = ol.organization_fk
		and ol.language_fk = row['id']




	print org, person, program, language
	
	org name
	for each person, print person name
	for each program, print program name, language name
	for each language, print language

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

