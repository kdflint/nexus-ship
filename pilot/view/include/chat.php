<?

require_once($_SESSION['appRoot'] . "control/util.php");
require_once($_SESSION['appRoot'] . "config/env_config.php");
require_once($_SESSION['appRoot'] . "model/pgDb.php");

$roomLink = "";

$cursor = pgDb::getUserSessionByUsername($_SESSION['username']);
while ($row = pg_fetch_array($cursor)) {
 	$roomLink = $row['link'];
}

?>

<div class="topLeftQuad">
 	<a href="#">Community Conference</a>
 	<div style="margin-left:50px;margin-top:10px;">
 	<table>
 		<tr><td>Phone Line:</td><td><? echo $wc_phone[$_SESSION['networkId']]; ?></td></tr>
 		<tr><td>Meeting ID:</td><td><? echo $wc_code[$_SESSION['networkId']]; ?>#</td></tr>
 		<tr><td>Host PIN:</td><td><? echo $wc_pin; ?>#</td></tr>
	</table>
	<p>Busy signal? Try (559) 546-1400</p>
	<p><i>Toll charges will apply in accordance with your phone plan.</i></p>
	<!-- TODO - something comparable with new system -->
		<? if (isset($roomLink) && strlen($roomLink) > 1) {
				$formattedLink = "http://conference.northbridgetech.org" . $roomLink;
				$displayText = "Your Virtual Room Pass";
			} else {
				$formattedLink = "#";
				$displayText = "Your Virtual Room Pass";;
			}
		?>
		<p>
		<!--<a class="bigbutton" href="<? echo $formattedLink; ?>" target="_blank" >-->
		<a class="bigbutton" href="../control/meetingProcessor.php" target="_blank">
 		&nbsp;<br/>
 		<? echo $displayText; ?>
 	</a></p>
	</div>
</div>
 	
 	<div class="topRightQuad2">	
 		 <iframe src="http://northbridgetech.org/<? echo $env_appRoot; ?>/nexus/view/include/conferenceTechCheck.php" width="100%" height="100%" frameborder="0"></iframe> 
	</div>

<div class="bottomHalf" >
	<div class="navigation2" style="padding:0px;height:0px;">
  	<ul>
			<li<?php if ($thisPage=="directory") echo " id=\"currentpage\""; ?>><a href="#">Your Message Center</a></li>
		</ul>
	</div>
	<!--
	<div id="default" style="display:block;font-size:12px;">
		<img src="image/comingSoon.jpg" width="85" height="85" />
		<p><b>For authorized Nexus pilot users</b></p>
		<p>Your private, in-network messaging and collaboration dashboard<br/>will be available <b>early 2015</b></p>
	</div>
	-->
</div>




