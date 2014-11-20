<?php

include '../control/searchPreProcessor.php';

?>

<div class="topLeftQuad">

	<form action="../control/searchProcessor.php" method="post" id="searchForm">
		<input type="hidden" name="action" value="search" />
		<p><a href="#">Search</a><? echo $stickyCount; ?></p>
		<table cellpadding="5">
			<tr><td>&nbsp;</td><td><input type="radio" name="scope" value="group" <? echo $groupChecked; ?> />Your groups
		<input type="radio" name="scope" value="network" <? echo $networkChecked; ?> />Entire network </td></tr>
			<tr><td><img src="image/mag-glass.jpg" width="25" height="25" /></td><td><input type="text" size="20" name="string" value="<? echo $stickyString; ?>"/></td></tr>
			<tr><td><i>and</i></td><td>
				<select name="topic" style="width: 230px">    
					<option value="0" selected>Specialty is</option>	
					<option value="0" >------------</option>										
					<? include 'include/tmpSpecialty/' . $_SESSION['networkId'] . '.html'; ?>
				</select>
				</td></tr>	
							
				<tr><td><i>and</i></td><td>
				<select name="type" style="width: 230px">    
					<option value="0" selected>Organization Type is</option>
					<option value="0" >------------</option>
					<option value="Academic">Academic</option>
					<option value="Collaboration/Network">Collaboration/Network</option>
					<option value="Community Organization">Community Organization</option>
					<option value="Faith Community/House of Worship">Faith Community/House of Worship</option>
					<option value="Government">Government</option>
					<option value="Health Care Provider">Health Care Provider</option>
				</select>
			</td></tr>
			
			<!--
				<tr><td><i>and</i></td><td>
				<select name="type" style="width: 230px" disabled>    
					<option value="0" selected>Group is</option>
					<option value="0" >------------</option>
					<option value="">Faith Based Research</option>
				</select>
			</td></tr>
			-->
				
			<tr><td>&nbsp;</td><td><input type="submit" value="Search" style="float:right;"/></td></tr>
		</table>

	</form>
</div>

<form action="../control/messageProcessor.php" method="post" id="messageForm">
<div class="rightColumn">

	<?
		$searchResultId = $detailResultId = $pageMode = "";
		$pageMode = "default";
		
  	if (isset($_GET['searchId']) && strlen($_GET['searchId']) == 36) {
  		$_SESSION['searchId'] =  $_GET['searchId'];
	 		$pageMode = "results";
		}
		
		if (isset($_GET['detailId']) && strlen($_GET['detailId']) == 36) {
	  	$_SESSION['detailId'] =  $_GET['detailId'];
			$pageMode = "detail";
		}
		
		if (isset($_GET['mapId'])) {
			$pageMode = "map";
		}
		
		if (isset($_SESSION['searchId']) && strlen($_SESSION['searchId']) == 36) {
			$searchResultId = "&searchId=" . $_SESSION['searchId'];
		}
		
		if (isset($_SESSION['detailId']) && strlen($_SESSION['detailId']) == 36) {
			$detailResultId = "&detailId=" . $_SESSION['detailId'];
		}
		  
	?>

	<div class="navigation2">
  	<ul>
			<li<? if ($pageMode=="map") echo " id=\"currentpage\""; ?>><a href="nexus.php?thisPage=directory&mapId=0">Map</a></li>
			<li<? if ($pageMode=="detail") echo " id=\"currentpage\""; ?>><a href="nexus.php?thisPage=directory<? echo $detailResultId; ?>">Detail</a></li>
			<li<? if ($pageMode=="results" || $pageMode =="default") echo " id=\"currentpage\""; ?>><a href="nexus.php?thisPage=directory<? echo $searchResultId; ?>">Results</a></li>
		</ul>
	</div>
  
  <? if (!strcmp($pageMode, "results")) {

   ?>
		<div style="font-size:12px;height:460px;overflow:auto;">
			<? include("include/tmpResults/" . $_SESSION['searchId'] . ".php"); ?>
		</div>
		
	<? } else if (!strcmp($pageMode, "detail")) { ?>

		<div style="font-size:12px;">
			<? include("include/tmpDetail/" . $_SESSION['detailId'] . ".php"); ?>
		</div>

	<? } else if (!strcmp($pageMode, "map")) { ?>

		<div style="font-size:12px;">
			<? include("include/mapPlaceholder.php"); ?>
		</div>
		
	<? } else { // show default search results, at this time equal to group directory for this user ?> 
	
		<div style="font-size:12px;height:460px;overflow:auto;">
			<? include("include/tmpResults/" . $_SESSION['defaultSearchId'] . ".php"); ?>
		</div>	
	
	<? } ?>

</div> 

<div class="lowerLeftQuad">
	<table cellpadding="2">
		<tr><td valign="top">To:</td><td><span id="toDisplay" /></tr>
		<tr><td colspan="2">Your Message:</td></tr>
	  <!-- TODO: Figure out max length after subtracting NorthBridge text. -->
		<tr><td colspan="2"><textarea name="message" maxlength="105" rows="5" cols="34"></textarea></td></tr>
	<tr><td colspan="2"><input type="submit" id="messageSendSubmit" value="Send your Message" style="float:right;" disabled ></td></tr>
</table>
</div>

		<div id="light_userprofile" class="white_content">
		</div>
<input type="hidden" name="pageRestore" value="<? echo(!strcmp($pageMode, "results") ? $searchResultId : $detailResultId); ?>" />
</form>

