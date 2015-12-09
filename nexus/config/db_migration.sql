-- config changes

--nexus config:
update config path to TKN_ROOT
add LIB_ROOT to config file
add PTR_STC to config file
add PILOT_NAME to config file

--pilot config:
add $env_fileRoot to config file
add require statement

--filesystem changes

add soft link: northbr6@northbridgetech.org [~/batch/dev/nexus]# ln -s config_env.php /home1/northbr6/public_html/dev/new_nexus/config/env_config.php
I think above is incorrect/unnecessary??
add soft link: ln -s /home1/northbr6/public_html/dev/new_nexus/config/config_env.php config_env.php
add soft link: ~/batch/dev ln -s nexus new_nexus
add soft link: pilot/migration/Util.php --> nexus/nexus/../util.php

open up permissions on dev/new_nexus/config/config_env.php - ? pending test on Thur a.m.

move token folder
move /lib folder
remove Validate.php
move /image/partner folder
resize every partner logo (in place, no name change)

-- execute db changes

update public.user set fname = 'aaNot' where id = 293

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
ALTER TABLE event ADD COLUMN registration_url character varying(150);
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

-- prep public user/group

insert into public.user (uuid, username, fname, lname, email, status_fk, create_dttm, activate_dttm) values (
'209774a1-739a-4b60-bfee-9cb00c7ee6e0', 
'pUser-12345678',
'Public',
'User',
'',
'1',
now(),
now()) returning id;

insert into public.group (name, descr, create_dttm, activate_dttm, uid) values (
'Public Group',
'This group is a placeholder for publicly visible things',
now(),
now(),
'5d0754e7') returning id;

insert into user_group (user_fk, create_dttm, group_fk, role_fk) values
(307,
now(),
13,
5);

insert into user_organization (user_fk, organization_fk, grantor_fk, create_dttm, role_fk) values (
307,
330,
88,
now(),
5)

-- add public meetings

insert into event (uuid, start_dttm, duration, name, descr, reserved_user_fk, group_fk, tz_name, tz_abbrev, type, location, isBbbMeet) values ('589e6019-285c-435f-bc91-a49c9cbb3a6e', '01-01-2016 00:00:00', '30:00:00', 'Public Test Meeting', 'test test test test', 307, 13, 'America/Chicago', 'CDT', 'collaboration', 'location', 'f') returning id;
insert into event (uuid, start_dttm, duration, name, descr, reserved_user_fk, group_fk, tz_name, tz_abbrev, type, location, isBbbMeet) values ('1f5fc268-117a-4bd1-94a6-626879622867', '01-01-2016 00:00:00', '30:00:00', 'Public Test Meeting With a Longer Name', 'test test test test', 307, 13, 'America/Chicago', 'CDT', 'collaboration', 'location', 'f') returning id;
insert into event (uuid, start_dttm, duration, name, descr, reserved_user_fk, group_fk, tz_name, tz_abbrev, type, location, isBbbMeet) values ('5807c186-4927-4be4-a1c8-74a885433912', '01-01-2016 00:00:00', '30:00:00', 'Public Test Meeting', 'test test test test <script>alert(''hello'');</script>', 307, 13, 'America/Chicago', 'CDT', 'collaboration', 'location', 'f') returning id;
insert into event (uuid, start_dttm, duration, name, descr, reserved_user_fk, group_fk, tz_name, tz_abbrev, type, location, isBbbMeet) values ('2aeaf271-3d14-4027-8457-717f903e63da', '01-01-2016 00:00:00', '30:00:00', 'Public Test Meeting', 'test test test test', 307, 13, 'America/Chicago', 'CDT', 'collaboration', '', 'f') returning id;
insert into event (uuid, start_dttm, duration, name, descr, reserved_user_fk, group_fk, tz_name, tz_abbrev, type, location, isBbbMeet) values ('7023e99c-41da-49db-a4b3-57b24075b1e0', '01-01-2016 00:00:00', '30:00:00', 'Public Test Meeting', '', 307, 13, 'America/Chicago', 'CDT', 'collaboration', 'location', 'f') returning id;
insert into event (uuid, start_dttm, duration, name, descr, reserved_user_fk, group_fk, tz_name, tz_abbrev, type, location, isBbbMeet) values ('70fd11ee-6908-4630-9228-a732095c0a53', '01-01-2016 00:00:00', '30:00:00', 'Public Test Meeting', 'test test test test', 307, 13, 'America/Chicago', 'CDT', 'collaboration', 'location', 'f') returning id;


-- snag migrate statements, then execute (strip " chars first in editor)
select 'insert into event_group (event_fk, group_fk) values (' || id || ',' || group_fk || ')' from event

-- sanity check - count should equal:

select count(*) from event;
select count(*) from event_group;

-- drop deprecated event column

alter table event drop column group_fk

-- add organization_account table

CREATE SEQUENCE organization_account_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 7
  CACHE 1;
ALTER TABLE organization_account_id_seq
  OWNER TO northbr6_devnexus;
GRANT ALL ON TABLE organization_account_id_seq TO northbr6_devnexus;
GRANT SELECT, UPDATE ON TABLE organization_account_id_seq TO northbr6_web;

CREATE TABLE organization_account
(
  id integer NOT NULL DEFAULT nextval('organization_account_id_seq'::regclass),
  organization_fk integer NOT NULL,
  account_type character varying(10) NOT NULL,
  CONSTRAINT organization_account_pkey PRIMARY KEY (id),
  CONSTRAINT organization_account_organization_fk_fkey FOREIGN KEY (organization_fk)
      REFERENCES organization (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE organization_account
  OWNER TO northbr6_devnexus;
GRANT ALL ON TABLE organization_account TO northbr6_devnexus;
GRANT ALL ON TABLE organization_account TO northbr6_nbnexus;
GRANT SELECT, UPDATE, INSERT, REFERENCES ON TABLE organization_account TO northbr6_web WITH GRANT OPTION;

-- migrate organization_account

select distinct uid from organization
select id from organization where uid in ('userdemo', '12345678', '3000356e', '00ba26d5')
select 'insert into organization_account (organization_fk, account_type) values (' || id || ',''ADV'');' from organization where id not in (330,331,332,333)
select 'insert into organization_account (organization_fk, account_type) values (' || id || ',''NWM'');' from organization where id in (330,331,332,333)

-- count should equal

select count(*) from organization
select count(*) from organization_account

-- code deployment steps

-- testing - org id 1 should be ADV after migration. Add user/group if there is none

-- add uid, logo to org id 1
-- insert into public.user (uuid, username, fname, lname, email, status_fk, create_dttm, activate_dttm, enable_email) values ('be72d650-9db6-45a1-9cc1-9dca6f5b024f', 'kdfTestAdv', 'Kathy', 'Flint', 'kathy.flint@northbridgetech.org', '1', now(), now(), 'f') returning id
-- insert into user_organization (user_fk, organization_fk, grantor_fk, role_fk, create_dttm) values (296, 1, 88, 4, now()) returning id
-- insert into user_group (user_fk, group_fk, role_fk, create_dttm) values (296, 5, 4, now())

pull from github
build: from ~/projects/nexus-community/nexus, execute build-nexus
copy file to nexus folder (parent of /web)
rename web -> web.bak0
tar xvf web.tar.gz
rm web.tar.gz

-- copy over entire NWM project

-- copy over NVM batch (renamed Util class)

-- copy over pilot

-- TODO

lib management - ??
