	     	<img class="banner-image" src="image/nexus4.png" />
       	<span class="banner">
					<span class="product-name" style="">Nexus</span><br/>
					<span id="index-module-name" class="module-name" style="">Web Meet</span>					
					<a id="menu-userList" class="pure-button button-menu" href="javascript:void(0)" onclick="toggleFrameDisplay('userList')" style="float:right;background-color:rgba(210, 123, 75, 1);" >TEAM</a>
					<a id="menu-reserveList" class="pure-button button-menu active" href="javascript:void(0)" onclick="toggleFrameDisplay('reserveList')" style="float:right;background-color:rgba(137, 157, 112, 1);margin-right:-7px;">ROOM</a> 
      	</span>  	
  	
      	<span class="controls" style="float:right;padding-bottom:10px;margin-top:30px;">
					<a href="javascript:void(0)" onclick="if(typeof Formilla != 'undefined'){Formilla.initFormillaChat();}">Problem?</a> | 
      		<a href="login.php?oid=<?php echo $_SESSION['orgUid']; ?>&logout=true" style="color:#d27b4b;text-decoration:none;">Logout</a>
      	</span>
      	<a id="profile_control" href="javascript:void(0);"><span id="profile_control_icon" style="clear:right;float:right;padding-top:10px;margin:0px;color:#d27b4b;" class="fa fa-lg fa-plus-square" ></span></a>
				<span style="float:right;padding:10px;">Hello <?php echo $_SESSION['fname']; ?></span> 	