--add to config_env: define("ENV_PROTOCOL", "https://");
--alter config_env:  define("FORUM_URL", "localhost/phpBB3");

--copy over default_empty.png to /partner/images

-- .htaccess to /dev/nexus and /dev/forum

ALTER TABLE contact ALTER COLUMN url TYPE varchar(200);

-- crm config_env,sensitive_config values

