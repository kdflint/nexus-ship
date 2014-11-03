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
-- Name: contact; Type: TABLE; Schema: public; Owner: northbr6; Tablespace: 
--

CREATE TABLE contact (
    id integer DEFAULT nextval('contact_id_seq'::regclass) NOT NULL,
    email character varying(50) DEFAULT ''::character varying NOT NULL,
    sms character varying(20) DEFAULT ''::character varying NOT NULL,
    phone character varying(20) DEFAULT ''::character varying NOT NULL,
    url character varying(100) DEFAULT ''::character varying NOT NULL,
    media_fk integer,
    fax character varying(10) DEFAULT ''::character varying NOT NULL,
    title character varying(50) DEFAULT ''::character varying NOT NULL,
    name character varying(200) DEFAULT ''::character varying NOT NULL
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
-- Name: group_id_seq; Type: SEQUENCE; Schema: public; Owner: northbr6
--

CREATE SEQUENCE group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.group_id_seq OWNER TO northbr6;

--
-- Name: group; Type: TABLE; Schema: public; Owner: northbr6; Tablespace: 
--

CREATE TABLE "group" (
    id integer DEFAULT nextval('group_id_seq'::regclass) NOT NULL,
    name character varying(50) NOT NULL,
    descr character varying(200)
);


ALTER TABLE public."group" OWNER TO northbr6;

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
    organization_fk integer,
    group_fk integer
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
-- Name: COLUMN invitation.group_fk; Type: COMMENT; Schema: public; Owner: northbr6
--

COMMENT ON COLUMN invitation.group_fk IS 'This identifies the group that issued the invitation.';


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
-- Name: location; Type: TABLE; Schema: public; Owner: northbr6; Tablespace: 
--

CREATE TABLE location (
    id integer DEFAULT nextval('location_id_seq'::regclass) NOT NULL,
    address1 character varying(50) DEFAULT ''::character varying NOT NULL,
    address2 character varying(50) DEFAULT ''::character varying NOT NULL,
    municipality character varying(50) DEFAULT ''::character varying NOT NULL,
    region1 character varying(50) DEFAULT ''::character varying NOT NULL,
    region2 character varying(50) DEFAULT ''::character varying NOT NULL,
    country character varying(50) DEFAULT ''::character varying NOT NULL,
    postal_code character varying(12) DEFAULT ''::character varying NOT NULL,
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
-- Name: message_id_seq; Type: SEQUENCE; Schema: public; Owner: northbr6
--

CREATE SEQUENCE message_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.message_id_seq OWNER TO northbr6;

--
-- Name: message; Type: TABLE; Schema: public; Owner: northbr6; Tablespace: 
--

CREATE TABLE message (
    id integer DEFAULT nextval('message_id_seq'::regclass) NOT NULL,
    sender_fk integer NOT NULL,
    subject character varying(30),
    message character varying(500),
    reply_to_fk integer,
    create_dttm timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.message OWNER TO northbr6;

--
-- Name: COLUMN message.sender_fk; Type: COMMENT; Schema: public; Owner: northbr6
--

COMMENT ON COLUMN message.sender_fk IS 'Indicates the sender of the message.';


--
-- Name: COLUMN message.reply_to_fk; Type: COMMENT; Schema: public; Owner: northbr6
--

COMMENT ON COLUMN message.reply_to_fk IS 'Indicates which message this message is in reply to, if any.';


--
-- Name: message_recipient; Type: TABLE; Schema: public; Owner: northbr6; Tablespace: 
--

CREATE TABLE message_recipient (
    message_fk integer NOT NULL,
    recipient_fk integer NOT NULL,
    uuid uuid NOT NULL
);


ALTER TABLE public.message_recipient OWNER TO northbr6;

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
    logo character varying(100) DEFAULT ''::character varying
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
-- Name: program; Type: TABLE; Schema: public; Owner: northbr6; Tablespace: 
--

CREATE TABLE program (
    id integer DEFAULT nextval('program_id_seq'::regclass) NOT NULL,
    description character varying(1000) DEFAULT ''::character varying NOT NULL,
    name character varying(50) DEFAULT ''::character varying NOT NULL
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
    username character varying(50) DEFAULT ''::character varying NOT NULL,
    password character varying(72) DEFAULT ''::character varying,
    fname character varying(50) DEFAULT ''::character varying NOT NULL,
    mname character varying(50) DEFAULT ''::character varying NOT NULL,
    lname character varying(50) DEFAULT ''::character varying NOT NULL,
    create_dttm timestamp with time zone NOT NULL,
    update_dttm timestamp with time zone,
    activate_dttm timestamp with time zone,
    suspend_dttm timestamp with time zone,
    status_fk integer NOT NULL,
    nickname character varying(50) DEFAULT ''::character varying NOT NULL,
    email character varying(50) DEFAULT ''::character varying NOT NULL,
    sms character varying(10) DEFAULT ''::character varying NOT NULL,
    enable_email boolean DEFAULT false NOT NULL,
    enable_sms boolean DEFAULT false NOT NULL,
    contact_fk integer,
    cryptimpl character varying(5) DEFAULT 'None'::character varying NOT NULL,
    salt character varying(32),
    crypt_dttm timestamp with time zone,
    conference_link character varying(100) DEFAULT ''::character varying
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
-- Name: COLUMN "user".cryptimpl; Type: COMMENT; Schema: public; Owner: northbr6
--

COMMENT ON COLUMN "user".cryptimpl IS 'Identify the system-specific implementation of the hash algorithm';


--
-- Name: COLUMN "user".crypt_dttm; Type: COMMENT; Schema: public; Owner: northbr6
--

COMMENT ON COLUMN "user".crypt_dttm IS 'Date the password was last encrypted.';


--
-- Name: user_group_id_seq; Type: SEQUENCE; Schema: public; Owner: northbr6
--

CREATE SEQUENCE user_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.user_group_id_seq OWNER TO northbr6;

--
-- Name: user_group; Type: TABLE; Schema: public; Owner: northbr6; Tablespace: 
--

CREATE TABLE user_group (
    id integer DEFAULT nextval('user_group_id_seq'::regclass) NOT NULL,
    user_fk integer NOT NULL,
    create_dttm timestamp with time zone DEFAULT now() NOT NULL,
    update_dttm timestamp with time zone,
    group_fk integer NOT NULL
);


ALTER TABLE public.user_group OWNER TO northbr6;

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
-- Name: user_password_id_seq; Type: SEQUENCE; Schema: public; Owner: northbr6
--

CREATE SEQUENCE user_password_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.user_password_id_seq OWNER TO northbr6;

--
-- Name: user_password; Type: TABLE; Schema: public; Owner: northbr6; Tablespace: 
--

CREATE TABLE user_password (
    id integer DEFAULT nextval('user_password_id_seq'::regclass) NOT NULL,
    user_fk integer NOT NULL,
    activity character varying(10) NOT NULL,
    create_dttm timestamp with time zone DEFAULT now() NOT NULL,
    response_dttm timestamp with time zone,
    uuid uuid
);


ALTER TABLE public.user_password OWNER TO northbr6;

--
-- Name: user_session_id_seq; Type: SEQUENCE; Schema: public; Owner: northbr6
--

CREATE SEQUENCE user_session_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.user_session_id_seq OWNER TO northbr6;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: northbr6; Tablespace: 
--

CREATE TABLE user_session (
    id integer DEFAULT nextval('user_session_id_seq'::regclass) NOT NULL,
    user_fk integer,
    ip inet,
    create_dttm timestamp with time zone NOT NULL
);


ALTER TABLE public.user_session OWNER TO northbr6;

--
-- Name: COLUMN user_session.create_dttm; Type: COMMENT; Schema: public; Owner: northbr6
--

COMMENT ON COLUMN user_session.create_dttm IS 'Indicates when the login activity occurred.';


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
-- Name: group_pkey; Type: CONSTRAINT; Schema: public; Owner: northbr6; Tablespace: 
--

ALTER TABLE ONLY "group"
    ADD CONSTRAINT group_pkey PRIMARY KEY (id);


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
-- Name: message_pkey; Type: CONSTRAINT; Schema: public; Owner: northbr6; Tablespace: 
--

ALTER TABLE ONLY message
    ADD CONSTRAINT message_pkey PRIMARY KEY (id);


--
-- Name: message_recipient_pkey; Type: CONSTRAINT; Schema: public; Owner: northbr6; Tablespace: 
--

ALTER TABLE ONLY message_recipient
    ADD CONSTRAINT message_recipient_pkey PRIMARY KEY (message_fk, recipient_fk);


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
-- Name: role_privilege_pkey; Type: CONSTRAINT; Schema: public; Owner: northbr6; Tablespace: 
--

ALTER TABLE ONLY role_privilege
    ADD CONSTRAINT role_privilege_pkey PRIMARY KEY (role_id_fk, privilege_id_fk);


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
-- Name: user_group_pkey; Type: CONSTRAINT; Schema: public; Owner: northbr6; Tablespace: 
--

ALTER TABLE ONLY user_group
    ADD CONSTRAINT user_group_pkey PRIMARY KEY (id);


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
-- Name: user_password_pkey; Type: CONSTRAINT; Schema: public; Owner: northbr6; Tablespace: 
--

ALTER TABLE ONLY user_password
    ADD CONSTRAINT user_password_pkey PRIMARY KEY (id);


--
-- Name: user_pkey; Type: CONSTRAINT; Schema: public; Owner: northbr6; Tablespace: 
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: user_session_pkey; Type: CONSTRAINT; Schema: public; Owner: northbr6; Tablespace: 
--

ALTER TABLE ONLY user_session
    ADD CONSTRAINT user_session_pkey PRIMARY KEY (id);


--
-- Name: user_username_key; Type: CONSTRAINT; Schema: public; Owner: northbr6; Tablespace: 
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_username_key UNIQUE (username);


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
-- Name: invitation_group_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY invitation
    ADD CONSTRAINT invitation_group_fk_fkey FOREIGN KEY (group_fk) REFERENCES "group"(id);


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
-- Name: message_recipient_message_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY message_recipient
    ADD CONSTRAINT message_recipient_message_fk_fkey FOREIGN KEY (message_fk) REFERENCES message(id);


--
-- Name: message_recipient_recipient_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY message_recipient
    ADD CONSTRAINT message_recipient_recipient_fk_fkey FOREIGN KEY (recipient_fk) REFERENCES "user"(id);


--
-- Name: message_reply_to_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY message
    ADD CONSTRAINT message_reply_to_fk_fkey FOREIGN KEY (reply_to_fk) REFERENCES message(id);


--
-- Name: message_sender_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY message
    ADD CONSTRAINT message_sender_fk_fkey FOREIGN KEY (sender_fk) REFERENCES "user"(id);


--
-- Name: organization_contact_contact_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY organization_contact
    ADD CONSTRAINT organization_contact_contact_fk_fkey FOREIGN KEY (contact_fk) REFERENCES contact(id);


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
-- Name: user_group_group_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY user_group
    ADD CONSTRAINT user_group_group_fk_fkey FOREIGN KEY (group_fk) REFERENCES "group"(id);


--
-- Name: user_group_user_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY user_group
    ADD CONSTRAINT user_group_user_fk_fkey FOREIGN KEY (user_fk) REFERENCES "user"(id);


--
-- Name: user_password_user_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY user_password
    ADD CONSTRAINT user_password_user_fk_fkey FOREIGN KEY (user_fk) REFERENCES "user"(id);


--
-- Name: user_session_user_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbr6
--

ALTER TABLE ONLY user_session
    ADD CONSTRAINT user_session_user_fk_fkey FOREIGN KEY (user_fk) REFERENCES "user"(id);


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
GRANT ALL ON TABLE category TO northbr6_devnexus;


--
-- Name: category_topic; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON TABLE category_topic FROM PUBLIC;
REVOKE ALL ON TABLE category_topic FROM northbr6;
GRANT ALL ON TABLE category_topic TO northbr6;
GRANT ALL ON TABLE category_topic TO northbr6_nbnexus;
GRANT ALL ON TABLE category_topic TO northbr6_devnexus;


--
-- Name: contact; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON TABLE contact FROM PUBLIC;
REVOKE ALL ON TABLE contact FROM northbr6;
GRANT ALL ON TABLE contact TO northbr6;
GRANT ALL ON TABLE contact TO northbr6_nbnexus;
GRANT ALL ON TABLE contact TO northbr6_devnexus;


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
GRANT ALL ON TABLE forum_user TO northbr6_devnexus;


--
-- Name: group_id_seq; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON SEQUENCE group_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE group_id_seq FROM northbr6;
GRANT ALL ON SEQUENCE group_id_seq TO northbr6;
GRANT SELECT,UPDATE ON SEQUENCE group_id_seq TO northbr6_web;


--
-- Name: group; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON TABLE "group" FROM PUBLIC;
REVOKE ALL ON TABLE "group" FROM northbr6;
GRANT ALL ON TABLE "group" TO northbr6;
GRANT SELECT,INSERT,UPDATE ON TABLE "group" TO northbr6_web;
GRANT ALL ON TABLE "group" TO northbr6_nbnexus;


--
-- Name: invitation; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON TABLE invitation FROM PUBLIC;
REVOKE ALL ON TABLE invitation FROM northbr6;
GRANT ALL ON TABLE invitation TO northbr6;
GRANT ALL ON TABLE invitation TO northbr6_nbnexus;
GRANT SELECT,INSERT,REFERENCES,UPDATE ON TABLE invitation TO northbr6_web;
GRANT ALL ON TABLE invitation TO northbr6_devnexus;


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
GRANT ALL ON TABLE invitation_organization TO northbr6_devnexus;


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
GRANT ALL ON TABLE language TO northbr6_devnexus;


--
-- Name: location; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON TABLE location FROM PUBLIC;
REVOKE ALL ON TABLE location FROM northbr6;
GRANT ALL ON TABLE location TO northbr6;
GRANT ALL ON TABLE location TO northbr6_nbnexus;
GRANT ALL ON TABLE location TO northbr6_devnexus;


--
-- Name: message_id_seq; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON SEQUENCE message_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE message_id_seq FROM northbr6;
GRANT ALL ON SEQUENCE message_id_seq TO northbr6;
GRANT SELECT,UPDATE ON SEQUENCE message_id_seq TO northbr6_web;


--
-- Name: message; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON TABLE message FROM PUBLIC;
REVOKE ALL ON TABLE message FROM northbr6;
GRANT ALL ON TABLE message TO northbr6;
GRANT SELECT,INSERT,UPDATE ON TABLE message TO northbr6_web;
GRANT ALL ON TABLE message TO northbr6_nbnexus;


--
-- Name: message_recipient; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON TABLE message_recipient FROM PUBLIC;
REVOKE ALL ON TABLE message_recipient FROM northbr6;
GRANT ALL ON TABLE message_recipient TO northbr6;
GRANT SELECT,INSERT ON TABLE message_recipient TO northbr6_web;
GRANT ALL ON TABLE message_recipient TO northbr6_nbnexus;


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
GRANT ALL ON TABLE organization_program TO northbr6_devnexus;


--
-- Name: organization_topic; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON TABLE organization_topic FROM PUBLIC;
REVOKE ALL ON TABLE organization_topic FROM northbr6;
GRANT ALL ON TABLE organization_topic TO northbr6;
GRANT SELECT,INSERT,REFERENCES,UPDATE ON TABLE organization_topic TO northbr6_web WITH GRANT OPTION;
GRANT ALL ON TABLE organization_topic TO northbr6_nbnexus;
GRANT ALL ON TABLE organization_topic TO northbr6_devnexus;


--
-- Name: privilege; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON TABLE privilege FROM PUBLIC;
REVOKE ALL ON TABLE privilege FROM northbr6;
GRANT ALL ON TABLE privilege TO northbr6;
GRANT SELECT,INSERT ON TABLE privilege TO northbr6_web;
GRANT ALL ON TABLE privilege TO northbr6_nbnexus;
GRANT ALL ON TABLE privilege TO northbr6_devnexus;


--
-- Name: program; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON TABLE program FROM PUBLIC;
REVOKE ALL ON TABLE program FROM northbr6;
GRANT ALL ON TABLE program TO northbr6;
GRANT SELECT,INSERT,REFERENCES,UPDATE ON TABLE program TO northbr6_web WITH GRANT OPTION;
GRANT ALL ON TABLE program TO northbr6_nbnexus;
GRANT ALL ON TABLE program TO northbr6_devnexus;


--
-- Name: program_language; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON TABLE program_language FROM PUBLIC;
REVOKE ALL ON TABLE program_language FROM northbr6;
GRANT ALL ON TABLE program_language TO northbr6;
GRANT ALL ON TABLE program_language TO northbr6_nbnexus;
GRANT ALL ON TABLE program_language TO northbr6_devnexus;


--
-- Name: role; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON TABLE role FROM PUBLIC;
REVOKE ALL ON TABLE role FROM northbr6;
GRANT ALL ON TABLE role TO northbr6;
GRANT ALL ON TABLE role TO northbr6_nbnexus;
GRANT SELECT ON TABLE role TO northbr6_web;
GRANT ALL ON TABLE role TO northbr6_devnexus;


--
-- Name: role_privilege; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON TABLE role_privilege FROM PUBLIC;
REVOKE ALL ON TABLE role_privilege FROM northbr6;
GRANT ALL ON TABLE role_privilege TO northbr6;
GRANT SELECT ON TABLE role_privilege TO northbr6_web;
GRANT ALL ON TABLE role_privilege TO northbr6_nbnexus;
GRANT ALL ON TABLE role_privilege TO northbr6_devnexus;


--
-- Name: status; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON TABLE status FROM PUBLIC;
REVOKE ALL ON TABLE status FROM northbr6;
GRANT ALL ON TABLE status TO northbr6;
GRANT SELECT,INSERT,UPDATE ON TABLE status TO northbr6_web;
GRANT ALL ON TABLE status TO northbr6_nbnexus;
GRANT ALL ON TABLE status TO northbr6_devnexus;


--
-- Name: topic; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON TABLE topic FROM PUBLIC;
REVOKE ALL ON TABLE topic FROM northbr6;
GRANT ALL ON TABLE topic TO northbr6;
GRANT ALL ON TABLE topic TO northbr6_nbnexus;
GRANT ALL ON TABLE topic TO northbr6_devnexus;


--
-- Name: user; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON TABLE "user" FROM PUBLIC;
REVOKE ALL ON TABLE "user" FROM northbr6;
GRANT ALL ON TABLE "user" TO northbr6;
GRANT ALL ON TABLE "user" TO northbr6_nbnexus;
GRANT ALL ON TABLE "user" TO northbr6_devnexus;


--
-- Name: user_group_id_seq; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON SEQUENCE user_group_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE user_group_id_seq FROM northbr6;
GRANT ALL ON SEQUENCE user_group_id_seq TO northbr6;
GRANT SELECT,UPDATE ON SEQUENCE user_group_id_seq TO northbr6_web;


--
-- Name: user_group; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON TABLE user_group FROM PUBLIC;
REVOKE ALL ON TABLE user_group FROM northbr6;
GRANT ALL ON TABLE user_group TO northbr6;
GRANT SELECT,INSERT,UPDATE ON TABLE user_group TO northbr6_web;
GRANT ALL ON TABLE user_group TO northbr6_nbnexus;


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
GRANT ALL ON TABLE user_organization TO northbr6_devnexus;


--
-- Name: user_organization_id_seq; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON SEQUENCE user_organization_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE user_organization_id_seq FROM northbr6;
GRANT ALL ON SEQUENCE user_organization_id_seq TO northbr6;
GRANT SELECT,UPDATE ON SEQUENCE user_organization_id_seq TO northbr6_web;


--
-- Name: user_password_id_seq; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON SEQUENCE user_password_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE user_password_id_seq FROM northbr6;
GRANT ALL ON SEQUENCE user_password_id_seq TO northbr6;
GRANT SELECT,UPDATE ON SEQUENCE user_password_id_seq TO northbr6_web;


--
-- Name: user_password; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON TABLE user_password FROM PUBLIC;
REVOKE ALL ON TABLE user_password FROM northbr6;
GRANT ALL ON TABLE user_password TO northbr6;
GRANT SELECT,INSERT,UPDATE ON TABLE user_password TO northbr6_web;


--
-- Name: user_session_id_seq; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON SEQUENCE user_session_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE user_session_id_seq FROM northbr6;
GRANT ALL ON SEQUENCE user_session_id_seq TO northbr6;
GRANT SELECT,UPDATE ON SEQUENCE user_session_id_seq TO northbr6_web;


--
-- Name: user_session; Type: ACL; Schema: public; Owner: northbr6
--

REVOKE ALL ON TABLE user_session FROM PUBLIC;
REVOKE ALL ON TABLE user_session FROM northbr6;
GRANT ALL ON TABLE user_session TO northbr6;
GRANT SELECT,INSERT ON TABLE user_session TO northbr6_web;
GRANT ALL ON TABLE user_session TO northbr6_nbnexus;


--
-- PostgreSQL database dump complete
--

