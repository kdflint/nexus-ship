-- execute db changes

make now event adder == demo user

select * from event where id = 

select id from public.user where fname = 'Not'

update event set reserved_user_fk = 287 where id = 75

ALTER TABLE event ADD COLUMN location character varying(250);
ALTER TABLE event ADD COLUMN isBbbMeet boolean;
ALTER TABLE event ALTER COLUMN isBbbMeet SET DEFAULT true;
ALTER TABLE event ALTER COLUMN type DROP NOT NULL;

-- execute migration sql



-- add soft link: pilot/migration/Util.php --> nexus/nexus/../util.php

-- copy over entire NWM project, incl batch. (renamed Util class)



--deployment changes, writing them down :)

move token folder
update config path to TKN_ROOT

resize every partner logo (in place, no name change)
add PTR_STC to config file
move /image/partner folder

select id, logo from organization where logo like 'src%'
update organization set logo = 'demo.jpg' where id = 

add LIB_ROOT to config file
move /lib folder

remove Validate.php

-- deployment steps

config file changes
database migrations

pull from github
build: from ~/projects/nexus-community/nexus, execute build-nexus
copy file to nexus folder (parent of /web)
rename web -> web.bak0
tar xvf web.tar.gz

-- TODO

lib management - ??

