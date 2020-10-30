<?php

require_once("../src/framework/Util.php");
require_once(Utilities::getComposerRoot() . '/firebase/php-jwt/src/JWT.php');

use Firebase\JWT\JWT;

$conf = array('append' => true, 'mode' => 0644, 'timeFormat' => '%X %x');
$logger = Log::singleton("file", Utilities::getLogRoot() ."/recordingCallback.log", "", $conf, PEAR_LOG_DEBUG);
$logger->log("Hello from poster: " . print_r($_POST['signed_parameters'], true), PEAR_LOG_INFO);

// TODO - pull this from secure configs
$key = "39155623fe598ac60b1b1e427fccbe24";
$payload = $_POST['signed_parameters'];
//$payload = 'eyJhbGciOiJIUzI1NiJ9.eyJtZWV0aW5nX2lkIjoiNDExYThlYTYtZmIwYy1hZTIzLTViZTctMzVmNGE4NGI0OGIwIiwicmVjb3JkX2lkIjoiNTE1ZWY2OTY2NGVlOTZiNDZjZjAxMTExOTJhMjRmYjRjNjg0NWUwZC0xNjAyNzgyODY4ODQ1In0.cbQYn9E8ZdSLSDPVJF5z3Gtvv23Kv5sjJci4UfUH9v4';
$logger->log("Hello from decoder");
$decoded = JWT::decode($payload, $key, array('HS256'));
$logger->log(print_r($decoded, true), PEAR_LOG_INFO);

// TODO - run these inserts automatically
mail('kathy.flint@northbridgetech.org', 'new recording available', 'check recording_callback.log for meeting id ' . $decoded->meeting_id, 'From: support@northbridgetech.org');

?>