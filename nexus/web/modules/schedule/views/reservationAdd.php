<table style="border:2px solid #a6c3ce !important;background: #EDF0DE none repeat scroll 0% 0%;" class="pure-table">
	<tr>
  	<td>
  		<div class="event">
  			<span class="date">New</span><br/>
  			<span>Reservation</span>
			</div>
		</td>
    <td>
			<form id="schedule-form" class="pure-form" action="modules/schedule/control/scheduleProcessor.php" method="post">
				<fieldset>
      		<div>
	      		<input type="text" name="meeting-name" style="width:97%;" maxlength="50" placeholder="Purpose" >
					</div>
					<div id="tz-static" style="display:block;margin-top:10px;">
						<span style="font-size:90%;line-height:240%;"><b>Time Zone: </b><span id="local-tzDisplay"><?php echo $_SESSION['timezone']; ?></span><a href="javascript:void(0);" onclick="showTimeZoneDisplay('tz-select');" style="margin-left:10px;">Change</a></span>
						<input id="local-tzFormField" type="hidden" name="tzone-name" value="<?php echo $_SESSION['timezone']; ?>" />
					</div>
					<div id="tz-select" style="display:none;margin-top:10px;">
						<span style="font-size:90%;"><b>Time Zone: </b>
						<select id="country">
							<option selected>Country</option>
							<?php include("timeZoneCountryOptions.html"); ?>
						</select>
						<select id="countryTimeZones" style="width:137px;">
							<option selected>Time Zone</option>
						</select>
					</div>
					<div style="margin-top:10px;">
	      		<input type="text" id="datepicker" name="meeting-date" placeholder="Date" style="width:120px;margin-top:-32px;">	
      			<select id="schedule-form-time" name="meeting-time" style="width:135px;vertical-align:middle;">
	      			<option selected>Time</option>
	      			<?php include("meetingTimeOptions.html"); ?>
      			</select>	 
      			<select id="schedule-form-duration" name="meeting-duration" style="width:135px;vertical-align:middle;">
	      			<option selected>Duration</option>
	      			<?php include("meetingDurationOptions.html"); ?>
      			</select>
		    	</div> 			
				</fieldset>
			</form>  
		</td>
    <td>
    	<a href="javascript:void(0);" onclick="document.getElementById('schedule_control').click();" style="float:right;margin-right:6px;">Cancel</a><br/>
      <a id="schedule-form-submit" class="pure-button button-menu" href="javascript:void(0)" onclick="eventValidateAndSubmit('schedule-form');" style="float:right;background-color:#d27b4b;width:70px;font-size:90%;margin-top:45px;color:#e6e6e6">Reserve</a>
 		</td>
	</tr>
</table> 

<?php if (!isset($_SESSION['timezone']) || $_SESSION['timezone'] == "undefined") { ?>
	<script>
	  showTimeZoneDisplay('tz-select');
	</script> 
<?php } ?>

