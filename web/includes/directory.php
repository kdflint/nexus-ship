<?php

include("util/db.php");
include("util/util.php");

session_start();

Db::connect();

if (isset($_GET['newSearch'])) {
	$cursor = Db::freeSearch($_GET['newSearch']);
	$title = "Search Results";
} else {
	$cursor = Db::getRecentSearches($_SESSION['uidpk']);
	$title = "Your Recent Searches";
}

Db::disconnect();

?>

<div class="leftColumn">
	<p><a href="#">Search</a></p>
	<form action="searchProcessor.php" method="post">
			<img src="images/mag-glass.jpg" width="25" height="25" /> <input type="text" size="20" name="string" value=""/> <input type="submit" value="Go"/>
			<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<select name="topic" style="width: 230px">    
				<option value="0" selected>Service Area</option><br/>				
				<option value="36">Food Services</option><br/>
				<option value="34">Health Clinic</option><br/>
				<option value="46">Domestic Counseling</option><br/>
				<option value="50">Housing Services</option><br/>
				<option value="51">Youth Services</option><br/>
				</select></p>
				
			<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<select name="topic" style="width: 230px">    
				<option value="0" selected>Geography</option><br/>				
				<option value="36">Probably implemented as a dynamic map selector</option><br/>
				</select></p>
				
			<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<select name="topic" style="width: 230px">    
				<option value="0" selected>Other Filters TBD</option><br/>				
				<option value="36">For example, language, accessability, etc.</option><br/>
				</select></p>
				
	</form>
	
  <table>
  	<tr><td colspan="2"><p><a href="#"><? echo($title); ?></a></p></td><td><p><a href="#">Online?<a href="#"></p></td></td>
  
  <? 
  	$counter = 0;
  	while ($row = mysql_fetch_array($cursor, MYSQL_BOTH)) { 
  ?>
		

			<tr><td valign="top">
			
			<a id="imageDivLink<? echo $counter; ?>" href="javascript:toggle('contentDivImg<? echo $counter; ?>', 'imageDivLink<? echo $counter; ?>');"><img style="margin:5px;" src="images/plus.png" height="15" width="15" /></a></td><td valign="top"><? echo $row[0]; ?>
			<div id="contentDivImg<? echo $counter; ?>" style="display:none;">
				<p class="indented" ><b>Primary contact: </b><? echo $row[1]; ?></p>
				<p class="indented" ><b><? echo $row[2]; ?></b></p>
				<p class="indented" ><b>Online now? </b><span style="color:green;">Yes</span></p>
				<p class="indented" ><a href="#">Detail</a> | <a href="#">Send a message</a> | <a href="#">Invite to chat</a></p>
			</div>	</td>
			<td valign="top"><img src="http://northbridgetech.org/images/light_green.png" /></td>
			</tr>
  
	<? 
		$counter++;
		}	
	?>
		<tr><td colspan="3" style="text-align:right;"><p><form><input type="submit" value="Export" /></form></p></td></tr>
	</table>
	
</div>

<div class="rightColumn">
		<a href="nexus.php?showMap=0" onClick="toggleDisplay('browse')">Browse</a> | <a href="nexus.php?showMap=0&showDetail=1" onClick="toggleDisplay('detail')">Detail</a> | <a href="nexus.php?showMap=1" >Map</a>
		<hr/>
		<? 
		if (isset($_GET['showMap']) && $_GET['showMap'] === "1") {
				include("map.php");
		} else if (isset($_GET['showDetail']) && $_GET['showDetail'] === "1") {
		?>
			<div id="detail" style="display:block;font-size:12px;"><? include("detail.php"); ?></div>
		<? } else { ?>
			<div id="default" style="display:block;font-size:12px;"><? include("browse.php"); ?></div>
			<div id="browse" style="display:none;font-size:12px;"><? include("browse.php"); ?></div>
			<div id="detail" style="display:none;font-size:12px;"><? include("detail.php"); ?></div>
		<? } ?>
</div>

