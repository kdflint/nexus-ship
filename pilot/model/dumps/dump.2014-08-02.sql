--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

--
-- Name: organization_type; Type: TYPE; Schema: public; Owner: northbr6
--

CREATE TYPE organization_type AS ENUM (
    'Faith Community/House of Worship',
    'Collaborative/Network',
    'Community Organization',
    'Government',
    'Health Care Provider',
    'Academic Institution'
);


ALTER TYPE public.organization_type OWNER TO northbr6;

--
-- Name: category_id_seq; Type: SEQUENCE; Schema: public; Owner: northbr6
--

CREATE SEQUENCE category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.category_id_seq OWNER TO northbr6;

--
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbr6
--

SELECT pg_catalog.setval('category_id_seq', 1, true);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: category; Type: TABLE; Schema: public; Owner: northbr6; Tablespace: 
--

CREATE TABLE category (
    id integer DEFAULT nextval('category_id_seq'::regclass) NOT NULL,
    name character varying(30) NOT NULL,
    organization_fk integer NOT NULL
);


ALTER TABLE public.category OWNER TO northbr6;

--
-- Name: category_topic_id_seq; Type: SEQUENCE; Schema: public; Owner: northbr6
--

CREATE SEQUENCE category_topic_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.category_topic_id_seq OWNER TO northbr6;

--
-- Name: category_topic_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbr6
--

SELECT pg_catalog.setval('category_topic_id_seq', 41, true);


--
-- Name: category_topic; Type: TABLE; Schema: public; Owner: northbr6; Tablespace: 
--

CREATE TABLE category_topic (
    id integer DEFAULT nextval('category_topic_id_seq'::regclass) NOT NULL,
    category_fk integer NOT NULL,
    topic_fk integer NOT NULL
);


ALTER TABLE public.category_topic OWNER TO northbr6;

--
-- Name: contact_id_seq; Type: SEQUENCE; Schema: public; Owner: northbr6
--

CREATE SEQUENCE contact_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.contact_id_seq OWNER TO northbr6;

--
-- Name: contact_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbr6
--

SELECT pg_catalog.setval('contact_id_seq', 276, true);


--
-- Name: contact; Type: TABLE; Schema: public; Owner: northbr6; Tablespace: 
--

CREATE TABLE contact (
    id integer DEFAULT nextval('contact_id_seq'::regclass) NOT NULL,
    email character varying(50),
    sms character varying(20),
    phone character varying(20),
    url character varying(100),
    media_fk integer,
    fax character varying(10),
    title character varying(50),
    name character varying(200)
);


ALTER TABLE public.contact OWNER TO northbr6;

--
-- Name: COLUMN contact.media_fk; Type: COMMENT; Schema: public; Owner: northbr6
--

COMMENT ON COLUMN contact.media_fk IS 'Placeholder for a social media table fk';


--
-- Name: forum_user_id_seq; Type: SEQUENCE; Schema: public; Owner: northbr6
--

CREATE SEQUENCE forum_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.forum_user_id_seq OWNER TO northbr6;

--
-- Name: forum_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbr6
--

SELECT pg_catalog.setval('forum_user_id_seq', 21, true);


--
-- Name: forum_user; Type: TABLE; Schema: public; Owner: northbr6; Tablespace: 
--

CREATE TABLE forum_user (
    id integer DEFAULT nextval('forum_user_id_seq'::regclass) NOT NULL,
    user_fk integer NOT NULL,
    username character varying(25) NOT NULL,
    password character varying(25) NOT NULL,
    name character varying(50) NOT NULL,
    email character varying(50) NOT NULL
);


ALTER TABLE public.forum_user OWNER TO northbr6;

--
-- Name: COLUMN forum_user.user_fk; Type: COMMENT; Schema: public; Owner: northbr6
--

COMMENT ON COLUMN forum_user.user_fk IS 'Nexus system user id';


--
-- Name: COLUMN forum_user.username; Type: COMMENT; Schema: public; Owner: northbr6
--

COMMENT ON COLUMN forum_user.username IS 'This column is unused now. [Deprecated - Username for sso into forum. Kludgy, but actual forum username = this column value + id]';


--
-- Name: COLUMN forum_user.password; Type: COMMENT; Schema: public; Owner: northbr6
--

COMMENT ON COLUMN forum_user.password IS 'Password for sso into forum';


--
-- Name: COLUMN forum_user.name; Type: COMMENT; Schema: public; Owner: northbr6
--

COMMENT ON COLUMN forum_user.name IS 'Name as registered in forum. We are using this as the forum username.';


--
-- Name: COLUMN forum_user.email; Type: COMMENT; Schema: public; Owner: northbr6
--

COMMENT ON COLUMN forum_user.email IS 'Email as registered in forum';


--
-- Name: invitation; Type: TABLE; Schema: public; Owner: northbr6; Tablespace: 
--

CREATE TABLE invitation (
    id integer NOT NULL,
    uuid uuid NOT NULL,
    email character varying(50),
    create_dttm timestamp with time zone NOT NULL,
    accept_dttm timestamp with time zone,
    network_fk integer NOT NULL,
    invitation_dttm timestamp with time zone,
    role_fk integer NOT NULL,
    expire_dt date,
    issuer_fk integer NOT NULL,
    type character varying(10) NOT NULL,
    organization_fk integer
);


ALTER TABLE public.invitation OWNER TO northbr6;

--
-- Name: COLUMN invitation.email; Type: COMMENT; Schema: public; Owner: northbr6
--

COMMENT ON COLUMN invitation.email IS 'This identifies the email address that this invitation is specific to.';


--
-- Name: COLUMN invitation.create_dttm; Type: COMMENT; Schema: public; Owner: northbr6
--

COMMENT ON COLUMN invitation.create_dttm IS 'This identifies when the invitation record was created.';


--
-- Name: COLUMN invitation.accept_dttm; Type: COMMENT; Schema: public; Owner: northbr6
--

COMMENT ON COLUMN invitation.accept_dttm IS 'This identifies when the specific user accepted the invitation. Unused in pilot release.';


--
-- Name: COLUMN invitation.network_fk; Type: COMMENT; Schema: public; Owner: northbr6
--

COMMENT ON COLUMN invitation.network_fk IS 'This identifies the network that issued the invitation.';


--
-- Name: COLUMN invitation.invitation_dttm; Type: COMMENT; Schema: public; Owner: northbr6
--

COMMENT ON COLUMN invitation.invitation_dttm IS 'This identifies when a user-specific invitation was transmitted. Unused in pilot release.';


--
-- Name: COLUMN invitation.role_fk; Type: COMMENT; Schema: public; Owner: northbr6
--

COMMENT ON COLUMN invitation.role_fk IS 'This indicates the role that should be granted to the invited users.';


--
-- Name: COLUMN invitation.expire_dt; Type: COMMENT; Schema: public; Owner: northbr6
--

COMMENT ON COLUMN invitation.expire_dt IS 'This identifies when the invitation will expire.';


--
-- Name: COLUMN invitation.issuer_fk; Type: COMMENT; Schema: public; Owner: northbr6
--

COMMENT ON COLUMN invitation.issuer_fk IS 'This identifies which user generate the invitation.';


--
-- Name: COLUMN invitation.type; Type: COMMENT; Schema: public; Owner: northbr6
--

COMMENT ON COLUMN invitation.type IS 'This identifies whether an invitation is specific to a single user email.';


--
-- Name: COLUMN invitation.organization_fk; Type: COMMENT; Schema: public; Owner: northbr6
--

COMMENT ON COLUMN invitation.organization_fk IS 'This identifies the organization that issued the invitation.';


--
-- Name: invitation_id_seq; Type: SEQUENCE; Schema: public; Owner: northbr6
--

CREATE SEQUENCE invitation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.invitation_id_seq OWNER TO northbr6;

--
-- Name: invitation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: northbr6
--

ALTER SEQUENCE invitation_id_seq OWNED BY invitation.id;


--
-- Name: invitation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbr6
--

SELECT pg_catalog.setval('invitation_id_seq', 40, true);


--
-- Name: invitation_organization; Type: TABLE; Schema: public; Owner: northbr6; Tablespace: 
--

CREATE TABLE invitation_organization (
    id integer NOT NULL,
    invitation_fk integer,
    organization_fk integer,
    create_dttm timestamp with time zone,
    update_dttm timestamp with time zone
);


ALTER TABLE public.invitation_organization OWNER TO northbr6;

--
-- Name: invitation_organization_id_seq; Type: SEQUENCE; Schema: public; Owner: northbr6
--

CREATE SEQUENCE invitation_organization_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.invitation_organization_id_seq OWNER TO northbr6;

--
-- Name: invitation_organization_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: northbr6
--

ALTER SEQUENCE invitation_organization_id_seq OWNED BY invitation_organization.id;


--
-- Name: invitation_organization_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbr6
--

SELECT pg_catalog.setval('invitation_organization_id_seq', 32, true);


--
-- Name: language_id_seq; Type: SEQUENCE; Schema: public; Owner: northbr6
--

CREATE SEQUENCE language_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.language_id_seq OWNER TO northbr6;

--
-- Name: language_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbr6
--

SELECT pg_catalog.setval('language_id_seq', 13, true);


--
-- Name: language; Type: TABLE; Schema: public; Owner: northbr6; Tablespace: 
--

CREATE TABLE language (
    id integer DEFAULT nextval('language_id_seq'::regclass) NOT NULL,
    language character varying(50) NOT NULL
);


ALTER TABLE public.language OWNER TO northbr6;

--
-- Name: location_id_seq; Type: SEQUENCE; Schema: public; Owner: northbr6
--

CREATE SEQUENCE location_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.location_id_seq OWNER TO northbr6;

--
-- Name: location_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbr6
--

SELECT pg_catalog.setval('location_id_seq', 465, true);


--
-- Name: location; Type: TABLE; Schema: public; Owner: northbr6; Tablespace: 
--

CREATE TABLE location (
    id integer DEFAULT nextval('location_id_seq'::regclass) NOT NULL,
    address1 character varying(50),
    address2 character varying(50),
    municipality character varying(50),
    region1 character varying(50),
    region2 character varying(50),
    country character varying(50),
    postal_code character varying(12),
    latitude character varying(20),
    longitude character varying(20),
    type character varying(20)
);


ALTER TABLE public.location OWNER TO northbr6;

--
-- Name: COLUMN location.region1; Type: COMMENT; Schema: public; Owner: northbr6
--

COMMENT ON COLUMN location.region1 IS 'In the US, put county here.';


--
-- Name: COLUMN location.region2; Type: COMMENT; Schema: public; Owner: northbr6
--

COMMENT ON COLUMN location.region2 IS 'In the US, put state here';


--
-- Name: organization; Type: TABLE; Schema: public; Owner: northbr6; Tablespace: 
--

CREATE TABLE organization (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    handle character varying(10),
    structure character varying(10),
    create_dttm timestamp with time zone,
    update_dttm timestamp with time zone,
    activate_dttm timestamp with time zone,
    suspend_dttm timestamp with time zone,
    tax_exempt boolean,
    status_fk integer NOT NULL,
    type character varying(50),
    contact_fk integer
);


ALTER TABLE public.organization OWNER TO northbr6;

--
-- Name: organization_contact_id_seq; Type: SEQUENCE; Schema: public; Owner: northbr6
--

CREATE SEQUENCE organization_contact_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.organization_contact_id_seq OWNER TO northbr6;

--
-- Name: organization_contact_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbr6
--

SELECT pg_catalog.setval('organization_contact_id_seq', 273, true);


--
-- Name: organization_contact; Type: TABLE; Schema: public; Owner: northbr6; Tablespace: 
--

CREATE TABLE organization_contact (
    id integer DEFAULT nextval('organization_contact_id_seq'::regclass) NOT NULL,
    organization_fk integer NOT NULL,
    contact_fk integer NOT NULL
);


ALTER TABLE public.organization_contact OWNER TO northbr6;

--
-- Name: organization_id_seq; Type: SEQUENCE; Schema: public; Owner: northbr6
--

CREATE SEQUENCE organization_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.organization_id_seq OWNER TO northbr6;

--
-- Name: organization_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: northbr6
--

ALTER SEQUENCE organization_id_seq OWNED BY organization.id;


--
-- Name: organization_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbr6
--

SELECT pg_catalog.setval('organization_id_seq', 277, true);


--
-- Name: organization_language_id_seq; Type: SEQUENCE; Schema: public; Owner: northbr6
--

CREATE SEQUENCE organization_language_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.organization_language_id_seq OWNER TO northbr6;

--
-- Name: organization_language_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbr6
--

SELECT pg_catalog.setval('organization_language_id_seq', 119, true);


--
-- Name: organization_language; Type: TABLE; Schema: public; Owner: northbr6; Tablespace: 
--

CREATE TABLE organization_language (
    id integer DEFAULT nextval('organization_language_id_seq'::regclass) NOT NULL,
    organization_fk integer NOT NULL,
    language_fk integer NOT NULL
);


ALTER TABLE public.organization_language OWNER TO northbr6;

--
-- Name: organization_location_id_seq; Type: SEQUENCE; Schema: public; Owner: northbr6
--

CREATE SEQUENCE organization_location_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.organization_location_id_seq OWNER TO northbr6;

--
-- Name: organization_location_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbr6
--

SELECT pg_catalog.setval('organization_location_id_seq', 465, true);


--
-- Name: organization_location; Type: TABLE; Schema: public; Owner: northbr6; Tablespace: 
--

CREATE TABLE organization_location (
    id integer DEFAULT nextval('organization_location_id_seq'::regclass) NOT NULL,
    organization_fk integer NOT NULL,
    location_fk integer NOT NULL
);


ALTER TABLE public.organization_location OWNER TO northbr6;

--
-- Name: organization_organization; Type: TABLE; Schema: public; Owner: northbr6; Tablespace: 
--

CREATE TABLE organization_organization (
    id integer NOT NULL,
    organization_from_fk integer NOT NULL,
    organization_to_fk integer NOT NULL,
    relationship character varying(10) NOT NULL,
    create_dttm timestamp with time zone DEFAULT now() NOT NULL,
    update_dttm timestamp with time zone
);


ALTER TABLE public.organization_organization OWNER TO northbr6;

--
-- Name: organization_organization_id_seq; Type: SEQUENCE; Schema: public; Owner: northbr6
--

CREATE SEQUENCE organization_organization_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.organization_organization_id_seq OWNER TO northbr6;

--
-- Name: organization_organization_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: northbr6
--

ALTER SEQUENCE organization_organization_id_seq OWNED BY organization_organization.id;


--
-- Name: organization_organization_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbr6
--

SELECT pg_catalog.setval('organization_organization_id_seq', 270, true);


--
-- Name: organization_program_id_seq; Type: SEQUENCE; Schema: public; Owner: northbr6
--

CREATE SEQUENCE organization_program_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.organization_program_id_seq OWNER TO northbr6;

--
-- Name: organization_program_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbr6
--

SELECT pg_catalog.setval('organization_program_id_seq', 8, true);


--
-- Name: organization_program; Type: TABLE; Schema: public; Owner: northbr6; Tablespace: 
--

CREATE TABLE organization_program (
    id integer DEFAULT nextval('organization_program_id_seq'::regclass) NOT NULL,
    organization_fk integer NOT NULL,
    program_fk integer NOT NULL
);


ALTER TABLE public.organization_program OWNER TO northbr6;

--
-- Name: organization_topic_id_seq; Type: SEQUENCE; Schema: public; Owner: northbr6
--

CREATE SEQUENCE organization_topic_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.organization_topic_id_seq OWNER TO northbr6;

--
-- Name: organization_topic_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbr6
--

SELECT pg_catalog.setval('organization_topic_id_seq', 947, true);


--
-- Name: organization_topic; Type: TABLE; Schema: public; Owner: northbr6; Tablespace: 
--

CREATE TABLE organization_topic (
    id integer DEFAULT nextval('organization_topic_id_seq'::regclass) NOT NULL,
    organization_fk integer NOT NULL,
    program_fk integer,
    topic_fk integer NOT NULL
);


ALTER TABLE public.organization_topic OWNER TO northbr6;

--
-- Name: COLUMN organization_topic.program_fk; Type: COMMENT; Schema: public; Owner: northbr6
--

COMMENT ON COLUMN organization_topic.program_fk IS 'Optional to constrain this topic to a particular program. ';


--
-- Name: person_id_seq; Type: SEQUENCE; Schema: public; Owner: northbr6
--

CREATE SEQUENCE person_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.person_id_seq OWNER TO northbr6;

--
-- Name: person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbr6
--

SELECT pg_catalog.setval('person_id_seq', 1, false);


--
-- Name: privilege; Type: TABLE; Schema: public; Owner: northbr6; Tablespace: 
--

CREATE TABLE privilege (
    id integer NOT NULL,
    name character varying(20) NOT NULL,
    description character varying(100)
);


ALTER TABLE public.privilege OWNER TO northbr6;

--
-- Name: privilege_id_seq; Type: SEQUENCE; Schema: public; Owner: northbr6
--

CREATE SEQUENCE privilege_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.privilege_id_seq OWNER TO northbr6;

--
-- Name: privilege_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: northbr6
--

ALTER SEQUENCE privilege_id_seq OWNED BY privilege.id;


--
-- Name: privilege_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbr6
--

SELECT pg_catalog.setval('privilege_id_seq', 1, true);


--
-- Name: program_id_seq; Type: SEQUENCE; Schema: public; Owner: northbr6
--

CREATE SEQUENCE program_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.program_id_seq OWNER TO northbr6;

--
-- Name: program_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbr6
--

SELECT pg_catalog.setval('program_id_seq', 8, true);


--
-- Name: program; Type: TABLE; Schema: public; Owner: northbr6; Tablespace: 
--

CREATE TABLE program (
    id integer DEFAULT nextval('program_id_seq'::regclass) NOT NULL,
    description character varying(1000),
    name character varying(50)
);


ALTER TABLE public.program OWNER TO northbr6;

--
-- Name: program_language_id_seq; Type: SEQUENCE; Schema: public; Owner: northbr6
--

CREATE SEQUENCE program_language_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.program_language_id_seq OWNER TO northbr6;

--
-- Name: program_language_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbr6
--

SELECT pg_catalog.setval('program_language_id_seq', 1, false);


--
-- Name: program_language; Type: TABLE; Schema: public; Owner: northbr6; Tablespace: 
--

CREATE TABLE program_language (
    id integer DEFAULT nextval('program_language_id_seq'::regclass) NOT NULL,
    program_fk integer NOT NULL,
    language_fk integer NOT NULL
);


ALTER TABLE public.program_language OWNER TO northbr6;

--
-- Name: role; Type: TABLE; Schema: public; Owner: northbr6; Tablespace: 
--

CREATE TABLE role (
    id integer NOT NULL,
    name character varying(15) NOT NULL,
    description character varying(100) NOT NULL
);


ALTER TABLE public.role OWNER TO northbr6;

--
-- Name: role_id_seq; Type: SEQUENCE; Schema: public; Owner: northbr6
--

CREATE SEQUENCE role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.role_id_seq OWNER TO northbr6;

--
-- Name: role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: northbr6
--

ALTER SEQUENCE role_id_seq OWNED BY role.id;


--
-- Name: role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbr6
--

SELECT pg_catalog.setval('role_id_seq', 5, true);


--
-- Name: role_privilege; Type: TABLE; Schema: public; Owner: northbr6; Tablespace: 
--

CREATE TABLE role_privilege (
    role_id_fk integer NOT NULL,
    privilege_id_fk integer NOT NULL
);


ALTER TABLE public.role_privilege OWNER TO northbr6;

--
-- Name: status; Type: TABLE; Schema: public; Owner: northbr6; Tablespace: 
--

CREATE TABLE status (
    id integer NOT NULL,
    name character varying(10) NOT NULL,
    description character varying(100)
);


ALTER TABLE public.status OWNER TO northbr6;

--
-- Name: status_id_seq; Type: SEQUENCE; Schema: public; Owner: northbr6
--

CREATE SEQUENCE status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.status_id_seq OWNER TO northbr6;

--
-- Name: status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: northbr6
--

ALTER SEQUENCE status_id_seq OWNED BY status.id;


--
-- Name: status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbr6
--

SELECT pg_catalog.setval('status_id_seq', 2, true);


--
-- Name: topic_id_seq; Type: SEQUENCE; Schema: public; Owner: northbr6
--

CREATE SEQUENCE topic_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.topic_id_seq OWNER TO northbr6;

--
-- Name: topic_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbr6
--

SELECT pg_catalog.setval('topic_id_seq', 41, true);


--
-- Name: topic; Type: TABLE; Schema: public; Owner: northbr6; Tablespace: 
--

CREATE TABLE topic (
    id integer DEFAULT nextval('topic_id_seq'::regclass) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.topic OWNER TO northbr6;

--
-- Name: user; Type: TABLE; Schema: public; Owner: northbr6; Tablespace: 
--

CREATE TABLE "user" (
    id integer NOT NULL,
    uuid uuid NOT NULL,
    username character varying(12),
    password character varying(12),
    fname character varying(50),
    mname character varying(50),
    lname character varying(50),
    create_dttm timestamp with time zone NOT NULL,
    update_dttm timestamp with time zone,
    activate_dttm timestamp with time zone,
    suspend_dttm timestamp with time zone,
    status_fk integer NOT NULL,
    nickname character varying(50),
    email character varying(50),
    sms character varying(10),
    enable_email boolean DEFAULT false NOT NULL,
    enable_sms boolean DEFAULT false NOT NULL,
    contact_fk integer
);


ALTER TABLE public."user" OWNER TO northbr6;

--
-- Name: COLUMN "user".email; Type: COMMENT; Schema: public; Owner: northbr6
--

COMMENT ON COLUMN "user".email IS 'Drop this in favor of user_contact';


--
-- Name: COLUMN "user".sms; Type: COMMENT; Schema: public; Owner: northbr6
--

COMMENT ON COLUMN "user".sms IS 'Drop this in favor of user_contact';


--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: northbr6
--

CREATE SEQUENCE user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO northbr6;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: northbr6
--

ALTER SEQUENCE user_id_seq OWNED BY "user".id;


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbr6
--

SELECT pg_catalog.setval('user_id_seq', 99, true);


--
-- Name: user_organization; Type: TABLE; Schema: public; Owner: northbr6; Tablespace: 
--

CREATE TABLE user_organization (
    id integer NOT NULL,
    user_fk integer NOT NULL,
    organization_fk integer,
    grantor_fk integer NOT NULL,
    create_dttm timestamp with time zone DEFAULT now() NOT NULL,
    update_dttm timestamp with time zone,
    role_fk integer NOT NULL
);


ALTER TABLE public.user_organization OWNER TO northbr6;

--
-- Name: user_organization_id_seq; Type: SEQUENCE; Schema: public; Owner: northbr6
--

CREATE SEQUENCE user_organization_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.user_organization_id_seq OWNER TO northbr6;

--
-- Name: user_organization_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: northbr6
--

ALTER SEQUENCE user_organization_id_seq OWNED BY user_organization.id;


--
-- Name: user_organization_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbr6
--

SELECT pg_catalog.setval('user_organization_id_seq', 100, true);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY invitation ALTER COLUMN id SET DEFAULT nextval('invitation_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY invitation_organization ALTER COLUMN id SET DEFAULT nextval('invitation_organization_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY organization ALTER COLUMN id SET DEFAULT nextval('organization_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY organization_organization ALTER COLUMN id SET DEFAULT nextval('organization_organization_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY privilege ALTER COLUMN id SET DEFAULT nextval('privilege_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY role ALTER COLUMN id SET DEFAULT nextval('role_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY status ALTER COLUMN id SET DEFAULT nextval('status_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY "user" ALTER COLUMN id SET DEFAULT nextval('user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY user_organization ALTER COLUMN id SET DEFAULT nextval('user_organization_id_seq'::regclass);


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: northbr6
--

INSERT INTO category VALUES (1, 'Health Program Topics', 18);


--
-- Data for Name: category_topic; Type: TABLE DATA; Schema: public; Owner: northbr6
--

INSERT INTO category_topic VALUES (1, 1, 1);
INSERT INTO category_topic VALUES (2, 1, 2);
INSERT INTO category_topic VALUES (3, 1, 3);
INSERT INTO category_topic VALUES (4, 1, 4);
INSERT INTO category_topic VALUES (5, 1, 5);
INSERT INTO category_topic VALUES (6, 1, 6);
INSERT INTO category_topic VALUES (7, 1, 7);
INSERT INTO category_topic VALUES (8, 1, 8);
INSERT INTO category_topic VALUES (9, 1, 9);
INSERT INTO category_topic VALUES (10, 1, 10);
INSERT INTO category_topic VALUES (11, 1, 11);
INSERT INTO category_topic VALUES (12, 1, 12);
INSERT INTO category_topic VALUES (13, 1, 13);
INSERT INTO category_topic VALUES (14, 1, 14);
INSERT INTO category_topic VALUES (15, 1, 15);
INSERT INTO category_topic VALUES (16, 1, 16);
INSERT INTO category_topic VALUES (17, 1, 17);
INSERT INTO category_topic VALUES (18, 1, 18);
INSERT INTO category_topic VALUES (19, 1, 19);
INSERT INTO category_topic VALUES (20, 1, 20);
INSERT INTO category_topic VALUES (21, 1, 21);
INSERT INTO category_topic VALUES (22, 1, 22);
INSERT INTO category_topic VALUES (23, 1, 23);
INSERT INTO category_topic VALUES (24, 1, 24);
INSERT INTO category_topic VALUES (25, 1, 25);
INSERT INTO category_topic VALUES (26, 1, 26);
INSERT INTO category_topic VALUES (27, 1, 27);
INSERT INTO category_topic VALUES (28, 1, 28);
INSERT INTO category_topic VALUES (29, 1, 29);
INSERT INTO category_topic VALUES (30, 1, 30);
INSERT INTO category_topic VALUES (31, 1, 31);
INSERT INTO category_topic VALUES (32, 1, 32);
INSERT INTO category_topic VALUES (33, 1, 33);
INSERT INTO category_topic VALUES (34, 1, 34);
INSERT INTO category_topic VALUES (35, 1, 35);
INSERT INTO category_topic VALUES (36, 1, 36);
INSERT INTO category_topic VALUES (37, 1, 37);
INSERT INTO category_topic VALUES (38, 1, 38);
INSERT INTO category_topic VALUES (39, 1, 39);
INSERT INTO category_topic VALUES (40, 1, 40);
INSERT INTO category_topic VALUES (41, 1, 41);


--
-- Data for Name: contact; Type: TABLE DATA; Schema: public; Owner: northbr6
--

INSERT INTO contact VALUES (11, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (45, 'null', NULL, 'null', 'null', NULL, 'null', NULL, 'Rev. Marilyn Pagan Banks');
INSERT INTO contact VALUES (46, 'null', NULL, 'null', 'http://www.accessliving.org/', NULL, 'null', NULL, 'Ms. Rahnee Patrick');
INSERT INTO contact VALUES (47, 'null', NULL, '7737828464', 'http://www.familialatinaunida.org/', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (48, 'null', NULL, 'null', 'null', NULL, 'null', NULL, 'Corky DeBoer, Manager of Spiritual Services');
INSERT INTO contact VALUES (49, 'darlene.zec@advocatehealth.com', NULL, 'null', 'null', NULL, 'null', NULL, 'Darlene Zec');
INSERT INTO contact VALUES (50, 'null', NULL, '6305729393', 'http://www.advocatehealth.com/', NULL, 'null', NULL, 'Rev. Bonnie Condon');
INSERT INTO contact VALUES (51, 'nancy.durbin@advocatehealth.com', NULL, '8473843749', 'http://www.advocatehealth.com/', NULL, '8476960239', NULL, 'Nancy Durbin Director, Parish Nurse Ministry');
INSERT INTO contact VALUES (52, 'null', NULL, 'null', 'null', NULL, 'null', NULL, 'Minister Chris Church');
INSERT INTO contact VALUES (53, 'pastor@africancommunityumc.org', NULL, '7732627881', 'http://www.africancommunityumc.org/', NULL, 'null', NULL, 'Rev. Amos Olidapo');
INSERT INTO contact VALUES (54, 'beverly.kimmons@alz.org', NULL, '8479332413', 'null', NULL, 'null', NULL, 'Beverly Kimmons');
INSERT INTO contact VALUES (55, 'null', NULL, '7734167328', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (56, 'kim.blechschmidt@ageoptions.org', NULL, '7083830258', 'http://www.ageoptions.org/', NULL, 'null', NULL, 'Ms. Lisa Blechschmidt');
INSERT INTO contact VALUES (57, 'null', NULL, 'null', 'http://www.alexianbrothershealth.org/parishservices', NULL, 'null', NULL, 'Rita Tippentrop, Assistant Director');
INSERT INTO contact VALUES (58, 'null', NULL, '8479332413', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (59, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (60, 'null', NULL, '8002272345', 'http://www.cancer.org/', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (61, 'null', NULL, '3124766619', 'null', NULL, 'null', NULL, 'Debra Davis, Director of Cultural Health Initiatives');
INSERT INTO contact VALUES (62, 'null', NULL, '3122248172', 'null', NULL, '3122389464', NULL, '');
INSERT INTO contact VALUES (63, 'null', NULL, 'null', 'http://www.antiochteleguchurch.org/', NULL, 'null', NULL, 'Rev. David Sagar');
INSERT INTO contact VALUES (64, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (65, 'sistuhgsp@yahoo.com', NULL, '7733738500', 'null', NULL, '3128649007', NULL, 'Geraldine Peacock, Health Ministry Coordinator');
INSERT INTO contact VALUES (66, 'rabbi@bybs.org', NULL, '7087994110', 'http://www.bybs.org/', NULL, 'null', NULL, 'Rabbi Ellen Dreyfus');
INSERT INTO contact VALUES (67, 'revcwj2000@sbcglobal.net', NULL, '7735224812', 'null', NULL, '7735224812', NULL, 'Cynthia Johnson, Pastor');
INSERT INTO contact VALUES (68, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (69, 'TraceyKite@jcfs.org', NULL, '8475685216', 'http://www.jcfs.org/', NULL, '5475685100', NULL, 'Tracey Kite Director, Jewish Healing Network of Chicago');
INSERT INTO contact VALUES (70, 'null', NULL, '3123649071', 'http://www.networkofstrength.org/illinois', NULL, '3123649066', NULL, '');
INSERT INTO contact VALUES (71, 'yahmeihsieh@gmail.com', NULL, '6309636601', 'http://www.us.tzuchi.org/', NULL, 'null', NULL, 'Ms. Yahmei Hsieh');
INSERT INTO contact VALUES (72, 'faithcaucus@cbhconline.org', NULL, '3129139449', 'http://www.cbhconline.org/faith', NULL, '3129139559', NULL, 'Laura Leon, Director of Faith Initiatives');
INSERT INTO contact VALUES (73, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (74, 'dave_roth@lcfs.org', NULL, '7084885581', 'null', NULL, 'null', NULL, 'Rev. Dave Roth');
INSERT INTO contact VALUES (75, 'null', NULL, '7732446201', 'http://www.northpark.edu/sem/academics/faculty/mchasez.html', NULL, '7732446244', NULL, 'Mary Chase-Ziolek, PhD, RN Director, Professor of Health Ministries');
INSERT INTO contact VALUES (76, 'pastor@iglesiabautistacentral.org', NULL, '7733420836', 'http://www.iglesiabautistacentral.org/', NULL, 'null', NULL, 'Rev. Shakespeare Osorio');
INSERT INTO contact VALUES (77, 'chicagochinbaptistchurch@gmail.com', NULL, '7736033263', 'null', NULL, 'null', NULL, 'Pastor Danny Bawi Thianhlun');
INSERT INTO contact VALUES (78, 'dderylak@ctschicago.edu', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (79, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (80, 'pillaishanker@gmail.com', NULL, '6306533370', 'http://www.mychinmaya.org/', NULL, 'null', NULL, 'Mr. Shanker Pillai');
INSERT INTO contact VALUES (81, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (82, 'sguy178525@aol.com', NULL, '3129393720', 'null', NULL, '3123213027', NULL, 'Sandra Guy, Leadership team member');
INSERT INTO contact VALUES (83, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (84, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (85, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (86, 'null', NULL, '3129066196', 'null', NULL, '3129066123', NULL, 'Marty Hatlie, CEO');
INSERT INTO contact VALUES (87, 'blwater@dupagehealth.org', NULL, '6306827979', 'null', NULL, 'null', NULL, 'Bette Lawrence Water, Program Manager');
INSERT INTO contact VALUES (88, 'MAriyo@cityforce.org', NULL, '7734734100', 'http://www.ilfba.org/', NULL, '7734734200', NULL, 'Michele Ariyo');
INSERT INTO contact VALUES (89, 'kirsten.peachey@advocatehealth.com', NULL, '8473843552', 'http://www.advocatehealth.com/', NULL, '8476960239', NULL, 'Rev. Kirsten Peachey');
INSERT INTO contact VALUES (90, 'veronica@faithinplace.org', NULL, '3127334640', 'http://faithinplace.org/', NULL, '3127334610', NULL, '');
INSERT INTO contact VALUES (91, 'pastorcucc@sbcglobal.net', NULL, 'null', 'http://www.congucc.org/', NULL, 'null', NULL, 'Pastor Rex Piercy');
INSERT INTO contact VALUES (92, 'null', NULL, '3125737749', 'null', NULL, 'null', NULL, 'Rev. James Kenady, Lead Community Liaison');
INSERT INTO contact VALUES (93, 'sramsey@jpusa.org', NULL, '7735066396', 'http://www.ccolife.org/', NULL, 'null', NULL, 'Ms. Sandy Ramsey');
INSERT INTO contact VALUES (94, 'null', NULL, 'null', 'http://www.ciogc.org/', NULL, 'null', NULL, 'Ms. Ahlam Jbara');
INSERT INTO contact VALUES (95, 'BROM-ChurchRelations@advocatehealth.com', NULL, '3092685499', 'http://www.advocatehealth.com/bromenn/churchrelations', NULL, 'null', NULL, 'The Rev. Cheree'' Johnson');
INSERT INTO contact VALUES (96, 'null', NULL, '6306827979', 'null', NULL, '6304629085', NULL, '');
INSERT INTO contact VALUES (97, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (98, 'null', NULL, '7735618496', 'null', NULL, '7735618001', NULL, '');
INSERT INTO contact VALUES (99, 'macphie@sbcglobal.net', NULL, '7735614748', 'http://www.edgewaterpres.org/', NULL, 'null', NULL, 'Rev. Dr. Barb Cathey');
INSERT INTO contact VALUES (100, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (101, 'epworthchicago@gmail.com', NULL, 'null', 'http://www.epworthchicago.org/', NULL, 'null', NULL, 'Rev. Amos Olidapo');
INSERT INTO contact VALUES (102, 'hesed333@yahoo.com', NULL, '8475374449', 'http://www.egreenpc.org/', NULL, 'null', NULL, 'Rev. Yun Chun Han');
INSERT INTO contact VALUES (103, 'null', NULL, '8472089544', 'http://www.exoduschurch.org/', NULL, 'null', NULL, 'Rev. Dr. Jeremiah Yi');
INSERT INTO contact VALUES (104, 'lleon@cbhconline.org', NULL, '3129139449', 'http://www.cbhconline.org/issues/hcjc/faith.html', NULL, '3129139559', NULL, '');
INSERT INTO contact VALUES (105, 'null', NULL, '3127264948', 'http://www.faithinplace.org/', NULL, '3127266108', NULL, '');
INSERT INTO contact VALUES (106, 'null', NULL, '7738461056', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (107, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (108, 'null', NULL, '3129884850', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (109, 'null', NULL, '7087498800', 'null', NULL, 'null', NULL, 'Rev. Dr. Damon Jones');
INSERT INTO contact VALUES (110, 'fbclagrange@sbcglobal.net', NULL, 'null', 'http://www.fbclagrange.com/', NULL, 'null', NULL, 'Rev. Michael Strickland');
INSERT INTO contact VALUES (111, 'pastorfbc@yahoo.com', NULL, '7087482566', 'http://www.fbcparkforest.org/', NULL, 'null', NULL, 'Rev. Carol Jamieson Brown');
INSERT INTO contact VALUES (112, 'null', NULL, 'null', 'http://www.wscongo.org/', NULL, 'null', NULL, 'Deborah Stankiewicz, AHC Parish Nurse');
INSERT INTO contact VALUES (113, 'bshereos@firstfree.com', NULL, 'null', 'http://www.firstfree.com/', NULL, 'null', NULL, 'Rev. Bill Shereos');
INSERT INTO contact VALUES (114, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (115, 'newbethlehem@gmail.com', NULL, '7734886053', 'null', NULL, '7736021559', NULL, 'The Rev. Rickey Kendrick, Executive Director');
INSERT INTO contact VALUES (116, 'null', NULL, '7087982800', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (117, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (118, 'null', NULL, '3124551000', 'null', NULL, '3124559674', NULL, 'Heather Dudzinski, Community Outreach Coordinator');
INSERT INTO contact VALUES (119, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (120, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (121, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (122, 'rodneycwalker@yahoo.com', NULL, '7737835145', 'null', NULL, 'null', NULL, 'Rev. Rodney C. Walker');
INSERT INTO contact VALUES (123, 'rodneycwalker@yahoo.com', NULL, '7737835145', 'null', NULL, 'null', NULL, 'Rev. Rodney C. Walker');
INSERT INTO contact VALUES (124, 'gracevillapark@yahoo.com', NULL, 'null', 'null', NULL, 'null', NULL, 'Pastor Jade Yi');
INSERT INTO contact VALUES (125, 'null', NULL, 'null', 'http://www.graceriverforest.org/', NULL, 'null', NULL, 'Dr. MaryBeth Buschmann');
INSERT INTO contact VALUES (126, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (127, 'null', NULL, 'null', 'null', NULL, 'null', NULL, 'Charlayne Guy Moore');
INSERT INTO contact VALUES (128, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (129, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (130, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (131, 'null', NULL, '7735224812', 'null', NULL, '7735224812', NULL, '');
INSERT INTO contact VALUES (132, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (133, 'ksidd@hamdardcenter.org', NULL, '7734654600', 'http://www.hamdardcenter.org/', NULL, 'null', NULL, 'Ms. Kiran Siddiqui');
INSERT INTO contact VALUES (134, 'null', NULL, '7084848541', 'null', NULL, '7084843179', NULL, 'Carmen Carrizales, Health Initiatives Representative');
INSERT INTO contact VALUES (135, 'mbcukley@hcionline.org', NULL, '7088419515', 'null', NULL, '7088419713', NULL, 'Mayme Buckley, Associate Director, Interfaith and Development');
INSERT INTO contact VALUES (136, 'Laura@HealthyDinning.org', NULL, '3126669979', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (137, 'null', NULL, '3122797278', 'null', NULL, 'null', NULL, 'Desmond Konadu, Senior Health Initiatives Representative');
INSERT INTO contact VALUES (138, 'maria.oquendo@advocatehealth.com', NULL, '7732967157', 'http://www.hispanocare.org/', NULL, '7733278208', NULL, 'Maria Oquendo, Coordinator');
INSERT INTO contact VALUES (139, 'eric.chua@juno.com', NULL, '7732882677', 'http://www.hydeparkcrc.org/', NULL, 'null', NULL, 'Mr. Eric Chua');
INSERT INTO contact VALUES (140, 'null', NULL, 'null', 'http://www.idph.state.il.us/planready/index.htm', NULL, 'null', NULL, 'Dr. Leon Dingle');
INSERT INTO contact VALUES (141, 'null', NULL, '3124918161', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (142, 'alozanoff@illinoispirg.org', NULL, '3122910441', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (143, 'null', NULL, '3125031764', 'null', NULL, '3125061764', NULL, 'Sarah Bristol-Gould Director, Research Programs; IL Women''s Health Registry');
INSERT INTO contact VALUES (144, 'null', NULL, '7732752520', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (145, 'shamar@imancentral.org', NULL, '7734344626', 'http://www.imancentral.org/', NULL, 'null', NULL, 'Mr. Shamar Hemphill');
INSERT INTO contact VALUES (146, 'null', NULL, '3125031308', 'null', NULL, '3125031764', NULL, '');
INSERT INTO contact VALUES (147, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (148, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (149, 'nizar.jiwani@gmail.com', NULL, '7732621616', 'null', NULL, 'null', NULL, 'Mr. Nizar Jawani');
INSERT INTO contact VALUES (150, 'nizar.jiwani@gmail.com', NULL, '3123995713', 'null', NULL, 'null', NULL, 'Mr. Nizar Jiwani, Communications Director');
INSERT INTO contact VALUES (151, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (152, 'null', NULL, '7734673700', 'http://www.jcfs.org/', NULL, 'null', NULL, 'Ms. Robin Levine');
INSERT INTO contact VALUES (153, 'null', NULL, 'null', 'http://www.juf.org/guide/category.aspx?id=31892', NULL, 'null', NULL, 'Ms. Charlotte Mallon');
INSERT INTO contact VALUES (154, 'null', NULL, '8475685216', 'http://www.jcfs.org/', NULL, '8475685125', NULL, '');
INSERT INTO contact VALUES (155, 'null', NULL, '7732572324', 'null', NULL, 'null', NULL, 'Maureen Benjamins Senior Epidemiologist');
INSERT INTO contact VALUES (156, 'null', NULL, '7735330034', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (157, 'null', NULL, 'null', 'http://www.journeytogether.org/', NULL, 'null', NULL, 'Rev. Daniel Park');
INSERT INTO contact VALUES (158, 'joytobefitboom@sbcaol.com', NULL, '7083662633', 'null', NULL, 'null', NULL, 'Stephanie Jackson-Rowe, Founder and President');
INSERT INTO contact VALUES (159, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (160, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (161, 'null', NULL, '7083444470', 'null', NULL, '7083444564', NULL, '');
INSERT INTO contact VALUES (162, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (163, 'null', NULL, '3123649071', 'http://www.networkofstrength.org/illinois', NULL, '3123649066', NULL, 'Judy Guitelman, Program Coordinator');
INSERT INTO contact VALUES (164, 'null', NULL, '7083969777', 'null', NULL, '7083969732', NULL, '');
INSERT INTO contact VALUES (165, 'null', NULL, '3129156811', 'null', NULL, '3129156485', NULL, 'Mary Burns, Community Projects Director');
INSERT INTO contact VALUES (166, 'null', NULL, '3129156811', 'http://www.leadsafeillinois.org/', NULL, '3129156485', NULL, '');
INSERT INTO contact VALUES (167, 'illconfmontes@aol.com', NULL, '7083444470', 'http://www.uccillconf.org/', NULL, '7083444564', NULL, 'Jorge Montes, Reverend');
INSERT INTO contact VALUES (168, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (169, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (170, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (171, 'null', NULL, '3124551000', 'http://www.littlebrotherschicago.org/', NULL, '3124559674', NULL, '');
INSERT INTO contact VALUES (172, 'null', NULL, '7733791750', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (173, 'null', NULL, '7736554357', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (174, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (175, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (176, 'null', NULL, 'null', 'http://www.advocatehealth.com/lgch/', NULL, 'null', NULL, 'Rev. Kathi Bender Schwich');
INSERT INTO contact VALUES (177, 'null', NULL, 'null', 'http://www.lssi.org/', NULL, 'null', NULL, 'Daniel Schwick, V.P Church and Community');
INSERT INTO contact VALUES (178, 'cnicholas@kidneyfund.org', NULL, '3122248172', 'null', NULL, 'null', NULL, 'Courtney Nicholas, Associate Director');
INSERT INTO contact VALUES (179, 'null', NULL, '7086477658', 'null', NULL, 'null', NULL, 'Vicki Burke, Founder of the Ministry to New Moms');
INSERT INTO contact VALUES (180, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (181, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (182, 'info@mosquefoundation.org', NULL, 'null', 'http://www.mosquefoundation.org/', NULL, 'null', NULL, 'Imam Kifah Mustapha');
INSERT INTO contact VALUES (183, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (184, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (185, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (186, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (187, 'null', NULL, '7734931847', 'null', NULL, 'null', NULL, 'Rev. Dr. Biak Mang');
INSERT INTO contact VALUES (188, 'null', NULL, '3123942860', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (189, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (190, 'null', NULL, '7738389470', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (191, 'null', NULL, '7733847113', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (192, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (193, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (194, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (195, 'null', NULL, '7732446201', 'null', NULL, '7732446244', NULL, '');
INSERT INTO contact VALUES (196, 'cmvetty@northshorebaptist.org', NULL, '7737284200', 'http://www.northshorebaptist.org/', NULL, 'null', NULL, 'Ms. Dawn Noldan/Mrs. Emy Kosmas');
INSERT INTO contact VALUES (197, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (198, 'null', NULL, '8478085700', 'null', NULL, 'null', NULL, 'Rev. Bumhoon (John) Lee');
INSERT INTO contact VALUES (199, 'goodnewskitchen@sbcglobal.net', NULL, '7732622297', 'http://www.gnck.org/', NULL, '7732627872', NULL, 'Marilyn Pagan-Banks, Executive Director');
INSERT INTO contact VALUES (200, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (201, 'null', NULL, 'null', 'null', NULL, 'null', NULL, 'Dana Bright Community Health Coordinator');
INSERT INTO contact VALUES (202, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (203, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (204, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (205, 'null', NULL, 'null', 'null', NULL, 'null', NULL, 'Brett McCleneghan, Senior Minister');
INSERT INTO contact VALUES (206, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (207, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (208, 'null', NULL, '7737846633', 'null', NULL, 'null', NULL, 'Rev. Jean Darling');
INSERT INTO contact VALUES (209, 'office@pilgrimfaith.org', NULL, 'null', 'http://www.pilgrimfaith.org/', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (210, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (211, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (212, 'null', NULL, '3123649071', 'http://www.networkofstrength.org/illinois', NULL, '3123649066', NULL, 'Gabriela Kowalczyk, Program Coordinator');
INSERT INTO contact VALUES (213, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (214, 'null', NULL, '3124134609', 'null', NULL, '3124134503', NULL, '');
INSERT INTO contact VALUES (215, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (216, 'davidwu@puitak.org', NULL, '3123281188', 'http://www.puitak.org/', NULL, 'null', NULL, 'Mr. David Wu');
INSERT INTO contact VALUES (217, 'admin@rahabshouse.net', NULL, '7735935896', 'http://www.rahabshouse.net/', NULL, 'null', NULL, 'Denise Henley, Rev./President');
INSERT INTO contact VALUES (218, 'Info@RainbowHospice.org', NULL, '8476859900', 'http://www.rainbowhospice.org/', NULL, '8472949613', NULL, 'Dave Samson');
INSERT INTO contact VALUES (219, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (220, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (221, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (222, 'null', NULL, '8007570202', 'null', NULL, '3129426116', NULL, '');
INSERT INTO contact VALUES (223, 'null', NULL, '7733712300', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (224, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (225, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (226, 'null', NULL, '7732572324', 'null', NULL, '7732575680', NULL, '');
INSERT INTO contact VALUES (227, 'null', NULL, '7087984150', 'null', NULL, 'null', NULL, 'Re. Kris Orr');
INSERT INTO contact VALUES (228, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (229, 'null', NULL, '3123377111', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (230, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (231, 'null', NULL, 'null', 'null', NULL, 'null', NULL, 'Rev. Thomas Bishop');
INSERT INTO contact VALUES (232, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (233, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (234, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (235, 'mjh816@sbcglobal.net', NULL, '7735615343', 'http://www.saintita.org/', NULL, 'null', NULL, 'Sr. Mary Jeanne Hayes');
INSERT INTO contact VALUES (236, 'stjames.pastor@gmail.com', NULL, 'null', 'http://www.stjamesws.org/', NULL, 'null', NULL, 'Pastor Erin Clausen');
INSERT INTO contact VALUES (237, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (238, 'office@churchonthepark.com', NULL, '8472556687', 'null', NULL, '8472556388', NULL, '');
INSERT INTO contact VALUES (239, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (240, 'null', NULL, '7732355420', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (241, 'null', NULL, 'null', 'null', NULL, 'null', NULL, 'Erik Christensen, Rev.');
INSERT INTO contact VALUES (242, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (243, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (244, 'jvg001@sbcglobal.net', NULL, 'null', 'http://www.stpaulsbylake.org/', NULL, 'null', NULL, 'Ms. Judith Gramer');
INSERT INTO contact VALUES (245, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (246, 'null', NULL, '7734834300', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (247, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (248, 'stsylvester@archchicago.org', NULL, '7732353646', 'http://stsylvesterparish.com/', NULL, 'null', NULL, 'Dora Albert');
INSERT INTO contact VALUES (249, 'null', NULL, '6306827979', 'http://www.scimc.org/', NULL, 'null', NULL, 'Mr. Bob Skrocki');
INSERT INTO contact VALUES (250, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (251, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (252, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (253, 'rev.eshin.patti23@gmail.com', NULL, '7733344661', 'http://www.budtempchi.org/', NULL, 'null', NULL, 'Rev. Patti Nakai');
INSERT INTO contact VALUES (254, 'null', NULL, '7083662633', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (255, 'null', NULL, '8472530501', 'http://www.thesouthchurch.com/', NULL, 'null', NULL, 'Rev. Rick Kessler');
INSERT INTO contact VALUES (256, 'sghughes@uic.edu', NULL, '3124137500', 'null', NULL, 'null', NULL, 'Contact: Sharon Greene-Hughes, Antenatal Testing Specialist, Maternal Fetal Medicine High Risk Nurse');
INSERT INTO contact VALUES (257, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (258, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (259, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (260, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (261, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (262, 'null', NULL, 'null', 'http://www.tpoint.org/', NULL, 'null', NULL, 'Ms. Ann Fisher Raney');
INSERT INTO contact VALUES (263, 'bliss@imaginechicago.org', NULL, 'null', 'http://www.ubumama.org/', NULL, 'null', NULL, 'Bliss Browne, President');
INSERT INTO contact VALUES (264, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (265, 'null', NULL, '7083381150', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (266, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (267, 'unitylutheran@ameritech.net', NULL, '7738784747', 'http://www.unitylutheranchicago.org/', NULL, 'null', NULL, 'Rev. Fred Kinsey');
INSERT INTO contact VALUES (268, 'null', NULL, 'null', 'http://www.unitynorthwest.org/', NULL, 'null', NULL, 'Rev. Greg Barrette');
INSERT INTO contact VALUES (269, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (270, 'null', NULL, '3129964656', 'null', NULL, '3129963848', NULL, 'Bertha Paul, School and Community Health Educator');
INSERT INTO contact VALUES (271, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (272, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (273, 'null', NULL, 'null', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (274, 'jlewis6@gmail.com', NULL, '7737860249', 'null', NULL, '7737860256', NULL, 'Janine Lewis, Director of Health Promotions');
INSERT INTO contact VALUES (275, 'null', NULL, '7083969777', 'null', NULL, 'null', NULL, '');
INSERT INTO contact VALUES (276, 'zehra_zamshope@yahoo.com', NULL, 'null', 'http://www.zamshope.net/', NULL, 'null', NULL, '');


--
-- Data for Name: forum_user; Type: TABLE DATA; Schema: public; Owner: northbr6
--

INSERT INTO forum_user VALUES (12, 88, 'Kathy', 'admin', 'Kathy Flint', 'contact@northbridgetech.org');
INSERT INTO forum_user VALUES (13, 89, 'Kirsten', 'change-me', 'Kirsten Peachey', 'fake@northbridgetech.org');


--
-- Data for Name: invitation; Type: TABLE DATA; Schema: public; Owner: northbr6
--

INSERT INTO invitation VALUES (40, '0037adaf-de43-af5e-95e2-b2dea2d05f49', NULL, '2014-08-01 09:42:24.015911-06', NULL, 18, NULL, 1, NULL, 85, 'global', 18);


--
-- Data for Name: invitation_organization; Type: TABLE DATA; Schema: public; Owner: northbr6
--



--
-- Data for Name: language; Type: TABLE DATA; Schema: public; Owner: northbr6
--

INSERT INTO language VALUES (1, 'Arabic');
INSERT INTO language VALUES (2, 'English');
INSERT INTO language VALUES (3, 'Farsi');
INSERT INTO language VALUES (4, 'Hebrew');
INSERT INTO language VALUES (5, 'Hindi');
INSERT INTO language VALUES (6, 'Japanese');
INSERT INTO language VALUES (7, 'Korean');
INSERT INTO language VALUES (8, 'Polish');
INSERT INTO language VALUES (9, 'Russian');
INSERT INTO language VALUES (10, 'Spanish');
INSERT INTO language VALUES (11, 'Tagalog');
INSERT INTO language VALUES (12, 'Telugu');
INSERT INTO language VALUES (13, 'Urdu');


--
-- Data for Name: location; Type: TABLE DATA; Schema: public; Owner: northbr6
--

INSERT INTO location VALUES (219, '2025 Windsor Drive', '', 'Oak Brook', NULL, 'Illinois', 'US', '60523', NULL, NULL, NULL);
INSERT INTO location VALUES (220, '205 W. Touhy Ave.', 'Suite 127', 'Park Ridge', NULL, 'Illinois', 'US', '60068', NULL, NULL, NULL);
INSERT INTO location VALUES (221, '2440 York', '', 'Blue Island', NULL, 'Illinois', 'US', '60406', NULL, NULL, NULL);
INSERT INTO location VALUES (222, '8430 W. Bryn Mawr Avenue', 'Suite 800', 'Chicago', NULL, 'Illinois', 'US', '60631', NULL, NULL, NULL);
INSERT INTO location VALUES (223, '2424 W. Lithuanian Plaza', '', 'Chicago', NULL, 'Illinois', 'US', '60629', NULL, NULL, NULL);
INSERT INTO location VALUES (224, '1048 Lake St.', 'Suite 300', 'Oak Park', NULL, 'Illinois', 'US', '60301', NULL, NULL, NULL);
INSERT INTO location VALUES (225, '25 E. Schaumburg Rd.', 'Suite 106', 'Schaumburg', NULL, 'Illinois', 'US', '60194', NULL, NULL, NULL);
INSERT INTO location VALUES (226, '8430 W. Bryn Mawr Avenue', 'Suite 800', 'Chicago', NULL, 'Illinois', 'US', '60631', NULL, NULL, NULL);
INSERT INTO location VALUES (227, '283 E. Lincoln Highway', '', 'Chicago Heights', NULL, 'Illinois', 'US', '60411', NULL, NULL, NULL);
INSERT INTO location VALUES (228, '208 S. LaSalle Street', 'Suite 900', 'Chicago', NULL, 'Illinois', 'US', '60604', NULL, NULL, NULL);
INSERT INTO location VALUES (8, '5730 W. Fullerton', '', 'Chicago', NULL, 'Illinois', 'US', '60639', NULL, NULL, NULL);
INSERT INTO location VALUES (9, '7649 North Paulina Street', '', 'Chicago', NULL, 'Illinois', 'US', '60626', NULL, NULL, NULL);
INSERT INTO location VALUES (10, '115 W. Chicago', '', 'Chicago', NULL, 'Illinois', 'US', '60654', NULL, NULL, NULL);
INSERT INTO location VALUES (11, '2716 W Division St', '', 'Chicago', NULL, 'Illinois', 'US', '60622', NULL, NULL, NULL);
INSERT INTO location VALUES (12, '4440 W. 95th St.', '', 'Oak Lawn', NULL, 'Illinois', 'US', '60453', NULL, NULL, NULL);
INSERT INTO location VALUES (13, '2025 Windsor Drive', '', 'Oak Brook', NULL, 'Illinois', 'US', '60523', NULL, NULL, NULL);
INSERT INTO location VALUES (229, '4259 S. Berkeley Avenue', '', 'Chicago', NULL, 'Illinois', 'US', '60653', NULL, NULL, NULL);
INSERT INTO location VALUES (230, '2788 Wolf Rd.', '', 'Northlake', NULL, 'Illinois', 'US', '60164', NULL, NULL, NULL);
INSERT INTO location VALUES (231, '3823 S. Indiana Ave', '', 'Chicago', NULL, 'Illinois', 'US', '60653', NULL, NULL, NULL);
INSERT INTO location VALUES (232, '3823 South Ind. Ave.', '', 'Chicago', NULL, 'Illinois', 'US', '60653', NULL, NULL, NULL);
INSERT INTO location VALUES (233, '1424 W. 183rd St.', '', 'Homewood', NULL, 'Illinois', 'US', '60430', NULL, NULL, NULL);
INSERT INTO location VALUES (234, '4236 W. Cermak RD', '', 'Chicago', NULL, 'Illinois', 'US', '60623', NULL, NULL, NULL);
INSERT INTO location VALUES (235, '5433 S. Austin', '', 'Chicago', NULL, 'Illinois', 'US', '60638', NULL, NULL, NULL);
INSERT INTO location VALUES (236, '5150 Golf Road', '', 'Skokie', NULL, 'Illinois', 'US', '60077', NULL, NULL, NULL);
INSERT INTO location VALUES (237, '300 W. Adams', 'Suite 430', 'Chicago', NULL, 'Illinois', 'US', '60606', NULL, NULL, NULL);
INSERT INTO location VALUES (238, '1430 Plainfield Rd.', '', 'Darien', NULL, 'Illinois', 'US', '60561', NULL, NULL, NULL);
INSERT INTO location VALUES (239, '1325 S. Wabash', 'Suite 305', 'Chicago', NULL, 'Illinois', 'US', '60605', NULL, NULL, NULL);
INSERT INTO location VALUES (240, '7620 Madison Ave.', '%LCFS', 'River Forest', NULL, 'Illinois', 'US', '60305', NULL, NULL, NULL);
INSERT INTO location VALUES (241, '3225 W. Foster Ave.', '', 'Chicago', NULL, 'Illinois', 'US', '60625', NULL, NULL, NULL);
INSERT INTO location VALUES (242, '2417 N. Campbell', '', 'Chicago', NULL, 'Illinois', 'US', '60647', NULL, NULL, NULL);
INSERT INTO location VALUES (243, '5255 N. Ashland', '', 'Chicago', NULL, 'Illinois', 'US', '60660', NULL, NULL, NULL);
INSERT INTO location VALUES (244, '5757 S. University Avenue', '', 'Chicago', NULL, 'Illinois', 'US', '60637', NULL, NULL, NULL);
INSERT INTO location VALUES (245, '4720 N. Sheridan Rd.', '', 'Chicago', NULL, 'Illinois', 'US', '60641', NULL, NULL, NULL);
INSERT INTO location VALUES (246, '11 S 80 Rte. 83', '', 'Willowbrook', NULL, 'Illinois', 'US', '60527', NULL, NULL, NULL);
INSERT INTO location VALUES (247, '14 S. Ashland Ave.', '', 'Chicago', NULL, 'Illinois', 'US', '60607', NULL, NULL, NULL);
INSERT INTO location VALUES (248, '4100 N. Long Ave.', '', 'Chicago', NULL, 'Illinois', 'US', '60641', NULL, NULL, NULL);
INSERT INTO location VALUES (249, '10724 S Ewing Ave', '', 'Chicago', NULL, 'Illinois', 'US', '60617', NULL, NULL, NULL);
INSERT INTO location VALUES (250, '3235 W. Wrightwood', '', 'Chicago', NULL, 'Illinois', 'US', '60647', NULL, NULL, NULL);
INSERT INTO location VALUES (251, '111 N. County Farm Road', '', 'Wheaton', NULL, 'Illinois', 'US', '60187', NULL, NULL, NULL);
INSERT INTO location VALUES (252, '9 N. Cicero', '', 'Chicago', NULL, 'Illinois', 'US', '60644', NULL, NULL, NULL);
INSERT INTO location VALUES (253, '205 W. Touhy Ave', 'Suite 127', 'Park Ridge', NULL, 'Illinois', 'US', '60068', NULL, NULL, NULL);
INSERT INTO location VALUES (254, '2532 W. Warren', '', 'Chicago', NULL, 'Illinois', 'US', '60612', NULL, NULL, NULL);
INSERT INTO location VALUES (255, '1001 W. Kirchhoff Rd.', '', 'Arlington Heights', NULL, 'Illinois', 'US', '60005', NULL, NULL, NULL);
INSERT INTO location VALUES (256, '2300 Children''s Plaza', '#157', 'Chicago', NULL, 'Illinois', 'US', '60614', NULL, NULL, NULL);
INSERT INTO location VALUES (257, '4615 N. Clifton Ave.', '', 'Chicago', NULL, 'Illinois', 'US', '60640', NULL, NULL, NULL);
INSERT INTO location VALUES (258, '231 S. State St.', '', 'Chicago', NULL, 'Illinois', 'US', '60604', NULL, NULL, NULL);
INSERT INTO location VALUES (259, '1304 Franklin Ave.', '', 'Normal', NULL, 'Illinois', 'US', '61761', NULL, NULL, NULL);
INSERT INTO location VALUES (260, '111 W. County Farm Road', '', 'Wheaton', NULL, 'Illinois', 'US', '60187', NULL, NULL, NULL);
INSERT INTO location VALUES (261, '4919 W. Lexington', '', 'Chicago', NULL, 'Illinois', 'US', '60644', NULL, NULL, NULL);
INSERT INTO location VALUES (262, '1650 W. Foster', '', 'Chicago', NULL, 'Illinois', 'US', '60643', NULL, NULL, NULL);
INSERT INTO location VALUES (263, '1020 W. Bryn Mawr', '', 'Chicago', NULL, 'Illinois', 'US', '60660', NULL, NULL, NULL);
INSERT INTO location VALUES (264, '6554 N. Rockwell Street', '', 'Chicago', NULL, 'Illinois', 'US', '60645', NULL, NULL, NULL);
INSERT INTO location VALUES (265, '5253 N. Kenmore Ave.', '', 'Chicago', NULL, 'Illinois', 'US', '60640', NULL, NULL, NULL);
INSERT INTO location VALUES (266, '196 Highland Ave.', '', 'Wheeling', NULL, 'Illinois', 'US', '60090', NULL, NULL, NULL);
INSERT INTO location VALUES (267, '385 S. Buffalo Grove Rd.', '', 'Buffalo Grove', NULL, 'Illinois', 'US', '60089', NULL, NULL, NULL);
INSERT INTO location VALUES (268, '1325 S. Wabash', '#305', 'Chicago', NULL, 'Illinois', 'US', '60605', NULL, NULL, NULL);
INSERT INTO location VALUES (269, '70 E. Lake St,', 'Suite 920', 'Chicago', NULL, 'Illinois', 'US', '60612', NULL, NULL, NULL);
INSERT INTO location VALUES (270, '7158 South Peoria Street', '', 'Chicago', NULL, 'Illinois', 'US', '60612', NULL, NULL, NULL);
INSERT INTO location VALUES (271, '15015 Grant St', '', 'Dolton', NULL, 'Illinois', 'US', '60419', NULL, NULL, NULL);
INSERT INTO location VALUES (272, '6916 W. 34th St.', '', 'Berwyn', NULL, 'Illinois', 'US', '60402', NULL, NULL, NULL);
INSERT INTO location VALUES (273, '20 N. Ashland Ave.', '', 'LaGrange', NULL, 'Illinois', 'US', '60525', NULL, NULL, NULL);
INSERT INTO location VALUES (274, '80 N. Orchard Ave.', '', 'Park Forest', NULL, 'Illinois', 'US', '60466', NULL, NULL, NULL);
INSERT INTO location VALUES (275, '1106 Chestnut St.', '', 'Western Springs', NULL, 'Illinois', 'US', '60558', NULL, NULL, NULL);
INSERT INTO location VALUES (276, '5255 N. Ashland', '', 'Chicago', NULL, 'Illinois', 'US', '60640', NULL, NULL, NULL);
INSERT INTO location VALUES (277, '4134 W. Grenshaw Street', '', 'Chicago', NULL, 'Illinois', 'US', '60624', NULL, NULL, NULL);
INSERT INTO location VALUES (278, '325 East 69th Street', '', 'Chicago', NULL, 'Illinois', 'US', '60637-4601', NULL, NULL, NULL);
INSERT INTO location VALUES (279, '2218 Hutchison Road', '', 'Flossmoor', NULL, 'Illinois', 'US', '60422', NULL, NULL, NULL);
INSERT INTO location VALUES (280, '26 E. Chestnut Street', '', 'Chicago', NULL, 'Illinois', 'US', '60611', NULL, NULL, NULL);
INSERT INTO location VALUES (281, '355 N Ashland Avenue', '', 'Chicago', NULL, 'Illinois', 'US', '60607-1019', NULL, NULL, NULL);
INSERT INTO location VALUES (282, '2201 Foster St', '', 'Evanston', NULL, 'Illinois', 'US', '60201', NULL, NULL, NULL);
INSERT INTO location VALUES (283, '1133 Pfinsten Rd.', '', 'Northbrook', NULL, 'Illinois', 'US', '60062', NULL, NULL, NULL);
INSERT INTO location VALUES (284, '1100 Greenwood Ave', '', 'Ford Heights', NULL, 'Illinois', 'US', '60411', NULL, NULL, NULL);
INSERT INTO location VALUES (285, '7800 South Loomis Blvd', '', 'Chicago', NULL, 'Illinois', 'US', '60620', NULL, NULL, NULL);
INSERT INTO location VALUES (286, '7800 South Loomis Blvd.', '', 'Chicago', NULL, 'Illinois', 'US', '60620', NULL, NULL, NULL);
INSERT INTO location VALUES (287, '5 N. Princeton Ave.', '', 'Villa Park', NULL, 'Illinois', 'US', '60181', NULL, NULL, NULL);
INSERT INTO location VALUES (288, '7300 Division St.', '', 'River Forest', NULL, 'Illinois', 'US', '60305', NULL, NULL, NULL);
INSERT INTO location VALUES (289, '1308 W. Independence Blvd', '', 'Chicago', NULL, 'Illinois', 'US', '60623', NULL, NULL, NULL);
INSERT INTO location VALUES (290, '1308 S. Independence Blvd.', '', 'Chicago', NULL, 'Illinois', 'US', '60623', NULL, NULL, NULL);
INSERT INTO location VALUES (291, '1301 S. Sawyer Ave.', '', 'Chicago', NULL, 'Illinois', 'US', '60623', NULL, NULL, NULL);
INSERT INTO location VALUES (292, '1625 S. Lawndale', '', 'Chicago', NULL, 'Illinois', 'US', '60623', NULL, NULL, NULL);
INSERT INTO location VALUES (293, '1256 N. Waller', '', 'Chicago', NULL, 'Illinois', 'US', '60651', NULL, NULL, NULL);
INSERT INTO location VALUES (294, '4236 W. Cermak Road', '', 'Chicago', NULL, 'Illinois', 'US', '60623', NULL, NULL, NULL);
INSERT INTO location VALUES (295, '8422 S. Damen', '', 'Chicago', NULL, 'Illinois', 'US', '60620', NULL, NULL, NULL);
INSERT INTO location VALUES (296, '1542 West Devon Ave', '', 'Chicago', NULL, 'Illinois', 'US', '60626', NULL, NULL, NULL);
INSERT INTO location VALUES (297, '7234 W. Ogden Ave', 'Suite 35', 'Riverside', NULL, 'Illinois', 'US', '60546', NULL, NULL, NULL);
INSERT INTO location VALUES (298, '225 North Michigan Avenue', '#1210', 'Chicago', NULL, 'Illinois', 'US', '60601-7833', NULL, NULL, NULL);
INSERT INTO location VALUES (299, '836 W. Wellington', 'Suite 159', 'Chicago', NULL, 'Illinois', 'US', '60657', NULL, NULL, NULL);
INSERT INTO location VALUES (300, '5144 S. Cornell Ave', '', 'Chicago', NULL, 'Illinois', 'US', '60615', NULL, NULL, NULL);
INSERT INTO location VALUES (301, '122 S. Michigan', 'Suite 2009', 'Chicago', NULL, 'Illinois', 'US', '60603', NULL, NULL, NULL);
INSERT INTO location VALUES (302, '407 S. Dearborn', 'Suite 701', 'Chicago', NULL, 'Illinois', 'US', '60605', NULL, NULL, NULL);
INSERT INTO location VALUES (303, '300 E Superior St', '', 'Chicago', NULL, 'Illinois', 'US', '60611', NULL, NULL, NULL);
INSERT INTO location VALUES (304, '910 W Castlewood Terrace', '', 'Chicago', NULL, 'Illinois', 'US', '60640', NULL, NULL, NULL);
INSERT INTO location VALUES (305, '2744 W. 63rd St', '', 'Chicago', NULL, 'Illinois', 'US', '60629', NULL, NULL, NULL);
INSERT INTO location VALUES (306, '300 E Superior St', '', 'Chicago', NULL, 'Illinois', 'US', '60611', NULL, NULL, NULL);
INSERT INTO location VALUES (307, '480 Potter Rd', '', 'Des Plaines', NULL, 'Illinois', 'US', '60016', NULL, NULL, NULL);
INSERT INTO location VALUES (308, '300 W. Highridge Rd', '', 'Villa Park', NULL, 'Illinois', 'US', '60181', NULL, NULL, NULL);
INSERT INTO location VALUES (309, '6259 N. Broadway Ave', '', 'Chicago', NULL, 'Illinois', 'US', '60660', NULL, NULL, NULL);
INSERT INTO location VALUES (310, '100 Shermer Road', '', 'Glenview', NULL, 'Illinois', 'US', '60025', NULL, NULL, NULL);
INSERT INTO location VALUES (311, '208 Lake Street', '', 'Waukegan', NULL, 'Illinois', 'US', '60085', NULL, NULL, NULL);
INSERT INTO location VALUES (312, '3145 W. Pratt Blvd', '', 'Chicago', NULL, 'Illinois', 'US', '60645', NULL, NULL, NULL);
INSERT INTO location VALUES (313, '3145 W. Praat Blvd', '', 'Chicago', NULL, 'Illinois', 'US', '60645', NULL, NULL, NULL);
INSERT INTO location VALUES (314, '5150 Golf Road', '', 'Skokie', NULL, 'Illinois', 'US', '60077', NULL, NULL, NULL);
INSERT INTO location VALUES (315, '1500 S. California Ave', '', 'Chicago', NULL, 'Illinois', 'US', '60608', NULL, NULL, NULL);
INSERT INTO location VALUES (316, '3255 W. Carroll Avenue', '', 'Chicago', NULL, 'Illinois', 'US', '60624', NULL, NULL, NULL);
INSERT INTO location VALUES (317, '9600 Capitol Dr.', '', 'Wheeling', NULL, 'Illinois', 'US', '60090', NULL, NULL, NULL);
INSERT INTO location VALUES (318, '4608 S. Greenwood Ave', '', 'Chicago', NULL, 'Illinois', 'US', '60653', NULL, NULL, NULL);
INSERT INTO location VALUES (319, '2324 N. Kimball Avenue', '', 'Chicago', NULL, 'Illinois', 'US', '60647', NULL, NULL, NULL);
INSERT INTO location VALUES (320, '1840 Westchester Blvd', 'Suite 200', 'Westchester', NULL, 'Illinois', 'US', '60154', NULL, NULL, NULL);
INSERT INTO location VALUES (321, '716 W. Addison', '', 'Chicago', NULL, 'Illinois', 'US', '60613', NULL, NULL, NULL);
INSERT INTO location VALUES (322, '300 W. Adams', 'Suite 35', 'Chicago', NULL, 'Illinois', 'US', '60606', NULL, NULL, NULL);
INSERT INTO location VALUES (323, '2813 W. 147th Street', '', 'Posen', NULL, 'Illinois', 'US', '60469', NULL, NULL, NULL);
INSERT INTO location VALUES (324, '25 E. Pearson', '', 'Chicago', NULL, 'Illinois', 'US', '60611', NULL, NULL, NULL);
INSERT INTO location VALUES (325, 'Loyola Law School', '25 E. Pearson St.', 'Chicago', NULL, 'Illinois', 'US', '60611', NULL, NULL, NULL);
INSERT INTO location VALUES (326, '1840 Westchester Blvd', 'Suite 200', 'Westchester', NULL, 'Illinois', 'US', '60154', NULL, NULL, NULL);
INSERT INTO location VALUES (327, '4849 S. King Dr.', '', 'Chicago', NULL, 'Illinois', 'US', '60615', NULL, NULL, NULL);
INSERT INTO location VALUES (328, '649 W. 113th Street', '', 'Chicago', NULL, 'Illinois', 'US', '60628', NULL, NULL, NULL);
INSERT INTO location VALUES (329, '2242 South Damen Avenue', '', 'Chicago', NULL, 'Illinois', 'US', '60608', NULL, NULL, NULL);
INSERT INTO location VALUES (330, '355 N Ashland Avenue', '', 'Chicago', NULL, 'Illinois', 'US', '60607-1019', NULL, NULL, NULL);
INSERT INTO location VALUES (331, '4938 W. Chicago Avenue', '', 'Chicago', NULL, 'Illinois', 'US', '60651', NULL, NULL, NULL);
INSERT INTO location VALUES (332, '6554 N. Rockwell Street', '', 'Chicago', NULL, 'Illinois', 'US', '60645', NULL, NULL, NULL);
INSERT INTO location VALUES (333, '909 East Main Street', '', 'Barrington', NULL, 'Illinois', 'US', '60010', NULL, NULL, NULL);
INSERT INTO location VALUES (334, '460 Sunset Ridge Rd', '', 'Northfield', NULL, 'Illinois', 'US', '60093', NULL, NULL, NULL);
INSERT INTO location VALUES (335, '1775 W. Dempster', '', 'Park Ridge', NULL, 'Illinois', 'US', '60068', NULL, NULL, NULL);
INSERT INTO location VALUES (336, '1001 E. Touhy Ave.', '', 'Illinois', NULL, 'Illinois', 'US', '60018', NULL, NULL, NULL);
INSERT INTO location VALUES (337, '4259 S. Berkeley Avenue', '', 'Chicago', NULL, 'Illinois', 'US', '60653', NULL, NULL, NULL);
INSERT INTO location VALUES (338, '2218 Hutchison Road', '', 'Flossmoor', NULL, 'Illinois', 'US', '60422', NULL, NULL, NULL);
INSERT INTO location VALUES (339, '4411 N. Melvina Ave', '', 'Chicago', NULL, 'Illinois', 'US', '60630', NULL, NULL, NULL);
INSERT INTO location VALUES (340, '2750 W. Columbus Ave', '', 'Chicago', NULL, 'Illinois', 'US', '60652', NULL, NULL, NULL);
INSERT INTO location VALUES (341, '7360 West 93rd Street', '', 'Bridgeview', NULL, 'Illinois', 'US', '60455-2171', NULL, NULL, NULL);
INSERT INTO location VALUES (342, '11405 S. Michigan Avenue', '', 'Chicago', NULL, 'Illinois', 'US', '60628', NULL, NULL, NULL);
INSERT INTO location VALUES (343, '450 Keller Avenue', '', 'Waukegan', NULL, 'Illinois', 'US', '60085', NULL, NULL, NULL);
INSERT INTO location VALUES (344, '1259 W. 111th Place', '', 'Chicago', NULL, 'Illinois', 'US', '60643', NULL, NULL, NULL);
INSERT INTO location VALUES (345, '1813 Church Street', '', 'Evanston', NULL, 'Illinois', 'US', '60201', NULL, NULL, NULL);
INSERT INTO location VALUES (346, '501 S. Emerson St.', '', 'Mt Prospect', NULL, 'Illinois', 'US', '60056', NULL, NULL, NULL);
INSERT INTO location VALUES (347, '1137 N. Leavitt St.', '', 'Chicago', NULL, 'Illinois', 'US', '60622', NULL, NULL, NULL);
INSERT INTO location VALUES (348, '11026 S. Indiana Ave.', '', 'Chicago', NULL, 'Illinois', 'US', '60628', NULL, NULL, NULL);
INSERT INTO location VALUES (349, '2704 W. North Ave.', '', 'Chicago', NULL, 'Illinois', 'US', '60647', NULL, NULL, NULL);
INSERT INTO location VALUES (350, '32 E. 113th Place', '', 'Chicago', NULL, 'Illinois', 'US', '60628', NULL, NULL, NULL);
INSERT INTO location VALUES (351, '4301 W. Washington Blvd', '', 'Chicago', NULL, 'Illinois', 'US', '60624', NULL, NULL, NULL);
INSERT INTO location VALUES (352, '11300 South Indiana Avenue', '', 'Chicago', NULL, 'Illinois', 'US', '60628', NULL, NULL, NULL);
INSERT INTO location VALUES (353, '3225 W. Foster Ave', '', 'Chicago', NULL, 'Illinois', 'US', '60625-4895', NULL, NULL, NULL);
INSERT INTO location VALUES (354, '326 Julian St', '', 'Waukegan', NULL, 'Illinois', 'US', '60085', NULL, NULL, NULL);
INSERT INTO location VALUES (355, '100 N. Northgate Pkwy.', '', 'Wheeling', NULL, 'Illinois', 'US', '60090', NULL, NULL, NULL);
INSERT INTO location VALUES (356, '7649 North Paulina Street', '', 'Chicago', NULL, 'Illinois', 'US', '60626', NULL, NULL, NULL);
INSERT INTO location VALUES (357, '2415 North Butrick', '', 'Waukegan', NULL, 'Illinois', 'US', '60085', NULL, NULL, NULL);
INSERT INTO location VALUES (358, '710 S Paulina Street', '4th Floor', 'Chicago', NULL, 'Illinois', 'US', '60612', NULL, NULL, NULL);
INSERT INTO location VALUES (359, '3845 S. California Ave', '', 'Chicago', NULL, 'Illinois', 'US', '60632', NULL, NULL, NULL);
INSERT INTO location VALUES (360, '601 Talma Street', '', 'Aurora', NULL, 'Illinois', 'US', '60505', NULL, NULL, NULL);
INSERT INTO location VALUES (361, '7000 S. King Drive', '', 'Chicago', NULL, 'Illinois', 'US', '60637', NULL, NULL, NULL);
INSERT INTO location VALUES (362, '100 S. Courtland Ave', '', 'Park Ridge', NULL, 'Illinois', 'US', '60068', NULL, NULL, NULL);
INSERT INTO location VALUES (363, '21W500 Butterfield Rd', '', 'Lombard', NULL, 'Illinois', 'US', '60148', NULL, NULL, NULL);
INSERT INTO location VALUES (364, '3570 West Fifth Avenue', '', 'Chicago', NULL, 'Illinois', 'US', '60624', NULL, NULL, NULL);
INSERT INTO location VALUES (365, '941 W. Lawrence Ave', '', 'Chicago', NULL, 'Illinois', 'US', '60640', NULL, NULL, NULL);
INSERT INTO location VALUES (366, '7438 W. 62nd Place', '', 'Summit Argo', NULL, 'Illinois', 'US', '60501', NULL, NULL, NULL);
INSERT INTO location VALUES (367, '116 S. Central Ave.', '', 'Chicago', NULL, 'Illinois', 'US', '60644', NULL, NULL, NULL);
INSERT INTO location VALUES (368, '300 W. Adams', 'Suite 35', 'Chicago', NULL, 'Illinois', 'US', '60606', NULL, NULL, NULL);
INSERT INTO location VALUES (369, '1305 N. Hamlin', '', 'Chicago', NULL, 'Illinois', 'US', '60651', NULL, NULL, NULL);
INSERT INTO location VALUES (370, '1601 W. Taylor', '', 'Chicago', NULL, 'Illinois', 'US', '60612', NULL, NULL, NULL);
INSERT INTO location VALUES (371, '3658 South Wentworth Avenue', '', 'Chicago', NULL, 'Illinois', 'US', '60609', NULL, NULL, NULL);
INSERT INTO location VALUES (372, '2216 S. Wentworkth', '', 'Chicago', NULL, 'Illinois', 'US', '60616', NULL, NULL, NULL);
INSERT INTO location VALUES (373, '1550 Bishop Court', '', 'Mount Prospect', NULL, 'Illinois', 'US', '60056', NULL, NULL, NULL);
INSERT INTO location VALUES (374, 'PO Box 621', '', 'Blue Island', NULL, 'Illinois', 'US', '60406', NULL, NULL, NULL);
INSERT INTO location VALUES (375, '11310 S. Forest Avenue', '', 'Chicago', NULL, 'Illinois', 'US', '60628', NULL, NULL, NULL);
INSERT INTO location VALUES (376, '127 N. Leamington Ave', '', 'Chicago', NULL, 'Illinois', 'US', '60644', NULL, NULL, NULL);
INSERT INTO location VALUES (377, '710 S Paulina Street', '4th Floor', 'Chicago', NULL, 'Illinois', 'US', '60612', NULL, NULL, NULL);
INSERT INTO location VALUES (378, '752 E. 114th St', '', 'Chicago', NULL, 'Illinois', 'US', '60628', NULL, NULL, NULL);
INSERT INTO location VALUES (379, '800 S. Genessee St.', '', 'Waukegan', NULL, 'Illinois', 'US', '60085', NULL, NULL, NULL);
INSERT INTO location VALUES (380, '10540 S. Halsted', '', 'Chicago', NULL, 'Illinois', 'US', '60628', NULL, NULL, NULL);
INSERT INTO location VALUES (381, '1500 S. California Ave', '', 'Chicago', NULL, 'Illinois', 'US', '60608', NULL, NULL, NULL);
INSERT INTO location VALUES (382, '2640 Park Dr.', 'St. John the Evangelist', 'Flossmoor', NULL, 'Illinois', 'US', '60422', NULL, NULL, NULL);
INSERT INTO location VALUES (383, '1507 W. Sunnyside,', '', 'Chicago', NULL, 'Illinois', 'US', '60640', NULL, NULL, NULL);
INSERT INTO location VALUES (384, '1000 N. Orleans St', '', 'Chicago', NULL, 'Illinois', 'US', '60610', NULL, NULL, NULL);
INSERT INTO location VALUES (385, '9015 South Harper,', '', 'Chicago', NULL, 'Illinois', 'US', '60619', NULL, NULL, NULL);
INSERT INTO location VALUES (386, '120 Els St', '', 'Barrington', NULL, 'Illinois', 'US', '60010', NULL, NULL, NULL);
INSERT INTO location VALUES (387, '2508 Walnut St.', '', 'Blue Island', NULL, 'Illinois', 'US', '60406', NULL, NULL, NULL);
INSERT INTO location VALUES (388, '813 W. Roosevelt Rd.', '', 'Chicago', NULL, 'Illinois', 'US', '60608', NULL, NULL, NULL);
INSERT INTO location VALUES (389, '2451 N. Lamon', '', 'Chicago', NULL, 'Illinois', 'US', '60639', NULL, NULL, NULL);
INSERT INTO location VALUES (390, '1220 W. Catalpa', '', 'Chicago', NULL, 'Illinois', 'US', '60640', NULL, NULL, NULL);
INSERT INTO location VALUES (391, '5129 Wolf Rd', '', 'Western Springs', NULL, 'Illinois', 'US', '60558', NULL, NULL, NULL);
INSERT INTO location VALUES (392, '211 E. 115th St.', '', 'Chicago', NULL, 'Illinois', 'US', '60628', NULL, NULL, NULL);
INSERT INTO location VALUES (393, '10501 S. Torrence Ave.', '', 'Chicago', NULL, 'Illinois', 'US', '60617', NULL, NULL, NULL);
INSERT INTO location VALUES (394, '2649 N. Francisco Ave.', '', 'Chicago', NULL, 'Illinois', 'US', '60647', NULL, NULL, NULL);
INSERT INTO location VALUES (395, '2649 N. Francisco Ave.', '', 'Chicago', NULL, 'Illinois', 'US', '60647', NULL, NULL, NULL);
INSERT INTO location VALUES (396, '832 N. Leclaire Ave', '', 'Chicago', NULL, 'Illinois', 'US', '60651', NULL, NULL, NULL);
INSERT INTO location VALUES (397, '144 E Palatine Rd', '', 'Palatine', NULL, 'Illinois', 'US', '60067', NULL, NULL, NULL);
INSERT INTO location VALUES (398, '7100 N. Ashland Ave.', '', 'Chicago', NULL, 'Illinois', 'US', '60626', NULL, NULL, NULL);
INSERT INTO location VALUES (399, '1910 S. Ashland Ave', '', 'Chicago', NULL, 'Illinois', 'US', '60622', NULL, NULL, NULL);
INSERT INTO location VALUES (400, '1210 W. 78th Place', '', 'Chicago', NULL, 'Illinois', 'US', '60620', NULL, NULL, NULL);
INSERT INTO location VALUES (401, '3042 W. Washington', '', 'Chicago', NULL, 'Illinois', 'US', '60612', NULL, NULL, NULL);
INSERT INTO location VALUES (402, '2157 N. Humboldt Blvd', '', 'Chicago', NULL, 'Illinois', 'US', '60647', NULL, NULL, NULL);
INSERT INTO location VALUES (403, '111 N. County Farm Rd', '', 'Wheaton', NULL, 'Illinois', 'US', '60187', NULL, NULL, NULL);
INSERT INTO location VALUES (404, '351 S. Kilbourn', '', 'Chicago', NULL, 'Illinois', 'US', '60624', NULL, NULL, NULL);
INSERT INTO location VALUES (405, '6201 S Wolcott Ave', '', 'Chicago', NULL, 'Illinois', 'US', '60636', NULL, NULL, NULL);
INSERT INTO location VALUES (406, '208 S. LaSalle Street', 'Suite 900', 'Chicago', NULL, 'Illinois', 'US', '60604', NULL, NULL, NULL);
INSERT INTO location VALUES (407, '1151 W. Leland Ave', '', 'Chicago', NULL, 'Illinois', 'US', '60640', NULL, NULL, NULL);
INSERT INTO location VALUES (408, '501 S. Emerson', '', 'Mt Prospect', NULL, 'Illinois', 'US', '60056', NULL, NULL, NULL);
INSERT INTO location VALUES (439, '1801 West Taylor Street', '4th Floor', 'Chicago', NULL, 'Illinois', 'US', '60612', NULL, NULL, NULL);
INSERT INTO location VALUES (440, '1551 W. 95th St.', '', 'Chicago', NULL, 'Illinois', 'US', '60643', NULL, NULL, NULL);
INSERT INTO location VALUES (441, '1415 West 104th Street', '', 'Chicago', NULL, 'Illinois', 'US', '60643', NULL, NULL, NULL);
INSERT INTO location VALUES (442, '210 South Avenue', '', 'Waukegan', NULL, 'Illinois', 'US', '60085', NULL, NULL, NULL);
INSERT INTO location VALUES (443, '400 W. 95th Street', '', 'Chicago', NULL, 'Illinois', 'US', '60628', NULL, NULL, NULL);
INSERT INTO location VALUES (444, '1107 N Pulaski Rd', '', 'Chicago', NULL, 'Illinois', 'US', '60651', NULL, NULL, NULL);
INSERT INTO location VALUES (445, '8324 N. Skokie Blvd', '', 'Skokie', NULL, 'Illinois', 'US', '60077', NULL, NULL, NULL);
INSERT INTO location VALUES (446, '910 W Castlewood Terrace', '', 'Chicago', NULL, 'Illinois', 'US', '60640', NULL, NULL, NULL);
INSERT INTO location VALUES (447, '4242 W. Roosevelt', '', 'Chicago', NULL, 'Illinois', 'US', '60624', NULL, NULL, NULL);
INSERT INTO location VALUES (448, '40 S. 19th Ave.', '', 'Maywood', NULL, 'Illinois', 'US', '60153', NULL, NULL, NULL);
INSERT INTO location VALUES (454, '6525 W. Irving Park Rd.', '', 'Chicago', NULL, 'Illinois', 'US', '60634', NULL, NULL, NULL);
INSERT INTO location VALUES (455, '1212 W. Balmoral Ave.', '', 'Chicago', NULL, 'Illinois', 'US', '60640', NULL, NULL, NULL);
INSERT INTO location VALUES (456, '259 E. Central Rd', '', 'Des Plaines', NULL, 'Illinois', 'US', '60016', NULL, NULL, NULL);
INSERT INTO location VALUES (457, '15704 Park Ave.', '', 'Harvey', NULL, 'Illinois', 'US', '60426', NULL, NULL, NULL);
INSERT INTO location VALUES (459, '845 S. Damen', '5th Floor', 'Chicago', NULL, 'Illinois', 'US', '60612', NULL, NULL, NULL);
INSERT INTO location VALUES (460, '2902 W. 159th Street', '', 'Markham', NULL, 'Illinois', 'US', '60428', NULL, NULL, NULL);
INSERT INTO location VALUES (461, '3456 W. Flournoy Ave', '', 'Chicago', NULL, 'Illinois', 'US', '60624', NULL, NULL, NULL);
INSERT INTO location VALUES (462, '201 E. 95th St.', '', 'Chicago', NULL, 'Illinois', 'US', '60619', NULL, NULL, NULL);
INSERT INTO location VALUES (463, '4800 W. Chicago', '', 'Chicago', NULL, 'Illinois', 'US', '60651', NULL, NULL, NULL);
INSERT INTO location VALUES (464, 'LaVerne Barnes, DO, MPH', '2813 W. 147th St.', 'Posen', NULL, 'Illinois', 'US', '60469', NULL, NULL, NULL);
INSERT INTO location VALUES (465, '6401 N. Artesian Ave.', '', 'Chicago', NULL, 'Illinois', 'US', '60654', NULL, NULL, NULL);


--
-- Data for Name: organization; Type: TABLE DATA; Schema: public; Owner: northbr6
--

INSERT INTO organization VALUES (9, 'Oak Lawn Neighborhoods for Peace', NULL, NULL, '2014-05-26 18:36:55.837463-06', NULL, NULL, NULL, NULL, 1, NULL, NULL);
INSERT INTO organization VALUES (1, 'Greater-Chicago Communities Unite!', 'nta', 'nfp', '2014-05-13 15:31:28.774771-06', NULL, '2014-05-16 09:38:22.871587-06', '2014-05-16 09:37:13.939099-06', true, 1, NULL, NULL);
INSERT INTO organization VALUES (18, 'The Center for Faith and Community Health Transformations', NULL, NULL, '2014-07-14 16:09:45.885491-06', NULL, '2014-07-14 16:09:45.885491-06', NULL, NULL, 1, NULL, NULL);
INSERT INTO organization VALUES (19, 'Episcopal Diocese of Chicago', NULL, NULL, '2014-07-14 16:13:00.448838-06', NULL, '2014-07-14 16:13:00.448838-06', NULL, true, 1, NULL, NULL);
INSERT INTO organization VALUES (13, 'NorthBridge Technology Alliance', NULL, '', '2014-05-26 18:43:41.30068-06', NULL, '2014-05-26 18:43:41.30068-06', NULL, true, 1, NULL, NULL);
INSERT INTO organization VALUES (12, 'Howard Street Spanish Connections', NULL, NULL, '2014-05-26 18:36:28.32138-06', NULL, NULL, NULL, NULL, 1, NULL, NULL);
INSERT INTO organization VALUES (10, 'Englewood Community Health Services', NULL, NULL, '2014-05-26 18:35:52.322688-06', NULL, NULL, NULL, NULL, 1, 'Health Care Provider', NULL);
INSERT INTO organization VALUES (45, '30th Ward - St. James Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (46, 'A Just Harvest', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Community Organization', NULL);
INSERT INTO organization VALUES (47, 'Access Living', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Community Organization', NULL);
INSERT INTO organization VALUES (48, 'Adalberto Memorial United Methodist Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (49, 'Advocate Christ Medical Center', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Heath Care Provider', NULL);
INSERT INTO organization VALUES (50, 'Advocate Clinical Pastoral Education', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Heath Care Provider', NULL);
INSERT INTO organization VALUES (51, 'Advocate Health Care', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Heath Care Provider', NULL);
INSERT INTO organization VALUES (52, 'Advocate Parish Nurse Ministry', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (53, 'Advocate United Church of Christ', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (54, 'African Community United Methodist Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (55, 'African-American Alzheimer''s Outreach Initiative', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (56, 'Agape Family Life Center', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (57, 'Age Options', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Community Organization', NULL);
INSERT INTO organization VALUES (58, 'Alexian Brothers Parish Services', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Community Organization', NULL);
INSERT INTO organization VALUES (59, 'Alzheimer''s Association - Greater Illinois Chapter', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (60, 'Am I My Brothers Keeper', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (61, 'American Cancer Society, Chicago Region', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (62, 'American Heart Association Cultural Health Initiatives', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (63, 'American Kidney Fund', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (64, 'Antioch Telegu Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (65, 'Apostolic Church of God', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (66, 'Apostolic Faith Church Health Professions Ministry', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (67, 'B''nai Yehuda Beth Shalom', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (68, 'Beacon Light', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (69, 'Bethel Reform Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (70, 'Bikur Cholim (visiting the sick) training', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (71, 'Breast Cancer Network of Strength', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (72, 'Buddhist International Tzu Chi Relief Foundation (Midwest)', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Community Organization', NULL);
INSERT INTO organization VALUES (73, 'Campaign for Better Health Care', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (74, 'Caring for Health', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (75, 'CARRI (Chicago Area Regional Recovery Initiative)', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Community Organization', NULL);
INSERT INTO organization VALUES (76, 'Center for Faith and Health', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'University', NULL);
INSERT INTO organization VALUES (77, 'Central Spanish Baptist Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (78, 'Chicago Chin Baptist Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (79, 'Chicago Theological Seminary', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (80, 'Chicago Uptown Ministry', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (81, 'Chinmaya Mission Chicago-Badri', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (82, 'Christ Temple Apostolic Faith Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (83, 'Christ the King Lutheran Church ELCA', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (84, 'Christian Churches Caring', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (85, 'Christian Fellowship Flock', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (86, 'Church of Jesus Christ Latter Day Saints', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (87, 'Coalition for Quality and Patient Safety of Chicagoland', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (88, 'Community Health Services and Health Promotion', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (89, 'Community-Outreach Project', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (90, 'Congregational Health Partnerships', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Heath Care Provider', NULL);
INSERT INTO organization VALUES (91, 'Congregational Outreach', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (92, 'Congregational United Church of Christ of Arlington Heights', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (93, 'Consortium to Lower Obesity in Chicago Children (CLOCC)', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (94, 'Cornerstone Community Outreach', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Community Organization', NULL);
INSERT INTO organization VALUES (95, 'Council of Islamic Organizations of Greater Chicago', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Community Organization', NULL);
INSERT INTO organization VALUES (96, 'Delegate Church Association of Advocate BroMenn Medical Center', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Collaborative/Network', NULL);
INSERT INTO organization VALUES (97, 'DuPage Department of Public Health', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (98, 'Ebenezer Baptist', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (99, 'Ebenezer Lutheran Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (100, 'Edgewater Presbyterian Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (101, 'Education and Life Coaching', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (102, 'Epworth United Methodist Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (103, 'Evergreen Presbyterian Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (104, 'Exodus Community Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (105, 'Faith Caucus', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (106, 'Faith in Place', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Community Organization', NULL);
INSERT INTO organization VALUES (107, 'Faith Temple COGIC', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (108, 'Faith United Methodist Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (109, 'Figure Facts LLC', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Heath Care Provider', NULL);
INSERT INTO organization VALUES (110, 'First Baptist Church, Berwyn', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (111, 'First Baptist Church, LaGrange', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (112, 'First Baptist Church, Park Forest', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (113, 'First Congregational Church of Western Springs', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (114, 'First Evangelical Free Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (115, 'First Grace Missionary Baptist Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (116, 'First New Bethlehem Community Development Corporation', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (117, 'Flossmoor Community Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (118, 'Fourth Presbyterian Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (119, 'Friendly Visits', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (120, 'Friendship Baptist Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (121, 'Gloria Dei Lutheran Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (122, 'God Can Ministries', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (123, 'Grace Calvary United Methodist Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (124, 'Grace Calvary United Methodist Church- Gospel Cafe', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (125, 'Grace Evangelical Lutheran Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (126, 'Grace Lutheran Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (127, 'Greater Galilee MB Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (128, 'Greater Galilee Missionary Baptist Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (129, 'Greater Open Door Baptist Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (130, 'Greater Progressive Missionary Baptist Church Baptist Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (131, 'Greater St. John Bible Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (132, 'Greater St. Paul A M E C', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (133, 'Greater Walters AME Zion Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (134, 'Hamdard Center for Health and Human Services', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Community Organization', NULL);
INSERT INTO organization VALUES (135, 'Health Initiatives, West Cook Area', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (136, 'Healthcare Consortium of Illinois', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (137, 'Healthy Dining Chicago Healthy Dining Chicago', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Community Organization', NULL);
INSERT INTO organization VALUES (138, 'Healthy Spirit Healthy Soul', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (139, 'Hispanocare - Chicago', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (140, 'Hyde Park Christian Reformed Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (141, 'Illinois Faith Based Emergency Preparedness Initiative', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Government', NULL);
INSERT INTO organization VALUES (142, 'Illinois Maternal and Child Health Coalition', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (143, 'Illinois PIRG', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (144, 'Illinois Women''s Health Registry', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (145, 'Imagine Chicago', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (146, 'Inner City Muslim Action Network', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Community Organization', NULL);
INSERT INTO organization VALUES (147, 'Institute for Women''s Health Research', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (148, 'Islamic Community Center', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (149, 'Islamic Foundation of Villa Park', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (150, 'Ismaili Center in Chicago', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (151, 'Ismaili Center in Glenview', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (152, 'Jesus Name Apostolic Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (153, 'Jewish Child and Family Services', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Community Organization', NULL);
INSERT INTO organization VALUES (154, 'Jewish Community Emergency Resiliency Team', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Community Organization', NULL);
INSERT INTO organization VALUES (155, 'Jewish Healing Network of Chicago', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (156, 'Jewish School-Based Wellness Initiative', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (157, 'Joshua Missionary Baptist Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (158, 'Journey Community Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (159, 'Joy To Be Fit Gospel Aerobics Ministry', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (160, 'Kenwood UCC', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (161, 'Kimball Ave. Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (162, 'La Academia', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (163, 'Lakeview Presbyterian Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (164, 'Latino Community Program', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (165, 'LaVerne Barnes', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Heath Care Provider', NULL);
INSERT INTO organization VALUES (166, 'Lead Safe Housing Initiatives', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (167, 'lead safe illinois', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (168, 'Leadership and Church Development', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (169, 'Liberty Baptist', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (170, 'Lilydale Baptist Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (171, 'Lincoln United Methodist Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (172, 'Little Brothers - Friends of the Elderly, Chicago Chapter', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (173, 'Lively Stone Missonary Baptist Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (174, 'Living Well Ministries', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (175, 'Lutheran Church of Atonement', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (176, 'Lutheran Church of the Ascension', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (177, 'Lutheran General Hospital - Mission and Spiritual', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Heath Care Provider', NULL);
INSERT INTO organization VALUES (178, 'Lutheran Social Services of Illinois', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Community Organization', NULL);
INSERT INTO organization VALUES (179, 'M.I.K.E. Minority Intervention and Kidney Education Program', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (180, 'Ministry to New Moms', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (181, 'Montrose Baptist Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (182, 'Monument of Faith Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (183, 'Mosque Foundation', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (184, 'Mosque of Umar Inc.', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (185, 'Most Blessed Trinity Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (186, 'Mount Calvary Baptist Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (187, 'Mount Pisgah Ministries', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (188, 'Myanmar Christian Church of Metro Chicago', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (189, 'New Hope Bible Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (190, 'New Life Baptist Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (191, 'New Life Community Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (192, 'New Life Covenant Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (193, 'New Life Worship Center', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (194, 'New Mt.Pilgrim MB Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (195, 'New Pasadena MB Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (196, 'North Park Theological Seminary', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (197, 'North Shore Baptist Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (198, 'North Shore Church of Christ', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (199, 'Northfield Presbyterian Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (200, 'Northside P.O.W.E.R.', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (201, 'Nuestra Senora de Gaudalupe', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (202, 'Older Adult Programs', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (203, 'Our Lady of Fatima Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (204, 'Our Lady of Good Counsel', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (205, 'Park Manor Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (206, 'Park Ridge Community Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (207, 'Peace Lutheran Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (208, 'People''s Church of the Harvest', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (209, 'Peoples Church of Chicago', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (210, 'Pilgrim Faith United Church of Christ', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (211, 'Pillar of Love UCC', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (212, 'Pleasant Ridge Baptist Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (213, 'Polish Community', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (214, 'Primera Iglesia Congregacional', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (215, 'Program of Religion/Spirituality and Mental Health', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (216, 'Progressive Baptist Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (217, 'Pui Tak Center', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Community Organization', NULL);
INSERT INTO organization VALUES (218, 'Rahab''s House, Inc.', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (219, 'Rainbow Hospice and Palliative Care', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Community Organization', NULL);
INSERT INTO organization VALUES (220, 'Redeeming Life Family Worship Center COGIC', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (221, 'Reformation Lutheran Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (222, 'Revelation International Outreach Ministries', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (223, 'Rush University Medical Center', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (224, 'Salem Baptist', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (225, 'Shiloh Baptist Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (226, 'Shiloh Missionary Baptist Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (227, 'Sinai Urban Health Institute', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (228, 'South Suburban Interfaith Ministerial Association', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Community Organization', NULL);
INSERT INTO organization VALUES (229, 'Spanish Christian Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (230, 'St Matthews United Methodist Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (231, 'St. Ailbe Catholic Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (232, 'St. Anne Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (233, 'St. Clement''s Episcopal Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (234, 'St. Francis of Assisi Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (235, 'St. Genevieve Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (236, 'St. Ita Catholic Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (237, 'St. James Lutheran Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (238, 'St. John MB Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (239, 'St. John United Church of Christ', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (240, 'St. Kevins''s Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (241, 'St. Luke''s Lutheran of Logan Square', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (242, 'St. Luke''s Lutheran Church of Logan Square', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (243, 'St. Mark International Christian Ch.', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (244, 'St. Paul UCC', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (245, 'St. Paul''s Church by-the-Lake', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (246, 'St. Pius V. Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (247, 'St. Sabina Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (248, 'St. Stephen AME Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (249, 'St. Sylvester Catholic Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (250, 'Suburban Chicago Interfaith Mental Health Coalition', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Community Organization', NULL);
INSERT INTO organization VALUES (251, 'Sunrise Missionary Baptist Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (252, 'Temple of Faith Missionary Baptist Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (253, 'The American Heart Association (AHA)', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (254, 'The Buddhist Temple of Chicago', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (255, 'The Christian Aerobics and Fitness Association (CAFA)', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (256, 'The South Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (257, 'The Unversity of Illinois Medical Center for Women''s Health Associates', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (258, 'Third Baptist Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (259, 'Triedstone Full Gospel Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (260, 'Trinity AME Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (261, 'Trinity United Church of Christ', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (262, 'True Worship Baptist Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (263, 'Turning Point', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Community Organization', NULL);
INSERT INTO organization VALUES (264, 'Ubumama - Chicago', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (265, 'United Baptist Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (266, 'United Faith Missionary Baptist Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (267, 'United in Faith Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (268, 'Unity Lutheran Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (269, 'Unity Northwest Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (270, 'Universal House of Refuge Center', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (271, 'University of Illinois'' Division of Community Health', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (272, 'Victory Christian Assembly Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (273, 'VOCMA Faith Community Baptist Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (274, 'Wesley United Methodist Church', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Faith Community/House of Worship', NULL);
INSERT INTO organization VALUES (275, 'Westside Health Authority', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, '', NULL);
INSERT INTO organization VALUES (276, 'Wholistic Medical Clinic', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Heath Care Provider', NULL);
INSERT INTO organization VALUES (277, 'ZAM''s Hope Community Resource Center', NULL, NULL, '2014-07-31 15:02:26.883384-06', NULL, '2014-07-31 15:02:26.883384-06', NULL, NULL, 1, 'Community Organization', NULL);


--
-- Data for Name: organization_contact; Type: TABLE DATA; Schema: public; Owner: northbr6
--

INSERT INTO organization_contact VALUES (11, 45, 11);
INSERT INTO organization_contact VALUES (42, 46, 45);
INSERT INTO organization_contact VALUES (43, 47, 46);
INSERT INTO organization_contact VALUES (44, 48, 47);
INSERT INTO organization_contact VALUES (45, 49, 48);
INSERT INTO organization_contact VALUES (46, 50, 49);
INSERT INTO organization_contact VALUES (47, 51, 50);
INSERT INTO organization_contact VALUES (48, 52, 51);
INSERT INTO organization_contact VALUES (49, 53, 52);
INSERT INTO organization_contact VALUES (50, 54, 53);
INSERT INTO organization_contact VALUES (51, 55, 54);
INSERT INTO organization_contact VALUES (52, 56, 55);
INSERT INTO organization_contact VALUES (53, 57, 56);
INSERT INTO organization_contact VALUES (54, 58, 57);
INSERT INTO organization_contact VALUES (55, 59, 58);
INSERT INTO organization_contact VALUES (56, 60, 59);
INSERT INTO organization_contact VALUES (57, 61, 60);
INSERT INTO organization_contact VALUES (58, 62, 61);
INSERT INTO organization_contact VALUES (59, 63, 62);
INSERT INTO organization_contact VALUES (60, 64, 63);
INSERT INTO organization_contact VALUES (61, 65, 64);
INSERT INTO organization_contact VALUES (62, 66, 65);
INSERT INTO organization_contact VALUES (63, 67, 66);
INSERT INTO organization_contact VALUES (64, 68, 67);
INSERT INTO organization_contact VALUES (65, 69, 68);
INSERT INTO organization_contact VALUES (66, 70, 69);
INSERT INTO organization_contact VALUES (67, 71, 70);
INSERT INTO organization_contact VALUES (68, 72, 71);
INSERT INTO organization_contact VALUES (69, 73, 72);
INSERT INTO organization_contact VALUES (70, 74, 73);
INSERT INTO organization_contact VALUES (71, 75, 74);
INSERT INTO organization_contact VALUES (72, 76, 75);
INSERT INTO organization_contact VALUES (73, 77, 76);
INSERT INTO organization_contact VALUES (74, 78, 77);
INSERT INTO organization_contact VALUES (75, 79, 78);
INSERT INTO organization_contact VALUES (76, 80, 79);
INSERT INTO organization_contact VALUES (77, 81, 80);
INSERT INTO organization_contact VALUES (78, 82, 81);
INSERT INTO organization_contact VALUES (79, 83, 82);
INSERT INTO organization_contact VALUES (80, 84, 83);
INSERT INTO organization_contact VALUES (81, 85, 84);
INSERT INTO organization_contact VALUES (82, 86, 85);
INSERT INTO organization_contact VALUES (83, 87, 86);
INSERT INTO organization_contact VALUES (84, 88, 87);
INSERT INTO organization_contact VALUES (85, 89, 88);
INSERT INTO organization_contact VALUES (86, 90, 89);
INSERT INTO organization_contact VALUES (87, 91, 90);
INSERT INTO organization_contact VALUES (88, 92, 91);
INSERT INTO organization_contact VALUES (89, 93, 92);
INSERT INTO organization_contact VALUES (90, 94, 93);
INSERT INTO organization_contact VALUES (91, 95, 94);
INSERT INTO organization_contact VALUES (92, 96, 95);
INSERT INTO organization_contact VALUES (93, 97, 96);
INSERT INTO organization_contact VALUES (94, 98, 97);
INSERT INTO organization_contact VALUES (95, 99, 98);
INSERT INTO organization_contact VALUES (96, 100, 99);
INSERT INTO organization_contact VALUES (97, 101, 100);
INSERT INTO organization_contact VALUES (98, 102, 101);
INSERT INTO organization_contact VALUES (99, 103, 102);
INSERT INTO organization_contact VALUES (100, 104, 103);
INSERT INTO organization_contact VALUES (101, 105, 104);
INSERT INTO organization_contact VALUES (102, 106, 105);
INSERT INTO organization_contact VALUES (103, 107, 106);
INSERT INTO organization_contact VALUES (104, 108, 107);
INSERT INTO organization_contact VALUES (105, 109, 108);
INSERT INTO organization_contact VALUES (106, 110, 109);
INSERT INTO organization_contact VALUES (107, 111, 110);
INSERT INTO organization_contact VALUES (108, 112, 111);
INSERT INTO organization_contact VALUES (109, 113, 112);
INSERT INTO organization_contact VALUES (110, 114, 113);
INSERT INTO organization_contact VALUES (111, 115, 114);
INSERT INTO organization_contact VALUES (112, 116, 115);
INSERT INTO organization_contact VALUES (113, 117, 116);
INSERT INTO organization_contact VALUES (114, 118, 117);
INSERT INTO organization_contact VALUES (115, 119, 118);
INSERT INTO organization_contact VALUES (116, 120, 119);
INSERT INTO organization_contact VALUES (117, 121, 120);
INSERT INTO organization_contact VALUES (118, 122, 121);
INSERT INTO organization_contact VALUES (119, 123, 122);
INSERT INTO organization_contact VALUES (120, 124, 123);
INSERT INTO organization_contact VALUES (121, 125, 124);
INSERT INTO organization_contact VALUES (122, 126, 125);
INSERT INTO organization_contact VALUES (123, 127, 126);
INSERT INTO organization_contact VALUES (124, 128, 127);
INSERT INTO organization_contact VALUES (125, 129, 128);
INSERT INTO organization_contact VALUES (126, 130, 129);
INSERT INTO organization_contact VALUES (127, 131, 130);
INSERT INTO organization_contact VALUES (128, 132, 131);
INSERT INTO organization_contact VALUES (129, 133, 132);
INSERT INTO organization_contact VALUES (130, 134, 133);
INSERT INTO organization_contact VALUES (131, 135, 134);
INSERT INTO organization_contact VALUES (132, 136, 135);
INSERT INTO organization_contact VALUES (133, 137, 136);
INSERT INTO organization_contact VALUES (134, 138, 137);
INSERT INTO organization_contact VALUES (135, 139, 138);
INSERT INTO organization_contact VALUES (136, 140, 139);
INSERT INTO organization_contact VALUES (137, 141, 140);
INSERT INTO organization_contact VALUES (138, 142, 141);
INSERT INTO organization_contact VALUES (139, 143, 142);
INSERT INTO organization_contact VALUES (140, 144, 143);
INSERT INTO organization_contact VALUES (141, 145, 144);
INSERT INTO organization_contact VALUES (142, 146, 145);
INSERT INTO organization_contact VALUES (143, 147, 146);
INSERT INTO organization_contact VALUES (144, 148, 147);
INSERT INTO organization_contact VALUES (145, 149, 148);
INSERT INTO organization_contact VALUES (146, 150, 149);
INSERT INTO organization_contact VALUES (147, 151, 150);
INSERT INTO organization_contact VALUES (148, 152, 151);
INSERT INTO organization_contact VALUES (149, 153, 152);
INSERT INTO organization_contact VALUES (150, 154, 153);
INSERT INTO organization_contact VALUES (151, 155, 154);
INSERT INTO organization_contact VALUES (152, 156, 155);
INSERT INTO organization_contact VALUES (153, 157, 156);
INSERT INTO organization_contact VALUES (154, 158, 157);
INSERT INTO organization_contact VALUES (155, 159, 158);
INSERT INTO organization_contact VALUES (156, 160, 159);
INSERT INTO organization_contact VALUES (157, 161, 160);
INSERT INTO organization_contact VALUES (158, 162, 161);
INSERT INTO organization_contact VALUES (159, 163, 162);
INSERT INTO organization_contact VALUES (160, 164, 163);
INSERT INTO organization_contact VALUES (161, 165, 164);
INSERT INTO organization_contact VALUES (162, 166, 165);
INSERT INTO organization_contact VALUES (163, 167, 166);
INSERT INTO organization_contact VALUES (164, 168, 167);
INSERT INTO organization_contact VALUES (165, 169, 168);
INSERT INTO organization_contact VALUES (166, 170, 169);
INSERT INTO organization_contact VALUES (167, 171, 170);
INSERT INTO organization_contact VALUES (168, 172, 171);
INSERT INTO organization_contact VALUES (169, 173, 172);
INSERT INTO organization_contact VALUES (170, 174, 173);
INSERT INTO organization_contact VALUES (171, 175, 174);
INSERT INTO organization_contact VALUES (172, 176, 175);
INSERT INTO organization_contact VALUES (173, 177, 176);
INSERT INTO organization_contact VALUES (174, 178, 177);
INSERT INTO organization_contact VALUES (175, 179, 178);
INSERT INTO organization_contact VALUES (176, 180, 179);
INSERT INTO organization_contact VALUES (177, 181, 180);
INSERT INTO organization_contact VALUES (178, 182, 181);
INSERT INTO organization_contact VALUES (179, 183, 182);
INSERT INTO organization_contact VALUES (180, 184, 183);
INSERT INTO organization_contact VALUES (181, 185, 184);
INSERT INTO organization_contact VALUES (182, 186, 185);
INSERT INTO organization_contact VALUES (183, 187, 186);
INSERT INTO organization_contact VALUES (184, 188, 187);
INSERT INTO organization_contact VALUES (185, 189, 188);
INSERT INTO organization_contact VALUES (186, 190, 189);
INSERT INTO organization_contact VALUES (187, 191, 190);
INSERT INTO organization_contact VALUES (188, 192, 191);
INSERT INTO organization_contact VALUES (189, 193, 192);
INSERT INTO organization_contact VALUES (190, 194, 193);
INSERT INTO organization_contact VALUES (191, 195, 194);
INSERT INTO organization_contact VALUES (192, 196, 195);
INSERT INTO organization_contact VALUES (193, 197, 196);
INSERT INTO organization_contact VALUES (194, 198, 197);
INSERT INTO organization_contact VALUES (195, 199, 198);
INSERT INTO organization_contact VALUES (196, 200, 199);
INSERT INTO organization_contact VALUES (197, 201, 200);
INSERT INTO organization_contact VALUES (198, 202, 201);
INSERT INTO organization_contact VALUES (199, 203, 202);
INSERT INTO organization_contact VALUES (200, 204, 203);
INSERT INTO organization_contact VALUES (201, 205, 204);
INSERT INTO organization_contact VALUES (202, 206, 205);
INSERT INTO organization_contact VALUES (203, 207, 206);
INSERT INTO organization_contact VALUES (204, 208, 207);
INSERT INTO organization_contact VALUES (205, 209, 208);
INSERT INTO organization_contact VALUES (206, 210, 209);
INSERT INTO organization_contact VALUES (207, 211, 210);
INSERT INTO organization_contact VALUES (208, 212, 211);
INSERT INTO organization_contact VALUES (209, 213, 212);
INSERT INTO organization_contact VALUES (210, 214, 213);
INSERT INTO organization_contact VALUES (211, 215, 214);
INSERT INTO organization_contact VALUES (212, 216, 215);
INSERT INTO organization_contact VALUES (213, 217, 216);
INSERT INTO organization_contact VALUES (214, 218, 217);
INSERT INTO organization_contact VALUES (215, 219, 218);
INSERT INTO organization_contact VALUES (216, 220, 219);
INSERT INTO organization_contact VALUES (217, 221, 220);
INSERT INTO organization_contact VALUES (218, 222, 221);
INSERT INTO organization_contact VALUES (219, 223, 222);
INSERT INTO organization_contact VALUES (220, 224, 223);
INSERT INTO organization_contact VALUES (221, 225, 224);
INSERT INTO organization_contact VALUES (222, 226, 225);
INSERT INTO organization_contact VALUES (223, 227, 226);
INSERT INTO organization_contact VALUES (224, 228, 227);
INSERT INTO organization_contact VALUES (225, 229, 228);
INSERT INTO organization_contact VALUES (226, 230, 229);
INSERT INTO organization_contact VALUES (227, 231, 230);
INSERT INTO organization_contact VALUES (228, 232, 231);
INSERT INTO organization_contact VALUES (229, 233, 232);
INSERT INTO organization_contact VALUES (230, 234, 233);
INSERT INTO organization_contact VALUES (231, 235, 234);
INSERT INTO organization_contact VALUES (232, 236, 235);
INSERT INTO organization_contact VALUES (233, 237, 236);
INSERT INTO organization_contact VALUES (234, 238, 237);
INSERT INTO organization_contact VALUES (235, 239, 238);
INSERT INTO organization_contact VALUES (236, 240, 239);
INSERT INTO organization_contact VALUES (237, 241, 240);
INSERT INTO organization_contact VALUES (238, 242, 241);
INSERT INTO organization_contact VALUES (239, 243, 242);
INSERT INTO organization_contact VALUES (240, 244, 243);
INSERT INTO organization_contact VALUES (241, 245, 244);
INSERT INTO organization_contact VALUES (242, 246, 245);
INSERT INTO organization_contact VALUES (243, 247, 246);
INSERT INTO organization_contact VALUES (244, 248, 247);
INSERT INTO organization_contact VALUES (245, 249, 248);
INSERT INTO organization_contact VALUES (246, 250, 249);
INSERT INTO organization_contact VALUES (247, 251, 250);
INSERT INTO organization_contact VALUES (248, 252, 251);
INSERT INTO organization_contact VALUES (249, 253, 252);
INSERT INTO organization_contact VALUES (250, 254, 253);
INSERT INTO organization_contact VALUES (251, 255, 254);
INSERT INTO organization_contact VALUES (252, 256, 255);
INSERT INTO organization_contact VALUES (253, 257, 256);
INSERT INTO organization_contact VALUES (254, 258, 257);
INSERT INTO organization_contact VALUES (255, 259, 258);
INSERT INTO organization_contact VALUES (256, 260, 259);
INSERT INTO organization_contact VALUES (257, 261, 260);
INSERT INTO organization_contact VALUES (258, 262, 261);
INSERT INTO organization_contact VALUES (259, 263, 262);
INSERT INTO organization_contact VALUES (260, 264, 263);
INSERT INTO organization_contact VALUES (261, 265, 264);
INSERT INTO organization_contact VALUES (262, 266, 265);
INSERT INTO organization_contact VALUES (263, 267, 266);
INSERT INTO organization_contact VALUES (264, 268, 267);
INSERT INTO organization_contact VALUES (265, 269, 268);
INSERT INTO organization_contact VALUES (266, 270, 269);
INSERT INTO organization_contact VALUES (267, 271, 270);
INSERT INTO organization_contact VALUES (268, 272, 271);
INSERT INTO organization_contact VALUES (269, 273, 272);
INSERT INTO organization_contact VALUES (270, 274, 273);
INSERT INTO organization_contact VALUES (271, 275, 274);
INSERT INTO organization_contact VALUES (272, 276, 275);
INSERT INTO organization_contact VALUES (273, 277, 276);


--
-- Data for Name: organization_language; Type: TABLE DATA; Schema: public; Owner: northbr6
--

INSERT INTO organization_language VALUES (12, 47, 2);
INSERT INTO organization_language VALUES (13, 47, 10);
INSERT INTO organization_language VALUES (14, 48, 10);
INSERT INTO organization_language VALUES (15, 49, 1);
INSERT INTO organization_language VALUES (16, 49, 2);
INSERT INTO organization_language VALUES (17, 49, 8);
INSERT INTO organization_language VALUES (18, 49, 10);
INSERT INTO organization_language VALUES (19, 53, 2);
INSERT INTO organization_language VALUES (20, 54, 2);
INSERT INTO organization_language VALUES (21, 58, 2);
INSERT INTO organization_language VALUES (22, 58, 8);
INSERT INTO organization_language VALUES (23, 58, 10);
INSERT INTO organization_language VALUES (24, 61, 2);
INSERT INTO organization_language VALUES (25, 61, 10);
INSERT INTO organization_language VALUES (26, 64, 12);
INSERT INTO organization_language VALUES (27, 67, 2);
INSERT INTO organization_language VALUES (28, 67, 4);
INSERT INTO organization_language VALUES (29, 72, 10);
INSERT INTO organization_language VALUES (30, 77, 2);
INSERT INTO organization_language VALUES (31, 77, 10);
INSERT INTO organization_language VALUES (32, 81, 2);
INSERT INTO organization_language VALUES (33, 81, 5);
INSERT INTO organization_language VALUES (34, 92, 2);
INSERT INTO organization_language VALUES (35, 94, 2);
INSERT INTO organization_language VALUES (36, 94, 8);
INSERT INTO organization_language VALUES (37, 94, 10);
INSERT INTO organization_language VALUES (38, 100, 2);
INSERT INTO organization_language VALUES (39, 103, 2);
INSERT INTO organization_language VALUES (40, 103, 7);
INSERT INTO organization_language VALUES (41, 104, 2);
INSERT INTO organization_language VALUES (42, 104, 7);
INSERT INTO organization_language VALUES (43, 109, 2);
INSERT INTO organization_language VALUES (44, 110, 2);
INSERT INTO organization_language VALUES (45, 110, 8);
INSERT INTO organization_language VALUES (46, 110, 10);
INSERT INTO organization_language VALUES (47, 111, 2);
INSERT INTO organization_language VALUES (48, 112, 2);
INSERT INTO organization_language VALUES (49, 113, 2);
INSERT INTO organization_language VALUES (50, 113, 10);
INSERT INTO organization_language VALUES (51, 114, 2);
INSERT INTO organization_language VALUES (52, 123, 2);
INSERT INTO organization_language VALUES (53, 124, 2);
INSERT INTO organization_language VALUES (54, 125, 2);
INSERT INTO organization_language VALUES (55, 126, 2);
INSERT INTO organization_language VALUES (56, 137, 2);
INSERT INTO organization_language VALUES (57, 141, 2);
INSERT INTO organization_language VALUES (58, 141, 10);
INSERT INTO organization_language VALUES (59, 146, 1);
INSERT INTO organization_language VALUES (60, 146, 2);
INSERT INTO organization_language VALUES (61, 146, 10);
INSERT INTO organization_language VALUES (62, 146, 13);
INSERT INTO organization_language VALUES (63, 150, 1);
INSERT INTO organization_language VALUES (64, 150, 2);
INSERT INTO organization_language VALUES (65, 150, 3);
INSERT INTO organization_language VALUES (66, 150, 5);
INSERT INTO organization_language VALUES (67, 150, 13);
INSERT INTO organization_language VALUES (68, 151, 1);
INSERT INTO organization_language VALUES (69, 151, 2);
INSERT INTO organization_language VALUES (70, 151, 3);
INSERT INTO organization_language VALUES (71, 151, 5);
INSERT INTO organization_language VALUES (72, 151, 13);
INSERT INTO organization_language VALUES (73, 154, 2);
INSERT INTO organization_language VALUES (74, 158, 2);
INSERT INTO organization_language VALUES (75, 177, 2);
INSERT INTO organization_language VALUES (76, 177, 7);
INSERT INTO organization_language VALUES (77, 177, 8);
INSERT INTO organization_language VALUES (78, 177, 9);
INSERT INTO organization_language VALUES (79, 177, 10);
INSERT INTO organization_language VALUES (80, 178, 2);
INSERT INTO organization_language VALUES (81, 178, 8);
INSERT INTO organization_language VALUES (82, 178, 10);
INSERT INTO organization_language VALUES (83, 178, 11);
INSERT INTO organization_language VALUES (84, 183, 1);
INSERT INTO organization_language VALUES (85, 197, 2);
INSERT INTO organization_language VALUES (86, 197, 6);
INSERT INTO organization_language VALUES (87, 197, 7);
INSERT INTO organization_language VALUES (88, 197, 10);
INSERT INTO organization_language VALUES (89, 199, 7);
INSERT INTO organization_language VALUES (90, 206, 2);
INSERT INTO organization_language VALUES (91, 209, 2);
INSERT INTO organization_language VALUES (92, 210, 2);
INSERT INTO organization_language VALUES (93, 213, 8);
INSERT INTO organization_language VALUES (94, 232, 2);
INSERT INTO organization_language VALUES (95, 236, 2);
INSERT INTO organization_language VALUES (96, 236, 10);
INSERT INTO organization_language VALUES (97, 237, 2);
INSERT INTO organization_language VALUES (98, 239, 2);
INSERT INTO organization_language VALUES (99, 246, 10);
INSERT INTO organization_language VALUES (100, 249, 2);
INSERT INTO organization_language VALUES (101, 249, 8);
INSERT INTO organization_language VALUES (102, 249, 10);
INSERT INTO organization_language VALUES (103, 250, 2);
INSERT INTO organization_language VALUES (104, 254, 2);
INSERT INTO organization_language VALUES (105, 254, 6);
INSERT INTO organization_language VALUES (106, 256, 2);
INSERT INTO organization_language VALUES (107, 256, 8);
INSERT INTO organization_language VALUES (108, 256, 10);
INSERT INTO organization_language VALUES (109, 263, 2);
INSERT INTO organization_language VALUES (110, 263, 3);
INSERT INTO organization_language VALUES (111, 263, 6);
INSERT INTO organization_language VALUES (112, 263, 10);
INSERT INTO organization_language VALUES (113, 263, 13);
INSERT INTO organization_language VALUES (114, 268, 2);
INSERT INTO organization_language VALUES (115, 269, 2);
INSERT INTO organization_language VALUES (116, 277, 1);
INSERT INTO organization_language VALUES (117, 277, 5);
INSERT INTO organization_language VALUES (118, 277, 10);
INSERT INTO organization_language VALUES (119, 277, 13);


--
-- Data for Name: organization_location; Type: TABLE DATA; Schema: public; Owner: northbr6
--

INSERT INTO organization_location VALUES (219, 51, 219);
INSERT INTO organization_location VALUES (220, 52, 220);
INSERT INTO organization_location VALUES (221, 53, 221);
INSERT INTO organization_location VALUES (222, 55, 222);
INSERT INTO organization_location VALUES (223, 56, 223);
INSERT INTO organization_location VALUES (224, 57, 224);
INSERT INTO organization_location VALUES (225, 58, 225);
INSERT INTO organization_location VALUES (8, 45, 8);
INSERT INTO organization_location VALUES (9, 46, 9);
INSERT INTO organization_location VALUES (10, 47, 10);
INSERT INTO organization_location VALUES (11, 48, 11);
INSERT INTO organization_location VALUES (12, 49, 12);
INSERT INTO organization_location VALUES (13, 50, 13);
INSERT INTO organization_location VALUES (226, 59, 226);
INSERT INTO organization_location VALUES (227, 60, 227);
INSERT INTO organization_location VALUES (228, 62, 228);
INSERT INTO organization_location VALUES (229, 63, 229);
INSERT INTO organization_location VALUES (230, 64, 230);
INSERT INTO organization_location VALUES (231, 65, 231);
INSERT INTO organization_location VALUES (232, 66, 232);
INSERT INTO organization_location VALUES (233, 67, 233);
INSERT INTO organization_location VALUES (234, 68, 234);
INSERT INTO organization_location VALUES (235, 69, 235);
INSERT INTO organization_location VALUES (236, 70, 236);
INSERT INTO organization_location VALUES (237, 71, 237);
INSERT INTO organization_location VALUES (238, 72, 238);
INSERT INTO organization_location VALUES (239, 73, 239);
INSERT INTO organization_location VALUES (240, 75, 240);
INSERT INTO organization_location VALUES (241, 76, 241);
INSERT INTO organization_location VALUES (242, 77, 242);
INSERT INTO organization_location VALUES (243, 78, 243);
INSERT INTO organization_location VALUES (244, 79, 244);
INSERT INTO organization_location VALUES (245, 80, 245);
INSERT INTO organization_location VALUES (246, 81, 246);
INSERT INTO organization_location VALUES (247, 82, 247);
INSERT INTO organization_location VALUES (248, 84, 248);
INSERT INTO organization_location VALUES (249, 85, 249);
INSERT INTO organization_location VALUES (250, 86, 250);
INSERT INTO organization_location VALUES (251, 88, 251);
INSERT INTO organization_location VALUES (252, 89, 252);
INSERT INTO organization_location VALUES (253, 90, 253);
INSERT INTO organization_location VALUES (254, 91, 254);
INSERT INTO organization_location VALUES (255, 92, 255);
INSERT INTO organization_location VALUES (256, 93, 256);
INSERT INTO organization_location VALUES (257, 94, 257);
INSERT INTO organization_location VALUES (258, 95, 258);
INSERT INTO organization_location VALUES (259, 96, 259);
INSERT INTO organization_location VALUES (260, 97, 260);
INSERT INTO organization_location VALUES (261, 98, 261);
INSERT INTO organization_location VALUES (262, 99, 262);
INSERT INTO organization_location VALUES (263, 100, 263);
INSERT INTO organization_location VALUES (264, 101, 264);
INSERT INTO organization_location VALUES (265, 102, 265);
INSERT INTO organization_location VALUES (266, 103, 266);
INSERT INTO organization_location VALUES (267, 104, 267);
INSERT INTO organization_location VALUES (268, 105, 268);
INSERT INTO organization_location VALUES (269, 106, 269);
INSERT INTO organization_location VALUES (270, 107, 270);
INSERT INTO organization_location VALUES (271, 108, 271);
INSERT INTO organization_location VALUES (272, 110, 272);
INSERT INTO organization_location VALUES (273, 111, 273);
INSERT INTO organization_location VALUES (274, 112, 274);
INSERT INTO organization_location VALUES (275, 113, 275);
INSERT INTO organization_location VALUES (276, 114, 276);
INSERT INTO organization_location VALUES (277, 115, 277);
INSERT INTO organization_location VALUES (278, 116, 278);
INSERT INTO organization_location VALUES (279, 117, 279);
INSERT INTO organization_location VALUES (280, 118, 280);
INSERT INTO organization_location VALUES (281, 119, 281);
INSERT INTO organization_location VALUES (282, 120, 282);
INSERT INTO organization_location VALUES (283, 121, 283);
INSERT INTO organization_location VALUES (284, 122, 284);
INSERT INTO organization_location VALUES (285, 123, 285);
INSERT INTO organization_location VALUES (286, 124, 286);
INSERT INTO organization_location VALUES (287, 125, 287);
INSERT INTO organization_location VALUES (288, 126, 288);
INSERT INTO organization_location VALUES (289, 127, 289);
INSERT INTO organization_location VALUES (290, 128, 290);
INSERT INTO organization_location VALUES (291, 129, 291);
INSERT INTO organization_location VALUES (292, 130, 292);
INSERT INTO organization_location VALUES (293, 131, 293);
INSERT INTO organization_location VALUES (294, 132, 294);
INSERT INTO organization_location VALUES (295, 133, 295);
INSERT INTO organization_location VALUES (296, 134, 296);
INSERT INTO organization_location VALUES (297, 135, 297);
INSERT INTO organization_location VALUES (298, 138, 298);
INSERT INTO organization_location VALUES (299, 139, 299);
INSERT INTO organization_location VALUES (300, 140, 300);
INSERT INTO organization_location VALUES (301, 141, 301);
INSERT INTO organization_location VALUES (302, 143, 302);
INSERT INTO organization_location VALUES (303, 144, 303);
INSERT INTO organization_location VALUES (304, 145, 304);
INSERT INTO organization_location VALUES (305, 146, 305);
INSERT INTO organization_location VALUES (306, 147, 306);
INSERT INTO organization_location VALUES (307, 148, 307);
INSERT INTO organization_location VALUES (308, 149, 308);
INSERT INTO organization_location VALUES (309, 150, 309);
INSERT INTO organization_location VALUES (310, 151, 310);
INSERT INTO organization_location VALUES (311, 152, 311);
INSERT INTO organization_location VALUES (312, 153, 312);
INSERT INTO organization_location VALUES (313, 154, 313);
INSERT INTO organization_location VALUES (314, 155, 314);
INSERT INTO organization_location VALUES (315, 156, 315);
INSERT INTO organization_location VALUES (316, 157, 316);
INSERT INTO organization_location VALUES (317, 158, 317);
INSERT INTO organization_location VALUES (318, 160, 318);
INSERT INTO organization_location VALUES (319, 161, 319);
INSERT INTO organization_location VALUES (320, 162, 320);
INSERT INTO organization_location VALUES (321, 163, 321);
INSERT INTO organization_location VALUES (322, 164, 322);
INSERT INTO organization_location VALUES (323, 165, 323);
INSERT INTO organization_location VALUES (324, 166, 324);
INSERT INTO organization_location VALUES (325, 167, 325);
INSERT INTO organization_location VALUES (326, 168, 326);
INSERT INTO organization_location VALUES (327, 169, 327);
INSERT INTO organization_location VALUES (328, 170, 328);
INSERT INTO organization_location VALUES (329, 171, 329);
INSERT INTO organization_location VALUES (330, 172, 330);
INSERT INTO organization_location VALUES (331, 173, 331);
INSERT INTO organization_location VALUES (332, 174, 332);
INSERT INTO organization_location VALUES (333, 175, 333);
INSERT INTO organization_location VALUES (334, 176, 334);
INSERT INTO organization_location VALUES (335, 177, 335);
INSERT INTO organization_location VALUES (336, 178, 336);
INSERT INTO organization_location VALUES (337, 179, 337);
INSERT INTO organization_location VALUES (338, 180, 338);
INSERT INTO organization_location VALUES (339, 181, 339);
INSERT INTO organization_location VALUES (340, 182, 340);
INSERT INTO organization_location VALUES (341, 183, 341);
INSERT INTO organization_location VALUES (342, 184, 342);
INSERT INTO organization_location VALUES (343, 185, 343);
INSERT INTO organization_location VALUES (344, 186, 344);
INSERT INTO organization_location VALUES (345, 187, 345);
INSERT INTO organization_location VALUES (346, 188, 346);
INSERT INTO organization_location VALUES (347, 189, 347);
INSERT INTO organization_location VALUES (348, 190, 348);
INSERT INTO organization_location VALUES (349, 192, 349);
INSERT INTO organization_location VALUES (350, 193, 350);
INSERT INTO organization_location VALUES (351, 194, 351);
INSERT INTO organization_location VALUES (352, 195, 352);
INSERT INTO organization_location VALUES (353, 196, 353);
INSERT INTO organization_location VALUES (354, 198, 354);
INSERT INTO organization_location VALUES (355, 199, 355);
INSERT INTO organization_location VALUES (356, 200, 356);
INSERT INTO organization_location VALUES (357, 201, 357);
INSERT INTO organization_location VALUES (358, 202, 358);
INSERT INTO organization_location VALUES (359, 203, 359);
INSERT INTO organization_location VALUES (360, 204, 360);
INSERT INTO organization_location VALUES (361, 205, 361);
INSERT INTO organization_location VALUES (362, 206, 362);
INSERT INTO organization_location VALUES (363, 207, 363);
INSERT INTO organization_location VALUES (364, 208, 364);
INSERT INTO organization_location VALUES (365, 209, 365);
INSERT INTO organization_location VALUES (366, 211, 366);
INSERT INTO organization_location VALUES (367, 212, 367);
INSERT INTO organization_location VALUES (368, 213, 368);
INSERT INTO organization_location VALUES (369, 214, 369);
INSERT INTO organization_location VALUES (370, 215, 370);
INSERT INTO organization_location VALUES (371, 216, 371);
INSERT INTO organization_location VALUES (372, 217, 372);
INSERT INTO organization_location VALUES (373, 219, 373);
INSERT INTO organization_location VALUES (374, 220, 374);
INSERT INTO organization_location VALUES (375, 221, 375);
INSERT INTO organization_location VALUES (376, 222, 376);
INSERT INTO organization_location VALUES (377, 223, 377);
INSERT INTO organization_location VALUES (378, 224, 378);
INSERT INTO organization_location VALUES (379, 225, 379);
INSERT INTO organization_location VALUES (380, 226, 380);
INSERT INTO organization_location VALUES (381, 227, 381);
INSERT INTO organization_location VALUES (382, 228, 382);
INSERT INTO organization_location VALUES (383, 229, 383);
INSERT INTO organization_location VALUES (384, 230, 384);
INSERT INTO organization_location VALUES (385, 231, 385);
INSERT INTO organization_location VALUES (386, 232, 386);
INSERT INTO organization_location VALUES (387, 233, 387);
INSERT INTO organization_location VALUES (388, 234, 388);
INSERT INTO organization_location VALUES (389, 235, 389);
INSERT INTO organization_location VALUES (390, 236, 390);
INSERT INTO organization_location VALUES (391, 237, 391);
INSERT INTO organization_location VALUES (392, 238, 392);
INSERT INTO organization_location VALUES (393, 240, 393);
INSERT INTO organization_location VALUES (394, 241, 394);
INSERT INTO organization_location VALUES (395, 242, 395);
INSERT INTO organization_location VALUES (396, 243, 396);
INSERT INTO organization_location VALUES (397, 244, 397);
INSERT INTO organization_location VALUES (398, 245, 398);
INSERT INTO organization_location VALUES (399, 246, 399);
INSERT INTO organization_location VALUES (400, 247, 400);
INSERT INTO organization_location VALUES (401, 248, 401);
INSERT INTO organization_location VALUES (402, 249, 402);
INSERT INTO organization_location VALUES (403, 250, 403);
INSERT INTO organization_location VALUES (404, 251, 404);
INSERT INTO organization_location VALUES (405, 252, 405);
INSERT INTO organization_location VALUES (406, 253, 406);
INSERT INTO organization_location VALUES (407, 254, 407);
INSERT INTO organization_location VALUES (408, 256, 408);
INSERT INTO organization_location VALUES (439, 257, 439);
INSERT INTO organization_location VALUES (440, 258, 440);
INSERT INTO organization_location VALUES (441, 259, 441);
INSERT INTO organization_location VALUES (442, 260, 442);
INSERT INTO organization_location VALUES (443, 261, 443);
INSERT INTO organization_location VALUES (444, 262, 444);
INSERT INTO organization_location VALUES (445, 263, 445);
INSERT INTO organization_location VALUES (446, 264, 446);
INSERT INTO organization_location VALUES (447, 265, 447);
INSERT INTO organization_location VALUES (448, 266, 448);
INSERT INTO organization_location VALUES (454, 267, 454);
INSERT INTO organization_location VALUES (455, 268, 455);
INSERT INTO organization_location VALUES (456, 269, 456);
INSERT INTO organization_location VALUES (457, 270, 457);
INSERT INTO organization_location VALUES (459, 271, 459);
INSERT INTO organization_location VALUES (460, 272, 460);
INSERT INTO organization_location VALUES (461, 273, 461);
INSERT INTO organization_location VALUES (462, 274, 462);
INSERT INTO organization_location VALUES (463, 275, 463);
INSERT INTO organization_location VALUES (464, 276, 464);
INSERT INTO organization_location VALUES (465, 277, 465);


--
-- Data for Name: organization_organization; Type: TABLE DATA; Schema: public; Owner: northbr6
--

INSERT INTO organization_organization VALUES (1, 1, 10, 'parent', '2014-05-15 14:51:03.396809-06', NULL);
INSERT INTO organization_organization VALUES (3, 1, 12, 'parent', '2014-05-26 19:02:43.508528-06', NULL);
INSERT INTO organization_organization VALUES (4, 1, 9, 'parent', '2014-05-26 19:03:20.140682-06', NULL);
INSERT INTO organization_organization VALUES (2, 13, 1, 'parent', '2014-05-26 18:50:47.835112-06', NULL);
INSERT INTO organization_organization VALUES (6, 13, 13, 'god', '2014-06-01 16:49:05.51139-06', NULL);
INSERT INTO organization_organization VALUES (36, 13, 18, 'parent', '2014-07-31 14:44:16.265383-06', NULL);
INSERT INTO organization_organization VALUES (37, 13, 19, 'parent', '2014-07-31 14:44:28.796995-06', NULL);
INSERT INTO organization_organization VALUES (38, 18, 45, 'parent', '2014-07-31 15:12:26.905639-06', NULL);
INSERT INTO organization_organization VALUES (39, 18, 46, 'parent', '2014-07-31 15:12:26.929753-06', NULL);
INSERT INTO organization_organization VALUES (40, 18, 47, 'parent', '2014-07-31 15:12:26.951385-06', NULL);
INSERT INTO organization_organization VALUES (41, 18, 48, 'parent', '2014-07-31 15:12:26.971783-06', NULL);
INSERT INTO organization_organization VALUES (42, 18, 49, 'parent', '2014-07-31 15:12:26.992396-06', NULL);
INSERT INTO organization_organization VALUES (43, 18, 50, 'parent', '2014-07-31 15:12:27.017377-06', NULL);
INSERT INTO organization_organization VALUES (44, 18, 51, 'parent', '2014-07-31 15:12:27.038065-06', NULL);
INSERT INTO organization_organization VALUES (45, 18, 52, 'parent', '2014-07-31 15:12:27.059392-06', NULL);
INSERT INTO organization_organization VALUES (46, 18, 53, 'parent', '2014-07-31 15:12:27.08039-06', NULL);
INSERT INTO organization_organization VALUES (47, 18, 54, 'parent', '2014-07-31 15:12:27.109565-06', NULL);
INSERT INTO organization_organization VALUES (48, 18, 55, 'parent', '2014-07-31 15:12:27.138384-06', NULL);
INSERT INTO organization_organization VALUES (49, 18, 56, 'parent', '2014-07-31 15:12:27.164378-06', NULL);
INSERT INTO organization_organization VALUES (50, 18, 57, 'parent', '2014-07-31 15:12:27.187565-06', NULL);
INSERT INTO organization_organization VALUES (51, 18, 58, 'parent', '2014-07-31 15:12:27.209937-06', NULL);
INSERT INTO organization_organization VALUES (52, 18, 59, 'parent', '2014-07-31 15:12:27.234531-06', NULL);
INSERT INTO organization_organization VALUES (53, 18, 60, 'parent', '2014-07-31 15:12:27.26098-06', NULL);
INSERT INTO organization_organization VALUES (54, 18, 61, 'parent', '2014-07-31 15:12:27.290505-06', NULL);
INSERT INTO organization_organization VALUES (55, 18, 62, 'parent', '2014-07-31 15:12:27.3148-06', NULL);
INSERT INTO organization_organization VALUES (56, 18, 63, 'parent', '2014-07-31 15:12:27.339381-06', NULL);
INSERT INTO organization_organization VALUES (57, 18, 64, 'parent', '2014-07-31 15:12:27.364399-06', NULL);
INSERT INTO organization_organization VALUES (58, 18, 65, 'parent', '2014-07-31 15:12:27.390123-06', NULL);
INSERT INTO organization_organization VALUES (59, 18, 66, 'parent', '2014-07-31 15:12:27.413395-06', NULL);
INSERT INTO organization_organization VALUES (60, 18, 67, 'parent', '2014-07-31 15:12:27.435939-06', NULL);
INSERT INTO organization_organization VALUES (61, 18, 68, 'parent', '2014-07-31 15:12:27.457986-06', NULL);
INSERT INTO organization_organization VALUES (62, 18, 69, 'parent', '2014-07-31 15:12:27.481044-06', NULL);
INSERT INTO organization_organization VALUES (63, 18, 70, 'parent', '2014-07-31 15:12:27.502621-06', NULL);
INSERT INTO organization_organization VALUES (64, 18, 71, 'parent', '2014-07-31 15:12:27.526384-06', NULL);
INSERT INTO organization_organization VALUES (65, 18, 72, 'parent', '2014-07-31 15:12:27.551959-06', NULL);
INSERT INTO organization_organization VALUES (66, 18, 73, 'parent', '2014-07-31 15:12:27.623938-06', NULL);
INSERT INTO organization_organization VALUES (67, 18, 74, 'parent', '2014-07-31 15:12:27.650026-06', NULL);
INSERT INTO organization_organization VALUES (68, 18, 75, 'parent', '2014-07-31 15:12:27.672386-06', NULL);
INSERT INTO organization_organization VALUES (69, 18, 76, 'parent', '2014-07-31 15:12:27.706406-06', NULL);
INSERT INTO organization_organization VALUES (70, 18, 77, 'parent', '2014-07-31 15:12:27.77938-06', NULL);
INSERT INTO organization_organization VALUES (71, 18, 78, 'parent', '2014-07-31 15:12:27.800888-06', NULL);
INSERT INTO organization_organization VALUES (72, 18, 79, 'parent', '2014-07-31 15:12:27.822432-06', NULL);
INSERT INTO organization_organization VALUES (73, 18, 80, 'parent', '2014-07-31 15:12:27.852239-06', NULL);
INSERT INTO organization_organization VALUES (74, 18, 81, 'parent', '2014-07-31 15:12:27.873376-06', NULL);
INSERT INTO organization_organization VALUES (75, 18, 82, 'parent', '2014-07-31 15:12:27.906546-06', NULL);
INSERT INTO organization_organization VALUES (76, 18, 83, 'parent', '2014-07-31 15:12:27.930706-06', NULL);
INSERT INTO organization_organization VALUES (77, 18, 84, 'parent', '2014-07-31 15:12:27.951388-06', NULL);
INSERT INTO organization_organization VALUES (78, 18, 85, 'parent', '2014-07-31 15:12:27.971391-06', NULL);
INSERT INTO organization_organization VALUES (79, 18, 86, 'parent', '2014-07-31 15:12:27.991566-06', NULL);
INSERT INTO organization_organization VALUES (80, 18, 87, 'parent', '2014-07-31 15:12:28.023632-06', NULL);
INSERT INTO organization_organization VALUES (81, 18, 88, 'parent', '2014-07-31 15:12:28.065486-06', NULL);
INSERT INTO organization_organization VALUES (82, 18, 89, 'parent', '2014-07-31 15:12:28.08661-06', NULL);
INSERT INTO organization_organization VALUES (83, 18, 90, 'parent', '2014-07-31 15:12:28.108923-06', NULL);
INSERT INTO organization_organization VALUES (84, 18, 91, 'parent', '2014-07-31 15:12:28.129681-06', NULL);
INSERT INTO organization_organization VALUES (85, 18, 92, 'parent', '2014-07-31 15:12:28.153104-06', NULL);
INSERT INTO organization_organization VALUES (86, 18, 93, 'parent', '2014-07-31 15:12:28.182395-06', NULL);
INSERT INTO organization_organization VALUES (87, 18, 94, 'parent', '2014-07-31 15:12:28.204382-06', NULL);
INSERT INTO organization_organization VALUES (88, 18, 95, 'parent', '2014-07-31 15:12:28.227534-06', NULL);
INSERT INTO organization_organization VALUES (89, 18, 96, 'parent', '2014-07-31 15:12:28.250515-06', NULL);
INSERT INTO organization_organization VALUES (90, 18, 97, 'parent', '2014-07-31 15:12:28.271748-06', NULL);
INSERT INTO organization_organization VALUES (91, 18, 98, 'parent', '2014-07-31 15:12:28.29212-06', NULL);
INSERT INTO organization_organization VALUES (92, 18, 99, 'parent', '2014-07-31 15:12:28.312878-06', NULL);
INSERT INTO organization_organization VALUES (93, 18, 100, 'parent', '2014-07-31 15:12:28.334388-06', NULL);
INSERT INTO organization_organization VALUES (94, 18, 101, 'parent', '2014-07-31 15:12:28.357137-06', NULL);
INSERT INTO organization_organization VALUES (95, 18, 102, 'parent', '2014-07-31 15:12:28.377867-06', NULL);
INSERT INTO organization_organization VALUES (96, 18, 103, 'parent', '2014-07-31 15:12:28.401387-06', NULL);
INSERT INTO organization_organization VALUES (97, 18, 104, 'parent', '2014-07-31 15:12:28.423946-06', NULL);
INSERT INTO organization_organization VALUES (98, 18, 105, 'parent', '2014-07-31 15:12:28.445476-06', NULL);
INSERT INTO organization_organization VALUES (99, 18, 106, 'parent', '2014-07-31 15:12:28.466388-06', NULL);
INSERT INTO organization_organization VALUES (100, 18, 107, 'parent', '2014-07-31 15:12:28.486386-06', NULL);
INSERT INTO organization_organization VALUES (101, 18, 108, 'parent', '2014-07-31 15:12:28.506389-06', NULL);
INSERT INTO organization_organization VALUES (102, 18, 109, 'parent', '2014-07-31 15:12:28.526776-06', NULL);
INSERT INTO organization_organization VALUES (103, 18, 110, 'parent', '2014-07-31 15:12:28.547084-06', NULL);
INSERT INTO organization_organization VALUES (104, 18, 111, 'parent', '2014-07-31 15:12:28.567636-06', NULL);
INSERT INTO organization_organization VALUES (105, 18, 112, 'parent', '2014-07-31 15:12:28.603608-06', NULL);
INSERT INTO organization_organization VALUES (106, 18, 113, 'parent', '2014-07-31 15:12:28.626937-06', NULL);
INSERT INTO organization_organization VALUES (107, 18, 114, 'parent', '2014-07-31 15:12:28.649024-06', NULL);
INSERT INTO organization_organization VALUES (108, 18, 115, 'parent', '2014-07-31 15:12:28.670778-06', NULL);
INSERT INTO organization_organization VALUES (109, 18, 116, 'parent', '2014-07-31 15:12:28.692834-06', NULL);
INSERT INTO organization_organization VALUES (110, 18, 117, 'parent', '2014-07-31 15:12:28.717382-06', NULL);
INSERT INTO organization_organization VALUES (111, 18, 118, 'parent', '2014-07-31 15:12:28.742385-06', NULL);
INSERT INTO organization_organization VALUES (112, 18, 119, 'parent', '2014-07-31 15:12:28.767959-06', NULL);
INSERT INTO organization_organization VALUES (113, 18, 120, 'parent', '2014-07-31 15:12:28.793051-06', NULL);
INSERT INTO organization_organization VALUES (114, 18, 121, 'parent', '2014-07-31 15:12:28.814847-06', NULL);
INSERT INTO organization_organization VALUES (115, 18, 122, 'parent', '2014-07-31 15:12:28.840485-06', NULL);
INSERT INTO organization_organization VALUES (116, 18, 123, 'parent', '2014-07-31 15:12:28.864829-06', NULL);
INSERT INTO organization_organization VALUES (117, 18, 124, 'parent', '2014-07-31 15:12:28.885607-06', NULL);
INSERT INTO organization_organization VALUES (118, 18, 125, 'parent', '2014-07-31 15:12:28.906388-06', NULL);
INSERT INTO organization_organization VALUES (119, 18, 126, 'parent', '2014-07-31 15:12:28.926975-06', NULL);
INSERT INTO organization_organization VALUES (120, 18, 127, 'parent', '2014-07-31 15:12:28.947528-06', NULL);
INSERT INTO organization_organization VALUES (121, 18, 128, 'parent', '2014-07-31 15:12:29.002062-06', NULL);
INSERT INTO organization_organization VALUES (122, 18, 129, 'parent', '2014-07-31 15:12:29.035492-06', NULL);
INSERT INTO organization_organization VALUES (123, 18, 130, 'parent', '2014-07-31 15:12:29.058877-06', NULL);
INSERT INTO organization_organization VALUES (124, 18, 131, 'parent', '2014-07-31 15:12:29.140726-06', NULL);
INSERT INTO organization_organization VALUES (125, 18, 132, 'parent', '2014-07-31 15:12:29.163403-06', NULL);
INSERT INTO organization_organization VALUES (126, 18, 133, 'parent', '2014-07-31 15:12:29.191791-06', NULL);
INSERT INTO organization_organization VALUES (127, 18, 134, 'parent', '2014-07-31 15:12:29.21514-06', NULL);
INSERT INTO organization_organization VALUES (128, 18, 135, 'parent', '2014-07-31 15:12:29.239393-06', NULL);
INSERT INTO organization_organization VALUES (129, 18, 136, 'parent', '2014-07-31 15:12:29.262749-06', NULL);
INSERT INTO organization_organization VALUES (130, 18, 137, 'parent', '2014-07-31 15:12:29.285614-06', NULL);
INSERT INTO organization_organization VALUES (131, 18, 138, 'parent', '2014-07-31 15:12:29.307075-06', NULL);
INSERT INTO organization_organization VALUES (132, 18, 139, 'parent', '2014-07-31 15:12:29.33188-06', NULL);
INSERT INTO organization_organization VALUES (133, 18, 140, 'parent', '2014-07-31 15:12:29.358801-06', NULL);
INSERT INTO organization_organization VALUES (134, 18, 141, 'parent', '2014-07-31 15:12:29.382776-06', NULL);
INSERT INTO organization_organization VALUES (135, 18, 142, 'parent', '2014-07-31 15:12:29.410558-06', NULL);
INSERT INTO organization_organization VALUES (136, 18, 143, 'parent', '2014-07-31 15:12:29.440128-06', NULL);
INSERT INTO organization_organization VALUES (137, 18, 144, 'parent', '2014-07-31 15:12:29.467511-06', NULL);
INSERT INTO organization_organization VALUES (138, 18, 145, 'parent', '2014-07-31 15:12:29.495791-06', NULL);
INSERT INTO organization_organization VALUES (139, 18, 146, 'parent', '2014-07-31 15:12:29.520386-06', NULL);
INSERT INTO organization_organization VALUES (140, 18, 147, 'parent', '2014-07-31 15:12:29.544737-06', NULL);
INSERT INTO organization_organization VALUES (141, 18, 148, 'parent', '2014-07-31 15:12:29.570673-06', NULL);
INSERT INTO organization_organization VALUES (142, 18, 149, 'parent', '2014-07-31 15:12:29.628464-06', NULL);
INSERT INTO organization_organization VALUES (143, 18, 150, 'parent', '2014-07-31 15:12:29.661444-06', NULL);
INSERT INTO organization_organization VALUES (144, 18, 151, 'parent', '2014-07-31 15:12:29.693393-06', NULL);
INSERT INTO organization_organization VALUES (145, 18, 152, 'parent', '2014-07-31 15:12:29.723087-06', NULL);
INSERT INTO organization_organization VALUES (146, 18, 153, 'parent', '2014-07-31 15:12:29.772393-06', NULL);
INSERT INTO organization_organization VALUES (147, 18, 154, 'parent', '2014-07-31 15:12:29.826393-06', NULL);
INSERT INTO organization_organization VALUES (148, 18, 155, 'parent', '2014-07-31 15:12:29.850383-06', NULL);
INSERT INTO organization_organization VALUES (149, 18, 156, 'parent', '2014-07-31 15:12:29.872945-06', NULL);
INSERT INTO organization_organization VALUES (150, 18, 157, 'parent', '2014-07-31 15:12:29.895609-06', NULL);
INSERT INTO organization_organization VALUES (151, 18, 158, 'parent', '2014-07-31 15:12:29.922725-06', NULL);
INSERT INTO organization_organization VALUES (152, 18, 159, 'parent', '2014-07-31 15:12:29.94832-06', NULL);
INSERT INTO organization_organization VALUES (153, 18, 160, 'parent', '2014-07-31 15:12:29.969605-06', NULL);
INSERT INTO organization_organization VALUES (154, 18, 161, 'parent', '2014-07-31 15:12:29.991386-06', NULL);
INSERT INTO organization_organization VALUES (155, 18, 162, 'parent', '2014-07-31 15:12:30.012961-06', NULL);
INSERT INTO organization_organization VALUES (156, 18, 163, 'parent', '2014-07-31 15:12:30.037729-06', NULL);
INSERT INTO organization_organization VALUES (157, 18, 164, 'parent', '2014-07-31 15:12:30.060377-06', NULL);
INSERT INTO organization_organization VALUES (158, 18, 165, 'parent', '2014-07-31 15:12:30.082038-06', NULL);
INSERT INTO organization_organization VALUES (159, 18, 166, 'parent', '2014-07-31 15:12:30.10478-06', NULL);
INSERT INTO organization_organization VALUES (160, 18, 167, 'parent', '2014-07-31 15:12:30.130477-06', NULL);
INSERT INTO organization_organization VALUES (161, 18, 168, 'parent', '2014-07-31 15:12:30.153675-06', NULL);
INSERT INTO organization_organization VALUES (162, 18, 169, 'parent', '2014-07-31 15:12:30.179437-06', NULL);
INSERT INTO organization_organization VALUES (163, 18, 170, 'parent', '2014-07-31 15:12:30.202527-06', NULL);
INSERT INTO organization_organization VALUES (164, 18, 171, 'parent', '2014-07-31 15:12:30.225884-06', NULL);
INSERT INTO organization_organization VALUES (165, 18, 172, 'parent', '2014-07-31 15:12:30.250762-06', NULL);
INSERT INTO organization_organization VALUES (166, 18, 173, 'parent', '2014-07-31 15:12:30.273411-06', NULL);
INSERT INTO organization_organization VALUES (167, 18, 174, 'parent', '2014-07-31 15:12:30.297385-06', NULL);
INSERT INTO organization_organization VALUES (168, 18, 175, 'parent', '2014-07-31 15:12:30.320026-06', NULL);
INSERT INTO organization_organization VALUES (169, 18, 176, 'parent', '2014-07-31 15:12:30.342751-06', NULL);
INSERT INTO organization_organization VALUES (170, 18, 177, 'parent', '2014-07-31 15:12:30.365579-06', NULL);
INSERT INTO organization_organization VALUES (171, 18, 178, 'parent', '2014-07-31 15:12:30.39007-06', NULL);
INSERT INTO organization_organization VALUES (172, 18, 179, 'parent', '2014-07-31 15:12:30.413595-06', NULL);
INSERT INTO organization_organization VALUES (173, 18, 180, 'parent', '2014-07-31 15:12:30.438982-06', NULL);
INSERT INTO organization_organization VALUES (174, 18, 181, 'parent', '2014-07-31 15:12:30.462392-06', NULL);
INSERT INTO organization_organization VALUES (175, 18, 182, 'parent', '2014-07-31 15:12:30.486509-06', NULL);
INSERT INTO organization_organization VALUES (176, 18, 183, 'parent', '2014-07-31 15:12:30.510386-06', NULL);
INSERT INTO organization_organization VALUES (177, 18, 184, 'parent', '2014-07-31 15:12:30.533531-06', NULL);
INSERT INTO organization_organization VALUES (178, 18, 185, 'parent', '2014-07-31 15:12:30.55839-06', NULL);
INSERT INTO organization_organization VALUES (179, 18, 186, 'parent', '2014-07-31 15:12:30.585394-06', NULL);
INSERT INTO organization_organization VALUES (180, 18, 187, 'parent', '2014-07-31 15:12:30.62238-06', NULL);
INSERT INTO organization_organization VALUES (181, 18, 188, 'parent', '2014-07-31 15:12:30.654903-06', NULL);
INSERT INTO organization_organization VALUES (182, 18, 189, 'parent', '2014-07-31 15:12:30.715425-06', NULL);
INSERT INTO organization_organization VALUES (183, 18, 190, 'parent', '2014-07-31 15:12:30.747669-06', NULL);
INSERT INTO organization_organization VALUES (184, 18, 191, 'parent', '2014-07-31 15:12:30.77638-06', NULL);
INSERT INTO organization_organization VALUES (185, 18, 192, 'parent', '2014-07-31 15:12:30.800389-06', NULL);
INSERT INTO organization_organization VALUES (186, 18, 193, 'parent', '2014-07-31 15:12:30.825552-06', NULL);
INSERT INTO organization_organization VALUES (187, 18, 194, 'parent', '2014-07-31 15:12:30.849717-06', NULL);
INSERT INTO organization_organization VALUES (188, 18, 195, 'parent', '2014-07-31 15:12:30.873623-06', NULL);
INSERT INTO organization_organization VALUES (189, 18, 196, 'parent', '2014-07-31 15:12:30.895384-06', NULL);
INSERT INTO organization_organization VALUES (190, 18, 197, 'parent', '2014-07-31 15:12:30.917799-06', NULL);
INSERT INTO organization_organization VALUES (191, 18, 198, 'parent', '2014-07-31 15:12:30.939063-06', NULL);
INSERT INTO organization_organization VALUES (192, 18, 199, 'parent', '2014-07-31 15:12:30.963459-06', NULL);
INSERT INTO organization_organization VALUES (193, 18, 200, 'parent', '2014-07-31 15:12:30.988382-06', NULL);
INSERT INTO organization_organization VALUES (194, 18, 201, 'parent', '2014-07-31 15:12:31.012595-06', NULL);
INSERT INTO organization_organization VALUES (195, 18, 202, 'parent', '2014-07-31 15:12:31.036704-06', NULL);
INSERT INTO organization_organization VALUES (196, 18, 203, 'parent', '2014-07-31 15:12:31.061789-06', NULL);
INSERT INTO organization_organization VALUES (197, 18, 204, 'parent', '2014-07-31 15:12:31.085696-06', NULL);
INSERT INTO organization_organization VALUES (198, 18, 205, 'parent', '2014-07-31 15:12:31.110711-06', NULL);
INSERT INTO organization_organization VALUES (199, 18, 206, 'parent', '2014-07-31 15:12:31.137393-06', NULL);
INSERT INTO organization_organization VALUES (200, 18, 207, 'parent', '2014-07-31 15:12:31.162534-06', NULL);
INSERT INTO organization_organization VALUES (201, 18, 208, 'parent', '2014-07-31 15:12:31.188388-06', NULL);
INSERT INTO organization_organization VALUES (202, 18, 209, 'parent', '2014-07-31 15:12:31.213593-06', NULL);
INSERT INTO organization_organization VALUES (203, 18, 210, 'parent', '2014-07-31 15:12:31.23839-06', NULL);
INSERT INTO organization_organization VALUES (204, 18, 211, 'parent', '2014-07-31 15:12:31.264512-06', NULL);
INSERT INTO organization_organization VALUES (205, 18, 212, 'parent', '2014-07-31 15:12:31.29297-06', NULL);
INSERT INTO organization_organization VALUES (206, 18, 213, 'parent', '2014-07-31 15:12:31.329556-06', NULL);
INSERT INTO organization_organization VALUES (207, 18, 214, 'parent', '2014-07-31 15:12:31.353894-06', NULL);
INSERT INTO organization_organization VALUES (208, 18, 215, 'parent', '2014-07-31 15:12:31.378386-06', NULL);
INSERT INTO organization_organization VALUES (209, 18, 216, 'parent', '2014-07-31 15:12:31.402736-06', NULL);
INSERT INTO organization_organization VALUES (210, 18, 217, 'parent', '2014-07-31 15:12:31.425806-06', NULL);
INSERT INTO organization_organization VALUES (211, 18, 218, 'parent', '2014-07-31 15:12:31.451474-06', NULL);
INSERT INTO organization_organization VALUES (212, 18, 219, 'parent', '2014-07-31 15:12:31.475538-06', NULL);
INSERT INTO organization_organization VALUES (213, 18, 220, 'parent', '2014-07-31 15:12:31.507906-06', NULL);
INSERT INTO organization_organization VALUES (214, 18, 221, 'parent', '2014-07-31 15:12:31.53307-06', NULL);
INSERT INTO organization_organization VALUES (215, 18, 222, 'parent', '2014-07-31 15:12:31.559799-06', NULL);
INSERT INTO organization_organization VALUES (216, 18, 223, 'parent', '2014-07-31 15:12:31.582036-06', NULL);
INSERT INTO organization_organization VALUES (217, 18, 224, 'parent', '2014-07-31 15:12:31.662109-06', NULL);
INSERT INTO organization_organization VALUES (218, 18, 225, 'parent', '2014-07-31 15:12:31.700537-06', NULL);
INSERT INTO organization_organization VALUES (219, 18, 226, 'parent', '2014-07-31 15:12:31.735487-06', NULL);
INSERT INTO organization_organization VALUES (220, 18, 227, 'parent', '2014-07-31 15:12:31.760538-06', NULL);
INSERT INTO organization_organization VALUES (221, 18, 228, 'parent', '2014-07-31 15:12:31.83492-06', NULL);
INSERT INTO organization_organization VALUES (222, 18, 229, 'parent', '2014-07-31 15:12:31.856701-06', NULL);
INSERT INTO organization_organization VALUES (223, 18, 230, 'parent', '2014-07-31 15:12:31.88038-06', NULL);
INSERT INTO organization_organization VALUES (224, 18, 231, 'parent', '2014-07-31 15:12:31.904657-06', NULL);
INSERT INTO organization_organization VALUES (225, 18, 232, 'parent', '2014-07-31 15:12:31.925521-06', NULL);
INSERT INTO organization_organization VALUES (226, 18, 233, 'parent', '2014-07-31 15:12:31.952744-06', NULL);
INSERT INTO organization_organization VALUES (227, 18, 234, 'parent', '2014-07-31 15:12:31.97915-06', NULL);
INSERT INTO organization_organization VALUES (228, 18, 235, 'parent', '2014-07-31 15:12:32.002038-06', NULL);
INSERT INTO organization_organization VALUES (229, 18, 236, 'parent', '2014-07-31 15:12:32.024122-06', NULL);
INSERT INTO organization_organization VALUES (230, 18, 237, 'parent', '2014-07-31 15:12:32.044971-06', NULL);
INSERT INTO organization_organization VALUES (231, 18, 238, 'parent', '2014-07-31 15:12:32.065492-06', NULL);
INSERT INTO organization_organization VALUES (232, 18, 239, 'parent', '2014-07-31 15:12:32.08789-06', NULL);
INSERT INTO organization_organization VALUES (233, 18, 240, 'parent', '2014-07-31 15:12:32.1108-06', NULL);
INSERT INTO organization_organization VALUES (234, 18, 241, 'parent', '2014-07-31 15:12:32.132653-06', NULL);
INSERT INTO organization_organization VALUES (235, 18, 242, 'parent', '2014-07-31 15:12:32.158378-06', NULL);
INSERT INTO organization_organization VALUES (236, 18, 243, 'parent', '2014-07-31 15:12:32.18638-06', NULL);
INSERT INTO organization_organization VALUES (237, 18, 244, 'parent', '2014-07-31 15:12:32.212805-06', NULL);
INSERT INTO organization_organization VALUES (238, 18, 245, 'parent', '2014-07-31 15:12:32.236634-06', NULL);
INSERT INTO organization_organization VALUES (239, 18, 246, 'parent', '2014-07-31 15:12:32.258942-06', NULL);
INSERT INTO organization_organization VALUES (240, 18, 247, 'parent', '2014-07-31 15:12:32.297394-06', NULL);
INSERT INTO organization_organization VALUES (241, 18, 248, 'parent', '2014-07-31 15:12:32.324694-06', NULL);
INSERT INTO organization_organization VALUES (242, 18, 249, 'parent', '2014-07-31 15:12:32.349009-06', NULL);
INSERT INTO organization_organization VALUES (243, 18, 250, 'parent', '2014-07-31 15:12:32.372759-06', NULL);
INSERT INTO organization_organization VALUES (244, 18, 251, 'parent', '2014-07-31 15:12:32.397738-06', NULL);
INSERT INTO organization_organization VALUES (245, 18, 252, 'parent', '2014-07-31 15:12:32.422057-06', NULL);
INSERT INTO organization_organization VALUES (246, 18, 253, 'parent', '2014-07-31 15:12:32.449088-06', NULL);
INSERT INTO organization_organization VALUES (247, 18, 254, 'parent', '2014-07-31 15:12:32.474874-06', NULL);
INSERT INTO organization_organization VALUES (248, 18, 255, 'parent', '2014-07-31 15:12:32.500391-06', NULL);
INSERT INTO organization_organization VALUES (249, 18, 256, 'parent', '2014-07-31 15:12:32.528393-06', NULL);
INSERT INTO organization_organization VALUES (250, 18, 257, 'parent', '2014-07-31 15:12:32.55081-06', NULL);
INSERT INTO organization_organization VALUES (251, 18, 258, 'parent', '2014-07-31 15:12:32.579551-06', NULL);
INSERT INTO organization_organization VALUES (252, 18, 259, 'parent', '2014-07-31 15:12:32.609982-06', NULL);
INSERT INTO organization_organization VALUES (253, 18, 260, 'parent', '2014-07-31 15:12:32.637593-06', NULL);
INSERT INTO organization_organization VALUES (254, 18, 261, 'parent', '2014-07-31 15:12:32.662543-06', NULL);
INSERT INTO organization_organization VALUES (255, 18, 262, 'parent', '2014-07-31 15:12:32.715376-06', NULL);
INSERT INTO organization_organization VALUES (256, 18, 263, 'parent', '2014-07-31 15:12:32.73906-06', NULL);
INSERT INTO organization_organization VALUES (257, 18, 264, 'parent', '2014-07-31 15:12:32.764645-06', NULL);
INSERT INTO organization_organization VALUES (258, 18, 265, 'parent', '2014-07-31 15:12:32.786551-06', NULL);
INSERT INTO organization_organization VALUES (259, 18, 266, 'parent', '2014-07-31 15:12:32.809648-06', NULL);
INSERT INTO organization_organization VALUES (260, 18, 267, 'parent', '2014-07-31 15:12:32.836576-06', NULL);
INSERT INTO organization_organization VALUES (261, 18, 268, 'parent', '2014-07-31 15:12:32.861864-06', NULL);
INSERT INTO organization_organization VALUES (262, 18, 269, 'parent', '2014-07-31 15:12:32.883868-06', NULL);
INSERT INTO organization_organization VALUES (263, 18, 270, 'parent', '2014-07-31 15:12:32.905679-06', NULL);
INSERT INTO organization_organization VALUES (264, 18, 271, 'parent', '2014-07-31 15:12:32.927637-06', NULL);
INSERT INTO organization_organization VALUES (265, 18, 272, 'parent', '2014-07-31 15:12:32.949677-06', NULL);
INSERT INTO organization_organization VALUES (266, 18, 273, 'parent', '2014-07-31 15:12:32.972598-06', NULL);
INSERT INTO organization_organization VALUES (267, 18, 274, 'parent', '2014-07-31 15:12:32.994671-06', NULL);
INSERT INTO organization_organization VALUES (268, 18, 275, 'parent', '2014-07-31 15:12:33.017725-06', NULL);
INSERT INTO organization_organization VALUES (269, 18, 276, 'parent', '2014-07-31 15:12:33.045508-06', NULL);
INSERT INTO organization_organization VALUES (270, 18, 277, 'parent', '2014-07-31 15:12:33.069455-06', NULL);


--
-- Data for Name: organization_program; Type: TABLE DATA; Schema: public; Owner: northbr6
--

INSERT INTO organization_program VALUES (1, 46, 1);
INSERT INTO organization_program VALUES (2, 46, 2);
INSERT INTO organization_program VALUES (3, 46, 3);
INSERT INTO organization_program VALUES (4, 50, 4);
INSERT INTO organization_program VALUES (5, 50, 5);
INSERT INTO organization_program VALUES (6, 50, 6);
INSERT INTO organization_program VALUES (7, 50, 7);
INSERT INTO organization_program VALUES (8, 52, 8);


--
-- Data for Name: organization_topic; Type: TABLE DATA; Schema: public; Owner: northbr6
--

INSERT INTO organization_topic VALUES (26, 45, NULL, 17);
INSERT INTO organization_topic VALUES (27, 46, NULL, 8);
INSERT INTO organization_topic VALUES (28, 46, NULL, 17);
INSERT INTO organization_topic VALUES (29, 46, NULL, 18);
INSERT INTO organization_topic VALUES (30, 46, NULL, 30);
INSERT INTO organization_topic VALUES (31, 46, NULL, 33);
INSERT INTO organization_topic VALUES (32, 47, NULL, 13);
INSERT INTO organization_topic VALUES (33, 48, NULL, 23);
INSERT INTO organization_topic VALUES (34, 48, NULL, 26);
INSERT INTO organization_topic VALUES (35, 48, NULL, 27);
INSERT INTO organization_topic VALUES (36, 48, NULL, 33);
INSERT INTO organization_topic VALUES (37, 48, NULL, 37);
INSERT INTO organization_topic VALUES (38, 49, NULL, 13);
INSERT INTO organization_topic VALUES (47, 50, NULL, 7);
INSERT INTO organization_topic VALUES (51, 50, NULL, 14);
INSERT INTO organization_topic VALUES (52, 50, NULL, 16);
INSERT INTO organization_topic VALUES (53, 50, NULL, 19);
INSERT INTO organization_topic VALUES (54, 50, NULL, 27);
INSERT INTO organization_topic VALUES (55, 50, NULL, 37);
INSERT INTO organization_topic VALUES (56, 51, NULL, 34);
INSERT INTO organization_topic VALUES (57, 52, NULL, 31);
INSERT INTO organization_topic VALUES (58, 53, NULL, 13);
INSERT INTO organization_topic VALUES (59, 54, NULL, 1);
INSERT INTO organization_topic VALUES (60, 54, NULL, 3);
INSERT INTO organization_topic VALUES (61, 54, NULL, 20);
INSERT INTO organization_topic VALUES (62, 54, NULL, 23);
INSERT INTO organization_topic VALUES (63, 54, NULL, 38);
INSERT INTO organization_topic VALUES (64, 55, NULL, 4);
INSERT INTO organization_topic VALUES (65, 56, NULL, 35);
INSERT INTO organization_topic VALUES (66, 57, NULL, 13);
INSERT INTO organization_topic VALUES (67, 58, NULL, 13);
INSERT INTO organization_topic VALUES (68, 59, NULL, 4);
INSERT INTO organization_topic VALUES (69, 60, NULL, 37);
INSERT INTO organization_topic VALUES (70, 61, NULL, 5);
INSERT INTO organization_topic VALUES (71, 62, NULL, 9);
INSERT INTO organization_topic VALUES (72, 62, NULL, 13);
INSERT INTO organization_topic VALUES (73, 62, NULL, 30);
INSERT INTO organization_topic VALUES (74, 62, NULL, 32);
INSERT INTO organization_topic VALUES (75, 63, NULL, 9);
INSERT INTO organization_topic VALUES (76, 64, NULL, 2);
INSERT INTO organization_topic VALUES (77, 64, NULL, 3);
INSERT INTO organization_topic VALUES (78, 64, NULL, 7);
INSERT INTO organization_topic VALUES (79, 64, NULL, 12);
INSERT INTO organization_topic VALUES (80, 64, NULL, 13);
INSERT INTO organization_topic VALUES (81, 64, NULL, 14);
INSERT INTO organization_topic VALUES (82, 64, NULL, 16);
INSERT INTO organization_topic VALUES (83, 64, NULL, 19);
INSERT INTO organization_topic VALUES (84, 64, NULL, 25);
INSERT INTO organization_topic VALUES (85, 64, NULL, 27);
INSERT INTO organization_topic VALUES (86, 64, NULL, 29);
INSERT INTO organization_topic VALUES (87, 64, NULL, 38);
INSERT INTO organization_topic VALUES (88, 65, NULL, 17);
INSERT INTO organization_topic VALUES (89, 65, NULL, 37);
INSERT INTO organization_topic VALUES (90, 66, NULL, 7);
INSERT INTO organization_topic VALUES (91, 66, NULL, 12);
INSERT INTO organization_topic VALUES (92, 66, NULL, 19);
INSERT INTO organization_topic VALUES (93, 66, NULL, 21);
INSERT INTO organization_topic VALUES (94, 66, NULL, 25);
INSERT INTO organization_topic VALUES (95, 66, NULL, 27);
INSERT INTO organization_topic VALUES (96, 66, NULL, 29);
INSERT INTO organization_topic VALUES (97, 66, NULL, 32);
INSERT INTO organization_topic VALUES (98, 66, NULL, 36);
INSERT INTO organization_topic VALUES (99, 67, NULL, 4);
INSERT INTO organization_topic VALUES (100, 67, NULL, 5);
INSERT INTO organization_topic VALUES (101, 67, NULL, 7);
INSERT INTO organization_topic VALUES (102, 67, NULL, 9);
INSERT INTO organization_topic VALUES (103, 67, NULL, 13);
INSERT INTO organization_topic VALUES (104, 67, NULL, 14);
INSERT INTO organization_topic VALUES (105, 67, NULL, 15);
INSERT INTO organization_topic VALUES (106, 67, NULL, 16);
INSERT INTO organization_topic VALUES (107, 67, NULL, 19);
INSERT INTO organization_topic VALUES (108, 67, NULL, 25);
INSERT INTO organization_topic VALUES (109, 67, NULL, 27);
INSERT INTO organization_topic VALUES (110, 67, NULL, 33);
INSERT INTO organization_topic VALUES (111, 67, NULL, 38);
INSERT INTO organization_topic VALUES (112, 68, NULL, 7);
INSERT INTO organization_topic VALUES (113, 68, NULL, 15);
INSERT INTO organization_topic VALUES (114, 68, NULL, 19);
INSERT INTO organization_topic VALUES (115, 68, NULL, 21);
INSERT INTO organization_topic VALUES (116, 68, NULL, 25);
INSERT INTO organization_topic VALUES (117, 69, NULL, 17);
INSERT INTO organization_topic VALUES (118, 70, NULL, 2);
INSERT INTO organization_topic VALUES (119, 70, NULL, 7);
INSERT INTO organization_topic VALUES (120, 70, NULL, 14);
INSERT INTO organization_topic VALUES (121, 70, NULL, 16);
INSERT INTO organization_topic VALUES (122, 70, NULL, 19);
INSERT INTO organization_topic VALUES (123, 70, NULL, 29);
INSERT INTO organization_topic VALUES (124, 70, NULL, 40);
INSERT INTO organization_topic VALUES (125, 71, NULL, 5);
INSERT INTO organization_topic VALUES (126, 71, NULL, 41);
INSERT INTO organization_topic VALUES (127, 72, NULL, 12);
INSERT INTO organization_topic VALUES (128, 72, NULL, 13);
INSERT INTO organization_topic VALUES (129, 72, NULL, 15);
INSERT INTO organization_topic VALUES (130, 72, NULL, 30);
INSERT INTO organization_topic VALUES (131, 72, NULL, 38);
INSERT INTO organization_topic VALUES (132, 73, NULL, 21);
INSERT INTO organization_topic VALUES (133, 73, NULL, 25);
INSERT INTO organization_topic VALUES (134, 73, NULL, 27);
INSERT INTO organization_topic VALUES (135, 73, NULL, 33);
INSERT INTO organization_topic VALUES (136, 74, NULL, 2);
INSERT INTO organization_topic VALUES (137, 74, NULL, 3);
INSERT INTO organization_topic VALUES (138, 74, NULL, 18);
INSERT INTO organization_topic VALUES (139, 74, NULL, 29);
INSERT INTO organization_topic VALUES (140, 74, NULL, 30);
INSERT INTO organization_topic VALUES (141, 74, NULL, 32);
INSERT INTO organization_topic VALUES (142, 75, NULL, 13);
INSERT INTO organization_topic VALUES (143, 76, NULL, 7);
INSERT INTO organization_topic VALUES (144, 76, NULL, 21);
INSERT INTO organization_topic VALUES (145, 76, NULL, 31);
INSERT INTO organization_topic VALUES (146, 76, NULL, 33);
INSERT INTO organization_topic VALUES (147, 77, NULL, 1);
INSERT INTO organization_topic VALUES (148, 77, NULL, 20);
INSERT INTO organization_topic VALUES (149, 77, NULL, 23);
INSERT INTO organization_topic VALUES (150, 77, NULL, 26);
INSERT INTO organization_topic VALUES (151, 77, NULL, 33);
INSERT INTO organization_topic VALUES (152, 77, NULL, 37);
INSERT INTO organization_topic VALUES (153, 78, NULL, 1);
INSERT INTO organization_topic VALUES (154, 80, NULL, 37);
INSERT INTO organization_topic VALUES (155, 81, NULL, 17);
INSERT INTO organization_topic VALUES (156, 81, NULL, 20);
INSERT INTO organization_topic VALUES (157, 81, NULL, 25);
INSERT INTO organization_topic VALUES (158, 81, NULL, 27);
INSERT INTO organization_topic VALUES (159, 81, NULL, 38);
INSERT INTO organization_topic VALUES (160, 82, NULL, 35);
INSERT INTO organization_topic VALUES (161, 83, NULL, 25);
INSERT INTO organization_topic VALUES (162, 84, NULL, 37);
INSERT INTO organization_topic VALUES (163, 85, NULL, 37);
INSERT INTO organization_topic VALUES (164, 86, NULL, 17);
INSERT INTO organization_topic VALUES (165, 88, NULL, 2);
INSERT INTO organization_topic VALUES (166, 88, NULL, 3);
INSERT INTO organization_topic VALUES (167, 88, NULL, 4);
INSERT INTO organization_topic VALUES (168, 88, NULL, 5);
INSERT INTO organization_topic VALUES (169, 88, NULL, 6);
INSERT INTO organization_topic VALUES (170, 88, NULL, 9);
INSERT INTO organization_topic VALUES (171, 88, NULL, 12);
INSERT INTO organization_topic VALUES (172, 88, NULL, 13);
INSERT INTO organization_topic VALUES (173, 88, NULL, 23);
INSERT INTO organization_topic VALUES (174, 88, NULL, 28);
INSERT INTO organization_topic VALUES (175, 88, NULL, 30);
INSERT INTO organization_topic VALUES (176, 88, NULL, 32);
INSERT INTO organization_topic VALUES (177, 88, NULL, 36);
INSERT INTO organization_topic VALUES (178, 89, NULL, 3);
INSERT INTO organization_topic VALUES (179, 89, NULL, 13);
INSERT INTO organization_topic VALUES (180, 89, NULL, 22);
INSERT INTO organization_topic VALUES (181, 90, NULL, 21);
INSERT INTO organization_topic VALUES (182, 91, NULL, 15);
INSERT INTO organization_topic VALUES (183, 91, NULL, 30);
INSERT INTO organization_topic VALUES (184, 91, NULL, 33);
INSERT INTO organization_topic VALUES (185, 92, NULL, 13);
INSERT INTO organization_topic VALUES (186, 93, NULL, 8);
INSERT INTO organization_topic VALUES (187, 93, NULL, 9);
INSERT INTO organization_topic VALUES (188, 93, NULL, 28);
INSERT INTO organization_topic VALUES (189, 93, NULL, 30);
INSERT INTO organization_topic VALUES (190, 94, NULL, 2);
INSERT INTO organization_topic VALUES (191, 94, NULL, 7);
INSERT INTO organization_topic VALUES (192, 94, NULL, 24);
INSERT INTO organization_topic VALUES (193, 94, NULL, 26);
INSERT INTO organization_topic VALUES (194, 94, NULL, 28);
INSERT INTO organization_topic VALUES (195, 94, NULL, 29);
INSERT INTO organization_topic VALUES (196, 94, NULL, 34);
INSERT INTO organization_topic VALUES (197, 95, NULL, 13);
INSERT INTO organization_topic VALUES (198, 96, NULL, 1);
INSERT INTO organization_topic VALUES (199, 96, NULL, 2);
INSERT INTO organization_topic VALUES (200, 96, NULL, 4);
INSERT INTO organization_topic VALUES (201, 96, NULL, 7);
INSERT INTO organization_topic VALUES (202, 96, NULL, 8);
INSERT INTO organization_topic VALUES (203, 96, NULL, 9);
INSERT INTO organization_topic VALUES (204, 96, NULL, 10);
INSERT INTO organization_topic VALUES (205, 96, NULL, 11);
INSERT INTO organization_topic VALUES (206, 96, NULL, 13);
INSERT INTO organization_topic VALUES (207, 96, NULL, 14);
INSERT INTO organization_topic VALUES (208, 96, NULL, 17);
INSERT INTO organization_topic VALUES (209, 96, NULL, 18);
INSERT INTO organization_topic VALUES (210, 96, NULL, 19);
INSERT INTO organization_topic VALUES (211, 96, NULL, 20);
INSERT INTO organization_topic VALUES (212, 96, NULL, 21);
INSERT INTO organization_topic VALUES (213, 96, NULL, 25);
INSERT INTO organization_topic VALUES (214, 96, NULL, 28);
INSERT INTO organization_topic VALUES (215, 96, NULL, 29);
INSERT INTO organization_topic VALUES (216, 96, NULL, 30);
INSERT INTO organization_topic VALUES (217, 96, NULL, 31);
INSERT INTO organization_topic VALUES (218, 96, NULL, 32);
INSERT INTO organization_topic VALUES (219, 96, NULL, 33);
INSERT INTO organization_topic VALUES (220, 96, NULL, 34);
INSERT INTO organization_topic VALUES (221, 96, NULL, 36);
INSERT INTO organization_topic VALUES (222, 96, NULL, 37);
INSERT INTO organization_topic VALUES (223, 96, NULL, 38);
INSERT INTO organization_topic VALUES (224, 96, NULL, 39);
INSERT INTO organization_topic VALUES (225, 96, NULL, 40);
INSERT INTO organization_topic VALUES (226, 96, NULL, 41);
INSERT INTO organization_topic VALUES (227, 97, NULL, 2);
INSERT INTO organization_topic VALUES (228, 97, NULL, 3);
INSERT INTO organization_topic VALUES (229, 97, NULL, 4);
INSERT INTO organization_topic VALUES (230, 97, NULL, 5);
INSERT INTO organization_topic VALUES (231, 97, NULL, 6);
INSERT INTO organization_topic VALUES (232, 97, NULL, 9);
INSERT INTO organization_topic VALUES (233, 97, NULL, 12);
INSERT INTO organization_topic VALUES (234, 97, NULL, 13);
INSERT INTO organization_topic VALUES (235, 97, NULL, 23);
INSERT INTO organization_topic VALUES (236, 97, NULL, 28);
INSERT INTO organization_topic VALUES (237, 97, NULL, 30);
INSERT INTO organization_topic VALUES (238, 97, NULL, 32);
INSERT INTO organization_topic VALUES (239, 97, NULL, 36);
INSERT INTO organization_topic VALUES (240, 98, NULL, 35);
INSERT INTO organization_topic VALUES (241, 99, NULL, 37);
INSERT INTO organization_topic VALUES (242, 100, NULL, 1);
INSERT INTO organization_topic VALUES (243, 100, NULL, 4);
INSERT INTO organization_topic VALUES (244, 100, NULL, 5);
INSERT INTO organization_topic VALUES (245, 100, NULL, 7);
INSERT INTO organization_topic VALUES (246, 100, NULL, 25);
INSERT INTO organization_topic VALUES (247, 100, NULL, 29);
INSERT INTO organization_topic VALUES (248, 100, NULL, 32);
INSERT INTO organization_topic VALUES (249, 100, NULL, 39);
INSERT INTO organization_topic VALUES (250, 101, NULL, 4);
INSERT INTO organization_topic VALUES (251, 101, NULL, 7);
INSERT INTO organization_topic VALUES (252, 101, NULL, 25);
INSERT INTO organization_topic VALUES (253, 101, NULL, 27);
INSERT INTO organization_topic VALUES (254, 101, NULL, 30);
INSERT INTO organization_topic VALUES (255, 101, NULL, 32);
INSERT INTO organization_topic VALUES (256, 101, NULL, 37);
INSERT INTO organization_topic VALUES (257, 101, NULL, 39);
INSERT INTO organization_topic VALUES (258, 102, NULL, 27);
INSERT INTO organization_topic VALUES (259, 102, NULL, 37);
INSERT INTO organization_topic VALUES (260, 102, NULL, 38);
INSERT INTO organization_topic VALUES (261, 103, NULL, 4);
INSERT INTO organization_topic VALUES (262, 103, NULL, 5);
INSERT INTO organization_topic VALUES (263, 103, NULL, 7);
INSERT INTO organization_topic VALUES (264, 103, NULL, 9);
INSERT INTO organization_topic VALUES (265, 103, NULL, 13);
INSERT INTO organization_topic VALUES (266, 103, NULL, 14);
INSERT INTO organization_topic VALUES (267, 103, NULL, 15);
INSERT INTO organization_topic VALUES (268, 103, NULL, 16);
INSERT INTO organization_topic VALUES (269, 103, NULL, 17);
INSERT INTO organization_topic VALUES (270, 103, NULL, 19);
INSERT INTO organization_topic VALUES (271, 103, NULL, 20);
INSERT INTO organization_topic VALUES (272, 103, NULL, 24);
INSERT INTO organization_topic VALUES (273, 103, NULL, 27);
INSERT INTO organization_topic VALUES (274, 103, NULL, 31);
INSERT INTO organization_topic VALUES (275, 103, NULL, 32);
INSERT INTO organization_topic VALUES (276, 103, NULL, 35);
INSERT INTO organization_topic VALUES (277, 103, NULL, 38);
INSERT INTO organization_topic VALUES (278, 104, NULL, 2);
INSERT INTO organization_topic VALUES (279, 104, NULL, 3);
INSERT INTO organization_topic VALUES (280, 104, NULL, 4);
INSERT INTO organization_topic VALUES (281, 104, NULL, 5);
INSERT INTO organization_topic VALUES (282, 104, NULL, 7);
INSERT INTO organization_topic VALUES (283, 104, NULL, 8);
INSERT INTO organization_topic VALUES (284, 104, NULL, 9);
INSERT INTO organization_topic VALUES (285, 104, NULL, 10);
INSERT INTO organization_topic VALUES (286, 104, NULL, 11);
INSERT INTO organization_topic VALUES (287, 104, NULL, 12);
INSERT INTO organization_topic VALUES (288, 104, NULL, 13);
INSERT INTO organization_topic VALUES (289, 104, NULL, 14);
INSERT INTO organization_topic VALUES (290, 104, NULL, 15);
INSERT INTO organization_topic VALUES (291, 104, NULL, 16);
INSERT INTO organization_topic VALUES (292, 104, NULL, 17);
INSERT INTO organization_topic VALUES (293, 104, NULL, 18);
INSERT INTO organization_topic VALUES (294, 104, NULL, 19);
INSERT INTO organization_topic VALUES (295, 104, NULL, 20);
INSERT INTO organization_topic VALUES (296, 104, NULL, 21);
INSERT INTO organization_topic VALUES (297, 104, NULL, 22);
INSERT INTO organization_topic VALUES (298, 104, NULL, 23);
INSERT INTO organization_topic VALUES (299, 104, NULL, 24);
INSERT INTO organization_topic VALUES (300, 104, NULL, 25);
INSERT INTO organization_topic VALUES (301, 104, NULL, 27);
INSERT INTO organization_topic VALUES (302, 104, NULL, 28);
INSERT INTO organization_topic VALUES (303, 104, NULL, 29);
INSERT INTO organization_topic VALUES (304, 104, NULL, 30);
INSERT INTO organization_topic VALUES (305, 104, NULL, 32);
INSERT INTO organization_topic VALUES (306, 104, NULL, 38);
INSERT INTO organization_topic VALUES (307, 104, NULL, 39);
INSERT INTO organization_topic VALUES (308, 105, NULL, 21);
INSERT INTO organization_topic VALUES (309, 105, NULL, 25);
INSERT INTO organization_topic VALUES (310, 105, NULL, 33);
INSERT INTO organization_topic VALUES (311, 106, NULL, 15);
INSERT INTO organization_topic VALUES (312, 106, NULL, 30);
INSERT INTO organization_topic VALUES (313, 106, NULL, 33);
INSERT INTO organization_topic VALUES (314, 107, NULL, 35);
INSERT INTO organization_topic VALUES (315, 108, NULL, 17);
INSERT INTO organization_topic VALUES (316, 108, NULL, 37);
INSERT INTO organization_topic VALUES (317, 109, NULL, 3);
INSERT INTO organization_topic VALUES (318, 109, NULL, 5);
INSERT INTO organization_topic VALUES (319, 109, NULL, 6);
INSERT INTO organization_topic VALUES (320, 109, NULL, 8);
INSERT INTO organization_topic VALUES (321, 109, NULL, 9);
INSERT INTO organization_topic VALUES (322, 109, NULL, 12);
INSERT INTO organization_topic VALUES (323, 109, NULL, 20);
INSERT INTO organization_topic VALUES (324, 109, NULL, 21);
INSERT INTO organization_topic VALUES (325, 109, NULL, 28);
INSERT INTO organization_topic VALUES (326, 109, NULL, 30);
INSERT INTO organization_topic VALUES (327, 109, NULL, 38);
INSERT INTO organization_topic VALUES (328, 109, NULL, 40);
INSERT INTO organization_topic VALUES (329, 109, NULL, 41);
INSERT INTO organization_topic VALUES (330, 110, NULL, 2);
INSERT INTO organization_topic VALUES (331, 110, NULL, 7);
INSERT INTO organization_topic VALUES (332, 110, NULL, 13);
INSERT INTO organization_topic VALUES (333, 110, NULL, 14);
INSERT INTO organization_topic VALUES (334, 110, NULL, 19);
INSERT INTO organization_topic VALUES (335, 110, NULL, 38);
INSERT INTO organization_topic VALUES (336, 110, NULL, 39);
INSERT INTO organization_topic VALUES (337, 111, NULL, 2);
INSERT INTO organization_topic VALUES (338, 111, NULL, 4);
INSERT INTO organization_topic VALUES (339, 111, NULL, 7);
INSERT INTO organization_topic VALUES (340, 111, NULL, 11);
INSERT INTO organization_topic VALUES (341, 111, NULL, 13);
INSERT INTO organization_topic VALUES (342, 111, NULL, 14);
INSERT INTO organization_topic VALUES (343, 111, NULL, 17);
INSERT INTO organization_topic VALUES (344, 111, NULL, 19);
INSERT INTO organization_topic VALUES (345, 111, NULL, 25);
INSERT INTO organization_topic VALUES (346, 111, NULL, 26);
INSERT INTO organization_topic VALUES (347, 111, NULL, 28);
INSERT INTO organization_topic VALUES (348, 111, NULL, 29);
INSERT INTO organization_topic VALUES (349, 111, NULL, 34);
INSERT INTO organization_topic VALUES (350, 111, NULL, 38);
INSERT INTO organization_topic VALUES (351, 112, NULL, 13);
INSERT INTO organization_topic VALUES (352, 112, NULL, 14);
INSERT INTO organization_topic VALUES (353, 112, NULL, 16);
INSERT INTO organization_topic VALUES (354, 112, NULL, 19);
INSERT INTO organization_topic VALUES (355, 112, NULL, 25);
INSERT INTO organization_topic VALUES (356, 112, NULL, 27);
INSERT INTO organization_topic VALUES (357, 112, NULL, 36);
INSERT INTO organization_topic VALUES (358, 113, NULL, 13);
INSERT INTO organization_topic VALUES (359, 114, NULL, 20);
INSERT INTO organization_topic VALUES (360, 114, NULL, 27);
INSERT INTO organization_topic VALUES (361, 114, NULL, 37);
INSERT INTO organization_topic VALUES (362, 115, NULL, 35);
INSERT INTO organization_topic VALUES (363, 116, NULL, 5);
INSERT INTO organization_topic VALUES (364, 116, NULL, 7);
INSERT INTO organization_topic VALUES (365, 116, NULL, 9);
INSERT INTO organization_topic VALUES (366, 116, NULL, 12);
INSERT INTO organization_topic VALUES (367, 116, NULL, 13);
INSERT INTO organization_topic VALUES (368, 116, NULL, 16);
INSERT INTO organization_topic VALUES (369, 116, NULL, 19);
INSERT INTO organization_topic VALUES (370, 116, NULL, 21);
INSERT INTO organization_topic VALUES (371, 116, NULL, 22);
INSERT INTO organization_topic VALUES (372, 116, NULL, 25);
INSERT INTO organization_topic VALUES (373, 116, NULL, 27);
INSERT INTO organization_topic VALUES (374, 116, NULL, 39);
INSERT INTO organization_topic VALUES (375, 116, NULL, 40);
INSERT INTO organization_topic VALUES (376, 117, NULL, 37);
INSERT INTO organization_topic VALUES (377, 118, NULL, 17);
INSERT INTO organization_topic VALUES (378, 118, NULL, 35);
INSERT INTO organization_topic VALUES (379, 118, NULL, 37);
INSERT INTO organization_topic VALUES (380, 119, NULL, 4);
INSERT INTO organization_topic VALUES (381, 119, NULL, 26);
INSERT INTO organization_topic VALUES (382, 121, NULL, 17);
INSERT INTO organization_topic VALUES (383, 121, NULL, 37);
INSERT INTO organization_topic VALUES (384, 122, NULL, 17);
INSERT INTO organization_topic VALUES (385, 122, NULL, 37);
INSERT INTO organization_topic VALUES (386, 123, NULL, 2);
INSERT INTO organization_topic VALUES (387, 123, NULL, 4);
INSERT INTO organization_topic VALUES (388, 123, NULL, 5);
INSERT INTO organization_topic VALUES (389, 123, NULL, 6);
INSERT INTO organization_topic VALUES (390, 123, NULL, 7);
INSERT INTO organization_topic VALUES (391, 123, NULL, 8);
INSERT INTO organization_topic VALUES (392, 123, NULL, 9);
INSERT INTO organization_topic VALUES (393, 123, NULL, 11);
INSERT INTO organization_topic VALUES (394, 123, NULL, 12);
INSERT INTO organization_topic VALUES (395, 123, NULL, 13);
INSERT INTO organization_topic VALUES (396, 123, NULL, 14);
INSERT INTO organization_topic VALUES (397, 123, NULL, 17);
INSERT INTO organization_topic VALUES (398, 123, NULL, 19);
INSERT INTO organization_topic VALUES (399, 125, NULL, 27);
INSERT INTO organization_topic VALUES (400, 125, NULL, 37);
INSERT INTO organization_topic VALUES (401, 125, NULL, 38);
INSERT INTO organization_topic VALUES (402, 126, NULL, 1);
INSERT INTO organization_topic VALUES (403, 126, NULL, 2);
INSERT INTO organization_topic VALUES (404, 126, NULL, 3);
INSERT INTO organization_topic VALUES (405, 126, NULL, 4);
INSERT INTO organization_topic VALUES (406, 126, NULL, 5);
INSERT INTO organization_topic VALUES (407, 126, NULL, 7);
INSERT INTO organization_topic VALUES (408, 126, NULL, 8);
INSERT INTO organization_topic VALUES (409, 126, NULL, 9);
INSERT INTO organization_topic VALUES (410, 126, NULL, 13);
INSERT INTO organization_topic VALUES (411, 126, NULL, 14);
INSERT INTO organization_topic VALUES (412, 126, NULL, 16);
INSERT INTO organization_topic VALUES (413, 126, NULL, 17);
INSERT INTO organization_topic VALUES (414, 126, NULL, 18);
INSERT INTO organization_topic VALUES (415, 126, NULL, 19);
INSERT INTO organization_topic VALUES (416, 126, NULL, 21);
INSERT INTO organization_topic VALUES (417, 126, NULL, 24);
INSERT INTO organization_topic VALUES (418, 126, NULL, 27);
INSERT INTO organization_topic VALUES (419, 126, NULL, 29);
INSERT INTO organization_topic VALUES (420, 126, NULL, 30);
INSERT INTO organization_topic VALUES (421, 126, NULL, 31);
INSERT INTO organization_topic VALUES (422, 126, NULL, 32);
INSERT INTO organization_topic VALUES (423, 126, NULL, 38);
INSERT INTO organization_topic VALUES (424, 126, NULL, 39);
INSERT INTO organization_topic VALUES (425, 126, NULL, 40);
INSERT INTO organization_topic VALUES (426, 127, NULL, 17);
INSERT INTO organization_topic VALUES (427, 127, NULL, 35);
INSERT INTO organization_topic VALUES (428, 127, NULL, 37);
INSERT INTO organization_topic VALUES (429, 128, NULL, 17);
INSERT INTO organization_topic VALUES (430, 128, NULL, 18);
INSERT INTO organization_topic VALUES (431, 128, NULL, 20);
INSERT INTO organization_topic VALUES (432, 128, NULL, 21);
INSERT INTO organization_topic VALUES (433, 128, NULL, 30);
INSERT INTO organization_topic VALUES (434, 128, NULL, 37);
INSERT INTO organization_topic VALUES (435, 129, NULL, 37);
INSERT INTO organization_topic VALUES (436, 130, NULL, 37);
INSERT INTO organization_topic VALUES (437, 131, NULL, 37);
INSERT INTO organization_topic VALUES (438, 132, NULL, 7);
INSERT INTO organization_topic VALUES (439, 132, NULL, 15);
INSERT INTO organization_topic VALUES (440, 132, NULL, 17);
INSERT INTO organization_topic VALUES (441, 132, NULL, 19);
INSERT INTO organization_topic VALUES (442, 132, NULL, 21);
INSERT INTO organization_topic VALUES (443, 132, NULL, 25);
INSERT INTO organization_topic VALUES (444, 133, NULL, 37);
INSERT INTO organization_topic VALUES (445, 134, NULL, 1);
INSERT INTO organization_topic VALUES (446, 134, NULL, 2);
INSERT INTO organization_topic VALUES (447, 134, NULL, 3);
INSERT INTO organization_topic VALUES (448, 134, NULL, 4);
INSERT INTO organization_topic VALUES (449, 134, NULL, 5);
INSERT INTO organization_topic VALUES (450, 134, NULL, 6);
INSERT INTO organization_topic VALUES (451, 134, NULL, 8);
INSERT INTO organization_topic VALUES (452, 134, NULL, 9);
INSERT INTO organization_topic VALUES (453, 134, NULL, 11);
INSERT INTO organization_topic VALUES (454, 134, NULL, 17);
INSERT INTO organization_topic VALUES (455, 134, NULL, 23);
INSERT INTO organization_topic VALUES (456, 134, NULL, 24);
INSERT INTO organization_topic VALUES (457, 134, NULL, 27);
INSERT INTO organization_topic VALUES (458, 134, NULL, 28);
INSERT INTO organization_topic VALUES (459, 134, NULL, 29);
INSERT INTO organization_topic VALUES (460, 134, NULL, 30);
INSERT INTO organization_topic VALUES (461, 134, NULL, 33);
INSERT INTO organization_topic VALUES (462, 134, NULL, 34);
INSERT INTO organization_topic VALUES (463, 134, NULL, 38);
INSERT INTO organization_topic VALUES (464, 134, NULL, 39);
INSERT INTO organization_topic VALUES (465, 134, NULL, 41);
INSERT INTO organization_topic VALUES (466, 135, NULL, 5);
INSERT INTO organization_topic VALUES (467, 135, NULL, 14);
INSERT INTO organization_topic VALUES (468, 135, NULL, 19);
INSERT INTO organization_topic VALUES (469, 135, NULL, 33);
INSERT INTO organization_topic VALUES (470, 135, NULL, 36);
INSERT INTO organization_topic VALUES (471, 137, NULL, 4);
INSERT INTO organization_topic VALUES (472, 137, NULL, 5);
INSERT INTO organization_topic VALUES (473, 137, NULL, 6);
INSERT INTO organization_topic VALUES (474, 137, NULL, 9);
INSERT INTO organization_topic VALUES (475, 137, NULL, 10);
INSERT INTO organization_topic VALUES (476, 137, NULL, 15);
INSERT INTO organization_topic VALUES (477, 137, NULL, 20);
INSERT INTO organization_topic VALUES (478, 137, NULL, 30);
INSERT INTO organization_topic VALUES (479, 137, NULL, 40);
INSERT INTO organization_topic VALUES (480, 137, NULL, 41);
INSERT INTO organization_topic VALUES (481, 138, NULL, 5);
INSERT INTO organization_topic VALUES (482, 138, NULL, 30);
INSERT INTO organization_topic VALUES (483, 138, NULL, 32);
INSERT INTO organization_topic VALUES (484, 140, NULL, 4);
INSERT INTO organization_topic VALUES (485, 140, NULL, 27);
INSERT INTO organization_topic VALUES (486, 140, NULL, 38);
INSERT INTO organization_topic VALUES (487, 141, NULL, 13);
INSERT INTO organization_topic VALUES (488, 142, NULL, 8);
INSERT INTO organization_topic VALUES (489, 142, NULL, 28);
INSERT INTO organization_topic VALUES (490, 142, NULL, 30);
INSERT INTO organization_topic VALUES (491, 143, NULL, 16);
INSERT INTO organization_topic VALUES (492, 143, NULL, 33);
INSERT INTO organization_topic VALUES (493, 144, NULL, 36);
INSERT INTO organization_topic VALUES (494, 144, NULL, 41);
INSERT INTO organization_topic VALUES (495, 145, NULL, 28);
INSERT INTO organization_topic VALUES (496, 146, NULL, 1);
INSERT INTO organization_topic VALUES (497, 146, NULL, 3);
INSERT INTO organization_topic VALUES (498, 146, NULL, 6);
INSERT INTO organization_topic VALUES (499, 146, NULL, 8);
INSERT INTO organization_topic VALUES (500, 146, NULL, 9);
INSERT INTO organization_topic VALUES (501, 146, NULL, 10);
INSERT INTO organization_topic VALUES (502, 146, NULL, 12);
INSERT INTO organization_topic VALUES (503, 146, NULL, 15);
INSERT INTO organization_topic VALUES (504, 146, NULL, 18);
INSERT INTO organization_topic VALUES (505, 146, NULL, 22);
INSERT INTO organization_topic VALUES (506, 146, NULL, 24);
INSERT INTO organization_topic VALUES (507, 146, NULL, 25);
INSERT INTO organization_topic VALUES (508, 146, NULL, 26);
INSERT INTO organization_topic VALUES (509, 146, NULL, 27);
INSERT INTO organization_topic VALUES (510, 146, NULL, 28);
INSERT INTO organization_topic VALUES (511, 146, NULL, 29);
INSERT INTO organization_topic VALUES (512, 146, NULL, 30);
INSERT INTO organization_topic VALUES (513, 146, NULL, 32);
INSERT INTO organization_topic VALUES (514, 146, NULL, 33);
INSERT INTO organization_topic VALUES (515, 146, NULL, 34);
INSERT INTO organization_topic VALUES (516, 146, NULL, 38);
INSERT INTO organization_topic VALUES (517, 146, NULL, 39);
INSERT INTO organization_topic VALUES (518, 147, NULL, 36);
INSERT INTO organization_topic VALUES (519, 147, NULL, 41);
INSERT INTO organization_topic VALUES (520, 148, NULL, 17);
INSERT INTO organization_topic VALUES (521, 148, NULL, 37);
INSERT INTO organization_topic VALUES (522, 149, NULL, 17);
INSERT INTO organization_topic VALUES (523, 149, NULL, 37);
INSERT INTO organization_topic VALUES (524, 150, NULL, 6);
INSERT INTO organization_topic VALUES (525, 150, NULL, 9);
INSERT INTO organization_topic VALUES (526, 150, NULL, 13);
INSERT INTO organization_topic VALUES (527, 150, NULL, 20);
INSERT INTO organization_topic VALUES (528, 150, NULL, 24);
INSERT INTO organization_topic VALUES (529, 150, NULL, 25);
INSERT INTO organization_topic VALUES (530, 150, NULL, 27);
INSERT INTO organization_topic VALUES (531, 150, NULL, 29);
INSERT INTO organization_topic VALUES (532, 150, NULL, 30);
INSERT INTO organization_topic VALUES (533, 150, NULL, 32);
INSERT INTO organization_topic VALUES (534, 150, NULL, 33);
INSERT INTO organization_topic VALUES (535, 150, NULL, 37);
INSERT INTO organization_topic VALUES (536, 150, NULL, 38);
INSERT INTO organization_topic VALUES (537, 151, NULL, 5);
INSERT INTO organization_topic VALUES (538, 151, NULL, 6);
INSERT INTO organization_topic VALUES (539, 151, NULL, 12);
INSERT INTO organization_topic VALUES (540, 151, NULL, 13);
INSERT INTO organization_topic VALUES (541, 151, NULL, 17);
INSERT INTO organization_topic VALUES (542, 151, NULL, 22);
INSERT INTO organization_topic VALUES (543, 151, NULL, 28);
INSERT INTO organization_topic VALUES (544, 151, NULL, 29);
INSERT INTO organization_topic VALUES (545, 151, NULL, 30);
INSERT INTO organization_topic VALUES (546, 151, NULL, 32);
INSERT INTO organization_topic VALUES (547, 151, NULL, 37);
INSERT INTO organization_topic VALUES (548, 152, NULL, 17);
INSERT INTO organization_topic VALUES (549, 152, NULL, 37);
INSERT INTO organization_topic VALUES (550, 153, NULL, 13);
INSERT INTO organization_topic VALUES (551, 154, NULL, 13);
INSERT INTO organization_topic VALUES (552, 155, NULL, 2);
INSERT INTO organization_topic VALUES (553, 155, NULL, 7);
INSERT INTO organization_topic VALUES (554, 155, NULL, 14);
INSERT INTO organization_topic VALUES (555, 155, NULL, 16);
INSERT INTO organization_topic VALUES (556, 155, NULL, 19);
INSERT INTO organization_topic VALUES (557, 155, NULL, 29);
INSERT INTO organization_topic VALUES (558, 155, NULL, 40);
INSERT INTO organization_topic VALUES (559, 156, NULL, 8);
INSERT INTO organization_topic VALUES (560, 156, NULL, 30);
INSERT INTO organization_topic VALUES (561, 156, NULL, 32);
INSERT INTO organization_topic VALUES (562, 157, NULL, 35);
INSERT INTO organization_topic VALUES (563, 158, NULL, 1);
INSERT INTO organization_topic VALUES (564, 158, NULL, 13);
INSERT INTO organization_topic VALUES (565, 158, NULL, 15);
INSERT INTO organization_topic VALUES (566, 158, NULL, 20);
INSERT INTO organization_topic VALUES (567, 158, NULL, 27);
INSERT INTO organization_topic VALUES (568, 158, NULL, 28);
INSERT INTO organization_topic VALUES (569, 158, NULL, 38);
INSERT INTO organization_topic VALUES (570, 159, NULL, 30);
INSERT INTO organization_topic VALUES (571, 159, NULL, 32);
INSERT INTO organization_topic VALUES (572, 160, NULL, 17);
INSERT INTO organization_topic VALUES (573, 160, NULL, 37);
INSERT INTO organization_topic VALUES (574, 161, NULL, 37);
INSERT INTO organization_topic VALUES (575, 162, NULL, 25);
INSERT INTO organization_topic VALUES (576, 162, NULL, 31);
INSERT INTO organization_topic VALUES (577, 163, NULL, 17);
INSERT INTO organization_topic VALUES (578, 163, NULL, 37);
INSERT INTO organization_topic VALUES (579, 164, NULL, 5);
INSERT INTO organization_topic VALUES (580, 164, NULL, 23);
INSERT INTO organization_topic VALUES (581, 164, NULL, 26);
INSERT INTO organization_topic VALUES (582, 164, NULL, 41);
INSERT INTO organization_topic VALUES (583, 165, NULL, 34);
INSERT INTO organization_topic VALUES (584, 166, NULL, 8);
INSERT INTO organization_topic VALUES (585, 166, NULL, 15);
INSERT INTO organization_topic VALUES (586, 166, NULL, 23);
INSERT INTO organization_topic VALUES (587, 166, NULL, 28);
INSERT INTO organization_topic VALUES (588, 166, NULL, 34);
INSERT INTO organization_topic VALUES (589, 167, NULL, 8);
INSERT INTO organization_topic VALUES (590, 167, NULL, 15);
INSERT INTO organization_topic VALUES (591, 167, NULL, 23);
INSERT INTO organization_topic VALUES (592, 167, NULL, 28);
INSERT INTO organization_topic VALUES (593, 167, NULL, 34);
INSERT INTO organization_topic VALUES (594, 168, NULL, 25);
INSERT INTO organization_topic VALUES (595, 168, NULL, 31);
INSERT INTO organization_topic VALUES (596, 169, NULL, 37);
INSERT INTO organization_topic VALUES (597, 170, NULL, 17);
INSERT INTO organization_topic VALUES (598, 170, NULL, 37);
INSERT INTO organization_topic VALUES (599, 171, NULL, 17);
INSERT INTO organization_topic VALUES (600, 171, NULL, 37);
INSERT INTO organization_topic VALUES (601, 172, NULL, 4);
INSERT INTO organization_topic VALUES (602, 172, NULL, 26);
INSERT INTO organization_topic VALUES (603, 173, NULL, 35);
INSERT INTO organization_topic VALUES (604, 174, NULL, 4);
INSERT INTO organization_topic VALUES (605, 174, NULL, 7);
INSERT INTO organization_topic VALUES (606, 174, NULL, 25);
INSERT INTO organization_topic VALUES (607, 174, NULL, 27);
INSERT INTO organization_topic VALUES (608, 174, NULL, 30);
INSERT INTO organization_topic VALUES (609, 174, NULL, 32);
INSERT INTO organization_topic VALUES (610, 174, NULL, 37);
INSERT INTO organization_topic VALUES (611, 174, NULL, 39);
INSERT INTO organization_topic VALUES (612, 175, NULL, 17);
INSERT INTO organization_topic VALUES (613, 175, NULL, 37);
INSERT INTO organization_topic VALUES (614, 176, NULL, 17);
INSERT INTO organization_topic VALUES (615, 176, NULL, 37);
INSERT INTO organization_topic VALUES (616, 177, NULL, 13);
INSERT INTO organization_topic VALUES (617, 178, NULL, 13);
INSERT INTO organization_topic VALUES (618, 179, NULL, 9);
INSERT INTO organization_topic VALUES (619, 181, NULL, 17);
INSERT INTO organization_topic VALUES (620, 182, NULL, 17);
INSERT INTO organization_topic VALUES (621, 182, NULL, 37);
INSERT INTO organization_topic VALUES (622, 183, NULL, 3);
INSERT INTO organization_topic VALUES (623, 183, NULL, 4);
INSERT INTO organization_topic VALUES (624, 183, NULL, 7);
INSERT INTO organization_topic VALUES (625, 183, NULL, 13);
INSERT INTO organization_topic VALUES (626, 183, NULL, 15);
INSERT INTO organization_topic VALUES (627, 183, NULL, 16);
INSERT INTO organization_topic VALUES (628, 183, NULL, 17);
INSERT INTO organization_topic VALUES (629, 183, NULL, 18);
INSERT INTO organization_topic VALUES (630, 183, NULL, 19);
INSERT INTO organization_topic VALUES (631, 183, NULL, 21);
INSERT INTO organization_topic VALUES (632, 183, NULL, 23);
INSERT INTO organization_topic VALUES (633, 183, NULL, 24);
INSERT INTO organization_topic VALUES (634, 183, NULL, 25);
INSERT INTO organization_topic VALUES (635, 183, NULL, 29);
INSERT INTO organization_topic VALUES (636, 183, NULL, 30);
INSERT INTO organization_topic VALUES (637, 183, NULL, 33);
INSERT INTO organization_topic VALUES (638, 183, NULL, 35);
INSERT INTO organization_topic VALUES (639, 183, NULL, 37);
INSERT INTO organization_topic VALUES (640, 183, NULL, 38);
INSERT INTO organization_topic VALUES (641, 183, NULL, 39);
INSERT INTO organization_topic VALUES (642, 183, NULL, 41);
INSERT INTO organization_topic VALUES (643, 184, NULL, 17);
INSERT INTO organization_topic VALUES (644, 184, NULL, 37);
INSERT INTO organization_topic VALUES (645, 185, NULL, 17);
INSERT INTO organization_topic VALUES (646, 185, NULL, 37);
INSERT INTO organization_topic VALUES (647, 186, NULL, 17);
INSERT INTO organization_topic VALUES (648, 186, NULL, 37);
INSERT INTO organization_topic VALUES (649, 187, NULL, 37);
INSERT INTO organization_topic VALUES (650, 188, NULL, 1);
INSERT INTO organization_topic VALUES (651, 188, NULL, 13);
INSERT INTO organization_topic VALUES (652, 188, NULL, 16);
INSERT INTO organization_topic VALUES (653, 188, NULL, 19);
INSERT INTO organization_topic VALUES (654, 188, NULL, 23);
INSERT INTO organization_topic VALUES (655, 188, NULL, 28);
INSERT INTO organization_topic VALUES (656, 188, NULL, 29);
INSERT INTO organization_topic VALUES (657, 188, NULL, 30);
INSERT INTO organization_topic VALUES (658, 188, NULL, 37);
INSERT INTO organization_topic VALUES (659, 188, NULL, 38);
INSERT INTO organization_topic VALUES (660, 189, NULL, 35);
INSERT INTO organization_topic VALUES (661, 190, NULL, 17);
INSERT INTO organization_topic VALUES (662, 190, NULL, 37);
INSERT INTO organization_topic VALUES (663, 191, NULL, 35);
INSERT INTO organization_topic VALUES (664, 192, NULL, 35);
INSERT INTO organization_topic VALUES (665, 193, NULL, 37);
INSERT INTO organization_topic VALUES (666, 194, NULL, 37);
INSERT INTO organization_topic VALUES (667, 195, NULL, 37);
INSERT INTO organization_topic VALUES (668, 196, NULL, 7);
INSERT INTO organization_topic VALUES (669, 196, NULL, 21);
INSERT INTO organization_topic VALUES (670, 196, NULL, 31);
INSERT INTO organization_topic VALUES (671, 196, NULL, 33);
INSERT INTO organization_topic VALUES (672, 197, NULL, 3);
INSERT INTO organization_topic VALUES (673, 197, NULL, 4);
INSERT INTO organization_topic VALUES (674, 197, NULL, 14);
INSERT INTO organization_topic VALUES (675, 197, NULL, 15);
INSERT INTO organization_topic VALUES (676, 197, NULL, 19);
INSERT INTO organization_topic VALUES (677, 197, NULL, 23);
INSERT INTO organization_topic VALUES (678, 197, NULL, 25);
INSERT INTO organization_topic VALUES (679, 197, NULL, 29);
INSERT INTO organization_topic VALUES (680, 197, NULL, 33);
INSERT INTO organization_topic VALUES (681, 198, NULL, 37);
INSERT INTO organization_topic VALUES (682, 199, NULL, 5);
INSERT INTO organization_topic VALUES (683, 199, NULL, 7);
INSERT INTO organization_topic VALUES (684, 199, NULL, 13);
INSERT INTO organization_topic VALUES (685, 199, NULL, 17);
INSERT INTO organization_topic VALUES (686, 199, NULL, 21);
INSERT INTO organization_topic VALUES (687, 199, NULL, 24);
INSERT INTO organization_topic VALUES (688, 199, NULL, 26);
INSERT INTO organization_topic VALUES (689, 199, NULL, 27);
INSERT INTO organization_topic VALUES (690, 199, NULL, 32);
INSERT INTO organization_topic VALUES (691, 199, NULL, 36);
INSERT INTO organization_topic VALUES (692, 199, NULL, 38);
INSERT INTO organization_topic VALUES (693, 199, NULL, 40);
INSERT INTO organization_topic VALUES (694, 200, NULL, 18);
INSERT INTO organization_topic VALUES (695, 200, NULL, 30);
INSERT INTO organization_topic VALUES (696, 201, NULL, 17);
INSERT INTO organization_topic VALUES (697, 201, NULL, 37);
INSERT INTO organization_topic VALUES (698, 202, NULL, 4);
INSERT INTO organization_topic VALUES (699, 202, NULL, 9);
INSERT INTO organization_topic VALUES (700, 202, NULL, 29);
INSERT INTO organization_topic VALUES (701, 202, NULL, 34);
INSERT INTO organization_topic VALUES (702, 203, NULL, 17);
INSERT INTO organization_topic VALUES (703, 204, NULL, 37);
INSERT INTO organization_topic VALUES (704, 205, NULL, 17);
INSERT INTO organization_topic VALUES (705, 206, NULL, 13);
INSERT INTO organization_topic VALUES (706, 207, NULL, 37);
INSERT INTO organization_topic VALUES (707, 208, NULL, 37);
INSERT INTO organization_topic VALUES (708, 209, NULL, 1);
INSERT INTO organization_topic VALUES (709, 209, NULL, 15);
INSERT INTO organization_topic VALUES (710, 209, NULL, 25);
INSERT INTO organization_topic VALUES (711, 209, NULL, 33);
INSERT INTO organization_topic VALUES (712, 210, NULL, 2);
INSERT INTO organization_topic VALUES (713, 210, NULL, 4);
INSERT INTO organization_topic VALUES (714, 210, NULL, 10);
INSERT INTO organization_topic VALUES (715, 210, NULL, 18);
INSERT INTO organization_topic VALUES (716, 210, NULL, 19);
INSERT INTO organization_topic VALUES (717, 210, NULL, 25);
INSERT INTO organization_topic VALUES (718, 210, NULL, 37);
INSERT INTO organization_topic VALUES (719, 211, NULL, 17);
INSERT INTO organization_topic VALUES (720, 211, NULL, 37);
INSERT INTO organization_topic VALUES (721, 213, NULL, 5);
INSERT INTO organization_topic VALUES (722, 213, NULL, 41);
INSERT INTO organization_topic VALUES (723, 214, NULL, 37);
INSERT INTO organization_topic VALUES (724, 215, NULL, 7);
INSERT INTO organization_topic VALUES (725, 215, NULL, 25);
INSERT INTO organization_topic VALUES (726, 215, NULL, 29);
INSERT INTO organization_topic VALUES (727, 216, NULL, 17);
INSERT INTO organization_topic VALUES (728, 216, NULL, 37);
INSERT INTO organization_topic VALUES (729, 217, NULL, 4);
INSERT INTO organization_topic VALUES (730, 217, NULL, 23);
INSERT INTO organization_topic VALUES (731, 217, NULL, 24);
INSERT INTO organization_topic VALUES (732, 217, NULL, 32);
INSERT INTO organization_topic VALUES (733, 217, NULL, 38);
INSERT INTO organization_topic VALUES (734, 218, NULL, 2);
INSERT INTO organization_topic VALUES (735, 218, NULL, 7);
INSERT INTO organization_topic VALUES (736, 218, NULL, 27);
INSERT INTO organization_topic VALUES (737, 218, NULL, 28);
INSERT INTO organization_topic VALUES (738, 218, NULL, 29);
INSERT INTO organization_topic VALUES (739, 218, NULL, 39);
INSERT INTO organization_topic VALUES (740, 219, NULL, 1);
INSERT INTO organization_topic VALUES (741, 219, NULL, 4);
INSERT INTO organization_topic VALUES (742, 219, NULL, 5);
INSERT INTO organization_topic VALUES (743, 219, NULL, 6);
INSERT INTO organization_topic VALUES (744, 219, NULL, 7);
INSERT INTO organization_topic VALUES (745, 219, NULL, 8);
INSERT INTO organization_topic VALUES (746, 219, NULL, 14);
INSERT INTO organization_topic VALUES (747, 219, NULL, 19);
INSERT INTO organization_topic VALUES (748, 219, NULL, 36);
INSERT INTO organization_topic VALUES (749, 220, NULL, 37);
INSERT INTO organization_topic VALUES (750, 221, NULL, 17);
INSERT INTO organization_topic VALUES (751, 221, NULL, 37);
INSERT INTO organization_topic VALUES (752, 222, NULL, 37);
INSERT INTO organization_topic VALUES (753, 223, NULL, 4);
INSERT INTO organization_topic VALUES (754, 223, NULL, 9);
INSERT INTO organization_topic VALUES (755, 223, NULL, 29);
INSERT INTO organization_topic VALUES (756, 223, NULL, 34);
INSERT INTO organization_topic VALUES (757, 224, NULL, 17);
INSERT INTO organization_topic VALUES (758, 225, NULL, 37);
INSERT INTO organization_topic VALUES (759, 226, NULL, 37);
INSERT INTO organization_topic VALUES (760, 227, NULL, 8);
INSERT INTO organization_topic VALUES (761, 227, NULL, 32);
INSERT INTO organization_topic VALUES (762, 228, NULL, 13);
INSERT INTO organization_topic VALUES (763, 229, NULL, 37);
INSERT INTO organization_topic VALUES (764, 230, NULL, 35);
INSERT INTO organization_topic VALUES (765, 231, NULL, 17);
INSERT INTO organization_topic VALUES (766, 231, NULL, 37);
INSERT INTO organization_topic VALUES (767, 232, NULL, 13);
INSERT INTO organization_topic VALUES (768, 233, NULL, 37);
INSERT INTO organization_topic VALUES (769, 234, NULL, 17);
INSERT INTO organization_topic VALUES (770, 235, NULL, 17);
INSERT INTO organization_topic VALUES (771, 236, NULL, 4);
INSERT INTO organization_topic VALUES (772, 236, NULL, 6);
INSERT INTO organization_topic VALUES (773, 236, NULL, 25);
INSERT INTO organization_topic VALUES (774, 236, NULL, 33);
INSERT INTO organization_topic VALUES (775, 237, NULL, 13);
INSERT INTO organization_topic VALUES (776, 238, NULL, 17);
INSERT INTO organization_topic VALUES (777, 238, NULL, 37);
INSERT INTO organization_topic VALUES (778, 239, NULL, 1);
INSERT INTO organization_topic VALUES (779, 239, NULL, 14);
INSERT INTO organization_topic VALUES (780, 239, NULL, 19);
INSERT INTO organization_topic VALUES (781, 239, NULL, 33);
INSERT INTO organization_topic VALUES (782, 239, NULL, 37);
INSERT INTO organization_topic VALUES (783, 239, NULL, 38);
INSERT INTO organization_topic VALUES (784, 240, NULL, 17);
INSERT INTO organization_topic VALUES (785, 242, NULL, 2);
INSERT INTO organization_topic VALUES (786, 242, NULL, 7);
INSERT INTO organization_topic VALUES (787, 242, NULL, 30);
INSERT INTO organization_topic VALUES (788, 242, NULL, 32);
INSERT INTO organization_topic VALUES (789, 243, NULL, 17);
INSERT INTO organization_topic VALUES (790, 244, NULL, 37);
INSERT INTO organization_topic VALUES (791, 245, NULL, 1);
INSERT INTO organization_topic VALUES (792, 245, NULL, 2);
INSERT INTO organization_topic VALUES (793, 245, NULL, 3);
INSERT INTO organization_topic VALUES (794, 245, NULL, 4);
INSERT INTO organization_topic VALUES (795, 245, NULL, 8);
INSERT INTO organization_topic VALUES (796, 245, NULL, 14);
INSERT INTO organization_topic VALUES (797, 245, NULL, 19);
INSERT INTO organization_topic VALUES (798, 245, NULL, 23);
INSERT INTO organization_topic VALUES (799, 245, NULL, 28);
INSERT INTO organization_topic VALUES (800, 245, NULL, 29);
INSERT INTO organization_topic VALUES (801, 245, NULL, 30);
INSERT INTO organization_topic VALUES (802, 245, NULL, 41);
INSERT INTO organization_topic VALUES (803, 246, NULL, 17);
INSERT INTO organization_topic VALUES (804, 247, NULL, 17);
INSERT INTO organization_topic VALUES (805, 248, NULL, 37);
INSERT INTO organization_topic VALUES (806, 249, NULL, 1);
INSERT INTO organization_topic VALUES (807, 249, NULL, 4);
INSERT INTO organization_topic VALUES (808, 249, NULL, 6);
INSERT INTO organization_topic VALUES (809, 249, NULL, 9);
INSERT INTO organization_topic VALUES (810, 249, NULL, 12);
INSERT INTO organization_topic VALUES (811, 249, NULL, 23);
INSERT INTO organization_topic VALUES (812, 249, NULL, 24);
INSERT INTO organization_topic VALUES (813, 249, NULL, 26);
INSERT INTO organization_topic VALUES (814, 249, NULL, 30);
INSERT INTO organization_topic VALUES (815, 249, NULL, 31);
INSERT INTO organization_topic VALUES (816, 249, NULL, 32);
INSERT INTO organization_topic VALUES (817, 249, NULL, 37);
INSERT INTO organization_topic VALUES (818, 249, NULL, 39);
INSERT INTO organization_topic VALUES (819, 250, NULL, 1);
INSERT INTO organization_topic VALUES (820, 250, NULL, 2);
INSERT INTO organization_topic VALUES (821, 250, NULL, 3);
INSERT INTO organization_topic VALUES (822, 250, NULL, 4);
INSERT INTO organization_topic VALUES (823, 250, NULL, 7);
INSERT INTO organization_topic VALUES (824, 250, NULL, 8);
INSERT INTO organization_topic VALUES (825, 250, NULL, 13);
INSERT INTO organization_topic VALUES (826, 250, NULL, 19);
INSERT INTO organization_topic VALUES (827, 250, NULL, 20);
INSERT INTO organization_topic VALUES (828, 250, NULL, 21);
INSERT INTO organization_topic VALUES (829, 250, NULL, 25);
INSERT INTO organization_topic VALUES (830, 250, NULL, 29);
INSERT INTO organization_topic VALUES (831, 250, NULL, 31);
INSERT INTO organization_topic VALUES (832, 250, NULL, 36);
INSERT INTO organization_topic VALUES (833, 250, NULL, 38);
INSERT INTO organization_topic VALUES (834, 251, NULL, 37);
INSERT INTO organization_topic VALUES (835, 252, NULL, 35);
INSERT INTO organization_topic VALUES (836, 253, NULL, 9);
INSERT INTO organization_topic VALUES (837, 253, NULL, 13);
INSERT INTO organization_topic VALUES (838, 253, NULL, 30);
INSERT INTO organization_topic VALUES (839, 253, NULL, 32);
INSERT INTO organization_topic VALUES (840, 254, NULL, 4);
INSERT INTO organization_topic VALUES (841, 254, NULL, 9);
INSERT INTO organization_topic VALUES (842, 254, NULL, 24);
INSERT INTO organization_topic VALUES (843, 254, NULL, 25);
INSERT INTO organization_topic VALUES (844, 254, NULL, 38);
INSERT INTO organization_topic VALUES (845, 255, NULL, 30);
INSERT INTO organization_topic VALUES (846, 255, NULL, 32);
INSERT INTO organization_topic VALUES (847, 256, NULL, 2);
INSERT INTO organization_topic VALUES (848, 256, NULL, 10);
INSERT INTO organization_topic VALUES (849, 256, NULL, 13);
INSERT INTO organization_topic VALUES (850, 256, NULL, 14);
INSERT INTO organization_topic VALUES (851, 256, NULL, 15);
INSERT INTO organization_topic VALUES (852, 256, NULL, 18);
INSERT INTO organization_topic VALUES (853, 256, NULL, 19);
INSERT INTO organization_topic VALUES (854, 256, NULL, 21);
INSERT INTO organization_topic VALUES (855, 256, NULL, 30);
INSERT INTO organization_topic VALUES (856, 256, NULL, 38);
INSERT INTO organization_topic VALUES (857, 257, NULL, 41);
INSERT INTO organization_topic VALUES (858, 258, NULL, 17);
INSERT INTO organization_topic VALUES (859, 258, NULL, 37);
INSERT INTO organization_topic VALUES (860, 259, NULL, 17);
INSERT INTO organization_topic VALUES (861, 259, NULL, 35);
INSERT INTO organization_topic VALUES (862, 259, NULL, 37);
INSERT INTO organization_topic VALUES (863, 260, NULL, 37);
INSERT INTO organization_topic VALUES (864, 261, NULL, 17);
INSERT INTO organization_topic VALUES (865, 261, NULL, 35);
INSERT INTO organization_topic VALUES (866, 261, NULL, 37);
INSERT INTO organization_topic VALUES (867, 262, NULL, 35);
INSERT INTO organization_topic VALUES (868, 263, NULL, 1);
INSERT INTO organization_topic VALUES (869, 263, NULL, 2);
INSERT INTO organization_topic VALUES (870, 263, NULL, 3);
INSERT INTO organization_topic VALUES (871, 263, NULL, 4);
INSERT INTO organization_topic VALUES (872, 263, NULL, 7);
INSERT INTO organization_topic VALUES (873, 263, NULL, 8);
INSERT INTO organization_topic VALUES (874, 263, NULL, 9);
INSERT INTO organization_topic VALUES (875, 263, NULL, 10);
INSERT INTO organization_topic VALUES (876, 263, NULL, 12);
INSERT INTO organization_topic VALUES (877, 263, NULL, 13);
INSERT INTO organization_topic VALUES (878, 263, NULL, 14);
INSERT INTO organization_topic VALUES (879, 263, NULL, 15);
INSERT INTO organization_topic VALUES (880, 263, NULL, 16);
INSERT INTO organization_topic VALUES (881, 263, NULL, 17);
INSERT INTO organization_topic VALUES (882, 263, NULL, 18);
INSERT INTO organization_topic VALUES (883, 263, NULL, 19);
INSERT INTO organization_topic VALUES (884, 263, NULL, 21);
INSERT INTO organization_topic VALUES (885, 263, NULL, 23);
INSERT INTO organization_topic VALUES (886, 263, NULL, 25);
INSERT INTO organization_topic VALUES (887, 263, NULL, 26);
INSERT INTO organization_topic VALUES (888, 263, NULL, 27);
INSERT INTO organization_topic VALUES (889, 263, NULL, 29);
INSERT INTO organization_topic VALUES (890, 263, NULL, 30);
INSERT INTO organization_topic VALUES (891, 263, NULL, 32);
INSERT INTO organization_topic VALUES (892, 263, NULL, 33);
INSERT INTO organization_topic VALUES (893, 263, NULL, 34);
INSERT INTO organization_topic VALUES (894, 263, NULL, 35);
INSERT INTO organization_topic VALUES (895, 263, NULL, 36);
INSERT INTO organization_topic VALUES (896, 263, NULL, 38);
INSERT INTO organization_topic VALUES (897, 263, NULL, 39);
INSERT INTO organization_topic VALUES (898, 263, NULL, 40);
INSERT INTO organization_topic VALUES (899, 264, NULL, 28);
INSERT INTO organization_topic VALUES (900, 265, NULL, 17);
INSERT INTO organization_topic VALUES (901, 265, NULL, 37);
INSERT INTO organization_topic VALUES (902, 266, NULL, 35);
INSERT INTO organization_topic VALUES (903, 267, NULL, 17);
INSERT INTO organization_topic VALUES (904, 268, NULL, 1);
INSERT INTO organization_topic VALUES (905, 268, NULL, 10);
INSERT INTO organization_topic VALUES (906, 268, NULL, 15);
INSERT INTO organization_topic VALUES (907, 268, NULL, 32);
INSERT INTO organization_topic VALUES (908, 268, NULL, 33);
INSERT INTO organization_topic VALUES (909, 269, NULL, 4);
INSERT INTO organization_topic VALUES (910, 269, NULL, 7);
INSERT INTO organization_topic VALUES (911, 269, NULL, 10);
INSERT INTO organization_topic VALUES (912, 269, NULL, 13);
INSERT INTO organization_topic VALUES (913, 269, NULL, 14);
INSERT INTO organization_topic VALUES (914, 269, NULL, 19);
INSERT INTO organization_topic VALUES (915, 269, NULL, 25);
INSERT INTO organization_topic VALUES (916, 269, NULL, 29);
INSERT INTO organization_topic VALUES (917, 269, NULL, 38);
INSERT INTO organization_topic VALUES (918, 269, NULL, 39);
INSERT INTO organization_topic VALUES (919, 269, NULL, 40);
INSERT INTO organization_topic VALUES (920, 270, NULL, 37);
INSERT INTO organization_topic VALUES (921, 272, NULL, 17);
INSERT INTO organization_topic VALUES (922, 272, NULL, 35);
INSERT INTO organization_topic VALUES (923, 272, NULL, 37);
INSERT INTO organization_topic VALUES (924, 273, NULL, 37);
INSERT INTO organization_topic VALUES (925, 274, NULL, 37);
INSERT INTO organization_topic VALUES (926, 275, NULL, 3);
INSERT INTO organization_topic VALUES (927, 275, NULL, 6);
INSERT INTO organization_topic VALUES (928, 275, NULL, 8);
INSERT INTO organization_topic VALUES (929, 275, NULL, 9);
INSERT INTO organization_topic VALUES (930, 275, NULL, 12);
INSERT INTO organization_topic VALUES (931, 275, NULL, 22);
INSERT INTO organization_topic VALUES (932, 275, NULL, 28);
INSERT INTO organization_topic VALUES (933, 275, NULL, 30);
INSERT INTO organization_topic VALUES (934, 275, NULL, 32);
INSERT INTO organization_topic VALUES (935, 276, NULL, 34);
INSERT INTO organization_topic VALUES (936, 277, NULL, 1);
INSERT INTO organization_topic VALUES (937, 277, NULL, 3);
INSERT INTO organization_topic VALUES (938, 277, NULL, 8);
INSERT INTO organization_topic VALUES (939, 277, NULL, 20);
INSERT INTO organization_topic VALUES (940, 277, NULL, 22);
INSERT INTO organization_topic VALUES (941, 277, NULL, 23);
INSERT INTO organization_topic VALUES (942, 277, NULL, 24);
INSERT INTO organization_topic VALUES (943, 277, NULL, 27);
INSERT INTO organization_topic VALUES (944, 277, NULL, 29);
INSERT INTO organization_topic VALUES (945, 277, NULL, 34);
INSERT INTO organization_topic VALUES (946, 277, NULL, 39);
INSERT INTO organization_topic VALUES (947, 277, NULL, 41);


--
-- Data for Name: privilege; Type: TABLE DATA; Schema: public; Owner: northbr6
--

INSERT INTO privilege VALUES (1, 'create_invitation', 'Generate new invitations within own organizational boundaries.');


--
-- Data for Name: program; Type: TABLE DATA; Schema: public; Owner: northbr6
--

INSERT INTO program VALUES (1, 'Northside P.O.W.E.R. (People Organized to Work, Educate and Restore) is an institution-based people’s power organization whose members are located in the North Side of the City of Chicago and North Shore Communities. Northside P.O.W.E.R. works on issues that address the causes of hunger and poverty. Currently Northside P.O.W.E.R. is working in the areas of affordable housing and food justice.', 'Northside P.O.W.E.R.');
INSERT INTO program VALUES (2, 'Our Community Kitchen is the largest and only self-standing community soup kitchen in the Chicago metro area. We serve hot, nutritious meals 365 days per year to anyone in need. Last year, the Community Kitchen served more than 54,000 meals. The Community Kitchen also distributes several thousand pounds of food each month by hosting the Greater Chicago Food Depository’s Producemobile which distributes fruit and vegetables to more than 200 families each month.
', 'The Community Kitchen');
INSERT INTO program VALUES (3, 'Supports the Howard Area Community Center’s Greensleeves After-School Project and the Good News Reading Program;

Hosts the City of Chicago’s Summer Nutrition Program;

Operates a free hot lunch program for school age children during the school’s winter and spring breaks.', 'The Childrens’ Anti-Hunger Collaborative');
INSERT INTO program VALUES (4, 'Clinical Pastoral Education (CPE) is an intensive experiential educational program for pastors and religious leaders interested in developing their clinical skills. Students engage in pastoral work and reflect on their experience with a trained supervisor and a peer group. Key areas for learning include integrating theology into pastoral practice, formation as a religious leader, and self-reflection and knowledge. CPE can be an excellent tool for discernment, self-care and renewal.', 'Clinical Pastoral Education');
INSERT INTO program VALUES (5, 'Pastoral Internship is an introduction to supervised clinical pastoral practice with people in crisis. Chaplain interns function as integral members of treatment teams, assisting patients and family members to draw on the meaning and benefits of their faith and spiritual values in the midst of health crises. Skills in pastoral care are developed and approaches to understanding human relationships and spiritual needs are explored. At most sites, intensive 11-12 week programs are offered in the summer. At Advocate Lutheran General Hospital, intensive programs are offered quarterly, year-round.', 'Pastoral Internship');
INSERT INTO program VALUES (6, 'Pastoral Residency is a year-long program. This training provides opportunity for a more in-depth and specialized pastoral education experience. In addition to the basic format, this program includes:

Guided reading and instruction in the historic models of pastoral care


Pastoral theology

Studies in relationships among faith, religions and the behavioral sciences

Clinical/theological case conferences

Management and administration seminars examining principles and practices of pastoral care administration

Specialized opportunities in areas such as obstetrics, oncology, physical, rehabilitation, emergency medicine, pediatrics, gerontology, research methodology and design

Workshops and seminars in clinical ethical issues. ', 'Pastoral Residency');
INSERT INTO program VALUES (7, 'Supervisory CPE is designed for qualified persons with demonstrated pastoral, professional and clinical competence. Students learn the art of supervision through:

Education in supervisory theories by using conceptual models drawn from theology, behavioral science and education

Practicing supervision under an ACPE supervisor

Forming their identity as educators by a focus on integrating theory and practice with their distinct and personal attributes

Peer group seminars where the emerging supervisor''s understanding and practice are tested.', 'Supervisory CPE');
INSERT INTO program VALUES (8, 'As part of Advocate Health Care’s continuum of care, the Parish Nurse Ministry is working in 29 diverse congregations. These faith communities are widely scattered throughout the Chicagoland area from West Garfield Park and Uptown Chicago neighborhoods to the suburban settings of Arlington Heights and Naperville.

Advocate Parish Nurse Ministry continues to seek health ministry partnerships. Both partners, the health care institution and the congregation must espouse the belief that physical, emotional, intellectual, and social well-being are very much dependent on a healthy spiritual core of being.

Advocate Parish Nurse Ministry is designed to build on and strengthen capacities of individuals, families, and congregrations to understand and care for one another in light of their relationship with God, faith traditions, themselves, and the broader society.', 'Advocate Parish Nurse Ministry');


--
-- Data for Name: program_language; Type: TABLE DATA; Schema: public; Owner: northbr6
--



--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: northbr6
--

INSERT INTO role VALUES (1, 'admin_org', 'Administers organizational data and users.');
INSERT INTO role VALUES (2, 'admin_network', 'Administers network data and users.');
INSERT INTO role VALUES (3, 'admin_system', 'Administers all data and users.');
INSERT INTO role VALUES (4, 'admin_group', 'Administers group data and users.');
INSERT INTO role VALUES (5, 'user', 'Administers nothing.');


--
-- Data for Name: role_privilege; Type: TABLE DATA; Schema: public; Owner: northbr6
--

INSERT INTO role_privilege VALUES (1, 1);


--
-- Data for Name: status; Type: TABLE DATA; Schema: public; Owner: northbr6
--

INSERT INTO status VALUES (1, 'active', '');
INSERT INTO status VALUES (2, 'suspended', '');


--
-- Data for Name: topic; Type: TABLE DATA; Schema: public; Owner: northbr6
--

INSERT INTO topic VALUES (1, 'Access/Rights');
INSERT INTO topic VALUES (2, 'Addictions/Substance Abuse');
INSERT INTO topic VALUES (3, 'Adolescent Health');
INSERT INTO topic VALUES (4, 'Aging');
INSERT INTO topic VALUES (5, 'Cancer');
INSERT INTO topic VALUES (6, 'Cardiovascular Disease');
INSERT INTO topic VALUES (7, 'Chaplaincy/Spiritual Care');
INSERT INTO topic VALUES (8, 'Children''s Health');
INSERT INTO topic VALUES (9, 'Chronic Disease Prevention and Management');
INSERT INTO topic VALUES (10, 'Community Garden/Urban Agriculture');
INSERT INTO topic VALUES (11, 'Dental Health');
INSERT INTO topic VALUES (12, 'Diabetes');
INSERT INTO topic VALUES (13, 'Emergency Preparedness');
INSERT INTO topic VALUES (14, 'End of Life Care');
INSERT INTO topic VALUES (15, 'Environmental Issues');
INSERT INTO topic VALUES (16, 'Ethics');
INSERT INTO topic VALUES (17, 'Flu Clinic');
INSERT INTO topic VALUES (18, 'Food Access');
INSERT INTO topic VALUES (19, 'Grief and Bereavement');
INSERT INTO topic VALUES (20, 'Health Fair');
INSERT INTO topic VALUES (21, 'Health Ministry');
INSERT INTO topic VALUES (22, 'HIV/AIDS');
INSERT INTO topic VALUES (23, 'Immigrant Health');
INSERT INTO topic VALUES (24, 'Immunization');
INSERT INTO topic VALUES (25, 'Interfaith Understanding and Collaboration');
INSERT INTO topic VALUES (26, 'Latino Community');
INSERT INTO topic VALUES (27, 'Leadership Development');
INSERT INTO topic VALUES (28, 'Maternal and Child Health');
INSERT INTO topic VALUES (29, 'Mental Health');
INSERT INTO topic VALUES (30, 'Nutrition');
INSERT INTO topic VALUES (31, 'Parish Nursing');
INSERT INTO topic VALUES (32, 'Physical Activity');
INSERT INTO topic VALUES (33, 'Policy and Advocacy');
INSERT INTO topic VALUES (34, 'Primary Care');
INSERT INTO topic VALUES (35, 'Recreational Training');
INSERT INTO topic VALUES (36, 'Research');
INSERT INTO topic VALUES (37, 'Spiritual Care');
INSERT INTO topic VALUES (38, 'Spirituality and Healing');
INSERT INTO topic VALUES (39, 'Violence Prevention and Intervention');
INSERT INTO topic VALUES (40, 'Wholistic Healing');
INSERT INTO topic VALUES (41, 'Women''s Health');


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: northbr6
--

INSERT INTO "user" VALUES (85, '8ad02b5a-3ef4-7cfd-aec3-ec528bfa73ac', 'kdflint', 'kdflint', 'Kathy', 'D', 'Flint', '2014-08-01 09:40:24.775305-06', NULL, '2014-08-01 09:40:24.775305-06', NULL, 1, NULL, 'kathy.flint@northbridgetech.org', '3129195627', false, false, NULL);
INSERT INTO "user" VALUES (88, 'e8db0a62-67dd-3d0c-13fd-d2372f4b5d0c', 'admin', 'admin', 'Kathy', NULL, 'Flint', '2014-08-01 15:09:53.514038-06', NULL, '2014-08-01 15:09:53.514038-06', NULL, 1, NULL, 'contact@northbridgetech.org', NULL, false, false, NULL);
INSERT INTO "user" VALUES (89, 'fe58eefe-f487-11be-d5b0-267d8a36dfd7', 'kpeachey', 'change-me', 'Kirsten', NULL, 'Peachey', '2014-08-01 15:13:12.742905-06', NULL, '2014-08-01 15:13:12.742905-06', NULL, 1, NULL, 'fake@northbridgetech.org', NULL, false, false, NULL);


--
-- Data for Name: user_organization; Type: TABLE DATA; Schema: public; Owner: northbr6
--

INSERT INTO user_organization VALUES (89, 88, 18, 85, '2014-08-01 15:09:53.544925-06', NULL, 1);
INSERT INTO user_organization VALUES (90, 89, 18, 85, '2014-08-01 15:13:12.763613-06', NULL, 1);
INSERT INTO user_organization VALUES (86, 85, 13, 85, '2014-08-01 09:43:43.165403-06', NULL, 1);


--
-- Name: category_pkey; Type: CONSTRAINT; Schema: public; Owner: northbr6; Tablespace: 
--

ALTER TABLE ONLY category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


--
-- Name: category_topic_pkey; Type: CONSTRAINT; Schema: public; Owner: northbr6; Tablespace: 
--

ALTER TABLE ONLY category_topic
    ADD CONSTRAINT category_topic_pkey PRIMARY KEY (id);


--
-- Name: contact_pkey; Type: CONSTRAINT; Schema: public; Owner: northbr6; Tablespace: 
--

ALTER TABLE ONLY contact
    ADD CONSTRAINT contact_pkey PRIMARY KEY (id);


--
-- Name: forum_user_pkey; Type: CONSTRAINT; Schema: public; Owner: northbr6; Tablespace: 
--

ALTER TABLE ONLY forum_user
    ADD CONSTRAINT forum_user_pkey PRIMARY KEY (id);


--
-- Name: invitation_pkey; Type: CONSTRAINT; Schema: public; Owner: northbr6; Tablespace: 
--

ALTER TABLE ONLY invitation
    ADD CONSTRAINT invitation_pkey PRIMARY KEY (id);


--
-- Name: invitation_uuid_key; Type: CONSTRAINT; Schema: public; Owner: northbr6; Tablespace: 
--

ALTER TABLE ONLY invitation
    ADD CONSTRAINT invitation_uuid_key UNIQUE (uuid);


--
-- Name: language_pkey; Type: CONSTRAINT; Schema: public; Owner: northbr6; Tablespace: 
--

ALTER TABLE ONLY language
    ADD CONSTRAINT language_pkey PRIMARY KEY (id);


--
-- Name: location_pkey; Type: CONSTRAINT; Schema: public; Owner: northbr6; Tablespace: 
--

ALTER TABLE ONLY location
    ADD CONSTRAINT location_pkey PRIMARY KEY (id);


--
-- Name: organization_contact_pkey; Type: CONSTRAINT; Schema: public; Owner: northbr6; Tablespace: 
--

ALTER TABLE ONLY organization_contact
    ADD CONSTRAINT organization_contact_pkey PRIMARY KEY (id);


--
-- Name: organization_language_pkey; Type: CONSTRAINT; Schema: public; Owner: northbr6; Tablespace: 
--

ALTER TABLE ONLY organization_language
    ADD CONSTRAINT organization_language_pkey PRIMARY KEY (id);


--
-- Name: organization_location_pkey; Type: CONSTRAINT; Schema: public; Owner: northbr6; Tablespace: 
--

ALTER TABLE ONLY organization_location
    ADD CONSTRAINT organization_location_pkey PRIMARY KEY (id);


--
-- Name: organization_organization_pkey; Type: CONSTRAINT; Schema: public; Owner: northbr6; Tablespace: 
--

ALTER TABLE ONLY organization_organization
    ADD CONSTRAINT organization_organization_pkey PRIMARY KEY (id);


--
-- Name: organization_pkey; Type: CONSTRAINT; Schema: public; Owner: northbr6; Tablespace: 
--

ALTER TABLE ONLY organization
    ADD CONSTRAINT organization_pkey PRIMARY KEY (id);


--
-- Name: organization_program_pkey; Type: CONSTRAINT; Schema: public; Owner: northbr6; Tablespace: 
--

ALTER TABLE ONLY organization_program
    ADD CONSTRAINT organization_program_pkey PRIMARY KEY (id);


--
-- Name: organization_topic_pkey; Type: CONSTRAINT; Schema: public; Owner: northbr6; Tablespace: 
--

ALTER TABLE ONLY organization_topic
    ADD CONSTRAINT organization_topic_pkey PRIMARY KEY (id);


--
-- Name: privilege_pkey; Type: CONSTRAINT; Schema: public; Owner: northbr6; Tablespace: 
--

ALTER TABLE ONLY privilege
    ADD CONSTRAINT privilege_pkey PRIMARY KEY (id);


--
-- Name: program_language_pkey; Type: CONSTRAINT; Schema: public; Owner: northbr6; Tablespace: 
--

ALTER TABLE ONLY program_language
    ADD CONSTRAINT program_language_pkey PRIMARY KEY (id);


--
-- Name: program_pkey; Type: CONSTRAINT; Schema: public; Owner: northbr6; Tablespace: 
--

ALTER TABLE ONLY program
    ADD CONSTRAINT program_pkey PRIMARY KEY (id);


--
-- Name: role_name_key; Type: CONSTRAINT; Schema: public; Owner: northbr6; Tablespace: 
--

ALTER TABLE ONLY role
    ADD CONSTRAINT role_name_key UNIQUE (name);


--
-- Name: role_pkey; Type: CONSTRAINT; Schema: public; Owner: northbr6; Tablespace: 
--

ALTER TABLE ONLY role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- Name: role_privilege_role_id_fk_key; Type: CONSTRAINT; Schema: public; Owner: northbr6; Tablespace: 
--

ALTER TABLE ONLY role_privilege
    ADD CONSTRAINT role_privilege_role_id_fk_key UNIQUE (role_id_fk, privilege_id_fk);


--
-- Name: status_name_key; Type: CONSTRAINT; Schema: public; Owner: northbr6; Tablespace: 
--

ALTER TABLE ONLY status
    ADD CONSTRAINT status_name_key UNIQUE (name);


--
-- Name: status_pkey; Type: CONSTRAINT; Schema: public; Owner: northbr6; Tablespace: 
--

ALTER TABLE ONLY status
    ADD CONSTRAINT status_pkey PRIMARY KEY (id);


--
-- Name: topic_pkey; Type: CONSTRAINT; Schema: public; Owner: northbr6; Tablespace: 
--

ALTER TABLE ONLY topic
    ADD CONSTRAINT topic_pkey PRIMARY KEY (id);


--
-- Name: user_organization_pkey; Type: CONSTRAINT; Schema: public; Owner: northbr6; Tablespace: 
--

ALTER TABLE ONLY user_organization
    ADD CONSTRAINT user_organization_pkey PRIMARY KEY (id);


--
-- Name: user_organization_user_fk_key; Type: CONSTRAINT; Schema: public; Owner: northbr6; Tablespace: 
--

ALTER TABLE ONLY user_organization
    ADD CONSTRAINT user_organization_user_fk_key UNIQUE (user_fk, organization_fk);


--
-- Name: user_pkey; Type: CONSTRAINT; Schema: public; Owner: northbr6; Tablespace: 
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: user_uuid_key; Type: CONSTRAINT; Schema: public; Owner: northbr6; Tablespace: 
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_uuid_key UNIQUE (uuid);


--
-- Name: category_topic_category_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY category_topic
    ADD CONSTRAINT category_topic_category_fk_fkey FOREIGN KEY (category_fk) REFERENCES category(id);


--
-- Name: category_topic_topic_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY category_topic
    ADD CONSTRAINT category_topic_topic_fk_fkey FOREIGN KEY (topic_fk) REFERENCES topic(id);


--
-- Name: forum_user_user_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY forum_user
    ADD CONSTRAINT forum_user_user_fk_fkey FOREIGN KEY (user_fk) REFERENCES "user"(id);


--
-- Name: grantor_fk; Type: FK CONSTRAINT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY user_organization
    ADD CONSTRAINT grantor_fk FOREIGN KEY (grantor_fk) REFERENCES "user"(id);


--
-- Name: invitation_issuer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY invitation
    ADD CONSTRAINT invitation_issuer_fkey FOREIGN KEY (issuer_fk) REFERENCES "user"(id);


--
-- Name: invitation_network_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY invitation
    ADD CONSTRAINT invitation_network_fk_fkey FOREIGN KEY (network_fk) REFERENCES organization(id);


--
-- Name: invitation_organization_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY invitation
    ADD CONSTRAINT invitation_organization_fk_fkey FOREIGN KEY (organization_fk) REFERENCES organization(id);


--
-- Name: organization_contact_contact_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY organization_contact
    ADD CONSTRAINT organization_contact_contact_fk_fkey FOREIGN KEY (contact_fk) REFERENCES contact(id);


--
-- Name: organization_contact_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY organization
    ADD CONSTRAINT organization_contact_fk_fkey FOREIGN KEY (contact_fk) REFERENCES contact(id);


--
-- Name: organization_contact_organization_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY organization_contact
    ADD CONSTRAINT organization_contact_organization_fk_fkey FOREIGN KEY (organization_fk) REFERENCES organization(id);


--
-- Name: organization_fk; Type: FK CONSTRAINT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY user_organization
    ADD CONSTRAINT organization_fk FOREIGN KEY (organization_fk) REFERENCES organization(id);


--
-- Name: organization_language_language_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY organization_language
    ADD CONSTRAINT organization_language_language_fk_fkey FOREIGN KEY (language_fk) REFERENCES language(id);


--
-- Name: organization_language_organization_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY organization_language
    ADD CONSTRAINT organization_language_organization_fk_fkey FOREIGN KEY (organization_fk) REFERENCES organization(id);


--
-- Name: organization_organization_organization_from_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY organization_organization
    ADD CONSTRAINT organization_organization_organization_from_fk_fkey FOREIGN KEY (organization_from_fk) REFERENCES organization(id);


--
-- Name: organization_organization_organization_to_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY organization_organization
    ADD CONSTRAINT organization_organization_organization_to_fk_fkey FOREIGN KEY (organization_to_fk) REFERENCES organization(id);


--
-- Name: organization_program_organization_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY organization_program
    ADD CONSTRAINT organization_program_organization_fk_fkey FOREIGN KEY (organization_fk) REFERENCES organization(id);


--
-- Name: organization_program_program_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY organization_program
    ADD CONSTRAINT organization_program_program_fk_fkey FOREIGN KEY (program_fk) REFERENCES program(id);


--
-- Name: organization_topic_organization_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY organization_topic
    ADD CONSTRAINT organization_topic_organization_fk_fkey FOREIGN KEY (organization_fk) REFERENCES organization(id);


--
-- Name: organization_topic_program_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY organization_topic
    ADD CONSTRAINT organization_topic_program_fk_fkey FOREIGN KEY (program_fk) REFERENCES organization_program(id);


--
-- Name: organization_topic_topic_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY organization_topic
    ADD CONSTRAINT organization_topic_topic_fkey FOREIGN KEY (topic_fk) REFERENCES topic(id);


--
-- Name: role_fk; Type: FK CONSTRAINT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY user_organization
    ADD CONSTRAINT role_fk FOREIGN KEY (role_fk) REFERENCES role(id);


--
-- Name: role_fk; Type: FK CONSTRAINT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY invitation
    ADD CONSTRAINT role_fk FOREIGN KEY (role_fk) REFERENCES role(id);


--
-- Name: role_privilege_privilege_id_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY role_privilege
    ADD CONSTRAINT role_privilege_privilege_id_fk_fkey FOREIGN KEY (privilege_id_fk) REFERENCES privilege(id);


--
-- Name: role_privilege_role_id_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY role_privilege
    ADD CONSTRAINT role_privilege_role_id_fk_fkey FOREIGN KEY (role_id_fk) REFERENCES role(id);


--
-- Name: user_contact_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_contact_fk_fkey FOREIGN KEY (contact_fk) REFERENCES contact(id);


--
-- Name: user_fk; Type: FK CONSTRAINT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY user_organization
    ADD CONSTRAINT user_fk FOREIGN KEY (user_fk) REFERENCES "user"(id);


--
-- Name: user_status_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_status_fk_fkey FOREIGN KEY (status_fk) REFERENCES status(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: category; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON TABLE category FROM PUBLIC;
REVOKE ALL ON TABLE category FROM northbr6;
GRANT ALL ON TABLE category TO northbr6;
GRANT ALL ON TABLE category TO northbr6_nbnexus;


--
-- Name: category_topic; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON TABLE category_topic FROM PUBLIC;
REVOKE ALL ON TABLE category_topic FROM northbr6;
GRANT ALL ON TABLE category_topic TO northbr6;
GRANT ALL ON TABLE category_topic TO northbr6_nbnexus;


--
-- Name: contact; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON TABLE contact FROM PUBLIC;
REVOKE ALL ON TABLE contact FROM northbr6;
GRANT ALL ON TABLE contact TO northbr6;
GRANT ALL ON TABLE contact TO northbr6_nbnexus;


--
-- Name: forum_user_id_seq; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON SEQUENCE forum_user_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE forum_user_id_seq FROM northbr6;
GRANT USAGE ON SEQUENCE forum_user_id_seq TO northbr6;
GRANT SELECT,UPDATE ON SEQUENCE forum_user_id_seq TO northbr6 WITH GRANT OPTION;
GRANT SELECT,UPDATE ON SEQUENCE forum_user_id_seq TO northbr6_web WITH GRANT OPTION;


--
-- Name: forum_user; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON TABLE forum_user FROM PUBLIC;
REVOKE ALL ON TABLE forum_user FROM northbr6;
GRANT ALL ON TABLE forum_user TO northbr6;
GRANT SELECT,INSERT,REFERENCES,UPDATE ON TABLE forum_user TO northbr6_web WITH GRANT OPTION;
GRANT ALL ON TABLE forum_user TO northbr6_nbnexus;


--
-- Name: invitation; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON TABLE invitation FROM PUBLIC;
REVOKE ALL ON TABLE invitation FROM northbr6;
GRANT ALL ON TABLE invitation TO northbr6;
GRANT ALL ON TABLE invitation TO northbr6_nbnexus;
GRANT SELECT,INSERT,REFERENCES,UPDATE ON TABLE invitation TO northbr6_web;


--
-- Name: invitation_id_seq; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON SEQUENCE invitation_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE invitation_id_seq FROM northbr6;
GRANT ALL ON SEQUENCE invitation_id_seq TO northbr6;
GRANT SELECT,UPDATE ON SEQUENCE invitation_id_seq TO northbr6_web;


--
-- Name: invitation_organization; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON TABLE invitation_organization FROM PUBLIC;
REVOKE ALL ON TABLE invitation_organization FROM northbr6;
GRANT ALL ON TABLE invitation_organization TO northbr6;
GRANT SELECT,INSERT,REFERENCES,UPDATE ON TABLE invitation_organization TO northbr6_web;
GRANT ALL ON TABLE invitation_organization TO northbr6_nbnexus;


--
-- Name: invitation_organization_id_seq; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON SEQUENCE invitation_organization_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE invitation_organization_id_seq FROM northbr6;
GRANT ALL ON SEQUENCE invitation_organization_id_seq TO northbr6;
GRANT SELECT,UPDATE ON SEQUENCE invitation_organization_id_seq TO northbr6_web;


--
-- Name: language; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON TABLE language FROM PUBLIC;
REVOKE ALL ON TABLE language FROM northbr6;
GRANT ALL ON TABLE language TO northbr6;
GRANT SELECT,INSERT,REFERENCES,UPDATE ON TABLE language TO northbr6_web WITH GRANT OPTION;
GRANT ALL ON TABLE language TO northbr6_nbnexus;


--
-- Name: location; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON TABLE location FROM PUBLIC;
REVOKE ALL ON TABLE location FROM northbr6;
GRANT ALL ON TABLE location TO northbr6;
GRANT ALL ON TABLE location TO northbr6_nbnexus;


--
-- Name: organization; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON TABLE organization FROM PUBLIC;
REVOKE ALL ON TABLE organization FROM northbr6;
GRANT ALL ON TABLE organization TO northbr6;
GRANT ALL ON TABLE organization TO northbr6_nbnexus;
GRANT SELECT,INSERT,REFERENCES,UPDATE ON TABLE organization TO northbr6_web WITH GRANT OPTION;


--
-- Name: organization_contact; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON TABLE organization_contact FROM PUBLIC;
REVOKE ALL ON TABLE organization_contact FROM northbr6;
GRANT ALL ON TABLE organization_contact TO northbr6;
GRANT ALL ON TABLE organization_contact TO northbr6_nbnexus;


--
-- Name: organization_id_seq; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON SEQUENCE organization_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE organization_id_seq FROM northbr6;
GRANT ALL ON SEQUENCE organization_id_seq TO northbr6;
GRANT SELECT,UPDATE ON SEQUENCE organization_id_seq TO northbr6_web;


--
-- Name: organization_language; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON TABLE organization_language FROM PUBLIC;
REVOKE ALL ON TABLE organization_language FROM northbr6;
GRANT ALL ON TABLE organization_language TO northbr6;
GRANT SELECT,INSERT,REFERENCES,UPDATE ON TABLE organization_language TO northbr6_web WITH GRANT OPTION;
GRANT ALL ON TABLE organization_language TO northbr6_nbnexus;


--
-- Name: organization_location; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON TABLE organization_location FROM PUBLIC;
REVOKE ALL ON TABLE organization_location FROM northbr6;
GRANT ALL ON TABLE organization_location TO northbr6;
GRANT ALL ON TABLE organization_location TO northbr6_nbnexus;


--
-- Name: organization_organization; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON TABLE organization_organization FROM PUBLIC;
REVOKE ALL ON TABLE organization_organization FROM northbr6;
GRANT ALL ON TABLE organization_organization TO northbr6;
GRANT ALL ON TABLE organization_organization TO northbr6_nbnexus;


--
-- Name: organization_organization_id_seq; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON SEQUENCE organization_organization_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE organization_organization_id_seq FROM northbr6;
GRANT ALL ON SEQUENCE organization_organization_id_seq TO northbr6;
GRANT SELECT,UPDATE ON SEQUENCE organization_organization_id_seq TO northbr6_web;


--
-- Name: organization_program; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON TABLE organization_program FROM PUBLIC;
REVOKE ALL ON TABLE organization_program FROM northbr6;
GRANT ALL ON TABLE organization_program TO northbr6;
GRANT SELECT,INSERT,REFERENCES,UPDATE ON TABLE organization_program TO northbr6_web WITH GRANT OPTION;
GRANT ALL ON TABLE organization_program TO northbr6_nbnexus;


--
-- Name: organization_topic; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON TABLE organization_topic FROM PUBLIC;
REVOKE ALL ON TABLE organization_topic FROM northbr6;
GRANT ALL ON TABLE organization_topic TO northbr6;
GRANT SELECT,INSERT,REFERENCES,UPDATE ON TABLE organization_topic TO northbr6_web WITH GRANT OPTION;
GRANT ALL ON TABLE organization_topic TO northbr6_nbnexus;


--
-- Name: privilege; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON TABLE privilege FROM PUBLIC;
REVOKE ALL ON TABLE privilege FROM northbr6;
GRANT ALL ON TABLE privilege TO northbr6;
GRANT SELECT,INSERT ON TABLE privilege TO northbr6_web;
GRANT ALL ON TABLE privilege TO northbr6_nbnexus;


--
-- Name: program; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON TABLE program FROM PUBLIC;
REVOKE ALL ON TABLE program FROM northbr6;
GRANT ALL ON TABLE program TO northbr6;
GRANT SELECT,INSERT,REFERENCES,UPDATE ON TABLE program TO northbr6_web WITH GRANT OPTION;
GRANT ALL ON TABLE program TO northbr6_nbnexus;


--
-- Name: program_language; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON TABLE program_language FROM PUBLIC;
REVOKE ALL ON TABLE program_language FROM northbr6;
GRANT ALL ON TABLE program_language TO northbr6;
GRANT ALL ON TABLE program_language TO northbr6_nbnexus;


--
-- Name: role; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON TABLE role FROM PUBLIC;
REVOKE ALL ON TABLE role FROM northbr6;
GRANT ALL ON TABLE role TO northbr6;
GRANT ALL ON TABLE role TO northbr6_nbnexus;
GRANT SELECT ON TABLE role TO northbr6_web;


--
-- Name: role_privilege; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON TABLE role_privilege FROM PUBLIC;
REVOKE ALL ON TABLE role_privilege FROM northbr6;
GRANT ALL ON TABLE role_privilege TO northbr6;
GRANT SELECT ON TABLE role_privilege TO northbr6_web;
GRANT ALL ON TABLE role_privilege TO northbr6_nbnexus;


--
-- Name: status; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON TABLE status FROM PUBLIC;
REVOKE ALL ON TABLE status FROM northbr6;
GRANT ALL ON TABLE status TO northbr6;
GRANT SELECT,INSERT,UPDATE ON TABLE status TO northbr6_web;
GRANT ALL ON TABLE status TO northbr6_nbnexus;


--
-- Name: topic; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON TABLE topic FROM PUBLIC;
REVOKE ALL ON TABLE topic FROM northbr6;
GRANT ALL ON TABLE topic TO northbr6;
GRANT ALL ON TABLE topic TO northbr6_nbnexus;


--
-- Name: user; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON TABLE "user" FROM PUBLIC;
REVOKE ALL ON TABLE "user" FROM northbr6;
GRANT ALL ON TABLE "user" TO northbr6;
GRANT ALL ON TABLE "user" TO northbr6_nbnexus;


--
-- Name: user_id_seq; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON SEQUENCE user_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE user_id_seq FROM northbr6;
GRANT ALL ON SEQUENCE user_id_seq TO northbr6;
GRANT SELECT,UPDATE ON SEQUENCE user_id_seq TO northbr6_web;


--
-- Name: user_organization; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON TABLE user_organization FROM PUBLIC;
REVOKE ALL ON TABLE user_organization FROM northbr6;
GRANT ALL ON TABLE user_organization TO northbr6;
GRANT ALL ON TABLE user_organization TO northbr6_nbnexus;


--
-- Name: user_organization_id_seq; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON SEQUENCE user_organization_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE user_organization_id_seq FROM northbr6;
GRANT ALL ON SEQUENCE user_organization_id_seq TO northbr6;
GRANT SELECT,UPDATE ON SEQUENCE user_organization_id_seq TO northbr6_web;


--
-- PostgreSQL database dump complete
--

