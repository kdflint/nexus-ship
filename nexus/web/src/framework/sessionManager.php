<?php

session_start();

require_once("Util.php");
		
			if (Utilities::is_ajax()) {
				if (Utilities::isSessionValid()) {
					Utilities::setSessionLastActivity();
				}
			}				
	
?>

