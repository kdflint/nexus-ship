<?php

//session_start();

require_once dirname(__FILE__).'/forum_sso_functions.php';
// Important Note:
// You also need to update forum username on line 5 in forum_sso_functions.php.
// You also need to update forum API Key on line 7 in forum_sso_functions.php.

// Fill in the user information in a way that websitetoolbox forum can understand.
$user = array();

// After successful register to your website, assign the same user registration information to $user array to register at the websitetoolbox forum.
// For example: You can assign your register POST/GET values to user array like below:
// $user['member'] = $_POST['user'].

$user['member'] = $uid;
$user['pw'] = $password;
$user['email'] = $email;	
$user['name'] = $fname . " " . $lname;

// You can also assign optional registration fields to '$user' array.
// http://www.websitetoolbox.com/support/105?popup=2 - optional fields

// function called for registering a new user on websitetoolbox forum.
// Return user registeration status as "Registration Complete" / Register Failed Message.
$register_status = forumSignup($user);
if($register_status == 'Registration Complete') {
	header("location:test/registrationConfirm.php?message=Success: " . $register_status);
	exit(0);
} else {
	header("location:test/registrationConfirm.php?message=Fail: " . $register_status);
	exit(0);
}
?>