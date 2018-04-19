<?php

session_start();

require_once("src/framework/Util.php");
require_once(Utilities::getSrcRoot() . "/user/Invitation.php");
require_once(Utilities::getSrcRoot() . "/organization/Organization.php");

Utilities::setUserLanguageEnv();

$inviteId = $networkName = $networkLogo = $cleanMessage = $cleanIcon = $networkOid = "";
$validInvitation = false;
$showGroupEnrollWrite = $showGroupEnrollRead = false;
$publicGroups = array();
$enrollGroup = array();
$accountTypes = array("ADV" => "Advantage", "NWM" => "Web Meet");

if (Utilities::validateUuid($_GET['invitation'])) {
	if (Invitation::isInvitationOpen($_GET['invitation'])) {
		$inviteId = $_GET['invitation'];
		$validInvitation = true;
	}
}

if ($validInvitation) {	

	$_SESSION['invitation'] = $inviteId;
	
	$row1 = pg_fetch_array(Invitation::getInvitationByUuid($inviteId));

	$accountType = isset($accountTypes[$row1['account_type']]) ? $accountTypes[$row1['account_type']] : "";
	
	// This tests for a network-global, network-personal invite
	if ($row1['orgid'] === $row1['networkid'] && !$row1['groupid'] && $row1['roleid'] == 5) {
		$showGroupEnrollWrite = true;
		$publicGroups = Group::getPublicEnrollableGroupsByOrgId($row1['networkid']);
	}
	
	// This tests for group-global, group-personal
	if ($row1['groupid']) {
		$showGroupEnrollRead = true;
		$enrollGroup = Group::getGroupById($row1['groupid']);
	}
	
	$row2 = pg_fetch_array(Organization::getOrganizationById($row1['networkid']));
	$networkLogo = $row2['logo'];
	$networkName = $row2['name'];
	$networkOid = $row2['uid'];
		
} else {
	header("location:login.php");
	exit(0);
}

if(isset($_GET['error']) && Utilities::isSafeCharacterSet($_GET['error'])) {
	$cleanMessage = $_GET['error'];
	$cleanIcon = "fa fa-info-circle fa-2x";
}

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">
<html>
	
  <head>
  	<meta http-equiv="Content-type" content="text/html;charset=UTF-8">
  	<meta id="meta" name="viewport" content="width=device-width; initial-scale=1.0" />	
  	<link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Oswald:400,300|Open+Sans|Oxygen|Swanky+and+Moo+Moo">
  	<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
  	<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
		<link rel="stylesheet" href="//yui-s.yahooapis.com/pure/0.6.0/pure-min.css">
    <link rel="stylesheet" href="styles/nexus.css" type="text/css" />
		<script src="scripts/javascriptHandler.php" type="text/javascript" ></script>
 		<script src="//code.jquery.com/jquery-1.10.2.js"></script>
  	<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
  	<script src="//cdnjs.cloudflare.com/ajax/libs/jstimezonedetect/1.0.4/jstz.min.js"></script>
    <link rel="icon" href="images/NB_icon.png" />
    <title>Northbridge Nexus | Login</title> 
    
  <style>
  	label { display: inline-block; width: 5em; }
  	fieldset div { margin-bottom: 2em; }
  	fieldset .help { display: inline-block; }
  	.ui-tooltip { width: 210px; }
  </style>
  
   	<script> 
			$(document).ready(function () {
				$(document).on("keyup", function (event) {
    			if (event.which == 13) {
       			document.getElementById("enroll-form-submit").click();   
    			}
				});
			});
		</script>
  </head>
  
  <body>
  	<!-- TODO - finalize container width -->
    <div class="container" style="width:550px;">

      <div class="header">
       	<img class="banner-image" src="image/nexus4.png" />
       	<span class="banner" style="width:60%">
					<span class="product-name">Nexus</span><br/>
					<span class="module-name"><?php echo($accountType); ?> Enrollment</span>					
      	</span>  	
      	<span class="controls" style="float:right;padding-bottom:10px;margin-top:30px;">
      		<b>Already have<br/>an account?<br/></b>
      		<!-- TODO - make this oid dynamic -->
      		<a href="<?php echo Utilities::getHttpPath(); ?>/login.php?oid=<?php echo($networkOid); ?>" style="color:#d27b4b;text-decoration:none;"><?php echo _("Login"); ?></a>
      	</span>
      </div>

			<div class="frame"> 
			  <div class="loginColLeft">
					<?php include("scripts/noscript.php"); ?>		
			  	<p id="enroll-user-message" class="confirmation"><span class="<?php echo $cleanIcon; ?>" style="color:#007582;float:left;margin-right:5px;"></span><?php echo $cleanMessage; ?></p>
					<form id="enroll-form" class="pure-form" autocomplete="off" action="modules/login/control/enrollProcessor.php" method="post">
	    			<fieldset>
							<?php if($showGroupEnrollWrite && count($publicGroups) > 0 && $accountType == "Advantage") { ?>
							<!-- TODO - This is very bad! Assumes that there will *always* be one public group named "Public Group" -->
								<div style="margin-bottom:20px">
									<p><?php echo _("Which group(s) would you like to join?"); ?></p>
	 								<span style="font-size:90%;">
									<?php foreach($publicGroups as $group) { ?>
 											<input type="checkbox" name="group-enroll[]" value="<?php echo($group['id']); ?>" /> <?php echo($group['name']); ?><br/>
              		<?php } ?>
              		</span>
              	</div>
							<?php } ?>
							<?php if($showGroupEnrollRead && $enrollGroup) { 
								if ($accountType == "Advantage") { ?>
								<div style="margin-bottom:20px">
									<b>
										<p>Keep the conversation going! You have been invited to enroll in </p>
	 									<span style="font-size:90%;">
		 									<?php echo($enrollGroup[0]['name']); ?> discussion forum
	 										<input type="hidden" name="group-enroll[]" value="<?php echo($enrollGroup[0]['id']); ?>" >
              			</span>
              		</b>
              	</div>
              <?php } else { ?>
              	<input type="hidden" name="group-enroll[]" value="<?php echo($enrollGroup[0]['id']); ?>" >
							<?php } } ?>
							<input class="form-input" type="text" name="uid"  maxlength="25" title="7-25 characters. May not contain spaces" placeholder="<?php echo _("Choose your username"); ?>"/><span class="required"> *</span>	
							<input class="form-input" type="password" name="password1" maxlength="25" title="7-25 characters. Must contain at least 1 digit." placeholder="<?php echo _("Choose your password"); ?>"/><span class="required"> *</span>
							<input class="form-input" type="password" name="password2" maxlength="25" title="Must match previous password entry." placeholder="<?php echo _("Confirm your password"); ?>"/><span class="required"> *</span>
     					<input class="form-input" type="email" name="email" maxlength="50" title="Required. 6-50 characters" value="" placeholder="<?php echo _("Your email"); ?>"><span class="required"> *</span>											
							<input class="form-input" type="text" name="fname" maxlength="25" title="Required. 1-25 characters." placeholder="<?php echo _("Your first name"); ?>"/><span class="required"> *</span>										
							<input class="form-input" type="text" name="lname" maxlength="25" title="Optional. 0-25 characters." placeholder="<?php echo _("Your last name"); ?>"/>
        			<a id="enroll-form-submit" type="submit" class="pure-button pure-button-primary" style="width:45%;float:right;margin-right:20px;" href="javascript:void(0);" onclick="enrollValidateAndSubmit();"><?php echo _("Enroll"); ?></a>
     				</fieldset>
     			</form>   			 			
     		</div>
     		<div class="loginColRight">
      		<span style="clear:right;float:right;text-align:right;margin-top:20px;"><?php echo $networkName; ?></span>
      		<span style="clear:right;float:right;margin-top:20px;"><img src="<?php echo Utilities::getPartnerImageRoot(); ?><?php echo $networkLogo; ?>" /></span>
      		<?php if ($networkOid === "2ab2f516") { ?>
      			<p style="clear:right;float:right;text-align:right;margin-top:20px;"><a href="http://www.idra.org/who-we-are/privacy-policy/" target="_blank" >IDRA Privacy Policy</a></p>
      			<p style="clear:right;float:right;text-align:right;margin-top:20px;"><a href="http://www.idra.org/who-we-are/idra-online-comment-and-discussion-policy/" target="_blank" >IDRA Online Comment and Discussion Policy</a></p>
      		<?php } ?>
     		</div>
      </div>
      
      <div class="footer" style="clear:both;position:relative;bottom:-40px;">
      	<?php include("nwmFooter.php"); ?>
			</div>
    </div><!-- container -->       		  	

  <script>
  $(function() {
    //var tooltips = $( "[title]" ).tooltip({
    var tooltips = $( "#enroll-form :input" ).tooltip({
      position: {
        my: "left top",
        at: "right+5 top-5"
      },
      effect: "fade"
    });
    
    //$( "<button>" )
    //  .text( "Show help" )
    //  .button()
    //  .click(function() {
    //    tooltips.tooltip( "open" );
    //  })
    //  .insertAfter( "form" );
    
  });
  </script>

	</body>
</html>




