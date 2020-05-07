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

if (Utilities::isSessionValid()) {
    $logger->log("======================", PEAR_LOG_INFO);
    $logger->log($_SESSION['groups'][0]['name'], PEAR_LOG_INFO);
    $response = array();
    $counter = 0;
    // TODO - breaks if > 1 group in a session
    
    $recordingList = Event::getRecordingsByGroup($_SESSION['groups'][0]['id']);
    $logger->log(print_r($recordingList, true), PEAR_LOG_INFO);

    foreach ($recordingList as $thisRecording) {
        $response[$counter]['published'] = array("0" => $thisRecording['published']);
        $response[$counter]['url'] = array("0" => $thisRecording['url']);
        $response[$counter]['start'] = array("0" => $thisRecording['start']);
        $response[$counter]['name'] = $thisRecording['name'];
        $counter++;                
    }

    $logger->log(json_encode($response), PEAR_LOG_INFO);
    header('Content-Type: application/json');			
    echo json_encode($response);
} else {
    header("location:" . Utilities::getHttpPath() . "/nexus.php");
    exit(0);		
}			

?>

