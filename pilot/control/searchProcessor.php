<?php

error_reporting(E_ALL);
ini_set( 'display_errors','1'); 

session_start();

include("../model/pgDb.php");
include("util.php");

// TODO: Handle these posts more thoroughly

$string = $_POST['string'];
$filter = "";
$orgId = $_POST['id'];
$action = "none";

// TODO: Handle these posts more thoroughly

if ($_POST['topic'] > 0) {
	$filter = $_POST['topic'];
}

if (isset($_POST['action']) && strlen($_POST['action']) > 0) {
	$action = $_POST['action'];
}

if (!strcmp($action, "search")) {
	$results = doNewSearch($string, $filter, $_SESSION['networkId']);
	$searchId = formatNewSearchResults($results);
	header("location:../view/nexus.php?thisPage=directory&searchId=" . $searchId);
	exit(0);

} else if (!strcmp($action, "detail")) {
	$results = doDetailSearch($orgId);
	//$detailId = formatDetailSearchResults($results);
	//header("location:../view/nexus.php?thisPage=directory&detailId=" . $detailId);
	exit(0);	
	
	
} else {
	echo("no action specified");
	//header("location:../view/nexus.php?thisPage=directory");
	exit(0);	
	
}

function doDetailSearch($id) {
		$result = pgDb::getOrgDetailById($id);
		// LEFT OFF
		// test by echoing the data structure
		// exit(0);
		return $result;
}

function formatDetailSearchResults(array $results) {
		$fileId = Util::newUuid();
		$file = fopen("../view/include/tmpDetail/" . $fileId . ".php","w") or die("Unable to open file!");
		fwrite($file, $results[0]);	
		fclose($file);
		return $fileId;
}

function doNewSearch($inputString, $filter, $networkId) {
	
	$results = array();
	$terms = trim($inputString);
	
	// TODO: This seems to leave intact leading spaces, resulting in a bad search term which is matching the entire directory
	
	
	// If we have free search terms, process the first three.
	if (strlen($terms) > 0) {

		$searchTerms = preg_split("/[\s,]+/", $terms);
		$counter = 0;
	
		// TODO: weed out search terms < 2 chars
		// TODO: solve for 2 orgs with same name
	
		while ($counter < 3 && isset($searchTerms[$counter])) {
		
			// TODO: Seriously?? Seems that iterating a cursor dismantles a cursor... Perhaps must return a standard data type from pgDb so I can make copies?? 
			$cursor1 = pgDb::freeSearch($searchTerms[$counter], $networkId);
			$cursor2 = pgDb::freeSearch($searchTerms[$counter], $networkId);
			$cursor3 = pgDb::freeSearch($searchTerms[$counter], $networkId);
			$cursor4 = pgDb::freeSearch($searchTerms[$counter], $networkId);
			$cursor5 = pgDb::freeSearch($searchTerms[$counter], $networkId);
			$cursor6 = pgDb::freeSearch($searchTerms[$counter], $networkId);
			
			while ($pass1 = pg_fetch_array($cursor1)) { 
				if (!strcmp($pass1['type'], "Organization")) {
					if (array_key_exists($pass1['name'], $results)) {
						// do nothing - we already have an index for this org in the data set
					} else {
						$results[$pass1['name']] = array(
							"Programs" => array(),
							"People" =>  array(),
							"Contact" => array(),
							"Language" => array(),
							"Location" => array(),
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
						   	"Contact" => array(),
								"Language" => array(),
								"Location" => array(),
								"OrgId" => $inner2['id']
							);
						}
					}
				}
			}
		
			while ($pass5 = pg_fetch_array($cursor5)) { 
				if (!strcmp($pass5['type'], "Contact")) {
					$innerCursor5 = pgDb::getOrgByContactId($pass5['id']);
					while ($inner5 = pg_fetch_array($innerCursor5)) {
						if (array_key_exists($inner5['name'], $results)) {
							if (!in_array($pass5['name'], $results[$inner5['name']]["Contact"])) {
								array_push($results[$inner5['name']]["Contact"], $pass5['name']);
							}
						} else {
							$results[$inner5['name']] = array(
								"Programs" => array(),
								"People" => array(),
						  	"Contact" => array($pass5['name']),
								"Language" => array(),
								"Location" => array(),
								"OrgId" => $inner5['id']
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
								"Contact" => array(),
								"Language" => array($pass3['name']),
						  	"Location" => array(),
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
								"Contact" => array(),
								"Language" => array(),
								"Location" => array(),
								"OrgId" => $inner4['id']
							);
						}
					}
				}
			}
		
			while ($pass6 = pg_fetch_array($cursor6)) { 
				if (!strcmp($pass6['type'], "Location")) {
					$innerCursor6 = pgDb::getOrgByLocationId($pass6['id']);
					while ($inner6 = pg_fetch_array($innerCursor6)) {
						if (array_key_exists($inner6['name'], $results)) {
							if (!in_array($pass6['name'], $results[$inner6['name']]["Location"])) {
								array_push($results[$inner6['name']]["Location"], $pass6['name']);
							}
						} else {
							$results[$inner6['name']] = array(
								"Programs" => array(),
								"People" => array(),
						  	"Contact" => array(),
								"Language" => array(),
								"Location" => array($pass6['name']),
								"OrgId" => $inner6['id']
							);
						}
					}
				}
			}
			
			$counter++;
		}

		// On top of the free search term results, layer the filter if we have one
		if (isset($filter) && $filter > 1) {
			foreach ($results as $key=>$val) {
				$row = pg_fetch_row(pgDb::orgTopicExists($val['OrgId'], $filter));
				$topicMatch = $row[0];
				if (strcmp($topicMatch, "t")) {
					unset($results[$key]);
				}
			}	
		}
	
	// We get here if there are no free search terms. So, run a simple filter search if one exists
	} else if (isset($filter) && $filter > 0) {
		$cursor = pgDb::getOrgByTopicIds($filter, $networkId);
		while ($row = pg_fetch_array($cursor)) {
			$results[$row['name']] = array(
				"Programs" => array(),
				"People" =>  array(),
				"Contact" => array(),
				"Language" => array(),
				"Location" => array(),
				"OrgId" => $row['id']
			);
		}
	
	} else {
		// We get here if we had no free search terms or filter. 
	}
	
	return $results;

}

function formatNewSearchResults(array $results) {

	if (!empty($results)) {
		
		// TODO: Figure out a way to purge files
	
		$fileId = Util::newUuid();
		$file = fopen("../view/include/tmpResults/" . $fileId . ".php","w") or die("Unable to open file!");
		fwrite($file, "<table>\n");
	
		ksort($results);
		foreach ($results as $org => $orgComponents) {
				
				// LEFT OFF - does this capture the org id??
				fwrite($file, "<tr><td colspan=\"2\"><a href=\"javascript:post('../control/searchProcessor.php',{action:'detail',id:'" . $orgComponents['OrgId'] . "'})\">" . $org . "</a></td></tr>\n");
				//fwrite($file, "<tr><td colspan=\"2\"><a href=\"javascript:post('../control/searchProcessor.php',{action:'detail',id:'56'})\">" . $org . "</a></td></tr>\n");
				// ksort($results[$org]["Programs"]);
				
				foreach ($results[$org]["Programs"] as $key => $value) {
					fwrite($file, "<tr><td>&nbsp;</td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" . $value . "</td></tr>\n");
					/*
					TODO: implement program people and program language. See example data structure in comments of directoryPreProcessor.php
					
					foreach ($results[$org]["Programs"][$program]["People"] as $key => $value) {
						echo $value;
					}
					foreach ($results[$org]["Programs"][$program]["Language"] as $key => $value) {
						echo $value;
					}
					*/
				}
		
				foreach ($results[$org]["People"] as $key => $value) {
					fwrite($file, "<tr><td><input type=\"checkbox\" name=\"\" value=\"\"></td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" . $value . "</td></tr>\n");
				}
				//foreach ($results[$org]["Language"] as $key => $value) {
				//	echo "<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" . $value;
				//}
				foreach ($results[$org]["Contact"] as $key => $value) {
					fwrite($file, "<tr><td>&nbsp;</td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" . $value . "</td></tr>\n");
				}
				foreach ($results[$org]["Location"] as $key => $value) {
					fwrite($file, "<tr><td>&nbsp;</td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" . $value . "</td></tr>\n");
				}
				
		}
	
		fwrite($file, "</table>\n");
		fclose($file);	
	
	} else {	
		$fileId = "noResults";
	}
	
	return $fileId;
}


?>