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
		$this->creationParams->setLogoutUrl(Utilities::getHttpPath() . '/roomLogout.html');
		$this->creationParams->setAttendeePassword('ap');
		$this->creationParams->setModeratorPassword('mp');
		$this->creationParams->setDuration('0');
		//$this->creationParams->setRecord(true);
		//$this->creationParams->setAllowStartStopRecording(true);
		$this->creationParams->setAutoStartRecording(false);
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
		//return $configXml;
		

		//$asdkjfhaskdj = simplexml_load_file(dirname(__FILE__) . "/config/" . $inFile, 'SimpleXMLElement', LIBXML_NOCDATA | LIBXML_NOBLANKS);
		
		//$jackedup = new SimpleXMLElement($asdkjfhaskdj);
		
		$asdkjfhaskdj = new SimpleXMLElement($configXml);
		
		$configXmlParameters = new SetConfigXMLParameters($this->getMeetingId());
		$configXmlParameters->setRawXml($asdkjfhaskdj);
		return $configXmlParameters;
		
	}
	
}

?>