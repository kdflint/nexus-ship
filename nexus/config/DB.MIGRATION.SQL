-- clear forum cache

-- copy over CFCHT custom filters

GRANT SELECT, UPDATE, INSERT, DELETE, REFERENCES ON TABLE organization_contact TO northbr6_web WITH GRANT OPTION;
GRANT SELECT, UPDATE ON TABLE organization_contact_id_seq TO northbr6_web;

GRANT SELECT, UPDATE, INSERT, DELETE, REFERENCES ON TABLE organization_topic TO northbr6_web WITH GRANT OPTION;
GRANT SELECT, UPDATE ON TABLE organization_topic_id_seq TO northbr6_web;

GRANT SELECT, UPDATE, INSERT, DELETE, REFERENCES ON TABLE organization_location TO northbr6_web WITH GRANT OPTION;
GRANT SELECT, UPDATE ON TABLE organization_location_id_seq TO northbr6_web;

GRANT SELECT, UPDATE, INSERT, DELETE, REFERENCES ON TABLE organization_language TO northbr6_web WITH GRANT OPTION;
GRANT SELECT, UPDATE ON TABLE organization_language_id_seq TO northbr6_web;


ALTER TABLE organization ADD size varchar(20);

insert into language (language) values ('American Sign');
insert into language (language) values ('Cantonese');
insert into language (language) values ('Mandarin');

-- confirm ids match custom language options file

-- Sequence: affiliation_id_seq

-- DROP SEQUENCE affiliation_id_seq;

CREATE SEQUENCE affiliation_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 13
  CACHE 1;
ALTER TABLE affiliation_id_seq
  OWNER TO northbr6_devnexus;
  
 -- Sequence: organization_affiliation_id_seq

-- DROP SEQUENCE organization_affiliation_id_seq;

CREATE SEQUENCE organization_affiliation_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 119
  CACHE 1;
ALTER TABLE organization_affiliation_id_seq
  OWNER TO northbr6_devnexus;
  
 -- Table: affiliation

-- DROP TABLE affiliation;

CREATE TABLE affiliation
(
  id integer NOT NULL DEFAULT nextval('affiliation_id_seq'::regclass),
  affiliation character varying(50) NOT NULL,
  CONSTRAINT affiliation_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE affiliation
  OWNER TO northbr6_devnexus;
GRANT ALL ON TABLE affiliation TO northbr6_devnexus;
GRANT SELECT, UPDATE, INSERT, REFERENCES ON TABLE affiliation TO northbr6_web WITH GRANT OPTION;
GRANT ALL ON TABLE affiliation TO northbr6_nbnexus;


-- Table: organization_affiliation

-- DROP TABLE organization_affiliation;

CREATE TABLE organization_affiliation
(
  id integer NOT NULL DEFAULT nextval('organization_affiliation_id_seq'::regclass),
  organization_fk integer NOT NULL,
  affiliation_fk integer NOT NULL,
  CONSTRAINT organization_affiliation_pkey PRIMARY KEY (id),
  CONSTRAINT organization_affiliation_affiliation_fk_fkey FOREIGN KEY (affiliation_fk)
      REFERENCES affiliation (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT organization_affiliation_organization_fk_fkey FOREIGN KEY (organization_fk)
      REFERENCES organization (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE organization_affiliation
  OWNER TO northbr6_devnexus;
GRANT ALL ON TABLE organization_affiliation TO northbr6_devnexus;
GRANT SELECT, UPDATE, INSERT, DELETE, REFERENCES ON TABLE organization_affiliation TO northbr6_web WITH GRANT OPTION;
GRANT ALL ON TABLE organization_affiliation TO northbr6_nbnexus;

insert into affiliation (affiliation) values ('African Methodist Episcopal');
insert into affiliation (affiliation) values ('African Methodist Episcopal Zion');
insert into affiliation (affiliation) values ('Apostolic');
insert into affiliation (affiliation) values ('Assemblies of God');
insert into affiliation (affiliation) values ('Baptist');
insert into affiliation (affiliation) values ('Baptist-American');
insert into affiliation (affiliation) values ('Baptist-Missionary');
insert into affiliation (affiliation) values ('Baptist-Southern');
insert into affiliation (affiliation) values ('Buddhist');
insert into affiliation (affiliation) values ('Catholic-Roman');
insert into affiliation (affiliation) values ('Christian Methodist Episcopal');
insert into affiliation (affiliation) values ('Christian Science');
insert into affiliation (affiliation) values ('Church of God in Christ');
insert into affiliation (affiliation) values ('Church of the Brethren');
insert into affiliation (affiliation) values ('Congregational Church');
insert into affiliation (affiliation) values ('Disciples of Christ-Christian Church');
insert into affiliation (affiliation) values ('Episcopal Church');
insert into affiliation (affiliation) values ('Evangelical Covenent Church');
insert into affiliation (affiliation) values ('Evangelical Free Church');
insert into affiliation (affiliation) values ('Friends-Society of Friends-Quaker');
insert into affiliation (affiliation) values ('Hindu');
insert into affiliation (affiliation) values ('Jehovah Witness');
insert into affiliation (affiliation) values ('Jewish');
insert into affiliation (affiliation) values ('Lutheran-ELCA');
insert into affiliation (affiliation) values ('Lutheran-Missouri Synod');
insert into affiliation (affiliation) values ('Mennonite');
insert into affiliation (affiliation) values ('Methodist-United');
insert into affiliation (affiliation) values ('Mormon-Church Jesus Christ Latter Day Saints');
insert into affiliation (affiliation) values ('Muslim');
insert into affiliation (affiliation) values ('Nation of Islam');
insert into affiliation (affiliation) values ('Non-Denominational');
insert into affiliation (affiliation) values ('Orthodox-Greek');
insert into affiliation (affiliation) values ('Orthodox-Russian');
insert into affiliation (affiliation) values ('Pentecostal');
insert into affiliation (affiliation) values ('Presbyterian-United Presbyterian Church of America');
insert into affiliation (affiliation) values ('Reformed-Christian Reformed Church');
insert into affiliation (affiliation) values ('Reformed-Reformed Church in America');
insert into affiliation (affiliation) values ('Seventh Day Adventists');
insert into affiliation (affiliation) values ('Shinto');
insert into affiliation (affiliation) values ('Sikh');
insert into affiliation (affiliation) values ('Unitarian Universalist');
insert into affiliation (affiliation) values ('United Church of Christ');

-- create custom html file - remove extraneous quotes
select '<option value="' || id || '">' || affiliation || '</option>' from affiliation

-- Sequence: ethnicity_id_seq

-- DROP SEQUENCE ethnicity_id_seq;

CREATE SEQUENCE ethnicity_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 13
  CACHE 1;
ALTER TABLE ethnicity_id_seq
  OWNER TO northbr6_devnexus;
  
 -- Sequence: organization_ethnicity_id_seq

-- DROP SEQUENCE organization_ethnicity_id_seq;

CREATE SEQUENCE organization_ethnicity_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 119
  CACHE 1;
ALTER TABLE organization_ethnicity_id_seq
  OWNER TO northbr6_devnexus;
  
 -- Table: ethnicity

-- DROP TABLE ethnicity;

CREATE TABLE ethnicity
(
  id integer NOT NULL DEFAULT nextval('ethnicity_id_seq'::regclass),
  ethnicity character varying(50) NOT NULL,
  CONSTRAINT ethnicity_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE ethnicity
  OWNER TO northbr6_devnexus;
GRANT ALL ON TABLE ethnicity TO northbr6_devnexus;
GRANT SELECT, UPDATE, INSERT, REFERENCES ON TABLE ethnicity TO northbr6_web WITH GRANT OPTION;
GRANT ALL ON TABLE ethnicity TO northbr6_nbnexus;


-- Table: organization_ethnicity

-- DROP TABLE organization_ethnicity;

CREATE TABLE organization_ethnicity
(
  id integer NOT NULL DEFAULT nextval('organization_ethnicity_id_seq'::regclass),
  organization_fk integer NOT NULL,
  ethnicity_fk integer NOT NULL,
  CONSTRAINT organization_ethnicity_pkey PRIMARY KEY (id),
  CONSTRAINT organization_ethnicity_ethnicity_fk_fkey FOREIGN KEY (ethnicity_fk)
      REFERENCES ethnicity (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT organization_ethnicity_organization_fk_fkey FOREIGN KEY (organization_fk)
      REFERENCES organization (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE organization_ethnicity
  OWNER TO northbr6_devnexus;
GRANT ALL ON TABLE organization_ethnicity TO northbr6_devnexus;
GRANT SELECT, UPDATE, INSERT, DELETE, REFERENCES ON TABLE organization_ethnicity TO northbr6_web WITH GRANT OPTION;
GRANT ALL ON TABLE organization_ethnicity TO northbr6_nbnexus;

insert into ethnicity (ethnicity) values ('European American');
insert into ethnicity (ethnicity) values ('African American');
insert into ethnicity (ethnicity) values ('Mexican');
insert into ethnicity (ethnicity) values ('Puerto Rican');
insert into ethnicity (ethnicity) values ('Other Latino');
insert into ethnicity (ethnicity) values ('Asian/Pacific Islander');
insert into ethnicity (ethnicity) values ('South Asian (Indian, Pakistani)');
insert into ethnicity (ethnicity) values ('African');
insert into ethnicity (ethnicity) values ('Arab');
insert into ethnicity (ethnicity) values ('Eastern European (e.g. Polish, Lithuanian)');
insert into ethnicity (ethnicity) values ('Other European');
insert into ethnicity (ethnicity) values ('Native American');

-- create custom html file
select '<option value="' || id || '">' || ethnicity || '</option>' from ethnicity

GRANT ALL ON TABLE organization_affiliation_id_seq TO northbr6_devnexus;
GRANT SELECT, UPDATE ON TABLE organization_affiliation_id_seq TO northbr6_web;
GRANT ALL ON TABLE organization_ethnicity_id_seq TO northbr6_devnexus;
GRANT SELECT, UPDATE ON TABLE organization_ethnicity_id_seq TO northbr6_web;

