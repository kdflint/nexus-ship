<?php if ($_SESSION['nexusContext'] === "ADV") { ?>
	<span class='detail' style="font-size:140%;">Organization Directory</span>	<a id='member_view_control' href="#" onclick="switchToMemberView();" class="secondaryControl" title="Member Directory" style="display:none;"><span class='fa fa-users fa-lg'></span></a>
<?php } ?>

<form id="directory-form" class="pure-form" action="" method="post" id="searchForm">
	<div style="margin-top:10px;">
		<?php if ($_SESSION['nexusContext'] === "PUB") { ?>
			<span class='date detail' style="margin-top:5px;">Directory Search</span>
		<?php } ?>
		<p style="font-size:80%;margin-left:36px;">A keyword may be part of a name, address, or program description.</p>
		<span class="fa fa-search" style="margin-right:18px;"></span><input type="text" name="keyword" style="width:86%;" placeholder="Keywords (up to three)"/>
	</div>
	<?php if ($_SESSION['networkId'] === "18") { ?>
		<div style="margin-top:10px;">
			<span class="searchQualifier">and</span>
			<input type="text" name="keyword2" style="width:86%;" placeholder="Language is"/>	
		</div>
		<div style="margin-top:10px;">
			<span class="searchQualifier">and&nbsp;</span>
			<select id="directory-form-select-affiliation" name="affiliation">
				<option value="0" selected>Denomination is</option>	
				<option value="0" >------------</option>	
	    	<?php include(Utilities::getPartnerCustomRoot() . "/orgaffiliation-" . $_SESSION['networkId'] . ".html"); ?>
    	</select>
		</div>
	<?php } ?>
	<div style="margin-top:10px;">
		<span class="searchQualifier">and&nbsp;</span>
		<select id="directory-form-select-specialty" name="specialty">
			<option value="0" selected>Focus Area is</option>	
			<option value="0" >------------</option>	
	    <?php include(Utilities::getPartnerCustomRoot() . "/orgfocus-" . $_SESSION['networkId'] . ".html"); ?>
    </select>
	</div>
	<div style="margin-top:10px;">
		<span class="searchQualifier">and&nbsp;</span>
		<select id="directory-form-select-type" name="type">
			<option value="0" selected>Organization Type is</option>
			<option value="0" >------------</option>
			<?php include(Utilities::getPartnerCustomRoot() . "/orgtype-" . $_SESSION['networkId'] . ".html"); ?>
		</select>
	</div>
  <a id="directory-form-submit" class="pure-button button-menu" href="javascript:void(0)" onclick="getDirectoryList('directory-form');" style="float:right;background-color:#d27b4b;width:70px;font-size:90%;margin-top:25px;color:#e6e6e6" >Search</a>
  <a id="directory-form-reset" href="javascript:void(0)" onclick="resetDirectorySearchForm();" style="float:left;margin-top:32px;">Reset Form</a>
</form>