<?
require '../control/xmpp-prebind-php/lib/XmppPrebind.php';

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
$username = "admin";
$password = "password";
$xmppPrebind = new XmppPrebind('localhost', 'http://ec2-54-204-130-42.compute-1.amazonaws.com:3306/http-bind', '', false, false);
$xmppPrebind->connect($username, $password);
$xmppPrebind->auth();
$sessionInfo = $xmppPrebind->getSessionInfo(); // array containing sid, rid and jid

/*

if(curl_exec($ch) === false) 	{
    $out2 = 'Curl error: ' . curl_error($ch);
}	else 	{
    $out2 = 'Operation completed without any errors: ' . curl_exec($ch);
}

*/

$jid = "'" . $sessionInfo['jid'] . "'";
$sid = "'" . $sessionInfo['sid'] . "'";
$rid = "'" . $sessionInfo['rid'] . "'";

?>

<!DOCTYPE html>
<html>
<head>  	  	
	<meta http-equiv="Content-type" content="text/html;charset=UTF-8">
  <link rel="stylesheet" href="http://northbridgetech.org/apps/pilot/style/style.css" type="text/css" />
  <link rel="stylesheet" type="text/css" media="screen" href="converse.min.css">
  <link rel="shortcut icon" href="images/northbridge-ico.png" />
	<script src="builds/converse.min.js"></script>
  <script src="http://northbridgetech.org/apps/pilot/script/script.js" language="javascript"></script>
  <title>Nexus Home</title>
</head>

<body>
	<div class="container">
    	
  	<table>
    	<tr>
    	<td><img style="float:left;vertical-align:top;margin:20px;" src="http://northbridgetech.org/apps/pilot/images/demo.jpg" height="100" width="100" border="0" alt="Demo Organization Logo"/></a></td>
    	<td width="30%"><p style="text-align:left;color:#57574a;font-size:24px;margin:20px;"><b><? echo($_SESSION['network']); ?></b></p></td>
    	<td>
    		<p style="text-align:right;color:#c9c9a7;font-size:18px;margin:20px;"><b><? echo($_SESSION['affiliation']); ?></b></p>
    		<p style="text-align:right;margin:20px;"><b>Hello <? echo($_SESSION['fname']); ?></b><br/>
    		<a href="login.php?logout=true">Logout</a> | <a href="#">My Account</a> | <a href="#">Help</a></p>
    	</td>
    	</tr>
    </table>	
    	
      <div class="shell">
				<p>JID: <? echo $jid; ?></p>
				<p>SID: <? echo $sid; ?></p>
				<p>RID: <? echo $rid; ?></p>

				<div id="conversejs"></div>

     </div><!--shell-->
   </div><!-- container -->
</body>

<script>
		// Complete list of options published at
		// https://conversejs.org/docs/html/index.html#configuration-variables
		// The below are all the non-default values - rest we take defaults as specified in above doc
    require(['converse'], function (converse) {
        converse.initialize({
        		auto_list_rooms: true,
            bosh_service_url: 'http://ec2-54-204-130-42.compute-1.amazonaws.com:3306/http-bind', // felis connection manager
            debug: true ,
            fullname: 'Edgewood Community Services',
            hide_muc_server: true,
            i18n: locales['en'],
            prebind: true,
            jid: <? echo $jid; ?>,
            sid: <? echo $sid; ?>,
        		rid: <? echo $rid; ?>,
            show_controlbox_by_default: true,
            use_vcards: false
            // TODO: look further into show_call_button, otr, show_only_online_users, user_search
        });
    });
</script>
</html>
