ALTER TABLE event ADD COLUMN file character varying(4);
ALTER TABLE event_group ADD COLUMN status_fk integer;
update event_group set status_fk = 1;
ALTER TABLE event_group ADD CONSTRAINT event_group_status_fk_fkey FOREIGN KEY (status_fk) REFERENCES status (id) MATCH SIMPLE;
ALTER TABLE event_group ALTER status_fk set NOT NULL;

define("PTR_ROOT", "/home/kdflint/projects/nexus-community/nexus/partner");
define("EVENT_APPROVE_LIST", "kathy.flint@northbridgetech.org");

-- check on php.ini file upload settings, dir permissions
-- create nexus/partner/file folder



