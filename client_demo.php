<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<?php
	$cacheBuster = rand();
?>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Oxygen,Oswald">
	<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
	<title>Northbridge Demo Meeting Room</title>
	<style>
		.button {
  		border-top: 1px solid #a6c3ce;
   		background: #004d62;
		  padding: 5px 15px;
   		-webkit-border-radius: 10px;
   		-moz-border-radius: 10px;
   		border-radius: 10px;
   		text-shadow: rgba(0,0,0,.4) 0 1px 0;
   		color: #edf0de;
   		font-size: 16px;
   		font-family: "Oswald",Arial Sans-Serif;
   		text-decoration: none;
   		vertical-align: middle;
   		letter-spacing: .5px;
   		width: 100%;
   	}
   		
		.button:hover {
   		background: #a6c3ce;
   	}
   	
		.button:active {
   		background: #a6c3ce;
   	}
  </style>
  
  <script>
  	function showJoinForm() {
			document.getElementById("join-form").style.display='block';
			document.getElementById("fade").style.display='block';
		}
	</script>
	
</head>
	
<body style="font-family:oxygen,arial,sans-serif;text-align:center;color:#4b5b6e;">
	<div class="container" style="text-align:left;width:660px;">
		<div class="banner" style="width:100%;">
			<img src="http://northbridgetech.org/images/NB_horizontal_rgb.png" width="350" height="95" style="margin:20px;"/>
			<span style="background:#edf0de;float:right;padding:10px;margin-top:36px;border-radius:8px;"><span style="font-family:Oswald;font-size:130%">Nexus</span><hr/>Global Web Conference Center					
		</div>
		<div style="clear:both;"/>
		<div class="something" style="width:100%;">
			<button id="contextSwitch" class="button" href="javascript:void(0)" onclick="showJoinForm();">Tour Demo Meeting Room</button>

		</div>
		<!--
		<p style="background:#edf0de;width:510px;padding:5px;">Pre-meeting System Tech Check</p>
		<iframe src="http://northbridgetech.org/dev/nexus/view/include/conferenceTechCheck.html" width="600px" height="360px" frameborder="0" scrolling="no"></iframe> 
		-->
	</div>
	
	
	<div id="fade" class="black_overlay" style="display:none;"></div>
	<div id="join-form" class="white_content" style="420px;min-height:40px;display:none;border-radius:8px;">
		<FORM NAME="form1" METHOD="POST" action="demoMeetingProcessor.php" >
			<table cellpadding="5" cellspacing="5">
				<tbody>
					<tr>
						<td>&nbsp;</td>
						<td style="text-align: left; ">Your Name:</td>
						<td style="width: 5px; ">&nbsp;</td>
						<td style="text-align: left "><input type="text" autofocus required name="username" /></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td><input type="submit" value="Join" /></td>
					</tr>	
				</tbody>
			</table>
			<INPUT TYPE=hidden NAME=action VALUE="create">
		</FORM>
		<!--<a id="info-email-button" class="pure-button button-link" onclick="infoEmailValidateAndSubmit();" style="width:46px;border-radius:4px;float:right;"><span class="fa fa-play" style="margin-right:4px;" ></span>Send</a>-->
		</form>
	</div>
</body>
</html>

