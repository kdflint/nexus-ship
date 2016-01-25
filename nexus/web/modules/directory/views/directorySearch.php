<form id="directory-form" class="pure-form" action="<?php echo(Utilities::getHttpPath()); ?>/modules/directory/control/searchProcessor.php" method="post" id="searchForm">
	<!--<input type="hidden" name="action" value="search" />-->
 	<!--<p><a href="#">Search</a><?php echo $stickyCount; ?></p>-->
	<div style="margin-top:10px;">
		<span class="fa fa-search" style="margin-right:18px;"></span><input type="text" name="keyword" style="width:86%;" placeholder="Keywords (up to three)"/>
	</div>
	<div style="margin-top:10px;">
		<span class="searchQualifier">and</span>
		<select id="directory-form-select-specialty" name="specialty" style="width:86%;">
			<option value="0" selected>Specialty is</option>	
			<option value="0" >------------</option>	
			<!-- TODO - make this list dynamic by organization -->
	    <?php include(Utilities::getModulesRoot() . "/directory/views/18.html"); ?>
    </select>
	</div>
	<div style="margin-top:10px;">
		<span class="searchQualifier">and</span>
		<select id="directory-form-select-type" name="type" style="width:86%;">
			<option value="0" selected>Organization Type is</option>
			<option value="0" >------------</option>
			<option value="Academic">Academic</option>
			<option value="Collaboration/Network">Collaboration/Network</option>
			<option value="Community Organization">Community Organization</option>
			<option value="Faith Community/House of Worship">Faith Community/House of Worship</option>
			<option value="Government">Government</option>
			<option value="Health Care Provider">Health Care Provider</option>
		</select>
	</div>
  <a id="directory-form-submit" class="pure-button button-menu" href="javascript:void(0)" onclick="getDirectoryList('directory-form');" style="float:right;background-color:#d27b4b;width:70px;font-size:90%;margin-top:25px;color:#e6e6e6" <?php echo($disabled); ?> >Search</a>
</form>