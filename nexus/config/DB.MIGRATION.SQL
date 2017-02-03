--DROP TABLE forum_poll;

CREATE TABLE forum_poll
(
  forum_last_poll_dttm timestamp with time zone,
  topic_last_poll_dttm timestamp with time zone
)
WITH (
  OIDS=FALSE
);
ALTER TABLE forum_poll
  OWNER TO northbri_devnexus;
GRANT ALL ON TABLE forum_poll TO northbri_devnexus;
GRANT ALL ON TABLE forum_poll TO northbri_nbnexus;
GRANT SELECT, UPDATE, INSERT, REFERENCES ON TABLE forum_poll TO northbri_web WITH GRANT OPTION;

insert into forum_poll (forum_last_poll_dttm, topic_last_poll_dttm) values (now(), now());

ALTER TABLE "group"
   ADD COLUMN forum_group_id integer DEFAULT NULL;

==

~/batch/dev/nexus]# ln -s /home/northbri/public_html/dev/nexus/web/src/framework/Util.php Util.php
~/batch/dev/nexus]# ln -s /home/northbri/public_html/dev/nexus/web/src/framework/PgDb.php PgDb.php

==

updates to config, sensitive config w/ forum db connection info
update to config: add log root and folder, check permissions
update to config and sensitive: set sms service credentials
update to config: set FORUM_REGISTERED_USER_GROUP, FORUM_NETWORK_USER_GROUP, CFCHT_NEW_GROUP

==

update max login attempts to 0
purge forum cache

==

deploy build
deploy batch

==

-- copy over directory/views/include from last deploy - this is a defect

==

schedule forum_cron

