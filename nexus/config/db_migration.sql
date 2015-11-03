-- config changes

nexus config:
update config path to TKN_ROOT
add LIB_ROOT to config file
add PTR_STC to config file

pilot config:
add $$env_fileRoot
add require statement

--filesystem changes

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
ALTER TABLE event ADD COLUMN isBbbMeet boolean;
ALTER TABLE event ALTER COLUMN isBbbMeet SET DEFAULT true;
ALTER TABLE event ALTER COLUMN type DROP NOT NULL;

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

