			<form id="schedule-form" class="pure-form" action="<?php echo(Utilities::getHttpPath()); ?>/modules/schedule/control/scheduleProcessor.php" method="post" enctype="multipart/form-data">
				<fieldset style="position:absolute;width:400px;">
      		<p style="width:100%;font-size:130%;font-weight:bold;line-height:80%;" class='detail'>New Event Submission Form</p>					
      		<div style="margin-top:10px;">
	      		<input type="text" name="meeting-name" style="width:100%;" maxlength="50" placeholder="Meeting Name" >
					</div>
       		<div style="margin-top:10px;">
	      		<input type="text" name="meeting-url" style="width:100%" maxlength="50" placeholder="Web Link (http://)" >
					</div>
      		<div style="margin-top:10px;">
	      		<textarea name="meeting-descr" style="width:100%" rows="4" maxlength="1500" placeholder="Description"></textarea>
					</div>
					<div style="margin-top:10px;">
      			<textarea name="meeting-registr" style="width:100%;" rows="2" maxlength="200" placeholder="Registration Information"></textarea>
					</div>
      		<div style="margin-top:10px;">
	      		<input type="text" name="registration-url" style="width:100%;" maxlength="50" placeholder="Registration Link (http://" >
					</div>
				</fieldset>
				<fieldset style="position:absolute;left:420px;width:290px;">

					<div id="tz-static" style="display:block;margin-top:10px;">
						<span style="font-size:90%;line-height:240%;"><b>Time Zone: </b><span id="local-tzDisplay"><?php echo $_SESSION['timezone']; ?></span><a href="javascript:void(0);" onclick="showTimeZoneDisplay('tz-select');" style="margin-left:10px;">Change</a></span>
						<input id="local-tzFormField" type="hidden" name="tzone-name" value="<?php echo $_SESSION['timezone']; ?>" />
						<input id="local-tzFormChange" type="hidden" name="tzone-change" value="false" />
					</div>
					<div id="tz-select" style="display:none;margin-top:10px;">
						<!--<span style="font-size:90%;"><b>Time Zone: </b><br/>-->
						<select id="schedule-form-country" style="width:137px;">
							<option value="AA" selected>Country</option>
							<?php include(Utilities::getModulesRoot() . "/schedule/views/timeZoneCountryOptions.html"); ?>
						</select>
						<select id="schedule-form-countryTimeZones" style="width:137px;">
							<option selected>Time Zone</option>
						</select>
					</div>
					<div style="margin-top:10px;">
	      		<input type="text" id="datepicker" name="meeting-date" placeholder="Start Date" style="width:137px;vertical-align:top;">	
      			<select id="schedule-form-time" name="meeting-time" style="width:135px;vertical-align:middle;text-align:left;">
      				<option selected>Start Time</option>
	      			<?php include(Utilities::getModulesRoot() . "/schedule/views/meetingTimeOptions.html"); ?>
      			</select>
      		</div>	 
      		<div style="margin-top:10px;">
	      		<input type="text" id="datepicker-end" name="meeting-date-end" placeholder="End Date" style="width:137px;vertical-align:top;">	
      			<select id="schedule-form-time-end" name="meeting-time-end" style="width:135px;vertical-align:middle;text-align:left;">
      				<option selected>End Time</option>
	      			<?php include(Utilities::getModulesRoot() . "/schedule/views/meetingTimeOptions.html"); ?>
      			</select>
      			<input type="hidden" name="meeting-duration" value="false" />
		    	</div>
      		<div style="margin-top:10px;">
      			<input type="text" name="meeting-loc" style="width:100%;" maxlength="200" placeholder="Location"></textarea>
					</div>
      		<div style="margin-top:10px;">
	      		<input type="text" name="meeting-contact" style="width:100%" maxlength="50" placeholder="Contact Email" >
					</div>
					<div style="margin-top:10px;">
						<p style="font-size:90%;line-height:240%;"><b>Attach a file</b> (optional)</p>
						<input type="file" name="fileToUpload" id="fileToUpload" style="width:90%;" onchange="toggleFileClear();"><a id="fileClearControl" href="javascript:void(0)" onclick="clearFileInput(document.getElementById('fileToUpload'));" style="display:none;"><span class="fa fa-times" style="margin-left:10px;"></span></a>
					</div>
		    	<input id="schedule-form-isBbb" name="isBbbMeeting" type="checkbox" style="visibility:hidden;"/>
		      <a id="schedule-form-submit" class="pure-button button-menu" href="javascript:void(0)" onclick="eventValidateAndSubmit('schedule-form');" style="float:right;background-color:#d27b4b;width:70px;font-size:90%;margin-top:25px;color:#e6e6e6">Submit</a>
    			<a href="<?php echo(Utilities::getPluginPath()); ?>/publicSuite.php?oid=<?php echo($_SESSION['orgUid']); ?>&amp;context=calendar" style="float:right;margin-right:20px;margin-top:28px;"><span id="cancel_link">Cancel</span></a>
				</fieldset>
			</form>     
			
<?php if (!isset($_SESSION['timezone']) || $_SESSION['timezone'] == "undefined") { ?>
	<script>
	  showTimeZoneDisplay('tz-select');
	</script> 
<?php } ?>

