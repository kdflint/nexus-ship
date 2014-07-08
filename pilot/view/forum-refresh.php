
THIS PAGE IS GARBAGE NOW - DELETE!

<script>
	
function keepForumAlive() {
    http_request = new XMLHttpRequest();
    http_request.open('GET', "http://northbridge.websitetoolbox.com/register/dologin?authtoken=v8y0GsWUY18");
    http_request.send(null);
};

function init() {
    window.setInterval("keepForumAlive()", 300000);
}

window.onload = init;

</script>




<?
echo '<script type="text/javascript">'
	 . "\r\n\r\n"
   . 'function keepForumAlive() {'
	 . "\r\n"
   . ' http_request = new XMLHttpRequest();'
	 . "\r\n"
   . ' http_request.open(\'GET\', "http://northbridge.websitetoolbox.com/register/dologin?authtoken="' . $_SESSION['authtoken'] . '");'
	 . "\r\n"
   . ' http_request.send(null);'
	 . "\r\n"
	 . '}'
	 . "\r\n\r\n"
	 . 'function init() {window.setInterval("keepForumAlive()", 60000);}'
	 . "\r\n\r\n"
	 . 'window.onload = init;'
	 . "\r\n\r\n"
   . '</script>'
;
?>

    //http_request.open('GET', "http://northbridge.websitetoolbox.com/register/dologin?authtoken=v8y0GsWUY18");
