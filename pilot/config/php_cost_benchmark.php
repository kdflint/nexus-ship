
<?php

error_reporting(E_ALL);
ini_set( 'display_errors','1'); 

echo hash('sha256', 'The quick brown fox jumped over the lazy dog./n');

echo(generateRandomString(32) . '\n\n');

echo('The quick brown fox jumped over the lazy dog.' . generateRandomString(32)) . '\n\n';

echo hash('sha256', 'The quick brown fox jumped over the lazy dog.' . generateRandomString(32));

function generateRandomString($length) {
    $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()';
    $randomString = '';
    for ($i = 0; $i < $length; $i++) {
        $randomString .= $characters[rand(0, strlen($characters) - 1)];
    }
    return $randomString;
}

?>
