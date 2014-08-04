<div class="topLeftQuad">
	<p><a href="#">Search Your Network</a></p>
	<form action="../control/searchProcessor.php" method="post">
			<input type="hidden" name="action" value="search" />
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

<div class="rightColumn" style="overflow:auto;">

  Results | Detail | Map
  
  <? if (isset($_GET['searchId']) && strlen($_GET['searchId']) == 36) { ?>
  
		<div style="font-size:11px;">
			<? include("include/tmpResults/" . $_GET['searchId'] . ".php"); ?>
		</div>
		
	<? } else if (isset($_GET['detailId']) && strlen($_GET['detailId']) == 36) { ?>

		<div style="font-size:11px;">
			<? //include("include/tmpDetail/" . $_GET['detailId'] . ".php"); ?>
			<div style="font-size:10px;position: relative; float: left; width:220px;border: 1px solid #da5e00;overflow:auto;">
				<p>Organization Name</p>
				<p>all kinds of stuff about the org...</p>
			</div>
			<div style="font-size:10px;position:relative; float: right; width:220px;border: 1px solid #da5e00;overflow:auto;">
				<p>Collaborators</p>
				<p>all kinds of stuff about the org...</p>
			</div>
		</div>
		
	<? } else { ?> 
	
		<p>Nothing to see here... move along...</p>
		
	<? } ?>

</div> 

<div class="lowerLeftQuad">
	<p><a href="#">Send a Message</a></p>
	<form>
	</form>
</div>




