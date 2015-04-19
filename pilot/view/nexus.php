<?

//error_reporting(E_ALL);
//ini_set( 'display_errors','1'); 

session_start();

//require_once '../control/xmpp-prebind-php/lib/XmppPrebind.php';
require_once("../control/util.php");


if (!Util::isSessionValid()) {
	header("location:login.php?logout=true");
	exit(0);	
}

require_once($_SESSION['appRoot'] . "control/error/handlers.php");

$hideHere = false;
if (Util::hideInEnvironment()) {
	$hideHere = true;	
}

// LEFT OFF - put in session timeout code - or not?

// select content to show based on request variable, which is supplied in navigation.php
if (isset($_REQUEST['thisPage'])) {
	$thisPage = $_REQUEST['thisPage'];
} else {
	$thisPage = "directory";
}


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

//This script would go at the end of the page.
/*
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
*/

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
	  <!--<link rel="stylesheet" type="text/css" media="screen" href="style/converse.min.css">-->
 		<script src="script/script.js" language="javascript"></script>
		<!--<script src="script/converse.min.js"></script>-->
    <link rel="shortcut icon" href="image/northbridge-ico.png" />
    <title>Nexus Home</title>
		

    
    <link rel="stylesheet" href="script/jquery-ui-1.11.1.custom/jquery-ui.css">
    <script src="script/jquery-ui-1.11.1.custom/external/jquery/jquery.js"></script>
		<script src="script/jquery-ui-1.11.1.custom/jquery-ui.js"></script>
		<script>$(function() {$( document ).tooltip();});</script>
		<style>label {display: inline-block;width: 5em;}</style>		
		
  </head>
  
  <!-- For Formilla feedback form -->
  <script type="text/javascript">
    (function () {
        var head = document.getElementsByTagName("head").item(0);
        var script = document.createElement("script");
        var src = (document.location.protocol == 'https:' ? 'https://www.formilla.com/scripts/feedback.js' : 'http://www.formilla.com/scripts/feedback.js');
        script.setAttribute("type", "text/javascript"); script.setAttribute("src", src); script.setAttribute("async", true);
        var complete = false;

        script.onload = script.onreadystatechange = function () {
            if (!complete && (!this.readyState || this.readyState == 'loaded' || this.readyState == 'complete')) {
                complete = true;
                Formilla.guid = 'd94fe060-648d-45c5-9698-2e43d5817798';
                Formilla.loadFormillaChatButton();
            }
        };

        head.appendChild(script);
    })();
  </script>
                
  
  <body>
    <div class="container">
    	
    <table width="100%">
    	<tr>
    	<td>
    		<img style="float:left;vertical-align:top;margin:20px;" <? echo $_SESSION['logo']; ?> border="0" alt=""/>
    	</td>
    	<td>
    		<p style="text-align:right;color:#c9c9a7;font-size:18px;margin:20px;"><b><? echo($_SESSION['orgName']); ?></b></p>
    		<p style="text-align:right;margin:20px;color:#4b5b6e"><b>Hello <? echo($_SESSION['fname']); ?></b><br/>
    		<!-- <a id="chatControlLink" href="javascript:toggleChat('chatControl')">Chat</a> |  -->
				<a href="include/download/help.pdf">Help</a> | <a href="javascript:void(0)" onclick="if(typeof Formilla != 'undefined'){Formilla.initFormillaChat();}">Problem?</a> | <a href="../control/resetForumSession.php">Support Forum</a> | <a href="login.php?logout=true&network=<? echo $_SESSION['networkId']; ?>">Logout</a></p>
			</td>
    	</tr>
    </table>	
        	
      <div class="shell">
      	
				<div class="navigation">
      		<? include($_SESSION['appRoot'] . "view/include/navigation.php"); ?>
 		  	</div>

				<div class="projectsContent">						
			 	<?
			   $contentFile = $_SESSION['appRoot'] . "view/include/" . $thisPage . ".php";
			   include($contentFile); 
			 	?>
			 	</div>
			 				
					<!--<div id="chatControl" style="display:block;">-->
			 		<!--	<div id="conversejs"></div> -->
			 		<!--</div>-->
			 			 		
      </div><!--shell-->
    </div><!-- container -->
		<div id="fade" class="black_overlay"></div>    
	</body>
	




</html>

