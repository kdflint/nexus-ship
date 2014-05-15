<?php

session_start();

include("pgDb.php");
include("util.php");

// Just placeholders - normally requires authentication to get these two values
$_SESSION['uid'] = "anita";
$cursor = pgDb::getInvitationsByOrg("1");

$inviteId = "";
$isInviteValid = false;

if (isset($_REQUEST['inviteId'])) {
	$inviteId = Util::clean($_REQUEST['inviteId']);
	$isInviteValid = pgDb::checkValidInvitation($inviteId);	
	if ($isInviteValid) {
		$cursor = pgDb::getInvitationByUuid($inviteId);
		
	}
	$row = pg_fetch_array($cursor);
	$_SESSION['orgId'] = $row['orgId'];
	$_SESSION['grantorId'] = $row['grantorId'];	
	$_SESSION['inviteId'] = $inviteId;
}

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">
  <head>
  	<meta http-equiv="Content-type" content="text/html;charset=UTF-8">
    <link rel="stylesheet" href="style/modelViewStyle.css" type="text/css" />
    <script src="script/script.js" language="javascript"></script>
  </head>
  
  <body>
  <div class="container">  	
  <div class="shell">
  	
  	<h1>Registration Model</h1>
  	
  	<h2>VIEW: Registration Invitation</h2>

  	<hr/>
	  	<h3>Create Registrations</h3>
	  	<p>Required to initialize: orgId</p>
  		<form action="registrationProcessor.php" method="post">
	  		Organization ID: <input type="text" name="orgId" value="1" /><br/>
	  		Password: <input type="password" name="password" /><br/>
				<input type="hidden" name="action" value="createInvitation" />
  			<input type="submit" value="Generate Invitation" />
  		</form>  		
	  	
			<h3>Read Registrations</h3>  	
			<p>Required to initialize: orgId</p>
			
			<table border="1" cellpadding="10">
				<?
					while ($row = pg_fetch_array($cursor)) {
						echo("<tr><td>***" . substr($row['uuid'], -4) . "</td><td>n accepted</td><td>expires in " . $row['days_remaining'] . " days</td></tr>");
					}
				?>
			</table>

	
  	<h2>VIEW: Registration</h2>
  	<hr/>	
	  	<h3>Update Registration</h3>
	  	<p>Invitation from network and admin name.</p>
	  	<? if ($isInviteValid) { ?>
  			<form action="registrationProcessor.php" method="post">
	  			Your Organization Name*: <input type="text" name="orgName" /><br/>
  				Organization EIN*: <input type="text" name="ein" /><br/>
  				Your email*: <input type="email" name="email" /><br/>
	  			<input type="hidden" name="action" value="createRegistration" />
  				<input type="submit" value="Accept Invitation!" />
  			</form>  		
  		<? } else { ?>
  		<p>Invalid invitation.</p>
  	<? } ?>
		  	 		  	
  </div>
  </div>
  </body>

</html>