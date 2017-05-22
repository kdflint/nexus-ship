-- Sequence: program_contact_id_seq

-- DROP SEQUENCE program_contact_id_seq;

CREATE SEQUENCE program_contact_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 534
  CACHE 1;
ALTER TABLE program_contact_id_seq
  OWNER TO northbri_devnexus;
GRANT ALL ON TABLE program_contact_id_seq TO northbri_devnexus;
GRANT SELECT, UPDATE ON TABLE program_contact_id_seq TO northbri_web;

-- Sequence: program_location_id_seq

-- DROP SEQUENCE program_location_id_seq;

CREATE SEQUENCE program_location_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 703
  CACHE 1;
ALTER TABLE program_location_id_seq
  OWNER TO northbri_devnexus;
GRANT ALL ON TABLE program_location_id_seq TO northbri_devnexus;
GRANT SELECT, UPDATE ON TABLE program_location_id_seq TO northbri_web;


-- Table: program_contact

-- DROP TABLE program_contact;

CREATE TABLE program_contact
(
  id integer NOT NULL DEFAULT nextval('program_contact_id_seq'::regclass),
 	program_fk integer NOT NULL,
  contact_fk integer NOT NULL,
  CONSTRAINT program_contact_pkey PRIMARY KEY (id),
  CONSTRAINT program_contact_contact_fk_fkey FOREIGN KEY (contact_fk)
      REFERENCES contact (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT program_contact_program_fk_fkey FOREIGN KEY (program_fk)
      REFERENCES program (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE program_contact
  OWNER TO northbri_devnexus;
GRANT ALL ON TABLE program_contact TO northbri_devnexus;
GRANT ALL ON TABLE program_contact TO northbri_nbnexus;
GRANT SELECT, UPDATE, INSERT, DELETE, REFERENCES ON TABLE program_contact TO northbri_web WITH GRANT OPTION;


ALTER TABLE program ADD size varchar(20);


-- Table: program_location

-- DROP TABLE program_location;

CREATE TABLE program_location
(
  id integer NOT NULL DEFAULT nextval('program_location_id_seq'::regclass),
  program_fk integer NOT NULL,
  location_fk integer NOT NULL,
  CONSTRAINT program_location_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE program_location
  OWNER TO northbri_devnexus;
GRANT ALL ON TABLE program_location TO northbri_devnexus;
GRANT ALL ON TABLE program_location TO northbri_nbnexus;
GRANT SELECT, UPDATE, INSERT, DELETE, REFERENCES ON TABLE program_location TO northbri_web WITH GRANT OPTION;

alter table program add column eligibility varchar(250);
alter table program add column services varchar(1000);
alter table program add column involvement varchar(250);
alter table program add column partner_interest varchar(250);
alter table program add column partner_descr varchar(250);
alter table program add column hours varchar(50);
alter table program add column ada boolean;

alter table public.user add column custom_profile varchar(500);

update organization set size = null where size = '0'

-- copy over custom profile

-- copy over Authenticator.php