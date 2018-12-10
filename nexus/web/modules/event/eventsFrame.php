	<div id="event-secondary" class="secondaryControlContainer">
		<?php if(Utilities::isSessionAdmin()) { ?>
			<a href='#openEventEdit' onclick="return resetEventForm();" class="secondaryControl" title="Add New Event"><span class='fa fa-calendar-o fa-lg' ></span><span style='padding-left:2px;' class='fa fa-plus' ></span></a>
		<?php } ?>
	</div>
	<!-- TODO - move this div id out to advFrame.php? -->
	<div id="event-frame">
		<div class="controlCol" style="left:15px;border-right: 1px solid #eeeeee;margin-top:-10px;">
			<?php include(Utilities::getModulesRoot() . "/event/views/calendarSearch.php"); ?>
		</div>
		<div id="current_schedule_display" class="displayCol" style="border:0px !important;overflow:visible;font-size:80%;margin-top:40px;">
				<div id="reservationTable" class=""></div>
		 	<?php 
			 		include("views/eventListPending.php");
			 		include("views/eventListFilter.php"); 
			 		include("views/eventListRecorded.php"); 
		 	?>
		</div>		
	</div>
	
	<?php if(Utilities::isSessionAdmin()) { ?>
		<script> getEventListPending(<?php echo (time() + 15*60); ?>); </script>
	<?php } else { ?>
		<script> getEventListFilter(<?php echo (time() + 15*60); ?>, 'public'); </script>
	<?php } ?>