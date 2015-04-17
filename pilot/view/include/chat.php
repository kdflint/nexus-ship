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
 	<p style="margin-left:20px;">To start or join a meeting, simply click the button!</p>
 	<div style="margin-left:20px;margin-top:10px;">
 	<!--
 	<table>
 		<tr><td>Telephone Line:</td><td><? echo $wc_phone[$_SESSION['networkId']]; ?></td></tr>
 		<tr><td>Meeting ID:</td><td><? echo $wc_code[$_SESSION['networkId']]; ?>#</td></tr>
 		<tr><td>Host PIN:</td><td><? echo $wc_pin; ?>#</td></tr>
	</table>
	<p>Busy signal? Try (559) 546-1400</p>
	<p><i>Toll charges will apply in accordance with your phone plan.</i></p>
	-->
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
  &nbsp;<br/>
	<a href="#">Tutorial</a>
	<p style="margin-left:20px;">How to join your computer to a web conference</p>
	<div style="margin-left:20px;margin-top:10px;">
		<iframe width="280" height="157" src="https://www.youtube.com/embed/4Y__UsUrRx0" frameborder="0" allowfullscreen></iframe>
	</div>
	&nbsp;<br/>
	<a href="#">Training</a>
</div>
<div class="lowerTraining">

<p style="margin-left:20px;"><b>Ready to give web conferencing a try?</b></p>
<p style="margin-left:20px;">All <? echo $_SESSION['networkName']; ?> pilot users are eligible for free, personalized, no-obligation web conference training. This will help your network to take full advantage of the benefits of web conferencing.</p>
<p style="margin-left:20px;"><a href="">Register for a free, no-obligation training session</a></p>
</div>
 	
<div class="rightColumnPlain" style="left:360px;width:450px;">	
	 	<a href="#">Your System Tech Check</a>
	 <iframe src="http://northbridgetech.org/<? echo $env_appRoot; ?>/nexus/view/include/conferenceTechCheck.html" width="100%" height="75%" frameborder="0" scrolling="no"></iframe> 
</div>

