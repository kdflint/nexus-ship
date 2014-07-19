<?

error_reporting(E_ALL);
ini_set( 'display_errors','1'); 

session_start();

// select content to show based on request variable, which is supplied in navigation.php
if (isset($_REQUEST['thisPage'])) {
	$thisPage = $_REQUEST['thisPage'];
} else {
	$thisPage = "directory";
}


require_once '../control/xmpp-prebind-php/lib/XmppPrebind.php';

/**
 * Comment here for explanation of the options.
 *
 * Create a new XMPP Object with the required params
 *
 * @param string $jabberHost Jabber Server Host (virtual server)
 * @param string $boshUri    Full URI to the http-bind
 * @param string $resource   Resource identifier
 * @param bool   $useSsl     Use SSL (not working yet, TODO)
 * @param bool   $debug      Enable debug
 */
 
// Do this during the login sequence 
//$username = $_SESSION['fname'];
//$password = "password";
//$xmppPrebind = new XmppPrebind('nexus.test', 'http://ec2-54-204-130-42.compute-1.amazonaws.com:3306/http-bind', '', false, false);
//$xmppPrebind->connect($username, $password);
//$xmppPrebind->auth();
//$sessionInfo = $xmppPrebind->getSessionInfo(); // array containing sid, rid and jid

/*

if(curl_exec($ch) === false) 	{
    $out2 = 'Curl error: ' . curl_error($ch);
}	else 	{
    $out2 = 'Operation completed without any errors: ' . curl_exec($ch);
}

*/

//$jid = "'" . $sessionInfo['jid'] . "'";
//$sid = "'" . $sessionInfo['sid'] . "'";
//$rid = "'" . $sessionInfo['rid'] . "'";



?>

<!DOCTYPE html> 

<html>
  <head>  	
  		
    <!-- For Google Map 
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCw8wGNP_YbytpUxZCfgxhtqKG6izDixN0&sensor=false"></script>
     End Google stuff -->
  	
  	<meta http-equiv="Content-type" content="text/html;charset=UTF-8">
	  <link rel="stylesheet" type="text/css" href="style/style.css" />
	  <link rel="stylesheet" type="text/css" media="screen" href="style/converse.min.css">
 		<script src="script/script.js" language="javascript"></script>
		<script src="script/converse.min.js"></script>
    <link rel="shortcut icon" href="image/northbridge-ico.png" />
    <title>Nexus Home</title>
  </head>
  
  <body>
    <div class="container">
    	
    <table>
    	<tr>
    	<td>
    		<img style="float:left;vertical-align:top;margin:20px;" src="http://chicagofaithandhealth.org/imgs/logo.png" height="88" width="365" border="0" alt="Demo Organization Logo"/>
    	</td>
    	<!--<td width="30%"><p style="text-align:left;color:#57574a;font-size:24px;margin:20px;"><b><? echo($_SESSION['networkName']); ?></b></p></td>-->
    	<td>
    		<p style="text-align:right;color:#c9c9a7;font-size:18px;margin:20px;"><b><? echo($_SESSION['orgName']); ?></b></p>
    		<p style="text-align:right;margin:20px;"><b>Hello <? echo($_SESSION['fname']); ?></b><br/>
    		<!-- <a id="chatControlLink" href="javascript:toggleChat('chatControl')">Chat</a> |  -->
				<a href="#">Help</a> | <a href="login.php?logout=true">Logout</a></p>
			</td>
    	</tr>
    </table>	
        	
      <div class="shell">
      	
				<div class="navigation">
      		<? include 'include/navigation.php'; ?>
 		  	</div>

				<div class="projectsContent">						
			 	<?
			   $contentFile = "include/" . $thisPage . ".php";
			   include $contentFile; 
			 	?>
			 	</div>
			 				
					<!--<div id="chatControl" style="display:block;">-->
			 		<!--	<div id="conversejs"></div> -->
			 		<!--</div>-->
			 			 		
      </div><!--shell-->
    </div><!-- container -->
    
	</body>
	
<!--
<script>
		// Complete list of options published at
		// https://conversejs.org/docs/html/index.html#configuration-variables
		// The below are all the non-default values - rest we take defaults as specified in above doc
    require(['converse'], function (converse) {
        converse.initialize({
        		auto_list_rooms: true,
            bosh_service_url: 'http://ec2-54-204-130-42.compute-1.amazonaws.com:3306/http-bind', // felis connection manager
            debug: true,
            hide_muc_server: true,
            i18n: locales['en'],
            prebind: true,
            jid: <? echo $_SESSION['jid']; ?>,
            sid: <? echo $_SESSION['sid']; ?>,
        		rid: <? echo $_SESSION['rid']; ?>,
            show_controlbox_by_default: true,
            use_vcards: true
            // TODO: look further into show_call_button, otr, show_only_online_users, user_search, vcards
        });
    });
</script>
-->

<script>
	
	 function keepForumAlive() {
		 http_request = new XMLHttpRequest();
     http_request.open('GET', "http://northbridge.websitetoolbox.com/register/dologin?authtoken=<? echo($_SESSION['authtoken']); ?>");
     http_request.send(null);
	 };

	 function init() {
    	window.setInterval("keepForumAlive()", 60000);
	 }

	 window.onload = init;

</script>


</html>

