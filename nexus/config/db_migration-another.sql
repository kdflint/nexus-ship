ALTER TABLE event ADD COLUMN file character varying(4);

-- move existing files to proper name/location, update file column and delete url column value

-- create nexus/partner/file folder

define("APP_ROOT", "/home/kdflint/projects/nexus-community/nexus");

-- check on php.ini file upload settings, permissions