#!/usr/php/54/usr/bin/php -q

<?php

// Take the input email and write it to pipe.txt. Rewrite pipe.txt on each new email input.

$fd = fopen("php://stdin", "r");
$email = "";
while (!feof($fd)) {
  $email .= fread($fd, 1024);
}
fclose($fd);

$fdw = fopen("pipe.txt", "w");
fwrite($fdw, $email);
fclose($fdw);

exit(0);

?>