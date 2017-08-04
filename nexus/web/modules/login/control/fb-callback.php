<?php
session_start();

require_once("../../../src/framework/Util.php");
require_once(Utilities::getLibRoot() . '/facebook/Facebook/autoload.php' );

$conf = array('append' => true, 'mode' => 0644, 'timeFormat' => '%X %x');	
$logger = Log::singleton("file", Utilities::getLogRoot() ."/facebook_login.log", "", $conf, PEAR_LOG_DEBUG);

$fb = new Facebook\Facebook([
  'app_id' => Utilities::getFbAppId(),
  'app_secret' => Utilities::getFbAppSecret()
  //'default_graph_version' => 'v2.2',
  ]); 

$helper = $fb->getRedirectLoginHelper();

try {
  $accessToken = $helper->getAccessToken();
} catch(Facebook\Exceptions\FacebookResponseException $e) {
  // When Graph returns an error
	$logger->log("Facebook Graph returned an error: " . $e->getMessage(), PEAR_LOG_INFO);
	returnToLoginWithError("We're sorry - something went wrong with this Facebook login. Please use standard sign in.");
} catch(Facebook\Exceptions\FacebookSDKException $e) {
  // When validation fails or other local issues
	$logger->log("Facebook SDK returned an error: " . $e->getMessage(), PEAR_LOG_INFO);
	returnToLoginWithError("We're sorry - something went wrong with this Facebook login. Please use standard sign in.");
}

if (! isset($accessToken)) {
  if ($helper->getError()) {
    header('HTTP/1.0 401 Unauthorized');
		$logger->log("Facebook SDK returned an error: " . $helper->getError(), PEAR_LOG_INFO);
		$logger->log("Error Code: " . $helper->getErrorCode(), PEAR_LOG_INFO);
		$logger->log("Error Reason: " . $helper->getErrorReason(), PEAR_LOG_INFO);
		$logger->log("Error Description: " . $helper->getErrorDescription(), PEAR_LOG_INFO);
		returnToLoginWithError("We're sorry - something went wrong with this Facebook login. Please use standard sign in.");
  } else {
    header('HTTP/1.0 400 Bad Request');
		$logger->log("Facebook returned an error: " . "Bad callback request", PEAR_LOG_INFO);
		returnToLoginWithError("We're sorry - something went wrong with this Facebook login. Please use standard sign in.");
  }
}
  
// Logged in now

// The OAuth 2.0 client handler helps us manage access tokens
$oAuth2Client = $fb->getOAuth2Client();

// Get the access token metadata from /debug_token
$tokenMetadata = $oAuth2Client->debugToken($accessToken);

if (! $accessToken->isLongLived()) {
  // Exchanges a short-lived access token for a long-lived one
  try {
    $accessToken = $oAuth2Client->getLongLivedAccessToken($accessToken);
  } catch (Facebook\Exceptions\FacebookSDKException $e) {
		$logger->log("Facebook error getting long-lived access token: " . $helper->getMessage(), PEAR_LOG_INFO);
    returnToLoginWithError("We're sorry - something went wrong with this Facebook login. Please use the standard sign in button.");
  }
}

$response = $fb->get('/me?fields=email', $accessToken);
$node = $response->getGraphObject();

$tokenString = (string) $accessToken;
$_SESSION['fb_access_token'] = substr($tokenString, 0, 16) . "...";
$_SESSION['fb_email'] = $node->getProperty('email');

// User is logged in with a long-lived access token.
// You can redirect them to a members-only page.
//header('Location: https://example.com/members.php');

header('Location: ' . Utilities::getHttpPath() . '/modules/login/control/loginProcessor.php');
exit(0);

function returnToLoginWithError($errorMessage) {
	header("location:" . Utilities::getHttpPath() . "/login.php?logout=true&error=" . $errorMessage);
	exit(0);
}

?>
