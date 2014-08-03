
<? 

include '../control/directoryPreProcessor.php';

?>

<div class="topLeftQuad">
	<p><a href="#">Search Your Network</a></p>
	<form action="../control/searchProcessor.php" method="post">
			<img src="image/mag-glass.jpg" width="25" height="25" /> <input type="text" size="20" name="string" value=""/> <input type="submit" value="Go"/>

			<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<select name="topic" style="width: 230px">    
					<option value="0" selected>Health Topics</option>	
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
				</select></p>			
							
				<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<select name="type" style="width: 230px">    
					<option value="0" selected>Organization Type</option>
					<option value="0" >------------</option>
					<option value="">Academic</option>
					<option value="">Collaborative/Network</option>
					<option value="">Community Organization</option>
					<option value="">Faith Community/House of Worship</option>
					<option value="">Government</option>
					<option value="">Health Care Provider</option>
				</select></p>	
				
				<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<select name="type" style="width: 230px">    
					<option value="0" selected>Room for One More Filter</option>
					<option value="0" >------------</option>
				</select></p>	
	</form>
</div>

<form>

<div class="topRightQuad">
	<p><a href="#">Send a Message</a></p>
</div>

<div class="lowerHalf" style="overflow:auto;">

  Results | Detail | <a href="nexus.php?showMap=1" >Map</a>
  
		<div id="default" style="display:block;font-size:11px;">
			<? include("include/tmpResults/" . $fileId . ".php"); ?>
		</div>

		<div id="detail" style="display:none;font-size:11px;">
			<a href="nexus.php?thisPage=directory" onClick="toggleDisplay('default')">Some text</a>
		</div>

</div> 

</form>

<!--

<div class="lowerHalf">
		<a href="nexus.php?showMap=0" onClick="toggleDisplay('browse')">Results</a> | <a href="nexus.php?showMap=0&showDetail=1" onClick="toggleDisplay('detail')">Detail</a> | <a href="nexus.php?showMap=1" >Map</a>
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
-->

					<!--
					<tr>
					<td valign="top">
						<a id="imageDivLink<? echo $counter; ?>" href="javascript:toggle('contentDivImg<? echo $counter; ?>', 'imageDivLink<? echo $counter; ?>');"><img style="margin:5px;" src="image/plus.png" height="15" 	width="15" /></a></td>
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

