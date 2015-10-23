<?php

class BbbMeeting {
	
	const VIDEO_CHAT = 'video chat';
	const COLLABORATION = 'collaboration';
	const VIDEO_LINK = 'video tether';
	const WEBINAR = 'webinar';
	
	var $creationParams = array(
		'meetingId' => '',
		'meetingName' => '',
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
	
	var $meetingType = "";

	function __construct($id, $name, $type) {	
		require_once(dirname(__FILE__) . "/../framework/Util.php");
		$this->creationParams['meetingId'] = $id;
		$this->creationParams['meetingName'] = $name;	
		$this->creationParams['logoutUrl'] = Util::getHttpPath() . '/roomLogout.html';
		$this->meetingType = $type;
	}
	
	function getCreationParams() {
		return $this->creationParams;
	}
	
	function getMeetingId() {
		return $this->creationParams['meetingId'];
	}
	
	function getMeetingConfigurationXml() {
		
		$inFile;
		
		switch($this->meetingType) {
			case self::VIDEO_CHAT:
				$inFile = "config_video_chat.xml";
				break;
			case self::VIDEO_LINK:
				$inFile = "config_video_link.xml";
				break;
			case self::WEBINAR:
				$inFile = "config_webinar.xml";
				break;
			default:
				$inFile = "config_collaboration.xml";
		}
		
		$in = fopen(dirname(__FILE__) . "/config/" . $inFile, "r");
		$configXml = "";
		if ($in) {
			while (!feof($in)) {
				$configXml .= fread($in, 1024);
			}
		}
		fclose($in);
		return $configXml;
	}
	
}

?>