<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">

<html>
  <head>  	  		
  	<meta http-equiv="Content-type" content="text/html;charset=UTF-8">
    <!--<link rel="stylesheet" href="styles/nexus.css" type="text/css" />-->
    <link rel="stylesheet" href="styles/nexusCssHandler.php" type="text/css" />
    <link rel="shortcut icon" href="image/northbridge-ico.png" />
    <title>Nexus</title>    	
  </head>      
  
  <body>
    <div class="container">
      <div class="header">
       	<img class="banner-image" src="image/nexus4.png" />
       	<span class="banner" style="width:60%">
					<span class="product-name" style="">Nexus</span><br/>
					<span class="module-name" style="">Web Meet</span>					
      	</span>  		
      	<span class="controls" style="float:right;padding-bottom:10px;margin-top:30px;">
      		<a href="http://northbridgetech.org/downloads/Northbridge_web_conference_center.pdf" style="color:#d27b4b;text-decoration:none;" target="_blank"><?php echo _("About"); ?></a>
      	</span>
      </div>
      <div class="frame" style="padding-top:40px;">
      	<?php echo _("You are logged out of your Web Conference Room."); ?>
      </div>
      <div class="footer" style="clear:both;position:relative;bottom:-10px;">
      	<?php include("nwmFooter.php"); ?>
 			</div>
    </div>       		  	
	</body>
</html>

