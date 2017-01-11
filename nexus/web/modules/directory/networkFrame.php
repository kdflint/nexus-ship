<?php

require_once("control/searchPreProcessor.php");

$userMessage = "Select recipients from right";

if(isset($_GET['userMessage'])) {
	$userMessage = $_GET['userMessage'];
}

?>

<div id="network-secondary" class="secondaryControlContainer">
	<a href='#openDirectoryEdit' onclick="return resetDirectoryForm();" class="secondaryControl" title="Add New Organization"><span class='fa fa-address-card-o fa-lg' ></span><span style='padding-left:2px;' class='fa fa-plus' ></span></a>
	<!-- TODO - move js controls from public to nexus.js -->
	<a id='map_control' href="#" onclick="initMap();" class="secondaryControl" title="Map View"><span id="directory_control" class='fa fa-globe fa-lg'></span></a>
	<a id="secondary-network-filter"class="secondaryControl" href="#" onclick="toggleTertiary('network-tertiary');" title="Change Filter"><span class='fa fa-filter fa-lg' ></span></a>
	<!--<a id="secondary-network-edit" class="secondaryControl" href="#openDirectoryEdit" onclick="return populateDirectoryForm();" title="Edit Organization" style="display:none;"><span class='fa fa-pencil fa-lg' ></span></a>-->
	<a id="secondary-network-edit" class="secondaryControl" href="#" onclick="alert('Edit functionality on the way...')" title="Edit Organization" style="display:none;"><span class='fa fa-pencil fa-lg' ></span></a>
	<div id="network-tertiary" class="tertiaryControlContainer" style="display:none;">
		Filter by group menu
	</div>
</div>

<div id="network-frame" style="height:420px;">
	<div class="controlCol" style="left:15px;border-right: 1px solid #eeeeee;">
		<?php //echo "Sticky count " . $stickyCount; ?>
		<?php //echo "Search string " . $stickyString; ?>
		<?php include(Utilities::getModulesRoot() . "/directory/views/directorySearch.php"); ?>
	</div>
	<div id="show-directoryResults" class="displayCol" style="border:0px !important;width:600px;margin-left:5px;margin-top:-10px;">
		<?php include(Utilities::getModulesRoot() . "/directory/views/directorySummary.php"); ?>
	</div>
	<div id="show-directoryDetail" class="displayCol displayDetail" style="display:none;border:0px !important;margin-left:5px;margin-top:-10px;">
		<?php include(Utilities::getModulesRoot() . "/directory/views/directoryDetail.php"); ?>
	</div>
</div>




