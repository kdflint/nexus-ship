--
-- Name: meeting_type; Type: TYPE; Schema: public; Owner: northbr6
--

CREATE TYPE meeting_type AS ENUM (
    'video chat',
    'collaboration',
    'webinar',
    'video tether'
);


ALTER TYPE public.meeting_type OWNER TO northbr6;

--
-- Name: event; Type: TABLE; Schema: public; Owner: northbr6_nbnexus; Tablespace: 
--

CREATE TABLE event (
    id integer NOT NULL,
    uuid uuid NOT NULL,
    start_dttm timestamp with time zone NOT NULL,
    duration interval NOT NULL,
    name character varying(200) NOT NULL,
    descr character varying(500),
    reserved_user_fk integer NOT NULL,
    admin_user_fk integer,
    group_fk integer NOT NULL,
    tz_name character varying(50),
    tz_abbrev character varying(10),
    create_dttm timestamp with time zone DEFAULT now() NOT NULL,
    update_dttm timestamp with time zone,
    active boolean DEFAULT true,
    type meeting_type DEFAULT 'collaboration'::meeting_type NOT NULL
);


ALTER TABLE public.event OWNER TO northbr6_nbnexus;

--
-- Name: event_id_seq; Type: SEQUENCE; Schema: public; Owner: northbr6_nbnexus
--

CREATE SEQUENCE event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.event_id_seq OWNER TO northbr6_nbnexus;

--
-- Name: event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: northbr6_nbnexus
--

ALTER SEQUENCE event_id_seq OWNED BY event.id;

--
-- Name: group_new; Type: TABLE; Schema: public; Owner: northbr6; Tablespace: 
--

CREATE TABLE group_new (
    id integer DEFAULT nextval('group_id_seq'::regclass) NOT NULL,
    name character varying(100) NOT NULL,
    descr character varying(200),
    create_dttm timestamp with time zone DEFAULT now() NOT NULL,
    update_dttm timestamp with time zone,
    activate_dttm timestamp with time zone,
    suspend_dttm timestamp with time zone,
    logo character varying(100) DEFAULT ''::character varying,
    uid character(8) NOT NULL
);


ALTER TABLE public.group_new OWNER TO northbr6;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: northbr6_nbnexus
--

ALTER TABLE ONLY event ALTER COLUMN id SET DEFAULT nextval('event_id_seq'::regclass);

--
-- Name: event_pkey; Type: CONSTRAINT; Schema: public; Owner: northbr6_nbnexus; Tablespace: 
--

ALTER TABLE ONLY event
    ADD CONSTRAINT event_pkey PRIMARY KEY (id);

--
-- Name: group_new_pkey; Type: CONSTRAINT; Schema: public; Owner: northbr6; Tablespace: 
--

ALTER TABLE ONLY group_new
    ADD CONSTRAINT group_new_pkey PRIMARY KEY (id);
    
--
-- Name: organization_uid_key; Type: CONSTRAINT; Schema: public; Owner: northbr6_nbnexus; Tablespace: 
--

ALTER TABLE organization ADD uid character(8);

ALTER TABLE ONLY organization
    ADD CONSTRAINT organization_uid_key UNIQUE (uid);
    
    
--
-- Name: event_admin_user_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbr6_nbnexus
--

ALTER TABLE ONLY event
    ADD CONSTRAINT event_admin_user_fk_fkey FOREIGN KEY (admin_user_fk) REFERENCES "user"(id);


--
-- Name: event_group_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbr6_nbnexus
--

ALTER TABLE ONLY event
    ADD CONSTRAINT event_group_fk_fkey FOREIGN KEY (group_fk) REFERENCES group_new(id);


--
-- Name: event_reserved_user_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbr6_nbnexus
--

ALTER TABLE ONLY event
    ADD CONSTRAINT event_reserved_user_fk_fkey FOREIGN KEY (reserved_user_fk) REFERENCES "user"(id);

--
-- Name: user_group_role_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbr6_nbnexus
--

ALTER TABLE user_group add role_fk integer;

ALTER TABLE ONLY user_group
    ADD CONSTRAINT user_group_role_fk_fkey FOREIGN KEY (role_fk) REFERENCES role(id);

--
-- Name: event; Type: ACL; Schema: public; Owner: northbr6_nbnexus
--

REVOKE ALL ON TABLE event FROM PUBLIC;
REVOKE ALL ON TABLE event FROM northbr6_nbnexus;
GRANT ALL ON TABLE event TO northbr6_nbnexus;
GRANT SELECT,INSERT,UPDATE ON TABLE event TO northbr6_web;


--
-- Name: event_id_seq; Type: ACL; Schema: public; Owner: northbr6_nbnexus
--

REVOKE ALL ON SEQUENCE event_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE event_id_seq FROM northbr6_nbnexus;
GRANT ALL ON SEQUENCE event_id_seq TO northbr6_nbnexus;
GRANT SELECT,UPDATE ON SEQUENCE event_id_seq TO northbr6_web;

--
-- Name: group_new; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON TABLE group_new FROM PUBLIC;
REVOKE ALL ON TABLE group_new FROM northbr6;
GRANT ALL ON TABLE group_new TO northbr6;
GRANT SELECT,INSERT,UPDATE ON TABLE group_new TO northbr6_web;

GRANT SELECT,INSERT ON TABLE organization_organization TO northbr6_web;

GRANT SELECT,INSERT,UPDATE ON TABLE "user" TO northbr6_web;

GRANT SELECT,INSERT ON TABLE user_organization TO northbr6_web;

ALTER TABLE invitation ALTER COLUMN network_fk integer nullable;

