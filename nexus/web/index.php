<? 
session_start();

require_once("src/framework/Util.php");

if (!Util::isSessionValid()) {
	header("location:login.php?logout=true");
	exit(0);	
}

$hideHere = false;
if (Util::hideInEnvironment()) {
	$hideHere = true;	
}

// select content to show based on request variable, which is supplied in navigation.php
//if (isset($_REQUEST['thisPage'])) {
//	$thisPage = $_REQUEST['thisPage'];
//} else {
//	$thisPage = "directory";
//}

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
      	<span style="float:left;width:70%;padding:10px;margin-top:10px;border-radius:6px;background:#edf0de;color:#004d62;">
      		<span style="font-family:Oswald;font-size:130%">Nexus</span>
      		<hr style="text-align:left;margin-left:0;width:176px;">
      		<span>Web Conference Center</span>   
      	</span>  		
      	<span style="float:right;padding-bottom:10px;margin-top:30px;">
      		<a href="#" style="color:#d27b4b;text-decoration:none;">About</a> | 
      		<a href="login.php?logout=true" style="color:#d27b4b;text-decoration:none;">Logout</a> | 
      		<a id="techcheck_control" href="javascript:void(0)"><span style="padding:0px;margin:0px;color:#d27b4b;" class="fa fa-exclamation-triangle" ></span></a>
      	</span>
      	<a id="user_control" href="javascript:void(0)"><span style="clear:right;float:right;padding-top:12px;margin:0px;color:#d27b4b;" class="fa fa-plus-circle" ></span></a>
				<span style="float:right;padding:10px;">Hello <? echo $_SESSION['fname']; ?></span> 	
      </div>

			<div class="frame" >
				<div class="loginColLeft" style="width:80%;">
					<a id="join_control" class="pure-button button-join" href="javascript:void(0)">Start a Meeting</a>    
						<div id="join_display" style="display:none;">
							<?php include("modules/schedule/views/joinConfirm.html"); ?>	
						</div>
					<a id="schedule_control" class="pure-button button-schedule" href="javascript:void(0)">Reserve the Room</a>
						<div id="schedule_display" style="display:none;">
							<?php include("modules/schedule/views/datePicker.html"); ?>	
						</div>
					<table style="width:90%;margin-top:30px;" class="pure-table">
        			<tr>
            		<td>
            			<div class="event">
  									<span class="day">Wednesday</span><br/>
  									<span class="date">30</span><br/>
  									<span class="month">June</span><br/>
  									<span class="time">8:00 pm CT</span>
									</div>
								</td>
            		<td>
            			<div class="meeting">
            				<span class="purpose">Board Meeting</span><br/>
            				<span class="descr" style="font-size:90%;" >This is the quarterly meeting of the Board of Directors
            					<p><span style="padding-right:5px;margin:0px;color:#d27b4b;" class="fa fa-envelope" ></span>Reserved by: Kathy Flint</p>
            				</span>
            			</div>
            		</td>
            		<td style="vertical-align:top;">
            			<a class="pure-button button-join" style="width:100%;" href="javascript:void(0)">Join</a>  
            		</td>
        			</tr>
        			<tr>
            		<td>
            			<div class="event">
  									<span class="day">Wednesday</span><br/>
  									<span class="date">30</span><br/>
  									<span class="month">June</span><br/>
  									<span class="time">8:00 pm CT</span>
									</div>
								</td>
            		<td>
            			<div class="meeting">
            				<span class="purpose">Board Meeting</span><br/>
            				<span class="descr" style="font-size:90%;" >This is the quarterly meeting of the Board of Directors
            					<p><span style="padding-right:5px;margin:0px;color:#d27b4b;" class="fa fa-envelope" ></span>Reserved by: Kathy Flint</p>
            				</span>
            			</div>
            		</td>
        			</tr>					
					</table>
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




