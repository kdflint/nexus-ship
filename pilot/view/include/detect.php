
		
	<!--
			Reference:
			http://html5hub.com/using-the-getusermedia-api-with-the-html5-video-and-canvas-elements/
			https://developer.mozilla.org/en-US/docs/NavigatorUserMedia.getUserMedia
	-->
	<script>
		function hasGetUserMedia() {
  		return !!(navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia);
		}
		
		function checkAudio() {
			var $mState = "<img id=\"flash_enabled\" src=\"image/light_green.png\" />";
			if (hasGetUserMedia()) {
				navigator.getUserMedia = (navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia);
		  	if (navigator.getUserMedia) {
	      	navigator.getUserMedia( {video:false,audio:true}, function(stream) { alert("good"); }, function(error) { 
      			//if (error == "PERMISSION_DENIED") {
	      			//alert("have but permission denied"); What if they have one but not the other??
      			//} else {
	      			$mState = "<img id=\"flash_enabled\" src=\"image/light_red.png\" />"; 
      			//}
      		//});
    		} else {
    		}
   		} else { 
	  		//alert('getUserMedia() is not supported in your browser');
			}	
			document.getElementById("mphone_enabled").innerHTML = $mState + "<button onclick=\"checkAudio()\">Re-Check</button>";
		}
	</script>
	


