<?php

require_once(dirname(__FILE__) . "/../framework/PgDb.php");
require_once Utilities::getComposerRoot() . '/autoload.php';

use BigBlueButton\Parameters\CreateMeetingParameters;
use BigBlueButton\Parameters\SetConfigXMLParameters;

class BbbMeeting {
	
	const VIDEO_CHAT = 'video chat';
	const COLLABORATION = 'collaboration';
	const VIDEO_LINK = 'video tether';
	const WEBINAR = 'webinar';
	
	var $creationParams;
	var $recordingParams;
	
	var $meetingType = "";

	function __construct($id, $name, $type) {	
		require_once(dirname(__FILE__) . "/../framework/Util.php");
		$this->creationParams = new CreateMeetingParameters($id, $name);
		$this->creationParams->setLogoutUrl(Utilities::getHttpPath() . '/roomLogout.php');
		$this->creationParams->setAttendeePassword('ap');
		$this->creationParams->setModeratorPassword('mp');
		$this->creationParams->setDuration('0');
		//$this->creationParams->setRecord(true);
		//$this->creationParams->setAllowStartStopRecording(true);
		$this->creationParams->setAutoStartRecording(false);
		$this->creationParams->addPresentation('https://northbridgetech.org/downloads/BBB_default_slide.pdf');
		$this->creationParams->setRecordingReadyCallbackUrl('https://northbridgetech.org/dev/nexus/web/api/postBbbRecordingComplete.php');
		$this->meetingType = $type;
	}
	
	function setRecordingParams($isPresenter) {
		if ($isPresenter) {
			$this->creationParams->setRecord(true);
			$this->creationParams->setAllowStartStopRecording(true);
		} else {
			$this->creationParams->setRecord(false);
			$this->creationParams->setAllowStartStopRecording(false);			
		}
	}
	
	function setMetaParams($network, $org, $group, $initiator, $uuid) {
		$this->creationParams->addMeta("network", $network);
		$this->creationParams->addMeta("organization", $org);
		$this->creationParams->addMeta("group", $group);
		$this->creationParams->addMeta("initiator", $initiator);	
		$this->creationParams->addMeta("uuid", $uuid);
		//$this->creationParams->addMeta("bbb-recording-ready-url", 'https%3A%2F%2Fnorthbridgetech.org%2Fdev%2Fnexus%2Fweb%2Fapi%2FpostBbbRecordingComplete.php');
		//$this->creationParams->addMeta("bbb-recording-ready-url", 'https://northbridgetech.org/dev/nexus/web/api/postBbbRecordingComplete.php');
		return true;		
	}
	
	function getCreationParams() {
		return $this->creationParams;
	}
	
	function getMeetingId() {

		return $this->creationParams->getMeetingId();
	}
	
	function getMeetingConfigurationXml() {
			
		$inFile = "config.xml";
			
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
			case self::COLLABORATION:
				$inFile = "config_collaboration.xml";
				break;
			default:
				$inFile = "config.xml";
		}
		
		$in = fopen(dirname(__FILE__) . "/config/" . $inFile, "r");
		$configXml = "";
		if ($in) {
			while (!feof($in)) {
				$configXml .= fread($in, 1024);
			}
		}
		fclose($in);
			
		$rawXml = new SimpleXMLElement($configXml);
		$configXmlParameters = new SetConfigXMLParameters($this->getMeetingId());
		$configXmlParameters->setRawXml($rawXml);
		
		return $configXmlParameters;
		
	}
	
function getMeetingConfigurationTokenProxy() {
					
		switch($this->meetingType) {
			case self::VIDEO_CHAT:
				$token_proxy = "northbridgetech_config_video_chat.xml";
				break;
			case self::VIDEO_LINK:
				$token_proxy = "northbridgetech_config_video_link.xml";
				break;
			case self::WEBINAR:
				$token_proxy = "northbridgetech_config_webinar.xml";
				break;
			case self::COLLABORATION:
				$token_proxy = "northbridgetech_config_collaboration.xml";
				break;
			default:
				$token_proxy = "northbridgetech_config_collaboration.xml";
		}
			
		return $token_proxy;
		
	}
	
}

?>