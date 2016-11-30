<?php

//https://lingohub.com/blog/2013/07/php-internationalization-with-gettext-tutorial/
//https://blog.udemy.com/php-gettext/

require_once("src/framework/Util.php");

putenv("LANGUAGE=es");
// on the machine command line, 'local -a' must contain the below value
$results = setlocale(LC_ALL, "es_ES.utf8");
if (!$results) {
	echo "setlocale() failed: locale function is not available on this platform, or the given local does not exist in this environment</br>";
	echo "Tip: run 'locale -a' on the runtime machine, It must contain your locale value</br>";
}
	
$domain = "messages";
$results = bindtextdomain($domain, Utilities::getLocaleRoot());
echo 'new text domain is set: ' . $results . "</br>";

$results = textdomain($domain);
echo 'current message domain is set: ' . $domain . "</br>";

echo "English is Username</br>";
echo "Spanish translation is " . gettext("Username") . "</br>";

?>