
<? 

include '../control/directoryPreProcessor.php';

?>

<div class="leftColumn">
	<p><a href="#">Search</a></p>
	<form action="../control/searchProcessor.php" method="post">
			<img src="image/mag-glass.jpg" width="25" height="25" /> <input type="text" size="20" name="string" value=""/> <input type="submit" value="Go"/>

			<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<select name="topic" style="width: 230px">    
					<option value="0" selected>Health Topics</option><br/>	
					<!-- TODO: make this list dynamic by network -->
					<option value="1" >------------</option><br/>				
					<option value="7">Chaplaincy/Spiritual Care</option><br/>
					<option value="8">Children's Health</option><br/>
					<option value="13">Emergency Preparedness</option><br/>
					<option value="14">End of Life Care</option><br/>
					<option value="16">Ethics</option><br/>
					<option value="17">Flu Clinic</option><br/>
					<option value="18">Food Access</option><br/>
					<option value="19">Grief and Bereavement</option><br/>
					<option value="27">Leadership Development</option><br/>
					<option value="30">Nutrition</option><br/>
					<option value="31">Parish Nursing</option><br/>
					<option value="33">Policy and Advocacy</option><br/>
					<option value="34">Primary Care</option><br/>
					<option value="37">Spiritual Care</option><br/>
				</select></p>			
	</form>

<? 
		//$counter = 0;
  	if (!empty($results)) {
?>	
		<div style="overflow:auto;width:350px;height:400px;">

		<table>
  	<tr><td colspan="2"><p><a href="#"><? echo($title); ?></a></p></td><td><p><a href="#">Send Message<a href="#"></p></td>
  		<td> </td></tr>
<?	
		//echo "<td><td>" . var_dump($results) . "</td></tr>";
		//echo "<td><td>original = " . $_GET['newSearch'] . "</td></tr>";
		//echo "<td><td>counter = " . $counter . "</td></tr>";
		ksort($results);
		foreach ($results as $org => $orgComponents) {
			echo "<tr><td>" . $org;
				// ksort($results[$org]["Programs"]);
				
				foreach ($results[$org]["Programs"] as $key => $value) {
					echo "<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" . $value;
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
					echo "<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" . $value;
				}
				//foreach ($results[$org]["Language"] as $key => $value) {
				//	echo "<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" . $value;
				//}
			echo "<tr><td>";
		}
		
  		//while ($row = pg_fetch_array($results)) { 
?>
				<!--
				<tr>
				<td valign="top">
					<a id="imageDivLink<? echo $counter; ?>" href="javascript:toggle('contentDivImg<? echo $counter; ?>', 'imageDivLink<? echo $counter; ?>');"><img style="margin:5px;" src="image/plus.png" height="15" width="15" /></a></td>
				<td valign="top"><? echo $row['table']; ?>
					<div id="contentDivImg<? echo $counter; ?>" style="display:none;">
					<p class="indented" ><b>Primary contact: </b><? echo $row['id']; ?></p>
					<p class="indented" ><b><? echo $row['name']; ?></b></p>
					<p class="indented" ><a href="#">Detail</a> | <a href="#">Send a message</a></a></p>
					</div>
				</td>
				<td valign="top"><img src="image/light_green.png" />
				</td>
				</tr>
				-->
<? 
			//$counter++;
?>
			<tr><td colspan="3" style="text-align:right;"><p><form><input type="submit" value="Export" /></form></p></td></tr>
			</table>
			</div> 
<?
		}
?>

	
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

