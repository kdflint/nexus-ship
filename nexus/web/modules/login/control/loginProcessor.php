<?php

session_start();

require_once("../../../src/framework/Util.php");

echo "Hello from login processor.

" . $_POST['uid'] . "

" . $_POST['password'];

exit(0);

$uid = $_POST['uid'];
$password = $_POST['password'];

/*

$isAuthenticated = Util::authenticate($uid, $password);

if($isAuthenticated){
	Util::setSession($uid);
	Util::setLogin($_SESSION['uidpk']);
	header("location:../view/nexus.php?thisPage=directory");
	exit(0);	
} else {
	returnToLoginWithError(Util::AUTHENTICATION_ERROR);
}

*/

function returnToLoginWithError($errorMessage) {
	header("location:../view/login.php?error=" . $errorMessage);
	exit(0);
}

?>