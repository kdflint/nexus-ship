<?php

error_reporting(E_ALL);
ini_set( 'display_errors','1'); 

session_start();

include("../model/pgDb.php");
include("util.php");

$string = $orgId = $action = "";
$filter = 0;

if (isset($_POST['string'])) {
	$string = $_POST['string'];
}

if (isset($_POST['id']) && strlen($_POST['id']) > 0) {
	$orgId = $_POST['id'];
}

if (isset($_POST['topic']) && $_POST['topic'] > 0) {
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
	$detailId = formatDetailSearchResults($results);
	header("location:../view/nexus.php?thisPage=directory&detailId=" . $detailId);
	exit(0);	
	
} else if (!strcmp($action, "message")) {
	header("location:../view/nexus.php?thisPage=directory");
	exit(0);
	
} else {
	// No action recognized
	header("location:../view/nexus.php?thisPage=directory");
	exit(0);	
	
}

function doNewSearch($inputString, $filter, $networkId) {
	
	$results = array();
	//$terms = trim($inputString);
	$terms = trim(Util::strip($inputString));
		
	// TODO: Escape apostrophes instead of stripping
	// TODO: allow quote marks
	// TODO: solve for 2 orgs with same name
	
	// If we have free search terms, process the first three.
	if (strlen($terms) > 0) {

		$searchTerms = preg_split("/[\s,]+/", $terms);
		$counter = 0;
	
		while ($counter < 3 && isset($searchTerms[$counter])) {
						
			if (preg_match("/^[Tt][Hh][Ee]$/", $searchTerms[$counter]) ||
					preg_match("/^[Aa][Nn]$/", $searchTerms[$counter]) ||
					preg_match("/^[Aa]$/", $searchTerms[$counter]) ||
					strlen($searchTerms[$counter]) < 2
					) {
				$counter++;
				continue;
			}
			
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
			
			// This is what is happening below, as pattern for the rest
			// $pass2 holds all matching data records from the original search, each typed. Here we are pulling out the "Person" record types
			// For each "Person" record type, we go get the orgs associated with this Person (user_organization table)
			// For each org, loop
			// If the organization name is already indexed in the master $results array
			// BUT
			// This particular Person is NOT already indexed therein
			// 		Set a Person associative index inside the $results record, where User Id is key, Person name is value
			// Otherwise create a new index for this organization inside $results and include this Person
		
			while ($pass2 = pg_fetch_array($cursor2)) { 
				if (!strcmp($pass2['type'], "Person")) {
					$innerCursor2 = pgDb::getUserOrgRelationsByUserId($pass2['id']);
					while ($inner2 = pg_fetch_array($innerCursor2)) {
						if (array_key_exists($inner2['name'], $results)) {
							if (!in_array($pass2['name'], $results[$inner2['name']]["People"])) {
								$results[$inner2['name']]['People'][$pass2['id']] = $pass2['name'];
							}
						} else {					
							$results[$inner2['name']] = array(
								"Programs" => array(),
								"People" => array($pass2['id'] => $pass2['name']),
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
		fwrite($file, "<div>\n");
	
		ksort($results);
		foreach ($results as $org => $orgComponents) {
				
				fwrite($file, "<p style=\"margin-top:15px;\"><a href=\"javascript:post('../control/searchProcessor.php',{action:'detail',id:'" . $orgComponents['OrgId'] . "'})\">" . $org . "</a></p>\n");
				// ksort($results[$org]["Programs"]);
				
				foreach ($results[$org]["Programs"] as $key => $value) {
					fwrite($file, "<p style=\"margin-left:20px;\">" . $value . "</p>\n");
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
					$disabled = "disabled";
					if (pgDb::isUserMessageEnabled($key)) {
						$disabled = "";
					}
					fwrite($file, "<p style=\"margin-left:20px;\"><input type=\"checkbox\" name=\"names[]\" value=\"" . $key . "::" . $value . "\" onchange=\"messageToFill()\" " . $disabled . " \></td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" . $value . "</p>\n");
				}
				//foreach ($results[$org]["Language"] as $key => $value) {
				//	echo "<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" . $value;
				//}
				foreach ($results[$org]["Contact"] as $key => $value) {
					fwrite($file, "<p style=\"margin-left:20px;\">" . $value . "</p>\n");
				}
				foreach ($results[$org]["Location"] as $key => $value) {
					fwrite($file, "<p style=\"margin-left:20px;\">" . $value . "</p>\n");
				}
				
		}
	
		fwrite($file, "</div>\n");
		fclose($file);	
	
	} else {	
		$fileId = "noResults";
	}
	
	return $fileId;
}

function doDetailSearch($id) {
		$result = pgDb::getOrgDetailById($id);
		return $result;
}

function formatDetailSearchResults(array $results) {
		$fileId = Util::newUuid();
		$file = fopen("../view/include/tmpDetail/" . $fileId . ".php","w") or die("Unable to open file!");

		fwrite($file, "<div style=\"position:relative;overflow:auto;height:460px;\">\n");	
		fwrite($file, "<p class=\"detailHeader1\">" . $results['orgName'] . "</p>\n");
		
		fwrite($file, "<table cellpadding=\"5\" width=\"95%\">\n<tr valign=\"top\">\n<td width=\"50%\">");

		fwrite($file, "<div class=\"collaboratorsList\">");
		fwrite($file, "<p class=\"detailHeader2\">Collaborators</p>\n");
		foreach ($results['orgUser'] as $key => $value) {
			if (count($value) > 0) {
				fwrite($file, "<p>");
				$disabled = "disabled";
				if (!strcmp($value[1], "t") || !strcmp($value[2], "t")) {
					$disabled = "";
				}
				fwrite($file, "<input type=\"checkbox\" name=\"names[]\" value=\"" . $value[3] . "::" . $value[0] . "\" onchange=\"messageToFill()\" " . $disabled . " \>");
				fwrite($file, $value[0]);
				fwrite($file, "</p>\n");
			} else {
				fwrite($file, "<p>No active collaborators</p>");
			}
		}
		fwrite($file, "</div>");
		
		fwrite($file, "<p class=\"detailHeader2\">Programs</p>");
		foreach ($results["orgProgram"] as $key => $value) {
			fwrite($file, "<p class=\"detailText\">");
			fwrite($file, $value[0]); // drop off description for now . "<br/>" .  $value[1]);
			fwrite($file, "</p>\n");
		}	
	
		fwrite($file, "</td><td width=\"50%\">");
		
		fwrite($file, "<p class=\"detailHeader2\">Directory Information</p>\n");

		if (strlen($results['orgType']) > 0) {
			fwrite($file, "<p class=\"detailText\">" . $results['orgType'] . "</p>\n");
		}
		
		fwrite($file, "<p class=\"detailText\">");		
		foreach ($results["orgLocation"] as $key => $value) {
			if (strlen($value[0]) > 0) { fwrite($file, $value[0]); }
			if (strlen($value[1]) > 0) { fwrite($file, "<br/>" . $value[1]); }
		}
		fwrite($file, "</p>\n");
		
		fwrite($file, "<p class=\"detailText\">");
		foreach ($results["orgContact"] as $key => $value) {
			if (strlen($value[0]) > 0) { fwrite($file, Util::prettyPrintPhone($value[0])); }
			if (strlen($value[1]) > 0) { fwrite($file, "<br/>" . $value[1]); }
			if (strlen($value[2]) > 0) { fwrite($file, "<br/><a style=\"font-size:12px;\" href=\"" . $value[2] . "\" target=\"_blank\" >" . $value[2] . "</a>"); }
			if (strlen($value[3]) > 0) { fwrite($file, "<br/>" . $value[3]); }
		}
		fwrite($file, "</p>\n");

		fwrite($file, "<p class=\"detailHeader2\">Languages</p><p class=\"detailText\">");
		foreach ($results["orgLanguage"] as $key => $value) {
			fwrite($file,  $value . "<br/>");
		}
		fwrite($file, "</p>\n");
		
		fwrite($file, "<p class=\"detailHeader2\">Health Topics</p><p class=\"detailText\">");
		foreach ($results["orgTopic"] as $key => $value) {
			fwrite($file,  $value . "<br/>");
		}
		fwrite($file, "</p>\n");
		
		
		fwrite($file, "</td>\n</tr>\n</table>");
		fwrite($file, "</div>\n");
		
		/*
		fwrite($file, "<div style=\"font-size:10px;position:relative;float:right;width:220px;border:1px solid #da5e00;overflow:auto;height:460px;\">");	
		fwrite($file, "<p>Collaborators</p>\n");
		
		foreach ($results["orgUser"] as $key => $value) {
			fwrite($file, "<p>");
			$disabled = "disabled";
			if (!strcmp($value[1], "t") || !strcmp($value[2], "t")) {
				$disabled = "";
			}
			fwrite($file, "<input type=\"checkbox\" name=\"names[]\" value=\"" . $value[3] . "::" . $value[0] . "\" onchange=\"messageToFill()\" " . $disabled . " \>");
			fwrite($file, $value[0]);
			fwrite($file, "</p>\n");
		}
		
		fwrite($file, "</div>\n");
		*/
		
		fclose($file);
		return $fileId;
}


?>