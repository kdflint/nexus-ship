<?
session_start();

// bounce an unauthenticated user
if(false) //(empty($_SESSION['userid']))
	{
  header("location:login.php");
}

// select content to show based on request variable, which is supplied in navigation.php
if (isset($_REQUEST['thisPage'])) {
	$thisPage = $_REQUEST['thisPage'];
} else {
	$thisPage="chat";
}
?>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">

<html>
  <head>
  	<meta http-equiv="Content-type" content="text/html;charset=UTF-8">
    <link rel="stylesheet" href="style/style.css" type="text/css" />
    <script src="script/script.js" language="javascript"></script>
    <link rel="shortcut icon" href="images/northbridge-ico.png" />
    <title>Nexus</title>
  </head>

  <body>
    <div class="container">
    <a href="http://northbridgetech.org/index.php"><img style="float:left;vertical-align:top;margin:10px;" src="http://northbridgetech.org/images/northbridge-logo.png" height="86" width="215" border="0" alt="NorthBridge Technology Alliance"/></a>
    <p style="text-align:right;color:#57574a;font-size:22px;margin:20px;"><b>Nexus</b>, v 0.01</b></p>
    <p style="text-align:right;margin:20px;"><a href="login.php?logout=true">Logout</a> | <a href="#">My Account</a> | <a href="#">Help</a></p>
      <div class="shell">

<div class="projectsContent">
  
  <ul>
  	<li>edit</li>
  	<li>export</li>
  	<li>map by services, location, outside constituency, etc.</li>
  	<li>personal directory view?</li>
  	<li>social media</li>
  </ul>
</div>      	
      	
      </div><!--shell-->
    </div><!-- container -->
	</body>
</html>
      	
