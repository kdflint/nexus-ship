<table style="border:2px solid #a6c3ce !important;background: #EDF0DE none repeat scroll 0% 0%;" class="pure-table">
	<tr>
  	<td>
  		<div class="event">
  			<span class="date">System</span><br/>
  			<span>Details</span>
			</div>
		</td>
    <td>
    	<div>
    		Browser Type
    		<span class="techCheckCol2"><img id="browser_status" src="<?php echo(Utilities::getHttpImagePath()); ?>/fa-square-o_16_486326.png"/></span>
    		<span id="browser_version" class="techCheckCol3 descr"></span>
    	</div>
    	<div style="margin-top:10px;">
     		Flash Plugin
     		<span class="techCheckCol2"><img id="flash_status" src="<?php echo(Utilities::getHttpImagePath()); ?>/fa-square-o_16_486326.png"/></span>
    		<span id="flash_version" class="techCheckCol3 descr"></span>
    	</div>
    	<div style="margin-top:10px;">
     		Java Plugin
     		<span class="techCheckCol2"><img id="java_status" src="<?php echo(Utilities::getHttpImagePath()); ?>/fa-square-o_16_486326.png"/></span>
    		<span id="java_version" class="techCheckCol3 descr"></span>
    	</div>
    	<div style="margin-top:10px;">
				Download Speed
				<span class="techCheckCol2"><img id="download_speed" src="<?php echo(Utilities::getHttpImagePath()); ?>/fa-square-o_16_486326.png"/></span>
    		<span id="dprogress" class="techCheckCol3 descr"></span>
    	</div>
    	<div style="margin-top:10px;">
     		Upload Speed
     		<span class="techCheckCol2"><img id="upload_speed" src="<?php echo(Utilities::getHttpImagePath()); ?>/fa-square-o_16_486326.png" /></span>
    		<span id="uprogress" class="techCheckCol3 descr"></span>
    	</div>
		</td>
    <td>
      <a href="javascript:void(0)" onclick="document.getElementById('tech_check_control').click();" style="float:right;margin-right:15px;">Close</a>
      <a href="javascript:void(0)" onclick="refreshCheckSummary();" style="float:right;margin-right:15px;"><span class="fa fa-refresh fa-lg"></span></a>
 		</td>
	</tr>
</table> 
