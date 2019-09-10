<?php

session_start();

require_once("Util.php");
require_once(Utilities::getSrcRoot() . "/schedule/Event.php");
require_once Utilities::getComposerRoot() . '/autoload.php';

use BigBlueButton\BigBlueButton;
use BigBlueButton\Parameters\GetRecordingsParameters;
use BigBlueButton\Core\Record;

$conf = array('append' => true, 'mode' => 0644, 'timeFormat' => '%X %x');
$logger = Log::singleton("file", Utilities::getLogRoot() . "/fetch_recording.log", "", $conf, PEAR_LOG_INFO);

// TODO - this check causes JSON object parse to be thrown from javascript -- better to tokenize it anyway
	if (Utilities::isSessionValid()) {
		if ($_SESSION['nexusContext'] === "ADV") {
			//$data = Event::getFutureEventsByGroupIdList($clean['filter'], $_SESSION['uidpk'], $_SESSION['timezone'], $clean['status']);	
		} else {	
			// TODO - this will break if user has > 1 group
			//$data = Event::getFutureEventsByGroupIdList($_SESSION['groups'][0]['id'], $_SESSION['uidpk'], $_SESSION['timezone']);
		}
		$logger->log("======================", PEAR_LOG_INFO);
		$response = array();
		$counter = 0;
		$bbbApi = new BigBlueButton();
		$recordingParams = new GetRecordingsParameters();
		// Below act as a filter for which meetings to retrieve
		if ($_SESSION['nexusContext'] === "NWM") {
			$recordingParams->addMeta("organization", $_SESSION['orgUid']);
			$recordingParams->addMeta("network", "n/a");
			$logger->log("org meta: " . $recordingParams->getMeta("organization"), PEAR_LOG_INFO);
		} else {
			$recordingParams->addMeta("organization", "n/a");
			$recordingParams->addMeta("network", $_SESSION['networkId']);
			$logger->log("network meta: " . $recordingParams->getMeta("network"), PEAR_LOG_INFO);
		}
		//$recordingParams->addMeta("group", $_SESSION['groups'][0]['id']);
		//$recordingParams->addMeta("initiator", $_SESSION['uidpk']);
		
		$logger->log("org meta: " . $recordingParams->getMeta("organization"), PEAR_LOG_INFO);
		$logger->log("network meta: " . $recordingParams->getMeta("network"), PEAR_LOG_INFO);

		$recordings = $bbbApi->getRecordings($recordingParams);
		$logger->log("response: " . $recordings->getReturnCode(), PEAR_LOG_INFO);


		if ($recordings->getReturnCode() == 'SUCCESS') {
			foreach ($recordings->getRawXml()->recordings->recording as $thisRecording) {
				$logger->log("id: " . $thisRecording->meetingID, PEAR_LOG_INFO);
				$logger->log("published? " . $thisRecording->published, PEAR_LOG_INFO);
				$logger->log("url: " . $thisRecording->playback->format->url, PEAR_LOG_INFO);
				$logger->log("room: " . $thisRecording->name, PEAR_LOG_INFO);
				$logger->log("start: " . $thisRecording->startTime, PEAR_LOG_INFO);
				$logger->log("network: " . $thisRecording->metadata->network, PEAR_LOG_INFO);
				$logger->log("organization: " . $thisRecording->metadata->organization, PEAR_LOG_INFO);
				$logger->log("group: " . $thisRecording->metadata->group, PEAR_LOG_INFO);
				$logger->log("initiator: " . $thisRecording->metadata->initiator, PEAR_LOG_INFO);
				$logger->log("uuid: " . $thisRecording->metadata->uuid, PEAR_LOG_INFO);
				
				/* Temporary client-side filter because API is not working as expected post-migration to blindside */
				if ($thisRecording->metadata->organization == $_SESSION['orgUid'] || $thisRecording->metadata->network == $_SESSION['networkId']) {
					$response[$counter]['published'] = $thisRecording->published;
					$response[$counter]['url'] = $thisRecording->playback->format->url;
					$response[$counter]['start'] = $thisRecording->startTime;
					if (Event::isValidEventUuid($thisRecording->metadata->uuid)) {
						$response[$counter]['name'] = Event::getEventName($thisRecording->metadata->uuid);
					} else {
						$response[$counter]['name'] = "";
					}
					$logger->log("name: " . $response[$counter]['name'], PEAR_LOG_INFO);
					$counter++;
				}
			}
			
			// Patch in for archived recordings, created pre Blindside transfer
			
			if ($_SESSION['orgUid'] == 'ed787a92') {
				$response[$counter]['published'] = array("0" => "true");
				$response[$counter]['url'] = array("0" => "https://nexus.northbridgetech.org/archive/playback.html?meetingId=c6f47f0a1161f39f29227423027e0187f68a53d5-1523887404405");
				$response[$counter]['start'] = array("0" => "1523887404405");
				$response[$counter]['name'] = "Faith, Trauma and Resilience: Literature Review";
				$counter++;
				$response[$counter]['published'] = array("0" => "true");
				$response[$counter]['url'] = array("0" => "https://nexus.northbridgetech.org/archive/playback.html?meetingId=9f7c6fba9717437fe38e8c6b8985c6d5d5e16b5f-1520263676040");
				$response[$counter]['start'] = array("0" => "1520263676040");
				$response[$counter]['name'] = "Nexus Web Meeting Tutorial";				
			}
			if ($_SESSION['orgUid'] == 'b2c2c38c') {
				$response[$counter]['published'] = array("0" => "true");
				$response[$counter]['url'] = array("0" => "https://nexus.northbridgetech.org/archive/playback.html?meetingId=3071e333923c26eeec8d5739ffb7bc6c38a64c97-1516464680143");
				$response[$counter]['start'] = array("0" => "1516464680143");
				$response[$counter]['name'] = "Quarterly Board Meeting";
			}
			
			// End patch			
			$logger->log("Loop: END", PEAR_LOG_INFO);
		}
						
		

	
		$logger->log(json_encode($response), PEAR_LOG_INFO);
		header('Content-Type: application/json');			
		echo json_encode($response);
	} else {
		header("location:" . Utilities::getHttpPath() . "/nexus.php");
		exit(0);		
	}			

?>

