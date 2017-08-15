<table style="border:2px solid #a6c3ce !important;background: #EDF0DE none repeat scroll 0% 0%;" class="pure-table">
	<tr>
  	<td>
  		<div class="event">
  			<span class="date">New</span><br/>
  			<span>Web Meeting</span>
  			<span>Reservation</span>
			</div>
		</td>
    <td>
			<form id="event-add-bbb-form" class="pure-form" action="modules/schedule/control/scheduleAddBbbProcessor.php" method="post">
				<fieldset>
					
      		<div>
	      		<p><b>Reserve Web Meeting room for</b></p><p><span id="schedule-form-meeting-name"></span></p>	
	      	</div>

		    	<div style="margin-top:10px;">
		    		<?php include(Utilities::getModulesRoot() . "/schedule/views/meetingTypeTooltip.html"); ?>
		    		<select id="schedule-form-type" name="meeting-type" style="width:370px;vertical-align:middle;">
		    			<?php include(Utilities::getModulesRoot() . "/schedule/views/meetingTypeOptions.html"); ?>
		    		</select>
		    	</div>
		    	
	    		<input type="hidden" name="meeting-uuid" value="" />
	    		
	    		<a id="event-add-bbb-form-submit" class="pure-button button-menu" href="javascript:void(0);" onclick="eventTypeAddValidateAndSubmit('event-add-bbb-form');" style="float:right;background-color:#d27b4b;width:70px;font-size:90%;margin-top:-10px;color:#e6e6e6" >Add</a>
					<a href="#close" style="float:right;margin-right:20px;">Cancel</a>
		
				</fieldset>
			</form>  
 		</td>
	</tr>
</table> 