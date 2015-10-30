<?php

session_start();

require_once("../../../src/framework/Util.php");
require_once(Utilities::getModulesRoot() . "/error/handlers.php");
require_once(Utilities::getLibRoot() . "/bigbluebutton/bbb-api-php/includes/bbb-api.php"); 

$bbb = new BigBlueButton();

$joinerPassword = "mp";
$trainingMeetingId = '7777';

$creationParams = array(
	'meetingId' => $trainingMeetingId,
	'meetingName' => "Northbridge Training Room",
	'attendeePw' => 'ap',
	'moderatorPw' => 'mp',
	'welcomeMsg' => '<b>Welcome to the Northbridge Technology Alliance Nexus Training Session!</b><br/><br/>Messages entered here will be displayed to the entire group, including the presenter.',
	'dialNumber' => '',
	'voiceBridge' => '',
	'webVoice' => '',
	'logoutUrl' => 'http://northbridgetech.org/dev/nexus/training-1b.php',
	'maxParticipants' => '',
	'record' => '',
	'duration' => '0'
);

$itsAllGood = TRUE;
$joinUrl = "";
$configToken = "";

try {
	$response = $bbb->createMeetingWithXmlResponseArray($creationParams);
	if (strcasecmp($response['returncode'], 'SUCCESS') != 0) {
		$itsAllGood = FALSE;
	}
} catch (Exception $e) {
	trigger_error("Cannot create meeting: " . $e->getMessage() . "\n", E_USER_ERROR);
	$itsAllGood = FALSE;
	echo "Problem with create meeting:" . $e->getMessage();
}

$joinParams = array(
	'meetingId' => $trainingMeetingId,
	'username' => "Kathy Flint",
	'password' => $joinerPassword,
	'configToken' => $configToken
);

if ($itsAllGood) {
	try {
		$joinUrl = $bbb->getJoinMeetingUrl($joinParams);
		// TODO - figure out how to tell if this url is well formed and valid. See under "join" at https://docs.bigbluebutton.org/dev/api.html
	} catch (Exception $e) {
		trigger_error("Cannot get join meeting url: " . $e->getMessage() . "\n", E_USER_ERROR);
		$itsAllGood = FALSE;
		echo "Problem with getting join url:" . $e->getMessage();
	}
}

echo "<p>Reload this page every time to rerun the create meeting logic</p>";
echo "<a href='" . $joinUrl . "'>Open Training</a>"; exit(0);

/*
function getConfigXml() {

	$thisConfig = 
	
'
<?phpxml version="1.0" ?>
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
            showLogoutWindow="true" showLayoutTools="false" showNetworkMonitor="false" confirmLogout="false"/>
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
			showButton="false"
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
*/
?>

