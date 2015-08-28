<?php

session_start();

require_once("../../../src/framework/Util.php");
require_once(Util::getSrcRoot() . "/schedule/Event.php");
require_once(Util::getModulesRoot() . "/error/handlers.php");
require_once(Util::getLibRoot() . "/bigbluebutton/bbb-api-php/includes/bbb-api.php"); 

$dirty = array('uuid' => $_GET['id'], 'mtype' => $_GET['type']);
$clean = array();

if (isset($dirty['uuid']) && Event::isValidEventUuid($dirty['uuid'])) {
	$clean['uuid'] = $dirty['uuid'];
} else {
	// TODO - centralize this
	forceLogout();
}

if (isset($dirty['mtype']) && Event::isValidMeetingType($dirty['mtype'])) {
	$clean['mtype'] = $dirty['mtype'];
} else {
	$clean['mtype'] = 'collaboration';
}

if (!Util::isSessionValid()) {
	header("location:" . Util::getHttpPath() . "/index.php");
	exit(0);
}

$bbb = new BigBlueButton();

$joinerPassword = "mp";
$meetingId = $clean['uuid'];
$itsAllGood = TRUE;
$joinUrl = "";
$configToken = "";

// TODO - log out url

$creationParams = array(
	'meetingId' => $meetingId,
	'meetingName' => array_values($_SESSION['groups'])[0] . " Web Room",
	'attendeePw' => 'ap',
	'moderatorPw' => 'mp',
	'welcomeMsg' => '<b>Messages entered here will be displayed to the entire group, including the presenter.</b><br/><br/>Click the Options tab to send a private chat message to an individual attender.',
	'dialNumber' => '',
	'voiceBridge' => '',
	'webVoice' => '',
	'logoutUrl' => '',
	'maxParticipants' => '',
	'record' => '',
	'duration' => '0'
);

try {
	$response = $bbb->createMeetingWithXmlResponseArray($creationParams);
	if (strcasecmp($response['returncode'], 'SUCCESS') != 0) {
		$itsAllGood = FALSE;
	}
} catch (Exception $e) {
	trigger_error("Cannot create meeting: " . $e->getMessage() . "\n", E_USER_ERROR);
	$itsAllGood = FALSE;
}

if ($itsAllGood && $clean['mtype'] == 'video chat') {
	try {
		$response = $bbb->setMeetingConfig(getConfigXml(), $meetingId);
		if (strcasecmp($response['returncode'], 'SUCCESS') != 0 || !isset($response['token']) || strlen($response['token']) < 1) {
			$itsAllGood = FALSE;
		} else {
			$configToken = (string)$response['token'];
		}
 	} catch (Exception $e) {
 		//echo "Cannot set configuration: " . $e->getMessage() . "\n", E_USER_ERROR;
		trigger_error("Cannot set configuration: " . $e->getMessage() . "\n", E_USER_ERROR);
		$itsAllGood = FALSE;
	}	
}

$joinParams = array(
	'meetingId' => $meetingId,
	'username' => $_SESSION['fname'] . " " . $_SESSION['lname'],
	'password' => $joinerPassword,
	'configToken' => $configToken
);

if ($itsAllGood) {
	try {
		$joinUrl = $bbb->getJoinMeetingUrl($joinParams);
		// TODO - figure out how to tell if this url is well formed and valid. See under "join" at https://docs.bigbluebutton.org/dev/api.html
	} catch (Exception $e) {
		//echo "Cannot get join meeting url: " . $e->getMessage() . "\n", E_USER_ERROR;
		trigger_error("Cannot get join meeting url: " . $e->getMessage() . "\n", E_USER_ERROR);
		$itsAllGood = FALSE;
	}
}

if ($itsAllGood) {
	header("location:" . $joinUrl);	
	exit(0);
} else {
	trigger_error("Cannot join conference: " . $joinUrl . "\n", E_USER_ERROR);
	exit(0);
}

function forceLogout() {
	header("location:" . Util::getHttpPath() . "/login.php?logout=true");
	exit(0);
}

function getConfigXml() {

	$thisConfig = 
	
'
<?xml version="1.0" ?>
<config>
		<localeversion suppressWarning="false">0.9.0</localeversion>
		<version>264</version>
    <help url="http://ec2-50-19-215-104.compute-1.amazonaws.com/help.html"/>
    <javaTest url="http://ec2-50-19-215-104.compute-1.amazonaws.com/testjava.html"/>
    <porttest host="ec2-50-19-215-104.compute-1.amazonaws.com" application="video/portTest" timeout="10000"/>    
    <bwMon server="10.113.144.150" application="video/bwTest"/>
    <application uri="rtmp://ec2-50-19-215-104.compute-1.amazonaws.com/bigbluebutton" host="http://ec2-50-19-215-104.compute-1.amazonaws.com/bigbluebutton/api/enter" />
    <language userSelectionEnabled="true" />
    <skinning enabled="true" url="http://ec2-50-19-215-104.compute-1.amazonaws.com/client/branding/css/BBBDefault.css.swf" />
    <shortcutKeys showButton="true" />
    <layout showLogButton="false" showVideoLayout="false" showResetLayout="true" defaultLayout="bbb.layout.name.videochat"
            showToolbar="true" showFooter="true" showMeetingName="true" showHelpButton="true" 
            showLogoutWindow="true" showLayoutTools="true" showNetworkMonitor="false" confirmLogout="true"/>
    <lock allowModeratorLocking="false" disableCamForLockedUsers="false" disableMicForLockedUsers="false" disablePrivateChatForLockedUsers="false" 
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
			forceListenOnly="false"
			presenterShareOnly="false"
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
			presenterShareOnly = "false"
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

