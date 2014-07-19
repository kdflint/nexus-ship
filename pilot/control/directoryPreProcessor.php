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
	$cursor = pgDb::freeSearch($_GET['newSearch']);
	$title = "Search Results";
} else {
	$cursor = null;
	$title = "Your Recent Searches";
}

Organization		Match On		

/*

[0] variable table name
[1] id
[2] name

organization


user

	pull name using id
	pull org name(s) by using org_user
	
	if row['table'] == "Person"
		select name
		from organization o, user_organization uo
		where o.id = uo.organization_fk
		and uo.user_fk = row['id']

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


*/

?>

