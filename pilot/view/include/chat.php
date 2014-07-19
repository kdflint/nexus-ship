<?php

include("util/db.php");
include("util/util.php");

$nick = $_SESSION['fname'];

session_start();

?>

<div class="leftColumn">
	&nbsp;<br/>
	&nbsp;<br/>
<p class="box">
	&nbsp;<br/>
	&nbsp;<br/>
	&nbsp;<br/>
	<a class="box" href='#synirc/test' 
 		onclick='window.open("http://widget.mibbit.com/?settings=f56cae76395599d549d3883a9e7cee69&server=ec2-54-204-130-42.compute-1.amazonaws.com&channel=%23nexus s5cr57&nick=<? echo $nick; ?>&autoConnect=true","Chat your network","width=800,height=500,top=100,left=300,screenX=100,screenY=300,location=no,menubar=no,scrollbars=no,status=no,titlebar=no,toolbar=no")'>
 		Chat your network
 	</a>
</p>
	&nbsp;<br/>
	&nbsp;<br/>
<p class="box">
	&nbsp;<br/>
	&nbsp;<br/>
	&nbsp;<br/>
	<a class="box" href='#' 
 		onclick='window.open("http://northbridgetech.org/apps/nexus/includes/meeting.php","Join a meeting","width=800,height=500,top=100,left=300,screenX=100,screenY=300,location=no,menubar=no,scrollbars=no,status=no,titlebar=no,toolbar=no")'>
 		Join a Meeting
 	</a>
</p>
</div>

<div class="rightColumn">
		<a href="#">Message Center</a>
		<hr/>
			<div id="default" style="display:block;font-size:12px;"><? include("inbox.php"); ?></div>
</div>

	