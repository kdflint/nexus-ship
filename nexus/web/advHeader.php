
	<?php 
		// Special network tab label for CFCHT, for now :)
		$networkTabLabel =  $_SESSION['environment'] === "prod" && $_SESSION['networkId'] === "18" ? "DIRECTORY" : "NETWORK";
	?>

	<img class="banner-image" src="image/nexus4.png" />
	<span class="banner" style="float:right;width:878px;">
		<div class="topRow">
			<span class="product-name" style="">Nexus</span>
			<!-- TODO - make sure logo size as uploaded to file system works in all contexts -->
			<span style="margin-left:124px;"><img src="<?php echo(Utilities::getPartnerImageRoot()); ?><?php echo $_SESSION['logo']; ?>" height="40"/></span>
			<span class="product-name" style="font-size:90%;color:#004d62;opacity:1;"><?php echo $_SESSION['networkName']; ?></span>  
			<span class="controls" style="float:right;padding:10px;padding-right:0px;">
				<a href="javascript:void(0)" onclick="toggleAdvFrameDisplay(document.getElementById('adv-menu-profile'));" title="Profile"><span class="fa fa-cog fa-2x" style="margin-right:10px;"></span></a>
				<a href="javascript:void(0)" onclick="if(typeof Formilla != 'undefined'){Formilla.initFormillaChat();}" title="Help"><span class="fa fa-question fa-2x" style="margin-right:10px;"></span></a>
	  		<a href="login.php?oid=<?php echo $_SESSION['orgUid']; ?>&logout=true" style="color:#d27b4b;text-decoration:none;" title="Logout"><span class="fa fa-sign-out fa-2x" style="margin-right:0px;"></span></a>
			</span>
		</div>
		<div class="bottomRow">
			<span id="index-module-name" class="module-name">Advantage</span>	
			<span id="advMenu" class="advMenu" style="">
				<a id="adv-menu-profile" class="pure-button button-menu-adv" href="javascript:void(0)" onclick="toggleAdvFrameDisplay(this)" style="float:right;background-color:#dae0bc;margin-right:0px;">PROFILE</a> 
				<a id="adv-menu-inbox" class="pure-button button-menu-adv" href="javascript:void(0)" onclick="toggleAdvFrameDisplay(this)" style="float:right;background-color:#dae0bc;margin-right:-7px;">INBOX</a> 			
				<a id="adv-menu-forum" class="pure-button button-menu-adv" href="javascript:void(0)" onclick="toggleAdvFrameDisplay(this)" style="float:right;background-color:#dae0bc;margin-right:-7px;">FORUM</a> 	
				<a id="adv-menu-network" class="pure-button button-menu-adv" href="javascript:void(0)" onclick="toggleAdvFrameDisplay(this)" style="float:right;background-color:#dae0bc;margin-right:-7px;"><?php echo($networkTabLabel); ?></a> 	
				<a id="adv-menu-event" class="pure-button button-menu-adv" href="javascript:void(0)" onclick="toggleAdvFrameDisplay(this)" style="float:right;background-color:rgba(137, 157, 112, 1);margin-right:-7px;" >EVENTS</a>
				<a id="adv-menu-360" class="pure-button button-menu-adv" href="javascript:void(0)" onclick="toggleAdvFrameDisplay(this)" style="float:right;background-color:#dae0bc;margin-right:-7px;">360&deg;</a> 	
			</span>
		</div>
	</span>
		

	
	
  	
