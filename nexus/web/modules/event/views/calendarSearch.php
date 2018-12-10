  <script>  
  	$(function() { 
	  	$("input[name='event-state-filter']").change(function(e){
    		if($(this).val() === 'event-list-pending') {
		     	getEventListPending(<?php echo (time() + 15*60); ?>);
	  		} else if($(this).val() === 'event-list-public') {
	     		getEventListFilter(<?php echo (time() + 15*60); ?>, 'public');
    		} else if($(this).val() === 'event-list-network') {
    			getEventListFilter(<?php echo (time() + 15*60); ?>, 'network');
    		} else if($(this).val() === 'event-list-recorded') {
    			getEventListRecorded();
    		}
			});
		});	
  </script>

<span class='detail' style="font-size:140%;">Calendar Search</span>
<form id="calendar-form" class="pure-form" action="#" method="post" id="">
	<?php if(Utilities::isSessionAdmin()) { ?>
		<div style="margin-top:10px;">
			<input type="radio" name="event-state-filter" onchange="toggleTertiary('event-tertiary');" value="event-list-pending" checked>&nbsp;Pending</br>
		</div>
	<?php } ?>
	<div style="margin-top:10px;">
		<input type="radio" name="event-state-filter" onchange="toggleTertiary('event-tertiary');" value="event-list-public" <?php if(!Utilities::isSessionAdmin()) { ?>checked<?php } ?>>&nbsp;Public</br>
	</div>
	<div style="margin-top:10px;">
		<input type="radio" name="event-state-filter" onchange="toggleTertiary('event-tertiary');" value="event-list-network">&nbsp;Network</br>
	</div>
	<div style="margin-top:10px;">
		<input type="radio" name="event-state-filter" onchange="toggleTertiary('event-tertiary');" value="event-list-recorded">&nbsp;Recorded</br>
	</div>	
</form>
