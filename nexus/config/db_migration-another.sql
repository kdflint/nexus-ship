ALTER TABLE event ADD COLUMN file character varying(4);

-- create nexus/partner/file folder

define("PTR_ROOT", "/home/kdflint/projects/nexus-community/nexus/partner");

-- check on php.ini file upload settings, dir permissions