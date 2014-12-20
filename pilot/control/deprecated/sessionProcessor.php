<?php

session_start();

require_once dirname(__FILE__).'/forum_sso_functions.php';
require_once '../control/xmpp-prebind-php/lib/XmppPrebind.php';
include("../model/pgDb.php");
include("util.php");

$action = Util::clean($_POST['action']);
$uid = Util::clean($_POST['uid']);
$password = Util::clean($_POST['password']);

if ($action == "authenticate") {
	$message = "";
	if (Util::authenticate($uid, $password)) {
		
		refreshSession($uid);
		
		if (initiateForumSession($uid)) {

		} else {
			$message = "?error=Forum login failed.";
		}
		
		if (initiateXmppSession($_SESSION['fname'], "password", "test.nexus")) {
		//if (initiateXmppSession("admin", "password", "test.nexus")) {

		} else {
			$message = "?error=XMPP login failed.";
		}		
		
		header("location:../view/nexus.php?showMap=1");
		exit(0);
		
	} else {
		$message = "?error=Nexus login failed.";
	}
	header("location:../view/login.php" . $message);
	exit(0);
}

function initiateForumSession($uid) {
	$user = array();
	$user['user'] = $uid;
	$login_status = forumSignin($user);	
	if($login_status == 'Login Successful') {
		return true;
	}
	return false;
}

function initiateXmppSession($username, $password, $host) {
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
	 
	$xmppPrebind = new XmppPrebind($host, 'http://ec2-54-204-130-42.compute-1.amazonaws.com:3306/http-bind', '', false, false);
	$xmppPrebind->connect($username, $password);
	$xmppPrebind->auth();
	$sessionInfo = $xmppPrebind->getSessionInfo(); // array containing sid, rid and jid
	
	$_SESSION['jid'] = "'" . $sessionInfo['jid'] . "'";
	$_SESSION['sid'] = "'" . $sessionInfo['sid'] . "'";
	$_SESSION['rid'] = "'" . $sessionInfo['rid'] . "'";

}

function refreshSession($uid) {

		session_regenerate_id();
		session_unset();
		
		$cursor = pgDb::getUserSessionByUsername($uid);
		$row = pg_fetch_array($cursor);	
		$_SESSION['userId'] = $row['id'];		
		$_SESSION['fname'] = $row['fname'];
		$_SESSION['lname'] = $row['lname'];
 		$_SESSION['role'] = $row['role'];
  	$_SESSION['network'] = $row['network'];
		$_SESSION['affiliation'] = $row['affiliation'];

}

?>