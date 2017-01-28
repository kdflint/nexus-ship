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

==

~/batch/dev/nexus]# ln -s /home/northbri/public_html/dev/nexus/web/src/framework/Util.php Util.php
~/batch/dev/nexus]# ln -s /home/northbri/public_html/dev/nexus/web/src/framework/PgDb.php PgDb.php

==

updates to config, sensitive config w/ forum db connection info

==

shut down forum emails
purge forum cache

==

deploy build

==

-- copy over directory/views/include from last deploy - this is a defect
