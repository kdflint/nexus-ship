

<?php
require_once("scripts/noscript.php");
?>	

<!-- TODO - make this div same class as below to inherit border style? -->
<!-- 
TODO - recalculate frame borders based on height of rendered content. See
https://www.jsnippet.net/snippet/536/Sidebar-pin-to-left-with-dynamic-tabs
-->
<div id="adv_frame_display" style="display:none;">
	<iframe id="adv-frame" src="production_placeholder.html" style="width:100%;border:0;margin:0;padding:0;height:5000px;overflow:hidden;" scrolling="no"></iframe>
</div>

<div class="adv-frame-contents" id="adv_div_display" style="display:block;">
	<div id="event_display" class="div-display" style="display:block;">
		<?php require_once("modules/event/eventsFrame.php"); ?>
	</div>
	<div id="network_display" class="div-display" style="display:none;">
		<?php require_once("modules/directory/networkFrame.php"); ?>
	</div>
</div>


