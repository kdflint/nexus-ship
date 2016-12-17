<!-- TODO - move standard blue border style to here -->

<?php
require_once("scripts/noscript.php");
?>	

<div id="adv_frame_display" style="display:none;">
	<iframe id="adv-frame" src="development_placeholder.html" style="width:100%;border:0;margin:0;padding:0;height:5000px;overflow:hidden;" scrolling="no"></iframe>
</div>

<div id="adv_div_display" style="border: 1px solid #004d62 !important;width:100%;border-radius:10px;display:block;">
	<div id="event_display" class="div-display" style="display:block;">
		<?php require_once("modules/event/eventsFrame.php"); ?>
	</div>
	<div id="network_display" class="div-display" style="display:none;">
		<?php require_once("modules/directory/networkFrame.php"); ?>
	</div>
</div>


