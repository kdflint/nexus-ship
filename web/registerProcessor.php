<?php

session_start();

require_once dirname(__FILE__).'/forum_sso_functions.php';
// Important Note:
// You also need to update forum username on line 5 in forum_sso_functions.php.
// You also need to update forum API Key on line 7 in forum_sso_functions.php.


// Your code to process the registration for the user on your website goes here.


// Fill in the user information in a way that websitetoolbox forum can understand.
$user = array();

// After successful register to your website, assign the same user registration information to $user array to register at the websitetoolbox forum.
// For example: You can assign your register POST/GET values to user array like below:
// $user['member'] = $_POST['user'].

// Assign username that's displayed on the forum
$user['member'] = $_POST['user']; // 'ada';
// Assign password for new registration 
$user['pw'] = $_POST['password']; // 'password';
// Assign email id for new registration
$user['email'] = $_POST['email']; // 'kathy.d.flint@gmail.com';	
// You can also assign optional registration fields to '$user' array.
// For example: $user['name'] = 'John wright';

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