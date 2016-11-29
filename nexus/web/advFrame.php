
  <script>
  $(function() {
    var circle = $( "#circle" );
 
 		// TODO - rename these variable
    $( "#color" ).selectmenu({
       change: function( event, data ) {
         var eventBlock = data.item.value;
         if (eventBlock == "event-list-pending") {
         	getEventListPending(<?php echo (time() + 15*60); ?>);
        } else {
         	getEventListPublic(<?php echo (time() + 15*60); ?>);
        }
       }
     });
  });
  </script>

					<div class="secondaryControls">
						<form action="#">
						  <div id="circle"></div>
    						<select name="color" id="color">
      						<option value="event-list-pending" selected>Pending</option>
      						<option value="event-list-public">Public</option>
    						</select>
						</form>
						<!--<a href='#openModal' onclick="return resetEventForm();" title="New Meeting" style="float:right;"><span style='padding:0px;' class='fa fa-calendar-o fa-2x' ></span><span style='padding-left:2px;' class='fa fa-plus' ></span></a>-->
					</div>
			  	<noscript>
			  		<p><span class="fa fa-exclamation-triangle fa-2x" style="color:#d27b4b;float:left;margin-right:5px;"></span>To use Nexus it is necessary to enable JavaScript.</p>
			  		<p>Here are the <a href="http://www.enable-javascript.com" target="_blank"> instructions how to enable JavaScript in your web browser</a></p>
			  	</noscript>	

						<div id="adv_frame_display">
								 <?php 
								 	include("modules/event/views/eventListPending.php");
								 	include("modules/event/views/eventListPublic.php"); 
								 ?>
						</div>
						<div id="openModal" class="modalDialog">
							<div>
								<a href="#close" title="Close" class="close">X</a>
								<?php include("modules/event/views/eventAddAdvantage2.php"); ?>
							</div>
						</div>
