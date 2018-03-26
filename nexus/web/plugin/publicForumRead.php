<?php

session_start();

require_once("../src/framework/Util.php");
require_once(Utilities::getSrcRoot() . "/organization/Organization.php");

$cleanNetworkId = "";
if(isset($_GET['oid']) && Organization::validateOrganizationUid($_GET['oid'])) {
 	$cleanNetworkId = $_GET['oid'];	
}

$cleanForumId = "";
if(isset($_GET['forumid'])) {
 	$cleanForumId =$_GET['forumid'];	
}

$cleanTopicId = "";
if(isset($_GET['topicid'])) {
 	$cleanTopicId =$_GET['topicid'];	
}

Utilities::setPublicSession($cleanNetworkId);

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">
<html>
	
  <head>
  	<meta http-equiv="Content-type" content="text/html;charset=UTF-8">
  	
  	<link rel="stylesheet" href="//fonts.googleapis.com/css?family=Open+Sans|Oxygen|">
  	<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
   	<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
		<link rel="stylesheet" href="//yui-s.yahooapis.com/pure/0.6.0/pure-min.css">
    <link rel="stylesheet" href="../styles/nexus.css" type="text/css" />
    
    <script src="../scripts/javascriptHandler.php" type="text/javascript" ></script>
 		<script src="//code.jquery.com/jquery-1.10.2.js" language="javascript"></script>
  	<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js" language="javascript"></script>
 	  	
    <style>
      fieldset { border: 0; }
      label { display: block; margin: 30px 0 0 0; }
      select { width: 170px; }
      .overflow { height: 200px; }
	  	table { border: 0px !important; margin-bottom: 0px; width: auto; }
			body { min-width: 215px; min-height: 440px;}
			.pure-table td { padding: 10px 0px !important; }
			.pure-table td:first-child { width: auto; }
			.event { width: 80px; padding-right: 8px; }
			.date { font-size: 130%; }
			.organization { font-size: 115%; }
			.meeting { font-size: 90%; padding-left: 8px; }
			.tod { font-size: 90%; }
			.period { font-size: 85%; }
			.instruction { font-size: 95%; }
			.detail { color: #004d62;}
			.scroll { text-align: right; padding-left: 220px; position:absolute; }
			.searchQualifier { vertical-align: 15px; font-style: italic; margin-right: 3px; }
			.pure-menu-link { padding: .5em .8em; };			
		</style>

  </head>
  <body>
		<div style="position:relative;margin:8px;height:460px;">
			<div id="public-suite-nav" style="position:relative;width:100%;height:42px;background-color:#eeeeee;font-size:110%;">
				<div class="pure-menu pure-menu-horizontal">
	    		<ul id="navList" class="pure-menu-list" style="float:right;">
						<?php if (isset($_SESSION['publicEnrollUuid'])) { ?>
							<li class="pure-menu-item"><a id="schedule_control" href="<?php echo(Utilities::getHttpPath()); ?>/enroll.php?invitation=<?php echo($_SESSION['publicEnrollUuid']); ?>" class="pure-menu-link" target="_blank" style="color:#d27b4b;">Enroll in Nexus</a></li>
						<?php } ?>
						<li class="pure-menu-item"><a id="schedule_control" href="<?php echo(Utilities::getHttpPath()); ?>/login.php?oid=<?php echo($_SESSION['orgUid']); ?>" class="pure-menu-link" target="_blank" style="color:#d27b4b;">Login to Nexus</a></li>	
    			</ul>
				</div>
			</div>
			<?php if (strlen($cleanTopicId) > 0) { ?>
				<iframe src="<?php echo(Utilities::getForumHttpPath()); ?>/viewtopic.php?f=<?php echo($cleanForumId); ?>&t=<?php echo($cleanTopicId); ?>" style="width:100%;border:0;margin:0;padding:0;position:absolute;height:5000px;overflow:hidden;" scrolling="no"></iframe>		
			<?php } else { ?>
				<iframe src="<?php echo(Utilities::getForumHttpPath()); ?>/viewforum.php?f=<?php echo($cleanForumId); ?>" style="width:100%;border:0;margin:0;padding:0;position:absolute;height:5000px;overflow:hidden;" scrolling="no"></iframe>					
		<?php } ?>
		</div>
		
	

		
	</body>
</html>
			
						