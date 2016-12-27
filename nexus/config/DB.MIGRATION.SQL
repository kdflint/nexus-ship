alter table public.organization add column forum_id varchar(4);
alter table public.organization add column public_forum_id varchar(4);

CREATE SEQUENCE event_recur_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 221
  CACHE 1;
ALTER TABLE event_recur_id_seq
  OWNER TO northbri_devnexus;
GRANT ALL ON TABLE event_recur_id_seq TO northbri_devnexus;
GRANT SELECT, UPDATE ON TABLE event_recur_id_seq TO northbri_web;

CREATE TABLE event_recur
(
  id integer NOT NULL DEFAULT nextval('event_recur_id_seq'::regclass),
  pattern character varying(12),
  num_occur numeric,
  end_dttm timestamp with time zone,
  CONSTRAINT event_recur_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE event_recur
  OWNER TO northbri_devnexus;
GRANT ALL ON TABLE event_recur TO northbri_devnexus;
GRANT SELECT, UPDATE, INSERT ON TABLE event_recur TO northbri_web;

ALTER TABLE event
   ADD COLUMN recur_fk integer;
   
ALTER TABLE event
  ADD CONSTRAINT event_recur_fk_fkey FOREIGN KEY (recur_fk)
      REFERENCES "event_recur" (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;
