<?php

session_start();

require_once("Util.php");
require_once '/home/kdflint/vendor/autoload.php';

use BigBlueButton\BigBlueButton;
use BigBlueButton\Parameters\GetRecordingsParameters;
use BigBlueButton\Core\Record;

$conf = array('append' => true, 'mode' => 0644, 'timeFormat' => '%X %x');
$logger = Log::singleton("file", Utilities::getLogRoot() . "/fetch_recording.log", "", $conf, PEAR_LOG_INFO);

// TODO - this check causes JSON object parse to be thrown from javascript -- better to tokenize it anyway
	if (Utilities::isSessionValid()) {
		if ($_SESSION['nexusContext'] === "ADV") {
			//$data = Event::getFutureEvents($clean['filter'], $_SESSION['timezone'], $_SESSION['uidpk'], $clean['status']);	
		} else {	
			// TODO - this will break if user has > 1 group
			//$data = Event::getFutureEvents($_SESSION['groups'][0]['id'], $_SESSION['timezone'], $_SESSION['uidpk']);
		}
		$logger->log("======================", PEAR_LOG_INFO);
		$response = array();
		$counter = 0;
		$bbbApi = new BigBlueButton();
		$recordingParams = new GetRecordingsParameters();
		$recordingParams->addMeta("network", $_SESSION['networkId']);
		//$recordingParams->addMeta("organization", $_SESSION['orgUid']);
		//$recordingParams->addMeta("group", $_SESSION['groups'][0]['id']);
		//$recordingParams->addMeta("initiator", $_SESSION['uidpk']);
		
		$recordings = $bbbApi->getRecordings($recordingParams);
		$logger->log("response: " . $recordings->getReturnCode(), PEAR_LOG_INFO);

		if ($recordings->getReturnCode() == 'SUCCESS') {
			foreach ($recordings->getRawXml()->recordings->recording as $thisRecording) {
				$logger->log("id: " . $thisRecording->meetingID, PEAR_LOG_INFO);
				$logger->log("state: " . $thisRecording->state[0], PEAR_LOG_INFO);
				$logger->log("participants: " . $thisRecording->participants, PEAR_LOG_INFO);
				$logger->log("url: " . $thisRecording->playback->format->url, PEAR_LOG_INFO);
				$logger->log("name: " . $thisRecording->name, PEAR_LOG_INFO);
				$logger->log("start: " . $thisRecording->startTime, PEAR_LOG_INFO);
				//$logger->log("meta: ". $recording->metadata->network, PEAR_LOG_INFO);
				//$logger->log("metas: ". var_dump($recording->metadata, true), PEAR_LOG_INFO);
				//$logger->log("metas: ". var_dump($recording->metas, true), PEAR_LOG_INFO);
				
				//if ($thisRecording->name === $_SESSION['groups'][0]['name']." Conference Room") {
					$response[$counter]['state'] = $thisRecording->state;
					$response[$counter]['participants'] = $thisRecording->participants;
					$response[$counter]['url'] = $thisRecording->playback->format->url;
					$response[$counter]['start'] = $thisRecording->startTime;
					$counter++;
				//}
			}
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

