<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<?php

	$cacheBuster = time();
	
?>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Oxygen">
<title>Northbridge Demo Meeting Room</title>
</head>
<body style="font-family:oxygen,arial;margin-left:30px;">

<img src="http://northbridgetech.org/images/NB_horizontal_tagline_rgb.png" width="500" height="155" style="margin:20px;"/><br> 

<p style="background:#edf0de;width:510px;padding:5px;">Web Conference Meetings</p>
<FORM NAME="form1" METHOD="POST" action="demoMeetingProcessor.php" >
<table cellpadding="5" cellspacing="5">
	<tbody>
		<tr>
			<td>
				&nbsp;</td>
			<td style="text-align: left; ">
				Your Name:</td>
			<td style="width: 5px; ">
				&nbsp;</td>
			<td style="text-align: left ">
				<input type="text" autofocus required name="username" /></td>
		</tr>
		
		<tr>
			<td>
				&nbsp;</td>
			<td style="text-align: left; ">
				Meeting:</td>
			<td>
				&nbsp;
			</td>
			<td style="text-align: left ">
			<select name="meetingID">
				<option value="Demo Meeting">Public Demo Meeting Room</option>
			</select>				
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;</td>
			<td>
				&nbsp;</td>
			<td>
				&nbsp;</td>
			<td>
				<input type="submit" value="Join" disabled /></td>
		</tr>	
	</tbody>
</table>
<INPUT TYPE=hidden NAME=action VALUE="create">
</FORM>
<p style="background:#edf0de;width:510px;padding:5px;">Pre-meeting System Tech Check</p>
<iframe src="http://northbridgetech.org/dev/nexus/view/include/conferenceTechCheck.php?nnn=<? echo $cacheBuster; ?>" width="600px" height="800px"frameborder="0" scrolling="no"></iframe> 
</body>
</html>

