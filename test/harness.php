<?
session_start();

// TODO: bounce an unauthenticated user
if(false) { //(empty($_SESSION['userid']))
  header("location:login.php");
}

//if(isset($_SESSION['error'])) {
//	$error = ""; // $error = $_SESSION['error'];
//} else { 
	$error = "";
//}

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">

<html>
  <head>
  	<meta http-equiv="Content-type" content="text/html;charset=UTF-8">
    <link rel="stylesheet" href="../style/style.css" type="text/css" />
    <script src="../script/script.js" language="javascript"></script>
    <link rel="shortcut icon" href="../images/northbridge-ico.png" />
    <title>Nexus</title>
  </head>
  <body>
    <div class="container">
    <a href="http://northbridgetech.org/index.php"><img style="float:left;vertical-align:top;margin:10px;" src="http://northbridgetech.org/images/northbridge-logo.png" height="86" width="215" border="0" alt="NorthBridge Technology Alliance"/></a>
    <p style="text-align:right;color:#57574a;font-size:22px;margin:20px;"><b>Nexus Test Harness</b></b></p>
      <div class="shell">

				<div class="leftColumn">
					<b>Forum</b>
							<form action="../loginProcessor.php" method="post">
									User Id: <input class="passed" type="text" size="25" name="user" value=""/><br/>
									<input type="submit" value="Login"/>
							</form>
							<form action="../logoutProcessor.php" method="post">
									User Id: <input class="passed" type="text" size="25" name="user" value=""/><br/>
									<input type="submit" value="Logout"/>
							</form>
							<form action="../registerProcessor.php" method="post">
									User Id: <input class="passed" type="text" size="25" name="user" value=""/><br/>
									Password: <input class="passed" type="text" size="25" name="password" value=""/><br/>
									Email: <input class="passed" type="text" size="25" name="email" value=""/><br/>
									<input type="submit" value="Register"/>
							</form>
			 	</div>

				<div class="rightColumn">
					more stuff
 		  	</div>

      </div><!--shell-->
    </div><!-- container -->  	
  </body>
</html>