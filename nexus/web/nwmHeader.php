				<!--<script type="text/javascript">(function() {var walkme = document.createElement('script'); walkme.type = 'text/javascript'; walkme.async = true; walkme.src = 'http://cdn.walkme.com/users/ab3d27eee206468794b47885dfc2df46/walkme_ab3d27eee206468794b47885dfc2df46.js'; var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(walkme, s); window._walkmeConfig = {smartLoad:true}; })();</script> -->

				<script type="text/javascript">(function() {var walkme = document.createElement('script'); walkme.type = 'text/javascript'; walkme.async = true; walkme.src = 'https://cdn.walkme.com/users/ab3d27eee206468794b47885dfc2df46/walkme_ab3d27eee206468794b47885dfc2df46_https.js'; var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(walkme, s); window._walkmeConfig = {smartLoad:true}; })();</script> 


	     	<img class="banner-image" src="image/nexus4.png" />
       	<span class="banner">
					<span class="product-name" style="">Nexus</span>
					<span style="float:right;margin-top:10px;color:#004d62;"><span class="fa fa-bookmark fa-2x" style="margin-right:10px;" ></span><span style="font-size:90%;"><?php echo _("featuring"); ?></span><span style="font-weight:bold;"> <?php echo _("pass_label"); ?> </span><span style="font-size:80%;">(<?php echo _("bookmark_shortcut"); ?>)</span></span>
					<span id="get-nexus-link" style="float:right;margin-top:20px;"></span><br/>
					<span id="index-module-name" class="module-name" style="">Web Meet</span>		
					
					<a id="menu-recordList" class="pure-button button-menu-adv" href="javascript:void(0)" onclick="toggleNwmFrameDisplay('recordList')" style="float:right;background-color:#dae0bc;"><?php echo _("ARCHIVE"); ?></a> 			
					<a id="menu-userList" class="pure-button button-menu-adv" href="javascript:void(0)" onclick="toggleNwmFrameDisplay('userList')" style="float:right;background-color:#dae0bc;margin-right:-7px;" ><?php echo _("Seats"); ?></a>
					<a id="menu-reserveList" class="pure-button button-menu-adv active" href="javascript:void(0)" onclick="toggleNwmFrameDisplay('reserveList')" style="float:right;background-color:rgba(137, 157, 112, 1);margin-right:-7px;"><?php echo _("Schedule"); ?></a> 
					<!--
					Here we place a dummy image, edited from the original walkme png. The real WalkMe launcher is pinned to this image id and offset to sit right on top of it.
					So, while we wait for the real image to locate the anchor point, which changes when the user clicks the tab, a dummy image indicates that the function is there but inactive
					This is way better than the real image flashing while it reloads depending on the visible menu item.
					-->
					<img id="walkme-recordList" src="image/walk-me-through-grey-grey-click.png" style="float:right;margin-right:8px;margin-top:-2px;z-index:-10;opacity:.6;display:none;"/>
					<img id="walkme-reserveList" src="image/walk-me-through-grey-grey-click.png" style="float:right;margin-right:8px;margin-top:-2px;z-index:-10;opacity:.6;display:block;"/>
					<img id="walkme-userList" src="image/walk-me-through-grey-grey-click.png" style="float:right;margin-right:8px;margin-top:-2px;z-index:-10;opacity:.6;display:none;"/>
      	</span>  	
  	
      	<span class="controls" style="float:right;padding-bottom:10px;margin-top:30px;">
					<!--<a href="javascript:void(0)" onclick="if(typeof Formilla != 'undefined'){Formilla.initFormillaChat();}">Problem?</a> | -->
					<a href="#openTrainModal" onclick=""><span class="fa fa-graduation-cap fa-2x" style="margin-left:8px;" title="<?php echo _("Training"); ?>"></span></a>
					<a href="javascript:void(0)" onclick="if(typeof Formilla != 'undefined'){Formilla.initFormillaChat();}" title="Ask Us"><span class="fa fa-question-circle fa-2x" style="margin-left:8px;" title="<?php echo _("Support"); ?>"></span></a>
      		<a href="login.php?oid=<?php echo $_SESSION['orgUid']; ?>&logout=true" style="color:#d27b4b;text-decoration:none;" title="<?php echo _("Logout"); ?>"><span class="fa fa-sign-out fa-2x" style="margin-left:8px;"></span></a>
      	</span>
      	<a id="profile_control" href="javascript:void(0);"><span id="profile_control_icon" style="clear:right;float:right;padding-top:10px;margin:0px;color:#d27b4b;" class="fa fa-lg fa-plus-square" ></span></a>
				<span style="float:right;padding:10px;">
					<?php echo _("Hello"); ?> <?php echo $_SESSION['fname']; ?>
					
				</span>
				
				<div id="openTrainModal" class="modalDialog">
					<div>
						<a href="#close" title="<?php echo _('close'); ?>" class="close">X</a>
						<p><?php echo _("Register for Nexus Web Meet training at the") ?> <a href="<?php echo Utilities::getMemberUrl(); ?>" target="_blank"><?php echo _("Northbridge Member Portal"); ?></a>.</p>
						<!--
						<p style="margin-top:10px;margin-bottom:30px;font-size:90%;margin-left:10px;">Virtual Collaboration for Social Nonprofits<a id="training-register1" class="pure-button button-menu" href="http://northbridge-training-01.eventbrite.com" target="_blank" style="float:right;background-color:#d27b4b;width:70px;font-size:90%;color:#e6e6e6;margin-bottom:0px;" <?php echo($disabled); ?>>Register</a></p>
						<p style="margin-top:10px;margin-bottom:30px;font-size:90%;margin-left:10px;">Leading Meetings with Nexus Web Meet<a id="training-register2" class="pure-button button-menu" href="http://northbridge-training-02.eventbrite.com" target="_blank" style="float:right;background-color:#d27b4b;width:70px;font-size:90%;color:#e6e6e6;margin-bottom:0px;" <?php echo($disabled); ?>>Register</a></p>
						-->
					</div>
				</div>