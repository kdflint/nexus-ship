<? 
session_start();

require_once("src/framework/Util.php");

if (!Util::isSessionValid()) {
	header("location:login.php?network=" . $_SESSION['networkId'] . "&logout=true");
	exit(0);	
}

$hideHere = false;
if (Util::hideInEnvironment()) {
	$hideHere = true;	
}

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">
<html>
	
  <head>
		<!-- TODO - localize all scripts and stylesheets -->
  	<meta http-equiv="Content-type" content="text/html;charset=UTF-8">
  	<meta id="meta" name="viewport" content="width=device-width; initial-scale=1.0" />   	
  	<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Oswald:400,300|Open+Sans|Oxygen|Swanky+and+Moo+Moo">
  	<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
  	<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
		<link rel="stylesheet" href="//yui.yahooapis.com/pure/0.6.0/pure-min.css">
		<link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.6.0/grids-responsive-min.css">
    <link rel="stylesheet" href="styles/nexus.css" type="text/css" />
    <script src="scripts/nexus.js" language="javascript"></script>
 		<script src="//code.jquery.com/jquery-1.10.2.js"></script>
  	<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>  
	  <link rel="icon" href="images/NB_icon.png" />
    <title>Northbridge Nexus</title> 
    
    <script type="text/javascript">
			$(document).ready(function () {
				$( '#schedule_control' ).click(function() {
	  			$( "#schedule_display" ).toggle( "blind" );
				});
				$( '#join_control' ).click(function() {
	  			$( "#join_display" ).toggle( "blind" );
				});
				$( '#adduser_control' ).click(function() {
	  			$( "#adduser_display" ).toggle( "blind" );
				});
				$( '#techcheck_control' ).click(function() {
	  			$( "#techcheck_display" ).toggle( "blind" );
				});
				$( '#user_control' ).click(function() {
	  			$( "#user_display" ).toggle( "blind" );
				});
			});
		</script>
    
		<!--================== Schedule Module Meta ==================-->

		<link rel="stylesheet" href="modules/schedule/views/jquery.timepicker.css">
		<script src="modules/schedule/views/jquery.timepicker.js" type="text/javascript"></script>
	
    <style>
      fieldset {
        border: 0;
      }
      label {
        display: block;
        margin: 30px 0 0 0;
      }
      select {
        width: 170px;
      }
      .overflow {
        height: 200px;
      }
    </style>

    <script type="text/javascript">
      $(function() {
        $( "#datepicker" ).datepicker({
          changeMonth: true,
          changeYear: true
        });
      });
      $(function() {
        //$( "#basicExample" ).timepicker();
        $( "#basicExample" ).selectmenu().selectmenu( "menuWidget" ).addClass( "overflow" );
      });
      $(function() {
        $( "#duration" ).selectmenu();
      });
    </script> 
    
  </head>
  
  <body>
    <div class="container">

      <div class="header">
       	<img class="banner-image" src="image/nexus4.png" />
       	<span class="banner">
					<span class="product-name" style="">Nexus</span><br/>
					<span class="module-name" style="">Web Meet</span>					
					<a id="menu-userList" class="pure-button button-menu" href="javascript:void(0)" onclick="toggleFrameDisplay('userList')" style="float:right;background-color:rgba(210, 123, 75, 1);" >TEAM</a>
					<a id="menu-reserveList" class="pure-button button-menu" href="javascript:void(0)" onclick="toggleFrameDisplay('reserveList')" style="float:right;background-color:rgba(137, 157, 112, 1);margin-right:-7px;">ROOM</a> 
      	</span>  	
  	
      	<span class="controls" style="float:right;padding-bottom:10px;margin-top:30px;">
      		<a href="#" style="color:#d27b4b;text-decoration:none;">About</a> | 
      		<a href="login.php?network=<? echo $_SESSION['networkId']; ?>&logout=true"?logout=true" style="color:#d27b4b;text-decoration:none;">Logout</a>
      	</span>
      	<a id="user_control" href="javascript:void(0);"><span style="clear:right;float:right;padding-top:4px;margin:0px;color:#d27b4b;" class="fa fa-caret-down fa-2x" ></span></a>
				<span style="float:right;padding:10px;">Hello <? echo $_SESSION['fname']; ?></span> 	
      </div>

			<div class="frame" >
				<div class="loginColLeft" style="width:80%;">
					<div id="reserveList" style="display:block;">
						<div id="join_display" style="display:none;margin-bottom:5px;">
							<?php include("modules/schedule/views/joinConfirm.html"); ?>	
						</div>
						<?php include("modules/schedule/views/openNow.html"); ?>
						<div id="schedule_display" style="display:none;">
							<?php include("modules/schedule/views/datePicker.html"); ?>	
						</div>
						<?php include("modules/schedule/views/reservationsList.html"); ?>
					</div>
					
					<div id="userList" style="display:none;">
						<div id="adduser_display" style="display:none;">
							<?php include("modules/schedule/views/joinConfirm.html"); ?>	
						</div>
						<?php include("modules/user/views/userList.html"); ?>
					</div>

      	</div>
      	
      	<div class="loginColRight" style="width:20%;">
      		<span style="clear:right;float:right;text-align:right;margin-top:20px;"><? echo $_SESSION['networkName']; ?></span>   
      		<span style="clear:right;float:right;margin-top:20px;"><img <?php echo $_SESSION['logo']; ?>/></span>   
      		<div id="techcheck_display" style="display:none;">
						<?php include("modules/techcheck/views/details.html"); ?>	
					</div>		
      		<div id="user_display" style="display:none;">
						<?php include("modules/user/views/profile.html"); ?>	
					</div>	
      	</div>
      </div>
      
      <div class="footer">
        powered by<br/>
    		<a href="http://northbridgetech.org/index.php" target="_blank"><img src="http://northbridgetech.org/images/NB_horizontal_rgb.png" height="60" width="221" border="0" alt="Northbridge Technology Alliance"/></a>
			</div>

    </div><!-- container -->       
  	
	</body>
	
</html>




