				<script type="text/javascript">(function() {var walkme = document.createElement('script'); walkme.type = 'text/javascript'; walkme.async = true; walkme.src = 'http://cdn.walkme.com/users/ab3d27eee206468794b47885dfc2df46/walkme_ab3d27eee206468794b47885dfc2df46.js'; var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(walkme, s); window._walkmeConfig = {smartLoad:true}; })();</script> 



	     	<img class="banner-image" src="image/nexus4.png" />
       	<span class="banner">
					<span class="product-name" style="">Nexus</span><br/>
					<span id="index-module-name" class="module-name" style="">Web Meet</span>					
					<a id="menu-userList" class="pure-button button-menu" href="javascript:void(0)" onclick="toggleFrameDisplay('userList')" style="float:right;background-color:rgba(210, 123, 75, 1);" >TEAM</a>
					<a id="menu-reserveList" class="pure-button button-menu active" href="javascript:void(0)" onclick="toggleFrameDisplay('reserveList')" style="float:right;background-color:rgba(137, 157, 112, 1);margin-right:-7px;">ROOM</a> 
					<!--
					Here we place a dummy image, edited from the original walkme png. The real WalkMe launcher is pinned to this image id and offset to sit right on top of it.
					So, while we wait for the real image to locate the anchor point, which changes when the user clicks the tab, a dummy image indicates that the function is there but inactive
					This is way better than the real image flashing while it reloads depending on the visible menu item.
					-->
					<img id="walkme-reserveList" src="image/walk-me-through-grey-grey-click.png" style="float:right;margin-right:8px;margin-top:-2px;z-index:-10;opacity:.6;display:block;"/>
					<img id="walkme-userList" src="image/walk-me-through-grey-grey-click.png" style="float:right;margin-right:8px;margin-top:-2px;z-index:-10;opacity:.6;display:none;"/>
      	</span>  	
  	
      	<span class="controls" style="float:right;padding-bottom:10px;margin-top:30px;">
					<!--<a href="javascript:void(0)" onclick="if(typeof Formilla != 'undefined'){Formilla.initFormillaChat();}">Problem?</a> | -->
					<a href="<?php echo Utilities::getSupportUrl(); ?>" target="_blank">Support</a> | 
      		<a href="login.php?oid=<?php echo $_SESSION['orgUid']; ?>&logout=true" style="color:#d27b4b;text-decoration:none;">Logout</a>
      	</span>
      	<a id="profile_control" href="javascript:void(0);"><span id="profile_control_icon" style="clear:right;float:right;padding-top:10px;margin:0px;color:#d27b4b;" class="fa fa-lg fa-plus-square" ></span></a>
				<span style="float:right;padding:10px;">Hello <?php echo $_SESSION['fname']; ?></span> 	