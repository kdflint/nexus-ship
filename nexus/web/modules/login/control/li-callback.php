<?php
session_start();

require_once("../../../src/framework/Util.php");
require_once(Utilities::getLibRoot() . '/linkedin/oauth_client.php' );
require_once(Utilities::getLibRoot() . '/linkedin/http.php' );

$conf = array('append' => true, 'mode' => 0644, 'timeFormat' => '%X %x');	
$logger = Log::singleton("file", Utilities::getLogRoot() ."/sm_login.log", "", $conf, PEAR_LOG_DEBUG);

$apiKey     = Utilities::getLiAppId();
$apiSecret  = Utilities::getLiAppSecret();
$redirectURL=  Utilities::getHttpPath() . '/modules/login/control/li-callback.php';
$scope      = 'r_emailaddress';

if ((isset($_GET["oauth_init"]) && $_GET["oauth_init"] == 1) || (isset($_GET['oauth_token']) && isset($_GET['oauth_verifier']))){

    $client = new oauth_client_class;
    
    $client->client_id = $apiKey;
    $client->client_secret = $apiSecret;
    $client->redirect_uri = $redirectURL;
    $client->scope = $scope;
    $client->debug = false;
    $client->debug_http = true;
    $application_line = __LINE__;
       
    //If authentication returns success
    if($success = $client->Initialize()){
        if(($success = $client->Process())){
            if(strlen($client->authorization_error)){
                $client->error = $client->authorization_error;
                $success = false;
            }elseif(strlen($client->access_token)){
                $success = $client->CallAPI('http://api.linkedin.com/v1/people/~:(email-address)', 
                'GET',
                array('format'=>'json'),
                array('FailOnAccessError'=>true), $userInfo);
            }
        }
        $success = $client->Finalize($success);
    }
    
    if($client->exit) { exit; }
    
    if($success){
       
        $_SESSION['li_oauth_status'] = 'verified';
        Utilities::setSmSessionValues($userInfo->emailAddress, 'LinkedIn');
        
				header('Location: ' . Utilities::getHttpPath() . '/modules/login/control/loginProcessor.php');
				exit(0);
    }else{
			$logger->log("LinkedIn error: " . __FILE__ . ":" . __LINE__, PEAR_LOG_INFO);
    	returnToLoginWithError("We're sorry - something went wrong with this LinkedIn login. Please use the standard sign in button.");    	
    }
} else if (isset($_GET["oauth_problem"]) && $_GET["oauth_problem"] <> ""){
		$logger->log("LinkedIn error: " . __FILE__ . ":" . __LINE__, PEAR_LOG_INFO);
   	returnToLoginWithError("We're sorry - something went wrong with this LinkedIn login. Please use the standard sign in button.");    	
} else {
			$logger->log("LinkedIn error: " . __FILE__ . ":" . __LINE__, PEAR_LOG_INFO);
    	returnToLoginWithError("We're sorry - something went wrong with this LinkedIn login. Please use the standard sign in button.");    	
}

function returnToLoginWithError($errorMessage) {
	header("location:" . Utilities::getHttpPath() . "/login.php?logout=true&error=" . $errorMessage);
	exit(0);
}

?>
