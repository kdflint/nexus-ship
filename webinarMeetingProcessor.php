<?php

session_start();

require_once("config/env_config.php");
require_once("control/error/handlers.php");
require_once("control/bbb-api-php/includes/bbb-api.php"); 
//require_once("control/bbb-api-php/includes/config.php"); 

//$base_url_setConfigXML = CONFIG_SERVER_BASE_URL . "api/setConfigXML.xml?";
//$securitySalt = CONFIG_SECURITY_SALT;

$bbb = new BigBlueButton();

$joinerPassword = "mp";

if (!strcmp($env_name, "prod")) {
	$joinerPassword = "ap";
}

$creationParams = array(
	'meetingId' => '8888',
	'meetingName' => "Northbridge Community Room",
	'attendeePw' => 'ap',
	'moderatorPw' => 'mp',
	'welcomeMsg' => 'Welcome to the Northbridge Technology Alliance Information Webinar!<br/><br/>To join the session audio, click the headphone icon in the upper left corner of your display.<br/><br/>Messages entered here will be displayed to the entire group including the presenter.',
	'dialNumber' => '',
	'voiceBridge' => '',
	'webVoice' => '',
	'logoutUrl' => 'http://northbridgetech.org/index.php?view=apply',
	'maxParticipants' => '',
	'record' => '',
	'duration' => '0'
);

$joinParams = array(
	'meetingId' => '8888',
	'username' => $_POST['username'],
	'password' => $joinerPassword,
	'configToken' => ''  /* LEFT OFF HERE */
);

$bbb->createMeetingWithXmlResponseArray($creationParams);

$configUrl = $bbb->_bbbServerBaseUrl."api/setConfigXML?";
$configMeetingId = '8888';
$configXML = urlencode(getConfigXml());
$checksum = sha1("setConfigXMLconfigXML=".$configXML."&meetingID=".$configMeetingId."32ae7a3e328fb2c5575d5edf9ca29c35");
$configPostFields =	"configXML=".$configXML."&meetingID=".$configMeetingId . '&checksum=' . $checksum;
echo $configPostFields . "<br/><br/>";
$back = _processXmlResponse($configUrl, $configPostFields);
echo print_r($back); exit(0);

// TODO - check returnCodes
$itsAllGood = TRUE;

try {
	$result = $bbb->getJoinMeetingUrl($joinParams);
} catch (Exception $e) {
	$itsAllGood = FALSE;
}

if ($itsAllGood) {
	header("location:" . $result);	
	exit(0);
} else {
	trigger_error("Cannot join conference: $result\n", E_USER_ERROR);
	exit(0);
}

function _processXmlResponse($url, $xml = ''){
	//private function _processXmlResponse($url, $xml = ''){
	/* 
	A private utility method used by other public methods to process XML responses.
	*/
		if (extension_loaded('curl')) {
			$ch = curl_init() or die ( curl_error() );
			$timeout = 10;
			curl_setopt( $ch, CURLOPT_SSL_VERIFYPEER, false);	
			curl_setopt( $ch, CURLOPT_URL, $url );
			curl_setopt( $ch, CURLOPT_RETURNTRANSFER, 1 );
			curl_setopt( $ch, CURLOPT_CONNECTTIMEOUT, $timeout);
			if(!empty($xml)){
				curl_setopt($ch, CURLOPT_HEADER, 0);
				curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'POST');
				curl_setopt($ch, CURLOPT_POST, 1);
				curl_setopt($ch, CURLOPT_POSTFIELDS, $xml);
				curl_setopt($ch, CURLOPT_HTTPHEADER, array(
                                       'Content-type: application/x-www-form-urlencoded',
                                       'Content-length: ' . strlen($xml)
                                     ));
			}
			$data = curl_exec( $ch );
			curl_close( $ch );

			if($data)
				return (new SimpleXMLElement($data));
			else
				return false;
		}
		if(!empty($xml))
			throw new Exception('Set xml, but curl does not installed.');

		return (simplexml_load_file($url));	
}

function getConfigXml() {
	$thisConfig = 
	
'
<?xml version="1.0" ?>
<config>
    <localeversion suppressWarning="false">0.9.0</localeversion>
    <version>158</version>
    <help url="http://ec2-50-19-215-104.compute-1.amazonaws.com/help.html"/>
    <javaTest url="http://ec2-50-19-215-104.compute-1.amazonaws.com/testjava.html"/>
    <porttest host="ec2-50-19-215-104.compute-1.amazonaws.com" application="video/portTest" timeout="10000"/>    
    <bwMon server="10.113.144.150" application="video/bwTest"/>
    <application uri="rtmp://ec2-50-19-215-104.compute-1.amazonaws.com/bigbluebutton" host="http://ec2-50-19-215-104.compute-1.amazonaws.com/bigbluebutton/api/enter" />
    <language userSelectionEnabled="true" />
    <skinning enabled="true" url="http://ec2-50-19-215-104.compute-1.amazonaws.com/client/branding/css/BBBDefault.css.swf" />
    <shortcutKeys showButton="false" />
    <layout showLogButton="false" showVideoLayout="false" showResetLayout="true" defaultLayout="Default"
            showToolbar="true" showFooter="false" showMeetingName="true" showHelpButton="false" 
            showLogoutWindow="true" showLayoutTools="false" showNetworkMonitor="false" confirmLogout="true"/>
    <lock allowModeratorLocking="true" disableCamForLockedUsers="true" disableMicForLockedUsers="true" disablePrivateChatForLockedUsers="false" 
          disablePublicChatForLockedUsers="false" lockLayoutForLockedUsers="false"/>
            
		<modules>
		 
		<module name="ChatModule" url="http://ec2-50-19-215-104.compute-1.amazonaws.com/client/ChatModule.swf?v=158" 
			uri="rtmp://ec2-50-19-215-104.compute-1.amazonaws.com/bigbluebutton" 
			dependsOn="UsersModule"	
			translationOn="false"
			translationEnabled="false"	
			privateEnabled="true"  
			position="top-right"
			baseTabIndex="701"
			colorPickerIsVisible="false"
		/>

		<module name="UsersModule" url="http://ec2-50-19-215-104.compute-1.amazonaws.com/client/UsersModule.swf?v=158" 
			uri="rtmp://ec2-50-19-215-104.compute-1.amazonaws.com/bigbluebutton" 
			allowKickUser="true"
			enableRaiseHand="true"
			enableSettingsButton="true"
			baseTabIndex="301"
		/>

		
		<module name="DeskShareModule" 
			url="http://ec2-50-19-215-104.compute-1.amazonaws.com/client/DeskShareModule.swf?v=4105" 
			uri="rtmp://ec2-50-19-215-104.compute-1.amazonaws.com/deskShare"
			showButton="true"
			autoStart="false"
			autoFullScreen="false"
			baseTabIndex="201"
		/>
		
		<module name="PhoneModule" url="http://ec2-50-19-215-104.compute-1.amazonaws.com/client/PhoneModule.swf?v=158" 
			uri="rtmp://ec2-50-19-215-104.compute-1.amazonaws.com/sip" 
			autoJoin="false"
			listenOnlyMode="true"
			forceListenOnly="true"
			presenterShareOnly="true"
			skipCheck="false"
			showButton="true"
			enabledEchoCancel="true"
			useWebRTCIfAvailable="false"
			showPhoneOption="false"
			echoTestApp="9196"
			dependsOn="UsersModule"
		/>

		<module name="VideoconfModule" url="http://ec2-50-19-215-104.compute-1.amazonaws.com/client/VideoconfModule.swf?v=158" 
			uri="rtmp://ec2-50-19-215-104.compute-1.amazonaws.com/video"
			dependson = "UsersModule"
			videoQuality = "100"
			presenterShareOnly = "true"
			controlsForPresenter = "false"
			resolutions = "320x240,640x480,1280x720"
			autoStart = "false"
			skipCamSettingsCheck="false"
			showButton = "true"
			showCloseButton = "true"
			publishWindowVisible = "true"
			viewerWindowMaxed = "false"
			viewerWindowLocation = "top"
			camKeyFrameInterval = "30"
			camModeFps = "10"
			camQualityBandwidth = "0"
			camQualityPicture = "90"
			smoothVideo="false"
			applyConvolutionFilter="false"
			convolutionFilter="-1, 0, -1, 0, 6, 0, -1, 0, -1"
			filterBias="0"
			filterDivisor="4"
			enableH264 = "true"
			h264Level = "2.1"
			h264Profile = "main"		
			displayAvatar = "false"
			focusTalking = "false"
			glowColor = "0x4A931D"
			glowBlurSize = "30.0"	
		/>
		
		<module name="WhiteboardModule" url="http://ec2-50-19-215-104.compute-1.amazonaws.com/client/WhiteboardModule.swf?v=4105" 
			uri="rtmp://ec2-50-19-215-104.compute-1.amazonaws.com/bigbluebutton" 
			dependsOn="PresentModule"
			baseTabIndex="601"
			whiteboardAccess="presenter"
			keepToolbarVisible="false"
		/>

		<module name="PresentModule" url="http://ec2-50-19-215-104.compute-1.amazonaws.com/client/PresentModule.swf?v=158" 
			uri="rtmp://ec2-50-19-215-104.compute-1.amazonaws.com/bigbluebutton" 
			host="http://ec2-50-19-215-104.compute-1.amazonaws.com" 
			showPresentWindow="true"
			showWindowControls="true"
			openExternalFileUploadDialog="false"
			dependsOn="UsersModule"
			baseTabIndex="501"
			maxFileSize="30"
		/>

		<module name="VideodockModule" url="http://ec2-50-19-215-104.compute-1.amazonaws.com/client/VideodockModule.swf?v=158"
			uri="rtmp://ec2-50-19-215-104.compute-1.amazonaws.com/bigbluebutton" 
			dependsOn="VideoconfModule, UsersModule"
			autoDock="true"
			showControls="true"
			maximizeWindow="false"
			position="bottom-right"
			width="172"
			height="179"
			layout="smart"
			oneAlwaysBigger="false"
			baseTabIndex="401"
		/>
		
		<module name="LayoutModule" url="http://ec2-50-19-215-104.compute-1.amazonaws.com/client/LayoutModule.swf?v=158"
			uri="rtmp://ec2-50-19-215-104.compute-1.amazonaws.com/bigbluebutton"
			layoutConfig="http://ec2-50-19-215-104.compute-1.amazonaws.com/client/conf/layout.xml"
			enableEdit="false"
		/>
    		
	</modules>
</config>
';

return $thisConfig;
}


?>
