<?php

include '../control/searchPreProcessor.php';

?>

<div class="topLeftQuad">

	<form action="../control/searchProcessor.php" method="post">
		<input type="hidden" name="action" value="search" />
		<p><a href="#">Search</a>	</p>
		<table cellpadding="5">
			<tr><td>&nbsp;</td><td><input type="radio" name="scope" value="group" checked />Your groups
		<input type="radio" name="scope" value="network" />Entire network </td></tr>
			<tr><td><img src="image/mag-glass.jpg" width="25" height="25" /></td><td><input type="text" size="20" name="string" value=""/></td></tr>
			<tr><td><i>and</i></td><td>
				<select name="topic" style="width: 230px">    
					<option value="0" selected>Specialty is</option>	
					<!-- TODO: make this list dynamic by network -->
					<option value="0" >------------</option>										
					<option value="1">Access/Rights</option>
					<option value="2">Addictions/Substance Abuse</option>
					<option value="3">Adolescent Health</option>
					<option value="4">Aging</option>
					<option value="5">Cancer</option>
					<option value="6">Cardiovascular Disease</option>
					<option value="7">Chaplaincy/Spiritual Care</option>
					<option value="8">Children's Health</option>
					<option value="9">Chronic Disease Prevention and Management</option>
					<option value="10">Community Garden/Urban Agriculture</option>
					<option value="11">Dental Health</option>
					<option value="12">Diabetes</option>
					<option value="13">Emergency Preparedness</option>
					<option value="14">End of Life Care</option>
					<option value="15">Environmental Issues</option>
					<option value="16">Ethics</option>
					<option value="17">Flu Clinic</option>
					<option value="18">Food Access</option>
					<option value="19">Grief and Bereavement</option>
					<option value="20">Health Fair</option>
					<option value="21">Health Ministry</option>
					<option value="22">HIV/AIDS</option>
					<option value="23">Immigrant Health</option>
					<option value="24">Immunization</option>
					<option value="25">Interfaith Understanding and Collaboration</option>
					<option value="26">Latino Community</option>
					<option value="27">Leadership Development</option>
					<option value="28">Maternal and Child Health</option>
					<option value="29">Mental Health</option>
					<option value="30">Nutrition</option>
					<option value="31">Parish Nursing</option>
					<option value="32">Physical Activity</option>
					<option value="33">Policy and Advocacy</option>
					<option value="34">Primary Care</option>
					<option value="35">Recreational Training</option>
					<option value="36">Research</option>
					<option value="37">Spiritual Care</option>
					<option value="38">Spirituality and Healing</option>
					<option value="39">Violence Prevention and Intervention</option>
					<option value="40">Wholistic Healing</option>
					<option value="41">Women's Health</option>
				</select></td></tr>	
							
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
	
		<div style="font-size:12px;">
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
<input type="hidden" name="pageRestore" value="<? echo(!strcmp($pageMode, "results") ? $searchResultId : $detailResultId); ?>" />
</form>

