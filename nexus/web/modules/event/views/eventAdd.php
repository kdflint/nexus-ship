
			<form id="schedule-form" class="pure-form" action="<?php echo(Utilities::getHttpPath()); ?>/modules/schedule/control/scheduleProcessor.php" method="post" enctype="multipart/form-data">
				<fieldset style="position:absolute;width:450px;">
      	<span style="font-size:130%;font-weight:bold;" class='detail'>New Event Submission Form</span></br>					
      		<div style="margin-top:10px;">
	      		<input type="text" name="meeting-name" style="width:100%;" maxlength="100" placeholder="Meeting Name" >
					</div>
       		<div style="margin-top:10px;">
	      		<input type="text" name="meeting-url" style="width:100%" maxlength="500" placeholder="Web Link (http://)" >
					</div>
      		<div style="margin-top:10px;">
	      		<textarea name="meeting-descr" style="width:100%" rows="4" maxlength="1500" placeholder="Description"></textarea>
					</div>
					<div style="margin-top:10px;">
      			<textarea name="meeting-registr" style="width:100%;" rows="2" maxlength="200" placeholder="Registration Information"></textarea>
					</div>
      		<div style="margin-top:10px;">
	      		<input type="text" name="registration-url" style="width:100%;" maxlength="500" placeholder="Registration Link (http://)" >
					</div>
				</fieldset>
				<fieldset style="position:absolute;left:460px;width:450px;">
					<a href="javascript:void(0)" onclick="document.getElementById('schedule-form-cancel').click();" style="float:right;"><span class="fa fa-times-circle-o fa-2x"></span></a>
					<div id="tz-static" style="display:block;margin-top:0px;">
						<span style="font-size:90%;line-height:240%;"><b>Time Zone: </b><span id="local-tzDisplay"><?php echo $_SESSION['timezone']; ?></span><a href="javascript:void(0);" onclick="showTimeZoneDisplay('tz-select');" style="margin-left:10px;">Change</a></span>
						<input id="local-tzFormField" type="hidden" name="tzone-name" value="<?php echo $_SESSION['timezone']; ?>" />
						<input id="local-tzFormChange" type="hidden" name="tzone-change" value="false" />
					</div>
					<div id="tz-select" style="display:none;margin-top:10px;">
						<select id="schedule-form-country" style="width:137px;">
							<option value="AA" selected>Country</option>
							<?php include(Utilities::getModulesRoot() . "/schedule/views/timeZoneCountryOptions.html"); ?>
						</select>
						<select id="schedule-form-countryTimeZones" style="width:137px;">
							<option selected>Time Zone</option>
						</select>
					</div>
					<div style="margin-top:5px;">	
	      		<input type="text" id="datepicker" name="meeting-date" placeholder="Start Date" style="width:137px;vertical-align:top;">	
      			<select id="schedule-form-time" name="meeting-time" style="width:135px;vertical-align:middle;text-align:left;">
      				<option selected>Start Time</option>
	      			<?php include(Utilities::getModulesRoot() . "/schedule/views/meetingTimeOptions.html"); ?>
      			</select>
      		</div>	 
      		<div style="margin-top:5px;">
	      		<input type="text" id="datepicker-end" name="meeting-date-end" placeholder="End Date" style="width:137px;vertical-align:top;">	
      			<select id="schedule-form-time-end" name="meeting-time-end" style="width:135px;vertical-align:middle;text-align:left;">
      				<option selected>End Time</option>
	      			<?php include(Utilities::getModulesRoot() . "/schedule/views/meetingTimeOptions.html"); ?>
      			</select>
      			<input type="hidden" name="meeting-duration" value="false" />
		    	</div>
      		<div style="margin-top:2px;">
      			<span style="font-size:90%;line-height:240%;">
      				<input id="repeat-check" name="repeat-check" onchange="toggleRecurFormElements(0);" type="checkbox"> <b>Repeat</b>
      			</span>
      			<span id="repeat-span" style="margin-left:5px;font-size:90%;visibility:hidden;">
      				Occurs <span id="repeat-descr">daily</span> for <span id="repeat-quantity">2</span> <span class="repeat-unit">days</span>
      				<span id="repeat-edit" style="margin-left:10px;"><a href="#" onclick="toggleRecurFormElements(0);">Change</a></span>
      			</span>
		    	</div>
					<div style="min-height:160px;">
						<div id="repeat-block" style="display:none;">
      				<p style="margin-top:10px;">
	      				Occurs <select id="repeat-interval" name="repeat-interval" onchange="updateRepeatDescr(this);" style="position:absolute;left:70px;width:208px;height: 2.5em;">
	      					<option value="0" selected>Daily</option>
      						<option value="1">Weekdays</option>
      						<option value="2">Weekly</option>
      						</select>	
      				</p>
      				<p style="padding-top:10px;">
	      				For <span style="position:absolute;left:70px;">
									<select id="repeat-freq" name="repeat-freq" onchange="updateRepeatFreq(this);" style="position:absolute;left:0px;width:50px;">
	      						<option value="2" selected>2</option>
      							<option value="3">3</option>
      							<option value="4">4</option>
      							<option value="5">5</option>
      							<option value="6">6</option>
      							<option value="7">7</option>
      							<option value="8">8</option>
      							<option value="9">9</option>
      							<option value="10">10</option>
      						</select>
	      				</span>
	      				<span class="repeat-unit" style="position:absolute;left:130px;">days</span>
		      			<a id="repeat-done" class="pure-button button-menu" href="javascript:void(0)" onclick="toggleRecurFormElements(1);" style="float:right;background-color:#bbbbbb;width:70px;font-size:90%;margin-top:25px;color:#e6e6e6">Set</a>
		      		</p>
 						</div>
						<div id="location-block" style="display:block;">
	      			<div style="margin-top:5px;">
	      				<input type="text" name="meeting-loc" style="width:100%;" maxlength="200" placeholder="Location">
							</div>
      				<div style="margin-top:10px;">
		      			<input type="text" name="meeting-contact" style="width:100%" maxlength="50" placeholder="Contact Email" >
							</div>
							<div style="margin-top:10px;">
								<p id="attachment-label" style="font-size:90%;line-height:240%;"><b>Attach a file</b> (optional)</p>
								<input type="file" name="fileToUpload" id="fileToUpload" style="width:90%;" onchange="toggleFileClear();"><a id="fileClearControl" href="javascript:void(0)" onclick="clearFileInput(document.getElementById('fileToUpload'));" style="display:none;"><span class="fa fa-times" style="margin-left:10px;"></span></a>
							</div>
						</div>
					</div>
		    	<input id="schedule-form-isBbb" name="isBbbMeeting" type="checkbox" style="visibility:hidden;"/>
		      <a id="schedule-form-submit" class="pure-button button-menu" href="javascript:void(0)" onclick="eventValidateAndSubmit('schedule-form');" style="float:right;background-color:#d27b4b;width:70px;font-size:90%;margin-top:25px;color:#e6e6e6">Submit</a>
    			<a id="schedule-form-cancel" href="<?php echo(Utilities::getPluginPath()); ?>/publicSuite.php?oid=<?php echo($_SESSION['orgUid']); ?>&amp;context=calendar" style="float:right;margin-right:20px;margin-top:28px;"><span id="cancel_link">Cancel</span></a>
				</fieldset>
				<input type="hidden" name="meeting-edit" value="false" />
				<input type="hidden" name="meeting-recur-duration" value="false" />
			</form>     
			
<?php if (!isset($_SESSION['timezone']) || $_SESSION['timezone'] == "undefined") { ?>
	<script>
	  showTimeZoneDisplay('tz-select');
	</script> 
<?php } ?>

