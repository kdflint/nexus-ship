-- config changes

nexus config:
update config path to TKN_ROOT
add LIB_ROOT to config file
add PTR_STC to config file
add PILOT_NAME to config file

pilot config:
add $env_fileRoot to config file
add require statement

--filesystem changes

add soft link: northbr6@northbridgetech.org [~/batch/dev/nexus]# ln -s config_env.php /home1/northbr6/public_html/dev/new_nexus/config/env_config.php
I think above is incorrect/unnecessary??
add soft link: ln -s /home1/northbr6/public_html/dev/new_nexus/config/config_env.php config_env.php
add soft link: pilot/migration/Util.php --> nexus/nexus/../util.php
move token folder
move /lib folder
remove Validate.php
move /image/partner folder
resize every partner logo (in place, no name change)

-- execute db changes

select id, logo from organization where logo like 'src%'
update organization set logo = 'demo.jpg' where id = 

make now event adder == demo user

select * from event where id = 
select id from public.user where fname = 'Not'
update event set reserved_user_fk = 293 where id = 33

ALTER TABLE event ADD COLUMN location character varying(250);
ALTER TABLE event ADD COLUMN registration character varying(250);
ALTER TABLE event ADD COLUMN contact character varying(50);
ALTER TABLE event ADD COLUMN url character varying(150);
ALTER TABLE event ADD COLUMN isBbbMeet boolean;
ALTER TABLE event ALTER COLUMN isBbbMeet SET DEFAULT true;
ALTER TABLE event ALTER COLUMN type DROP NOT NULL;

-- Sequence: group_id_seq

CREATE SEQUENCE event_group_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 7
  CACHE 1;
ALTER TABLE event_group_id_seq
  OWNER TO northbr6_devnexus;
GRANT ALL ON TABLE event_group_id_seq TO northbr6_devnexus;
GRANT SELECT, UPDATE ON TABLE event_group_id_seq TO northbr6_web;

-- Table: event_group

CREATE TABLE event_group
(
  id integer NOT NULL DEFAULT nextval('event_group_id_seq'::regclass),
  event_fk integer NOT NULL,
  group_fk integer NOT NULL,
  create_dttm timestamp with time zone NOT NULL DEFAULT now(),
  update_dttm timestamp with time zone,
  CONSTRAINT event_group_pkey PRIMARY KEY (id),
  CONSTRAINT event_group_event_fk_fkey FOREIGN KEY (event_fk)
      REFERENCES "event" (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT event_group_group_fk_fkey FOREIGN KEY (group_fk)
      REFERENCES "group" (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE event_group
  OWNER TO northbr6_devnexus;
GRANT ALL ON TABLE event_group TO northbr6_devnexus;
GRANT SELECT, UPDATE, INSERT ON TABLE event_group TO northbr6_web;
GRANT ALL ON TABLE event_group TO northbr6_nbnexus;

-- snag migrate statements, then execute (strip " chars first in editor)
select 'insert into event_group (event_fk, group_fk) values (' || id || ',' || group_fk || ')' from event

-- sanity check - count should equal:

select count(*) from event;
select count(*) from event_group;

-- code deployment steps

pull from github
build: from ~/projects/nexus-community/nexus, execute build-nexus
copy file to nexus folder (parent of /web)
rename web -> web.bak0
tar xvf web.tar.gz

-- copy over entire NWM project

-- copy over NVM batch (renamed Util class)

-- copy over pilot

-- TODO

lib management - ??
