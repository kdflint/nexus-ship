<table style="border:2px solid #a6c3ce !important;background: #EDF0DE none repeat scroll 0% 0%;" class="pure-table">
	<tr>
  	<td>
  		<div class="event">
  			<span class="date">Start</span><br/>
  			<span>Now</span>
			</div>
		</td>
    <td>
			<form id="now-form" class="pure-form" action="modules/schedule/control/scheduleProcessor.php" method="post">
				<fieldset>
      		<div>
	      		<input type="text" name="meeting-name" style="width:97%;" maxlength="50" placeholder="Purpose" >
					</div>
					<div style="margin-top:10px;">
      			<select id="now-form-type" name="meeting-type" style="width:232px;vertical-align:middle;">
	      			<?php include("meetingTypeOptions.html"); ?>			
      			</select>	 
      			<select id="now-form-duration" name="meeting-duration" style="width:132px;vertical-align:middle;">
	      			<?php include("meetingDurationOptions.html"); ?>
      			</select>
		    	</div> 	
		    	<input type="hidden" name="meeting-date" value="today" />
		    	<!-- Weird id for this form field required to make the javascript event validation reusable -->
		    	<input id="now-form-time-button" type="hidden" name="meeting-time" value="now" />
		    	<input type="hidden" name="tzone-name" value="system" />
  			</fieldset>
			</form>   
		</td>
    <td>
    	<a href="javascript:void(0);" onclick="document.getElementById('join_control').click();" style="float:right;margin-right:6px;">Cancel</a><br/>
      <a id="now-form-submit" class="pure-button button-menu" href="javascript:void(0);" onclick="eventValidateAndSubmit('now-form');" style="float:right;background-color:#d27b4b;width:90px;font-size:90%;margin-top:45px;color:#e6e6e6">Open Room</a>
 		</td>
	</tr>
</table> 

