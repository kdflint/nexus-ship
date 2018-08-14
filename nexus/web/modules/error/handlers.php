<?php

require_once(dirname(__FILE__) . "/../../src/framework/Util.php");

// https://web.stanford.edu/dept/its/communications/webservices/wiki/index.php/How_to_perform_error_handling_in_PHP

// Destinations
define("ADMIN_EMAIL", "kathy.flint@northbridgetech.org");
define("LOG_FILE", "/home/northbri/errors.log");
 
// Destination types
define("DEST_EMAIL", "1");
define("DEST_LOGFILE", "3");

$userid = isset($_SESSION['uidpk']) ? $_SESSION['uidpk'] : "undefined";
$email = isset($_SESSION['email']) ? $_SESSION['email'] : "undefined";
$context = isset($_SESSION['nexusContext']) ? $_SESSION['nexusContext'] : "undefined";
$orgid = isset($_SESSION['networkId']) ? $_SESSION['networkId'] : "undefined";
$first = isset($_SESSION['fname']) ? $_SESSION['fname'] : "undefined";
$last = isset($_SESSION['lname']) ? $_SESSION['lname'] : "undefined";

// TODO - fix header location and set up for all site
 
function my_error_handler($errno, $errstr, $errfile, $errline)
{  
  // This switch should actually be unnecessary since this handler should only be called on E_USER_ERROR
  switch ($errno) {
    case E_USER_ERROR:
      // Send an e-mail to the administrator
      if (isset($_SESSION['environment']) && $_SESSION['environment'] != "local") {
      	error_log("Error: $errstr \n\nFatal error on line $errline in file $errfile \n\nUser: " . $userid . ":" . $email . ":" . $first . ":" . $last . "\nContext: " . $orgid . ":" . $context, DEST_EMAIL, ADMIN_EMAIL);
      }
      // Screen out to user
      header("location:" . Utilities::getHttpPath() . "/nexus.php?view=fatal");
      break;
  }
 
  // Now execute PHP's internal error handler
  return FALSE;
}
 
// Use set_error_handler() to tell PHP to use our method
$old_error_handler = set_error_handler("my_error_handler", E_USER_ERROR);

?>
