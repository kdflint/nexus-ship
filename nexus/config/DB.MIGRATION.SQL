--add to config_env: define("ENV_PROTOCOL", "https://"); - DONE
--alter config_env:  define("FORUM_URL", "localhost/phpBB3"); - DONE

-- .htaccess to /dev/nexus and /dev/forum - DONE

--copy over default_empty.png to /partner/images - DONE

ALTER TABLE contact ALTER COLUMN url TYPE varchar(200); -- DONE

-- crm config_env,sensitive_config values - DONE

-- copy over onboard.php, onboard_processor.php - DONE

