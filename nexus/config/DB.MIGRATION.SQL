DROP TABLE forum_poll;

CREATE TABLE forum_poll
(
  forum_last_poll_dttm timestamp with time zone,
  topic_last_poll_dttm timestamp with time zone
)
WITH (
  OIDS=FALSE
);
ALTER TABLE forum_poll
  OWNER TO northbr6_devnexus;
GRANT ALL ON TABLE forum_poll TO northbr6_devnexus;
GRANT ALL ON TABLE forum_poll TO northbr6_nbnexus;
GRANT SELECT, UPDATE, INSERT, REFERENCES ON TABLE forum_poll TO northbr6_web WITH GRANT OPTION;

insert into forum_poll (forum_last_poll_dttm, topic_last_poll_dttm) values (now(), now());


-- copy over directory/views/include from last deploy - this is a defect

ln -s /home/northbri/public_html/dev/nexus/web/src/framework/Util.php Util.php
ln -s /home/northbri/public_html/dev/nexus/web/src/framework/PgDb.php PgDb.php

--updates to config, sensitive config
--forum db connection, password