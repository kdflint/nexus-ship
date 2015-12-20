<table style="border:2px solid #a6c3ce !important;background: #EDF0DE none repeat scroll 0% 0%;" class="pure-table">
	<tr>
  	<td>
  		<div class="event">
  			<span class="date">New</span><br/>
  			<span>Event</span>
			</div>
		</td>
    <td>
			<form id="schedule-form" class="pure-form" action="<?php echo(Utilities::getHttpPath()); ?>/modules/schedule/control/scheduleProcessor.php" method="post">
				<fieldset>
      		<div style="margin-top:10px;">
	      		<input type="text" name="meeting-name" style="width:396px;" maxlength="50" placeholder="Meeting Name" >
					</div>
      		<div style="margin-top:10px;">
	      		<textarea name="meeting-descr" style="width:396px;" rows="4" maxlength="400" placeholder="Description"></textarea>
					</div>
      		<div style="margin-top:10px;">
	      		<input type="text" name="meeting-url" style="width:396px;" maxlength="50" placeholder="Web Link" >
					</div>
					<div style="margin-top:10px;">
      			<textarea name="meeting-registr" style="width:396px;" rows="2" maxlength="200" placeholder="Registration Information"></textarea>
					</div>
      		<div style="margin-top:10px;">
	      		<input type="text" name="registration-url" style="width:396px;" maxlength="50" placeholder="Registration Link" >
					</div>
      		<div style="margin-top:10px;">
      			<textarea name="meeting-loc" style="width:396px;" rows="2" maxlength="200" placeholder="Location"></textarea>
					</div>
					<div id="tz-static" style="display:block;margin-top:10px;">
						<span style="font-size:90%;line-height:240%;"><b>Time Zone: </b><span id="local-tzDisplay"><?php echo $_SESSION['timezone']; ?></span><a href="javascript:void(0);" onclick="showTimeZoneDisplay('tz-select');" style="margin-left:10px;">Change</a></span>
						<input id="local-tzFormField" type="hidden" name="tzone-name" value="<?php echo $_SESSION['timezone']; ?>" />
						<input id="local-tzFormChange" type="hidden" name="tzone-change" value="false" />
					</div>
					<div id="tz-select" style="display:none;margin-top:10px;">
						<span style="font-size:90%;"><b>Time Zone: </b>
						<select id="schedule-form-country">
							<option value="AA" selected>Country</option>
							<?php include(Utilities::getModulesRoot() . "/schedule/views/timeZoneCountryOptions.html"); ?>
						</select>
						<select id="schedule-form-countryTimeZones" style="width:137px;">
							<option selected>Time Zone</option>
						</select>
					</div>
					<div style="margin-top:10px;">
	      		<input type="text" id="datepicker" name="meeting-date" placeholder="Date" style="width:120px;margin-top:-32px;">	
      			<select id="schedule-form-time" name="meeting-time" style="width:135px;vertical-align:middle;text-align:left;">
      				<option selected>Time</option>
	      			<?php include(Utilities::getModulesRoot() . "/schedule/views/meetingTimeOptions.html"); ?>
      			</select>	 
      			<select id="schedule-form-duration" name="meeting-duration" style="width:135px;vertical-align:middle;text-align:left;">
	      			<?php include(Utilities::getModulesRoot() . "/schedule/views/meetingDurationOptions.html"); ?>
      			</select>
		    	</div>
      		<div>
      			<p>Who may we contact with questions about this meeting?</p>
	      		<input type="text" name="meeting-contact" style="width:396px;" maxlength="50" placeholder="Contact Email" >
					</div>
		    	<input id="schedule-form-isBbb" name="isBbbMeeting" type="checkbox" style="visibility:hidden;"/>

				</fieldset>
			</form>  
		</td>
    <td>
    	<a href="javascript:void(0);" onclick="resetScheduleForm();" style="float:right;margin-right:6px;">Cancel</a><br/>
      <a id="schedule-form-submit" class="pure-button button-menu" href="javascript:void(0)" onclick="eventValidateAndSubmit('schedule-form');" style="float:right;background-color:#d27b4b;width:70px;font-size:90%;margin-top:45px;color:#e6e6e6" <?php echo($disabled); ?> >Add</a>
 		</td>
	</tr>
</table> 

<?php if (!isset($_SESSION['timezone']) || $_SESSION['timezone'] == "undefined") { ?>
	<script>
	  showTimeZoneDisplay('tz-select');
	</script> 
<?php } ?>
