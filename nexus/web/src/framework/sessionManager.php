<?php

session_start();

require_once("Util.php");
		
			if (is_ajax()) {
				if (Util::isSessionValid()) {
					Util::setSessionLastActivity();
				}
			}				
	
			//Function to check if the request is an AJAX request
			function is_ajax() {
  			return isset($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest';
			}
?>

