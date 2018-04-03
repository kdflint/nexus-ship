<table style="border:2px solid #a6c3ce !important;background: #EDF0DE none repeat scroll 0% 0%;" class="pure-table">
	<tr>
  	<td>
  		<div class="event">
  			<span class="date"><?php echo _("New"); ?></span><br/>
  			<span><?php echo _("Reservation"); ?></span>
			</div>
		</td>
    <td>
			<form id="schedule-form" class="pure-form" action="modules/schedule/control/scheduleProcessor.php" method="post">
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
		    		<?php include("meetingTypeTooltip.php"); ?>
		    		<select id="schedule-form-type" name="meeting-type" style="width:370px;vertical-align:middle;">
		    			<?php include("meetingTypeOptions.php"); ?>
		    		</select>
		    	</div> 			
				</fieldset>
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

