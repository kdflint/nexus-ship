<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">
<html>
  
	<head>
		<meta content="text/html;charset=utf-8" http-equiv="Content-Type">
	</head>
	<body>
		<?php
		
			$status = "closed";
			if (is_ajax()) {
				echo $status;
			} else {
				echo $status;
			}				
	
			//Function to check if the request is an AJAX request
			function is_ajax() {
  			return isset($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest';
			}
?>
	</body>
</html>
