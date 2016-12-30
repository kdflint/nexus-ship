<?php

/*
Of interest

https://www.phpbb.com/support/docs/en/3.0/kb/article/phpbb3-sessions-integration/
https://wiki.phpbb.com/Authentication_plugins
*/

// Assure phpBB code that we are calling it from inside a php-authorized "container"
define('IN_PHPBB', true);

/*
PHPBB_ROOT_PATH is a constant that is undefined in a traditional phpBB installation. As long as it is undefined, [local variable] $phpbb_root_path is always set [within phpBB codebase files like index.php] to "./". However, PHPBB_ROOT_PATH can be used by an external application [like this one] to overwrite the default value of $phpbb_root_path without requiring edits to the phpBB files (as long as it is defined before they are used). (http://area51.phpbb.com/phpBB/viewtopic.php?p=232245#p232245)

So here, we explicity define this path which will be hereafter picked up by all phpBB code initialized in the context of this session -kdf
*/
$phpbb_root_path = (defined('PHPBB_ROOT_PATH')) ? PHPBB_ROOT_PATH : Utilities::getPhpBbRoot();

// This just identifies the php file extension using the current filename as a pattern
$phpEx = substr(strrchr(__FILE__, '.'), 1);

// Pull the relevant phpBB code into this request execution
require_once($phpbb_root_path . 'common.' . $phpEx);

// This tells phpBB to allow our codebase to directly handle super globals ($_SESSION, etc.)
$request->enable_super_globals();

?>