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

$uuid = array('e839ac50-840d-80bd-3816-3985ae595715',
'07b74d3a-e39e-133f-ba3e-04df4d95d8ce',
'36174e18-26e7-6a76-de5c-3e81feac88c4',
'b54a7e2d-0dec-3071-1d01-4385fda6b1b3',
'cedc8956-f90b-6a26-4107-dd92474a548b',
'1b89ab08-d97d-2337-13f0-0233035287ac',
'f2347761-4f1a-cbfa-14d8-f3b7e543f27f',
'c2384c85-3d5c-ab02-b667-81967b725a1c',
'7ab54aaf-00f3-5531-bbf7-d0e6b8908601',
'5c979a3a-7e36-1b9f-7e03-52568d78e127',
'8120a323-ce1b-8a54-d5c6-8d330343a92c',
'fd5b2a63-48e9-5e6f-0b72-5111a8431398',
'e661accc-f0be-de11-c07c-58db160a8d78',
'f66475de-21a6-1047-d025-ff7019941fa2',
'ecd703d7-9695-1bf0-c501-eb213723cf40',
'2bae06d5-27d3-f638-8c4a-7f68c824393d',
'5d7dc86c-1384-2970-6b45-3a8eedaa5d4a',
'27e49ba0-250b-f896-186b-439e12f69ea7',
'84421a16-9a55-5b22-ef6c-c338548cf54d',
'00c856cd-13f4-666a-7b54-033c5a7f8496',
'7af014a5-27ff-264f-bdca-a0ca2a8e8355',
'95007180-317a-7e54-ba2c-2a6221b62a5d',
'c79d8300-55a4-bf4c-f838-23baa3313bd7',
'0f8d8eb0-0539-bd5a-a487-aa9847ae39c1',
'2821568f-0ed9-57f4-e509-8bc4d09fad25',
'88834d75-4041-f16c-1a40-ce784990becb',
'ff01cef0-807a-8e42-f9cd-02e72318363d',
'58e51005-cc32-2555-c7e2-9866c879da6c',
'e5f1f5f5-e10f-f365-c069-bb4a911a5a0d',
'8a5fd012-e2a6-a5b4-1b4a-d796ca4f1e25',
'a9c58c71-09cf-058c-7301-37faedf04f93',
'0ed4ce79-9b9f-4bf8-063a-59d52954b1ee',
'9d90a6cd-00ec-b48b-9e34-2366ac93933c',
'be18243d-507f-4dfd-e7a7-9e549092a3c7',
'a6482725-213a-ca7a-b5d5-e2a7518f2a22',
'5ea88f95-b479-8857-08ac-aab989397d85',
'2cef9b3d-562e-432b-caf8-0b91c49497f9',
'2750d649-f577-09ca-04e5-f3ab33785c8c',
'cbe1fe42-3a6b-b15a-963b-675c8c27de9d',
'5c95d3f1-91a0-6447-5075-f67d9862e6ec',
'601648ee-5df0-7aa2-334e-3e9c896f3f0c',
'c27f21ca-3957-17e4-8c08-2b61dbde8cb0',
'bba848f1-d853-d028-38c8-77fe37734ae7',
'2f3102c2-7c97-4c1c-433a-1f8a559512c3',
'4f6972ac-dc8b-d2b7-073d-44ebd19cb40d',
'd4176967-a218-6cca-87c2-3a1500c2755e',
'806722e0-b48b-4490-671d-d35f2476f5c9',
'7bbaf4e5-1a2f-d9c0-5ca3-b34e107867cb',
'66a481d1-3c30-6ea2-8f53-f00d9cfb997f',
'40fede81-4e68-1bee-405d-0b0f830dbbdd',
'084158c3-d6e7-4147-4e07-03608d7fc06c',
'ef1d58c8-1215-5f3f-52bd-7f250ff48b26',
'dd756307-2aec-f74c-ccf1-8772efe97b51',
'b64a00ef-0796-0dce-b0b7-3707fd043c3d',
'1c19c74e-f75e-ee75-877d-2d959be389ce',
'11744a98-eed3-8437-f9a2-73b0e0572646',
'6343ae7a-f6f5-e304-912b-3a60c6258a8d',
'bb33259b-8940-af73-c709-1bf04c407384',
'fdf7707e-8535-d36b-33d2-2fab9afa5d87',
'c33cc800-1e91-31a9-3aa2-f863b9761dd1',
'f1595812-ef76-3dc1-3314-f3295df04aa8',
'c470881c-b9b3-089a-5d8a-bd0cec9848d6',
'351c0da9-9e27-0630-d7b1-5c7941f4ae99',
'52a1d6c0-777d-1824-1693-e35f7bf03afe',
'686b32c7-ce47-e1b9-f790-0d91f1f834e5',
'c1fc9b88-20d8-3d46-177e-bee9acb27830',
'9aeb8d16-0e01-6020-c11e-9e527f4839f5',
'423929c9-c682-c650-0caa-eea10a747f14',
'b8c68cd9-a2dc-be7f-97fb-ffebf0ca9509',
'12cee5cf-d3c8-fead-6259-6078fa5b7fb9',
'170fc2ec-1499-cd50-e428-b26a17f5c0d0',
'715f346e-b9d7-857d-06c0-5ff12e7bd727',
'1215d453-0b0e-bedd-6a2e-4e883eae6344',
'63814390-63cd-5596-29b5-ed180db7135e',
'c34ab4ea-ece9-95ef-e73f-eba47868ed3d',
'1e1a2097-4763-cdee-9dd6-f26b2c4eb530',
'9190fb5e-06be-e588-bf5b-8c4ce49632e2',
'4de2837c-1262-f724-d891-3f4fedb1326c',
'0219e0d6-7980-675f-45f1-88f14c4b6de7',
'89209b96-96ff-601c-7e04-04a2865fad8f',
'ba534cee-a814-7cf7-ed37-ed20c4c668df',
'02a32fb2-d290-3f40-dcf1-bcaac0919a5c',
'055a3638-e8e9-d943-d130-dfe4a50b7c27',
'5c788665-1954-acd9-d4e8-7a6281a9ec98',
'24285791-3ad7-f02b-d200-0193d270a126',
'f910ddb4-9335-6ba4-611e-3f17c75d36ff',
'6db7c204-9893-368a-7cb6-c3d416a06abd',
'a57fc8cb-1ccd-521f-c275-d2231c2de9d7',
'8b15fad5-c877-b40b-4505-f2dcaba98ef2',
'1ac77608-b8d9-0f9d-8be8-950f68076f22',
'57611ba3-5d82-4648-675c-bcac262dde89',
'dd134c8e-0823-7613-e792-5295b25fc463',
'101f9be3-b7b2-de8a-d9af-4458068d40c7',
'8c251ffc-1f08-c34d-887a-c004c058ef2a',
'30039e71-376f-fea7-03fe-3384f4d65a63',
'30039e71-376f-fea7-03fe-3384f4d65a63',
'30039e71-376f-fea7-03fe-3384f4d65a63',
'30039e71-376f-fea7-03fe-3384f4d65a63',
'30039e71-376f-fea7-03fe-3384f4d65a63',
'8c251ffc-1f08-c34d-887a-c004c058ef2a',
'8c251ffc-1f08-c34d-887a-c004c058ef2a',
'09bc495d-1803-ca3b-a253-cad9bd9dd6a2',
'6bbed6ce-4326-28a8-873c-8ff8dfef5733',
'65878e82-aa4a-e242-2ab1-9813342286cb',
'4ee381ff-7c30-46d7-e22a-ff39812c22b5',
'f7f7322a-6492-6960-2ee6-2bd1cabc6859',
'9404fb47-ce98-6286-c4ec-afd35ddc4269',
'013244d1-f05e-451c-9b33-0a636b6e86bb',
'4df6eba0-c2b8-260b-ef48-1cb7c333f95d',
'cc4365c7-2e52-7e69-2c72-acd6b9cce7b7',
'b5690ba7-a3ff-c51c-6e98-b2e124b12865',
'161578af-8037-6cc5-4712-bdf1431a65c6',
'6351b1bf-80f3-9352-c1c6-b7bb367993bc',
'566e81d5-cb0f-43d6-3cb5-6ae5fc0c43e5',
'0965ecc9-704e-5706-920b-3a123776f2d4',
'e1bec4f2-99cb-7937-4b1f-e616a1aed355',
'990ad68d-a51e-7759-c544-6a528e2db37b',
'ad520727-fe2c-21f0-6319-8de1d8a65a92',
'cc7fc343-cfc3-48b0-6a5f-9c93297105d6',
'c61d18d8-89b7-3045-c285-9a081cd6ea75',
'4fe53f0e-3c1a-4e12-65cf-94fa3e6b88b8',
'e5fc6a20-9eb9-f6ea-420d-0ddd12aee1dd',
'901525b9-c00a-c9be-7f36-af9919353020',
'2a0293f8-e12e-dec4-78a3-07e7fde70924',
'5c5e3619-ee72-5784-f775-08388996f15b',
'94aed4d8-3df0-26c2-63bb-d9eb1b090cff',
'bc3e7427-ae60-add5-4ea8-e43d7e47a299',
'd62e08c1-7bbf-b495-582b-190698dca579',
'd4036e97-393e-fe60-3a7e-2f1883beda7a',
'3f442b8f-a690-d441-cfbe-8398b6f4836a',
'92033ae6-499b-e290-64cc-dd1eb6945fb7',
'ce5fe189-1262-28de-bef5-960ca0849332',
'688c4ae6-51a3-b231-c4ae-c69fe75257d3',
'e4e63b0f-96f0-e28b-ec7a-32cbd0a9d934',
'd2f586c2-4b84-7756-584c-aafe24b025bf',
'c204cc36-1de6-5a80-6596-831d136688b5',
'65242a64-baa0-ceef-f470-e9b0e7b1800e',
'34983541-bc6c-1f98-f6c6-c38ff6d2474d',
'f19f4018-7ac9-1f3d-d77a-59ca8c582f3c',
'b940d2f1-0fe6-494e-8279-2c40f871cba4',
'99c108f1-5c09-a10f-115f-c1afbf407441',
'f0f42dba-a811-a561-2ac5-a9c67fc5c5ca',
'7314f8af-fd5a-c98a-5049-56503c81ac4a',
'407e87e6-b0d9-3777-3600-9f912212c3ce',
'c5f37a82-f812-986d-0171-63444265a659',
'4c823018-0114-7541-7ff9-ba1b0f386e8c',
'fff9fc65-c180-a3e4-2b92-dcca4c474e9d',
'650a11ab-ab67-10b2-5eed-2fd1ef83ae35',
'37fb58bd-7f77-be81-9f10-a9ad5a7190e1',
'43ea9796-c7d5-ad0b-a649-bcede8b1ef8d',
'b5f78404-489c-dd6e-2bec-213b2e4f8ea6',
'b5f78404-489c-dd6e-2bec-213b2e4f8ea6',
'b5f78404-489c-dd6e-2bec-213b2e4f8ea6',
'f0e7f4c8-7cb4-f4c8-8fd7-38c995d6f1fa',
'634d3ca2-498b-b6d6-f37b-69cbac5d3f21',
'10ea11e9-4efb-d0fb-042f-2a67c8ed2b57',
'991b94b2-9d64-fbd5-90f8-fd3641e1fdf9',
'a73bb6ea-6148-eb11-0f6f-f3d3e8c95269',
'df92f68e-b3f1-2f46-f4cd-3041714af40c',
'bc36dc57-4891-643e-71ad-181fcbe8e8b6',
'119ca7cf-8eeb-258f-a397-dbad8cd5de7c',
'0f280c12-b57e-6390-1356-1d0e6aef6e3e',
'138d79c8-a332-fc82-12d2-7961197006b4',
'70d08cdc-5e18-e6ec-5c7e-7e5249963d70',
'1eed8d5a-d7c5-9e71-a55e-327b8b099d22',
'd468b30e-e73a-96bc-0d9b-14daa44ce263',
'78a82f5e-f60d-b78d-57bf-0e3b13e0577a',
'fe671702-d199-eb3e-39e5-36639b97cbcd',
'f851cee0-5c08-dc1a-4add-1025befb1a50',
'bfdbf1aa-5548-5315-a4e3-45192e86c309',
'c4d48e5b-bbdc-73cd-7b43-362dbbb39f46',
'411a8ea6-fb0c-ae23-5be7-35f4a84b48b0');


foreach($uuid as $key=>$value) {
    $recordingParams->setMeetingId($value);
    $recordings = $bbbApi->getRecordings($recordingParams);
    //$logger->log(print_r($recordings->getRawXml(), true));
    if ($recordings->getReturnCode() == 'SUCCESS') {
        foreach ($recordings->getRawXml()->recordings->recording as $thisRecording) {
            if ($thisRecording->published == "true") {
                $logger->log("SELECT id from public.event where uuid = '" . $thisRecording->meetingID . "' and active = true");
                $logger->log("INSERT INTO public.event_bbb (event_fk, recording_id, recording_url) values (, '', '" . $thisRecording->playback->format->url . "');");
            }
        }
    }
}

$logger->log("END");
                
echo("done");

