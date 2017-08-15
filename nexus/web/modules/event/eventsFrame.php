
  <script>  
  	$(function() { 
	  	$("input[name='event-state-filter']").change(function(e){
    		if($(this).val() === 'event-list-pending') {
		     	getEventListPending(<?php echo (time() + 15*60); ?>);
	  		} else if($(this).val() === 'event-list-public')  {
	     		getEventListFilter(<?php echo (time() + 15*60); ?>, 'public');
    		} else {
    			getEventListFilter(<?php echo (time() + 15*60); ?>, 'network');
    		}
			});
		});	
  </script>

	<div id="event-secondary" class="secondaryControlContainer">
		<?php if(Utilities::isSessionAdmin()) { ?>
			<a href='#openEventEdit' onclick="return resetEventForm();" class="secondaryControl" title="Add New Event"><span class='fa fa-calendar-o fa-lg' ></span><span style='padding-left:2px;' class='fa fa-plus' ></span></a>
		<?php } ?>
		<a href="#" onclick="toggleTertiary('event-tertiary');" class="secondaryControl" title="Change Filter"><span style='padding:0px;' class='fa fa-filter fa-lg' ></span></a>
		<!-- TODO - add a pointer like forum -->
		<div id="event-tertiary" class="tertiaryControlContainer" style="display:none;">
			<form action="#" class="pure-form">
				<p>Show these events:</p>
				<?php if(Utilities::isSessionAdmin()) { ?>
					<input type="radio" name="event-state-filter" onchange="toggleTertiary('event-tertiary');" value="event-list-pending" checked>&nbsp;Pending</br>
				<?php } ?>
				<input type="radio" name="event-state-filter" onchange="toggleTertiary('event-tertiary');" value="event-list-public" <?php if(!Utilities::isSessionAdmin()) { ?>checked<?php } ?>>&nbsp;Public</br>
				<input type="radio" name="event-state-filter" onchange="toggleTertiary('event-tertiary');" value="event-list-network">&nbsp;Network</br>
			</form>
		</div>
	</div>
	<!-- TODO - move this div id out to advFrame.php? -->
	<div id="event-frame">
		<div id="current_schedule_display" style="display:block;">
			<div id="reservationTable" class=""></div>
		</div>
		 <?php 
			 	include("views/eventListPending.php");
			 	include("views/eventListFilter.php"); 
		 ?>
	</div>
	
	<?php if(Utilities::isSessionAdmin()) { ?>
		<script> getEventListPending(<?php echo (time() + 15*60); ?>); </script>
	<?php } else { ?>
		<script> getEventListFilter(<?php echo (time() + 15*60); ?>, 'public'); </script>
	<?php } ?>