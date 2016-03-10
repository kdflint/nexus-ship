<?php

// https://web.stanford.edu/dept/its/communications/webservices/wiki/index.php/How_to_perform_error_handling_in_PHP

// Destinations
define("ADMIN_EMAIL", "kathy.flint@northbridgetech.org");
define("LOG_FILE", "/home/northbri/errors.log");
 
// Destination types
define("DEST_EMAIL", "1");
define("DEST_LOGFILE", "3");

// TODO - fix header location and set up for all site
 
function my_error_handler($errno, $errstr, $errfile, $errline)
{  
  // This switch should actually be unnecessary since this handler should only be called on E_USER_ERROR
  switch ($errno) {
    case E_USER_ERROR:
      // Send an e-mail to the administrator
      error_log("Error: $errstr \n\nFatal error on line $errline in file $errfile \n\nUser: " . $_SESSION['uidpk'] . ":" . $_SESSION['email'], DEST_EMAIL, ADMIN_EMAIL);
      // Screen out to user
      header("location:../../../nexus.php?view=fatal");
      break;
  }
 
  // Now execute PHP's internal error handler
  return FALSE;
}
 
// Use set_error_handler() to tell PHP to use our method
$old_error_handler = set_error_handler("my_error_handler", E_USER_ERROR);

?>
