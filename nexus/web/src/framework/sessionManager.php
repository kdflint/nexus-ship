<?php

session_start();

require_once("Util.php");
		
			if (Util::is_ajax()) {
				if (Util::isSessionValid()) {
					Util::setSessionLastActivity();
				}
			}				
	
?>

