
SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

CREATE TABLE public.group_new (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    descr character varying(200),
    create_dttm timestamp with time zone DEFAULT now() NOT NULL,
    update_dttm timestamp with time zone,
    activate_dttm timestamp with time zone,
    suspend_dttm timestamp with time zone,
    logo character varying(100) DEFAULT ''::character varying,
    uid character(8) NOT NULL
);

-- from current group table
INSERT INTO public.group_new (id, name, descr, uid) VALUES (2, 'Nexus Pilot User Group', 'Ths group is formed to evaluate the Nexus product for widespread use in the Episcopal Diocese of Chicago.', 11111111);
INSERT INTO public.group_new (id, name, descr, uid) VALUES (5, 'Antiracism Committee', 'Ths group is formed to evaluate the Nexus product for use by the Antiracism Committee.', 22222222);
INSERT INTO public.group_new (id, name, descr, uid) VALUES (1, 'Demo Workgroup', 'This group seeks to test the hell out of Nexus.', 33333333);

ALTER TABLE public.group_new OWNER TO northbr6;

ALTER TABLE public.group_new ADD CONSTRAINT group_new_pkey PRIMARY KEY (id);
    
ALTER TABLE public.group ALTER COLUMN id SET DEFAULT nextval('group_id_seq'::regclass);

REVOKE ALL ON TABLE public.group FROM PUBLIC;
REVOKE ALL ON TABLE public.group FROM northbr6_devnexus;
GRANT ALL ON TABLE public.group TO northbr6_devnexus;
GRANT ALL ON TABLE public.group TO northbr6_nbnexus;
GRANT SELECT,INSERT,REFERENCES,UPDATE ON TABLE public.group TO northbr6_web WITH GRANT OPTION;


-- TODO - make this not nullable (need a migration script)
alter table public.organization add column uid character(8) unique;
