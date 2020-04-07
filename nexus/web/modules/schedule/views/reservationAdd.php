<table style="border:2px solid #a6c3ce !important;background: #EDF0DE none repeat scroll 0% 0%;" class="pure-table">
	<tr>
  	<td>
  		<div class="event">
  			<span class="date"><?php echo _("New"); ?></span><br/>
  			<span><?php echo _("Reservation"); ?></span>
			</div>
		</td>
    <td>
			<form id="schedule-form" class="pure-form" action="modules/schedule/control/scheduleProcessor.php" method="post" style="width:105%;">
				<fieldset>
      		<div>
	      		<input type="text" name="meeting-name" style="width:396px;" maxlength="50" placeholder="<?php echo _("Meeting Name"); ?>" >
					</div>
					<div id="tz-static" style="display:block;margin-top:10px;">
						<span style="font-size:90%;line-height:240%;"><b><?php echo _("Time Zone"); ?>: </b><span id="local-tzDisplay"><?php echo $_SESSION['timezone']; ?></span><a href="javascript:void(0);" onclick="showTimeZoneDisplay('tz-select');" style="margin-left:10px;"><?php echo _("Change"); ?></a></span>
						<input id="local-tzFormField" type="hidden" name="tzone-name" value="<?php echo $_SESSION['timezone']; ?>" />
						<input id="local-tzFormChange" type="hidden" name="tzone-change" value="false" />
					</div>
					<div id="tz-select" style="display:none;margin-top:10px;">
						<span style="font-size:90%;"><b><?php echo _("Time Zone"); ?>: </b>
						<select id="schedule-form-country">
							<option value="AA" selected><?php echo _("Country"); ?></option>
							<?php include("timeZoneCountryOptions.html"); ?>
						</select>
						<select id="schedule-form-countryTimeZones" style="width:137px;">
							<option selected><?php echo _("Time Zone"); ?></option>
						</select>
					</div>
					<div style="margin-top:10px;">
	      		<input type="text" id="datepicker" name="meeting-date" placeholder="<?php echo _("Date"); ?>" style="width:120px;vertical-align:top;">	
      			<select id="schedule-form-time" name="meeting-time" style="width:135px;vertical-align:middle;">
      				<option selected><?php echo _("Time"); ?></option>
	      			<?php include("meetingTimeOptions.html"); ?>
      			</select>	 
      			<select id="schedule-form-duration" name="meeting-duration" style="width:135px;vertical-align:middle;">
	      			<?php include("meetingDurationOptions.php"); ?>
      			</select>
				</div>
				

				<div style="margin-top:10px;">
					
						<span style="vertical-align:top;font-size:90%;"><input id="repeat-check" name="repeat-check" onchange="toggleRecurNWMFormElements();" type="checkbox"> <b>Repeat</b></span>
						<span id="repeat-span" style="visibility:hidden;margin-left:10px;font-size: 90%;vertical-align:top;">				
							<span style="vertical-align:top;padding:5px;">Occurs </span><select id="schedule-form-repeat-interval" name="repeat-interval" style="width:125px;">
								<option value="0" selected>Daily</option>
								<option value="1">Weekdays</option>
								<option value="2">Weekly</option>
								</select>	
							<span style="vertical-align:top;padding:5px;">for </span><select id="schedule-form-repeat-freq" name="repeat-freq" style="width:56px;">
									<option value="2" selected>2</option>
									<option value="3">3</option>
									<option value="4">4</option>
									<option value="5">5</option>
									<option value="6">6</option>
									<option value="7">7</option>
									<option value="8">8</option>
									<option value="9">9</option>
									<option value="10">10</option>
								</select><span id="repeat-freq-descr" style="vertical-align:top;padding:5px;">days</span>
						</span>
 				</div>


		    	<div style="margin-top:10px;">
		    		<?php include("meetingTypeTooltip.php"); ?>
		    		<select id="schedule-form-type" name="meeting-type" style="width:370px;vertical-align:middle;">
		    			<?php include("meetingTypeOptions.php"); ?>
		    		</select>
		    	</div> 			
				</fieldset>
				<input type="hidden" name="meeting-recur-duration" value="false" />
			</form>  
		</td>
    <td>
    	<a href="javascript:void(0);" onclick="resetScheduleForm();" style="float:right;margin-right:6px;"><?php echo _("Cancel"); ?></a><br/>
      <a id="schedule-form-submit" class="pure-button button-menu" href="javascript:void(0)" onclick="eventValidateAndSubmit('schedule-form');" style="float:right;background-color:#d27b4b;width:70px;font-size:90%;margin-top:45px;color:#e6e6e6" <?php echo($disabled); ?> ><?php echo _("Reserve"); ?></a>
 		</td>
	</tr>
</table> 

<?php if (!isset($_SESSION['timezone']) || $_SESSION['timezone'] == "undefined") { ?>
	<script>
	  showTimeZoneDisplay('tz-select');
	</script> 
<?php } ?>

