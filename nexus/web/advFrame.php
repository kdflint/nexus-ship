					<div class="secondaryControls">
						<a href='#openModal' title="New Meeting"><span style='padding:0px;' class='fa fa-calendar-o fa-2x' ></span><span style='padding-left:2px;' class='fa fa-plus' ></span></a>
					</div>
			  	<noscript>
			  		<p><span class="fa fa-exclamation-triangle fa-2x" style="color:#d27b4b;float:left;margin-right:5px;"></span>To use Nexus it is necessary to enable JavaScript.</p>
			  		<p>Here are the <a href="http://www.enable-javascript.com" target="_blank"> instructions how to enable JavaScript in your web browser</a></p>
			  	</noscript>	

					<!-- Left off here - how to toggle this content -->
					<!--http://www.w3schools.com/howto/howto_html_include.asp-->
			  	
			  	<!--<div w3-include-html="modules/event/mod_controller.php"></div>-->
						<div id="adv_frame_display">
							<?php include("modules/event/mod_controller.php"); ?>
						</div>
						<div id="openModal" class="modalDialog">
							<div>
								<a href="#close" title="Close" class="close">X</a>
								<?php include("modules/event/views/eventAddAdvantage2.php"); ?>
							</div>
						</div>
