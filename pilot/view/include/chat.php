<?

include("../model/pgDb.php");

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
 		<tr><td>Phone Line:</td><td>(712) 432-1212</td></tr>
 		<tr><td>Meeting ID:</td><td>600 66 9366#</td></tr>
 		<tr><td>Host PIN:</td><td>2615#</td></tr>
	</table>
	<p>Busy signal? Try (559) 546-1400</p>
	<p><i>Toll charges will apply in accordance with your phone plan.</i></p>
		<? if (isset($roomLink) && strlen($roomLink) > 1) {
				$formattedLink = "http://conference.northbridgetech.org" . $roomLink;
				$displayText = "Your Virtual Room Pass";
			} else {
				$formattedLink = "#";
				$displayText = "Web Room Not Available";
			}
		?>
		<p><a class="bigbutton" href="<? echo $formattedLink; ?>" target="_blank" >
 		&nbsp;<br/>
 		<? echo $displayText; ?>
 	</a></p>
	</div>
</div>

<div class="rightColumn" style="overflow:auto;" >
	<div class="navigation2">
  	<ul>
			<li<?php if ($thisPage=="directory") echo " id=\"currentpage\""; ?>><a href="#">Your Message Center</a></li>
		</ul>
	</div>
	<div id="default" style="display:block;font-size:12px;margin-top:5px;">
		<img src="image/comingSoon.jpg" width="85" height="85" />
		<p><b>For authorized Nexus pilot users</b></p>
		<p>Your private, in-network messaging and collaboration dashboard<br/>will be available <b>October 2014</b></p>
		<? // include("inbox.php"); ?>
	</div>
</div>

	