<?

include("../model/pgDb.php");
include("../config/env_config.php");

$roomLink = "";

$cursor = pgDb::getUserSessionByUsername($_SESSION['username']);
while ($row = pg_fetch_array($cursor)) {
 	$roomLink = $row['link'];
}

$speed_check = '<img src="image/light_white.png" />';
	$kb=1024;
	$mb=$kb/1000;
	//echo "streaming $kb Kb...<!--";
	echo "<!--";
	flush();
	$time = explode(" ",microtime());
	$start = $time[0] + $time[1];
	for($x=0;$x<$kb;$x++){
			// echo 1K on each iteration
    	echo str_pad('', 1024, '.') . "<br/>";
    	flush();
	}
	$time = explode(" ",microtime());
	$finish = $time[0] + $time[1];
	$deltat = $finish - $start;
	//echo "-> Test finished in $deltat seconds. Your speed is ". round($kb / $deltat, 3)."Kb/s";
	echo "-->";
	$speed = round($mb / $deltat, 3);
	
	if ($speed > 2) {
		$speed_check = '<img src="image/light_green.png" />';
	} else {
		$speed_check = '<img src="image/light_red.png" />';
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
 			<table style="font-size: 12px;">
		 		<tr><td colspan="2" bgcolor="#eeeeee"><b>Conference System Requirement</b><br/>&nbsp;</td><td><b>Your System Status</b><br/>&nbsp;</td></tr>
 				<tr><td bgcolor="#eeeeee">Javascript</td><td bgcolor="#eeeeee">Enabled</td><td><img id="jscript_enabled" src="image/light_red.png" /></td></tr>
 				<tr><td bgcolor="#eeeeee">Flash</td><td bgcolor="#eeeeee">Version 11.2</td><td><img id="flash_enabled" src="image/light_red.png" /></td></tr>
 				<tr><td bgcolor="#eeeeee">Download speed</td><td bgcolor="#eeeeee">Min. 1 Mb/sec</td><td><? echo $speed_check; ?></td></tr>
 				<tr><td bgcolor="#eeeeee">Microphone</td><td bgcolor="#eeeeee">Available</td><td><img id="audio_enabled" src="image/light_white.png" /><button id="audioButton" onclick="checkAudio()">Check</button></td></tr>
 				<tr><td bgcolor="#eeeeee">Camera</td><td bgcolor="#eeeeee">Optional</td><td><img id="video_enabled" src="image/light_white.png" /><button id="videoButton" onclick="checkVideo()">Check</button></td></tr>
 				<!--<tr><td>Java</td><td>optional</td><td><button onClick="">Check</button></td></tr>-->
 			</table>
	</div>
	
 	<script>
 		document.getElementById("jscript_enabled").src = "image/light_green.png";
	</script>
	
	<script src="script/flash_detect.js"></script>
	<script> 
		// http://www.featureblend.com/javascript-flash-detection-library.html
  	if(FlashDetect.installed && FlashDetect.versionAtLeast(11,2)){
        document.getElementById("flash_enabled").src = "image/light_green.png";         
    }
	</script>

<div class="bottomHalf" >
	<div class="navigation2" style="padding:0px;height:0px;">
  	<ul>
			<li<?php if ($thisPage=="directory") echo " id=\"currentpage\""; ?>><a href="#">Your Message Center</a></li>
		</ul>
	</div>
	<div id="default" style="display:block;font-size:12px;">
		<img src="image/comingSoon.jpg" width="85" height="85" />
		<p><b>For authorized Nexus pilot users</b></p>
		<p>Your private, in-network messaging and collaboration dashboard<br/>will be available <b>early 2015</b></p>
		<? // include("inbox.php"); ?>
	</div>
</div>

	