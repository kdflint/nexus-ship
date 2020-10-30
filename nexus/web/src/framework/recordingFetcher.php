<?php

session_start();

require_once("Util.php");
require_once(Utilities::getSrcRoot() . "/schedule/Event.php");
require_once Utilities::getComposerRoot() . '/autoload.php';

use BigBlueButton\BigBlueButton;
use BigBlueButton\Parameters\GetRecordingsParameters;
use BigBlueButton\Core\Record;

$conf = array('append' => true, 'mode' => 0644, 'timeFormat' => '%X %x');
$logger = Log::singleton("file", Utilities::getLogRoot() . "/fetch_recording_gapped.log", "", $conf, PEAR_LOG_INFO);
$logger->log("START");


$bbbApi = new BigBlueButton();
$recordingParams = new GetRecordingsParameters();
//$uuid = array('bc3e7427-ae60-add5-4ea8-e43d7e47a299', '07b74d3a-e39e-133f-ba3e-04df4d95d8ce');

$uuid = array(
'411a8ea6-fb0c-ae23-5be7-35f4a84b48b0',
'ff132cb2-7a73-2462-211a-ba9c26dd2a2c',
'3c2d287c-fb22-ac91-9938-b50d20c08901',
'78a82f5e-f60d-b78d-57bf-0e3b13e0577a',
'5a1c3841-30f3-fef5-0e8e-d900ad78fd09',
'1fc2e1b8-f8c8-7a47-8bb7-9334979cdd76',
'd468b30e-e73a-96bc-0d9b-14daa44ce263',
'0f280c12-b57e-6390-1356-1d0e6aef6e3e',
'138d79c8-a332-fc82-12d2-7961197006b4',
'fe671702-d199-eb3e-39e5-36639b97cbcd',
'f851cee0-5c08-dc1a-4add-1025befb1a50',
'2706f9bc-b933-d178-97ae-68d24372438e',
'70d08cdc-5e18-e6ec-5c7e-7e5249963d70',
'c4d48e5b-bbdc-73cd-7b43-362dbbb39f46',
'bfdbf1aa-5548-5315-a4e3-45192e86c309',
'e0504764-ca00-11a4-77d4-bf0e6fb9e54e',
'e852705a-6e8f-e033-3d85-7e501fa7713f'
);


foreach($uuid as $key=>$value) {
    $recordingParams->setMeetingId($value);
    $recordings = $bbbApi->getRecordings($recordingParams);
    //$logger->log(print_r($recordings->getRawXml(), true));
    if ($recordings->getReturnCode() == 'SUCCESS') {
        foreach ($recordings->getRawXml()->recordings->recording as $thisRecording) {
            if ($thisRecording->published == "true") {
                $logger->log("SELECT id from public.event where uuid = '" . $thisRecording->meetingID . "' and active = true");
                $logger->log("INSERT INTO public.event_bbb (event_fk, recording_start_time, recording_id, recording_url) values (, " . $thisRecording->startTime . ", '', '" . $thisRecording->playback->format->url . "');");
            }
        }
    }
}

$logger->log("END");
                
echo("done");

