--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Name: affiliation_id_seq; Type: SEQUENCE; Schema: public; Owner: northbri_devnexus
--

CREATE SEQUENCE affiliation_id_seq
    START WITH 13
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE affiliation_id_seq OWNER TO northbri_devnexus;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: affiliation; Type: TABLE; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

CREATE TABLE affiliation (
    id integer DEFAULT nextval('affiliation_id_seq'::regclass) NOT NULL,
    affiliation character varying(50) NOT NULL
);


ALTER TABLE affiliation OWNER TO northbri_devnexus;

--
-- Name: category_id_seq; Type: SEQUENCE; Schema: public; Owner: northbri_devnexus
--

CREATE SEQUENCE category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE category_id_seq OWNER TO northbri_devnexus;

--
-- Name: category; Type: TABLE; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

CREATE TABLE category (
    id integer DEFAULT nextval('category_id_seq'::regclass) NOT NULL,
    name character varying(30) NOT NULL,
    organization_fk integer NOT NULL
);


ALTER TABLE category OWNER TO northbri_devnexus;

--
-- Name: category_topic_id_seq; Type: SEQUENCE; Schema: public; Owner: northbri_devnexus
--

CREATE SEQUENCE category_topic_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE category_topic_id_seq OWNER TO northbri_devnexus;

--
-- Name: category_topic; Type: TABLE; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

CREATE TABLE category_topic (
    id integer DEFAULT nextval('category_topic_id_seq'::regclass) NOT NULL,
    category_fk integer NOT NULL,
    topic_fk integer NOT NULL
);


ALTER TABLE category_topic OWNER TO northbri_devnexus;

--
-- Name: contact_id_seq; Type: SEQUENCE; Schema: public; Owner: northbri_devnexus
--

CREATE SEQUENCE contact_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE contact_id_seq OWNER TO northbri_devnexus;

--
-- Name: contact; Type: TABLE; Schema: public; Owner: northbri_devnexus; Tablespace: 
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


ALTER TABLE contact OWNER TO northbri_devnexus;

--
-- Name: COLUMN contact.media_fk; Type: COMMENT; Schema: public; Owner: northbri_devnexus
--

COMMENT ON COLUMN contact.media_fk IS 'Placeholder for a social media table fk';


--
-- Name: ethnicity_id_seq; Type: SEQUENCE; Schema: public; Owner: northbri_devnexus
--

CREATE SEQUENCE ethnicity_id_seq
    START WITH 13
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ethnicity_id_seq OWNER TO northbri_devnexus;

--
-- Name: ethnicity; Type: TABLE; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

CREATE TABLE ethnicity (
    id integer DEFAULT nextval('ethnicity_id_seq'::regclass) NOT NULL,
    ethnicity character varying(50) NOT NULL
);


ALTER TABLE ethnicity OWNER TO northbri_devnexus;

--
-- Name: event; Type: TABLE; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

CREATE TABLE event (
    id integer NOT NULL,
    uuid uuid NOT NULL,
    start_dttm timestamp with time zone NOT NULL,
    duration interval NOT NULL,
    name character varying(200) NOT NULL,
    descr character varying(1500),
    reserved_user_fk integer NOT NULL,
    admin_user_fk integer,
    tz_name character varying(50),
    tz_abbrev character varying(10),
    create_dttm timestamp with time zone DEFAULT now() NOT NULL,
    update_dttm timestamp with time zone,
    active boolean DEFAULT true,
    type meeting_type DEFAULT 'collaboration'::meeting_type,
    location character varying(250),
    isbbbmeet boolean DEFAULT true,
    registration character varying(250),
    url character varying(600),
    contact character varying(50),
    registration_url character varying(600),
    file character varying(4),
    recur_fk integer
);


ALTER TABLE event OWNER TO northbri_devnexus;

--
-- Name: event_group_id_seq; Type: SEQUENCE; Schema: public; Owner: northbri_devnexus
--

CREATE SEQUENCE event_group_id_seq
    START WITH 7
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE event_group_id_seq OWNER TO northbri_devnexus;

--
-- Name: event_group; Type: TABLE; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

CREATE TABLE event_group (
    id integer DEFAULT nextval('event_group_id_seq'::regclass) NOT NULL,
    event_fk integer NOT NULL,
    group_fk integer NOT NULL,
    create_dttm timestamp with time zone DEFAULT now() NOT NULL,
    update_dttm timestamp with time zone,
    status_fk integer NOT NULL
);


ALTER TABLE event_group OWNER TO northbri_devnexus;

--
-- Name: event_id_seq; Type: SEQUENCE; Schema: public; Owner: northbri_devnexus
--

CREATE SEQUENCE event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE event_id_seq OWNER TO northbri_devnexus;

--
-- Name: event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: northbri_devnexus
--

ALTER SEQUENCE event_id_seq OWNED BY event.id;


--
-- Name: event_recur_id_seq; Type: SEQUENCE; Schema: public; Owner: northbri_devnexus
--

CREATE SEQUENCE event_recur_id_seq
    START WITH 221
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE event_recur_id_seq OWNER TO northbri_devnexus;

--
-- Name: event_recur; Type: TABLE; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

CREATE TABLE event_recur (
    id integer DEFAULT nextval('event_recur_id_seq'::regclass) NOT NULL,
    pattern character varying(12),
    num_occur numeric,
    end_dttm timestamp with time zone
);


ALTER TABLE event_recur OWNER TO northbri_devnexus;

--
-- Name: forum_poll; Type: TABLE; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

CREATE TABLE forum_poll (
    forum_last_poll_dttm timestamp with time zone,
    topic_last_poll_dttm timestamp with time zone,
    pm_last_poll_dttm timestamp with time zone
);


ALTER TABLE forum_poll OWNER TO northbri_devnexus;

--
-- Name: forum_user_id_seq; Type: SEQUENCE; Schema: public; Owner: northbri_devnexus
--

CREATE SEQUENCE forum_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE forum_user_id_seq OWNER TO northbri_devnexus;

--
-- Name: forum_user; Type: TABLE; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

CREATE TABLE forum_user (
    id integer DEFAULT nextval('forum_user_id_seq'::regclass) NOT NULL,
    user_fk integer NOT NULL,
    username character varying(25) NOT NULL,
    password character varying(25) NOT NULL,
    name character varying(50) NOT NULL,
    email character varying(50) NOT NULL
);


ALTER TABLE forum_user OWNER TO northbri_devnexus;

--
-- Name: COLUMN forum_user.user_fk; Type: COMMENT; Schema: public; Owner: northbri_devnexus
--

COMMENT ON COLUMN forum_user.user_fk IS 'Nexus system user id';


--
-- Name: COLUMN forum_user.username; Type: COMMENT; Schema: public; Owner: northbri_devnexus
--

COMMENT ON COLUMN forum_user.username IS 'This column is unused now. [Deprecated - Username for sso into forum. Kludgy, but actual forum username = this column value + id]';


--
-- Name: COLUMN forum_user.password; Type: COMMENT; Schema: public; Owner: northbri_devnexus
--

COMMENT ON COLUMN forum_user.password IS 'Password for sso into forum';


--
-- Name: COLUMN forum_user.name; Type: COMMENT; Schema: public; Owner: northbri_devnexus
--

COMMENT ON COLUMN forum_user.name IS 'Name as registered in forum. We are using this as the forum username.';


--
-- Name: COLUMN forum_user.email; Type: COMMENT; Schema: public; Owner: northbri_devnexus
--

COMMENT ON COLUMN forum_user.email IS 'Email as registered in forum';


--
-- Name: group_id_seq; Type: SEQUENCE; Schema: public; Owner: northbri_devnexus
--

CREATE SEQUENCE group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE group_id_seq OWNER TO northbri_devnexus;

--
-- Name: group; Type: TABLE; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

CREATE TABLE "group" (
    id integer DEFAULT nextval('group_id_seq'::regclass) NOT NULL,
    name character varying(100) NOT NULL,
    descr character varying(200),
    create_dttm timestamp with time zone DEFAULT now() NOT NULL,
    update_dttm timestamp with time zone,
    activate_dttm timestamp with time zone,
    suspend_dttm timestamp with time zone,
    logo character varying(100) DEFAULT ''::character varying,
    uid character(8) NOT NULL,
    forum_group_id integer
);


ALTER TABLE "group" OWNER TO northbri_devnexus;

--
-- Name: invitation; Type: TABLE; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

CREATE TABLE invitation (
    id integer NOT NULL,
    uuid uuid NOT NULL,
    email character varying(50),
    create_dttm timestamp with time zone NOT NULL,
    accept_dttm timestamp with time zone,
    network_fk integer,
    invitation_dttm timestamp with time zone,
    role_fk integer NOT NULL,
    expire_dt date,
    issuer_fk integer NOT NULL,
    type character varying(10) NOT NULL,
    organization_fk integer,
    group_fk integer
);


ALTER TABLE invitation OWNER TO northbri_devnexus;

--
-- Name: COLUMN invitation.email; Type: COMMENT; Schema: public; Owner: northbri_devnexus
--

COMMENT ON COLUMN invitation.email IS 'This identifies the email address that this invitation is specific to.';


--
-- Name: COLUMN invitation.create_dttm; Type: COMMENT; Schema: public; Owner: northbri_devnexus
--

COMMENT ON COLUMN invitation.create_dttm IS 'This identifies when the invitation record was created.';


--
-- Name: COLUMN invitation.accept_dttm; Type: COMMENT; Schema: public; Owner: northbri_devnexus
--

COMMENT ON COLUMN invitation.accept_dttm IS 'This identifies when the specific user accepted the invitation. Unused in pilot release.';


--
-- Name: COLUMN invitation.network_fk; Type: COMMENT; Schema: public; Owner: northbri_devnexus
--

COMMENT ON COLUMN invitation.network_fk IS 'This identifies the network that issued the invitation.';


--
-- Name: COLUMN invitation.invitation_dttm; Type: COMMENT; Schema: public; Owner: northbri_devnexus
--

COMMENT ON COLUMN invitation.invitation_dttm IS 'This identifies when a user-specific invitation was transmitted. Unused in pilot release.';


--
-- Name: COLUMN invitation.role_fk; Type: COMMENT; Schema: public; Owner: northbri_devnexus
--

COMMENT ON COLUMN invitation.role_fk IS 'This indicates the role that should be granted to the invited users.';


--
-- Name: COLUMN invitation.expire_dt; Type: COMMENT; Schema: public; Owner: northbri_devnexus
--

COMMENT ON COLUMN invitation.expire_dt IS 'This identifies when the invitation will expire.';


--
-- Name: COLUMN invitation.issuer_fk; Type: COMMENT; Schema: public; Owner: northbri_devnexus
--

COMMENT ON COLUMN invitation.issuer_fk IS 'This identifies which user generate the invitation.';


--
-- Name: COLUMN invitation.type; Type: COMMENT; Schema: public; Owner: northbri_devnexus
--

COMMENT ON COLUMN invitation.type IS 'This identifies whether an invitation is specific to a single user email.';


--
-- Name: COLUMN invitation.organization_fk; Type: COMMENT; Schema: public; Owner: northbri_devnexus
--

COMMENT ON COLUMN invitation.organization_fk IS 'This identifies the organization that issued the invitation.';


--
-- Name: COLUMN invitation.group_fk; Type: COMMENT; Schema: public; Owner: northbri_devnexus
--

COMMENT ON COLUMN invitation.group_fk IS 'This identifies the group that issued the invitation.';


--
-- Name: invitation_id_seq; Type: SEQUENCE; Schema: public; Owner: northbri_devnexus
--

CREATE SEQUENCE invitation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE invitation_id_seq OWNER TO northbri_devnexus;

--
-- Name: invitation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: northbri_devnexus
--

ALTER SEQUENCE invitation_id_seq OWNED BY invitation.id;


--
-- Name: invitation_organization; Type: TABLE; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

CREATE TABLE invitation_organization (
    id integer NOT NULL,
    invitation_fk integer,
    organization_fk integer,
    create_dttm timestamp with time zone,
    update_dttm timestamp with time zone
);


ALTER TABLE invitation_organization OWNER TO northbri_devnexus;

--
-- Name: invitation_organization_id_seq; Type: SEQUENCE; Schema: public; Owner: northbri_devnexus
--

CREATE SEQUENCE invitation_organization_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE invitation_organization_id_seq OWNER TO northbri_devnexus;

--
-- Name: invitation_organization_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: northbri_devnexus
--

ALTER SEQUENCE invitation_organization_id_seq OWNED BY invitation_organization.id;


--
-- Name: language_id_seq; Type: SEQUENCE; Schema: public; Owner: northbri_devnexus
--

CREATE SEQUENCE language_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE language_id_seq OWNER TO northbri_devnexus;

--
-- Name: language; Type: TABLE; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

CREATE TABLE language (
    id integer DEFAULT nextval('language_id_seq'::regclass) NOT NULL,
    language character varying(50) NOT NULL
);


ALTER TABLE language OWNER TO northbri_devnexus;

--
-- Name: location_id_seq; Type: SEQUENCE; Schema: public; Owner: northbri_devnexus
--

CREATE SEQUENCE location_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE location_id_seq OWNER TO northbri_devnexus;

--
-- Name: location; Type: TABLE; Schema: public; Owner: northbri_devnexus; Tablespace: 
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
    type character varying(20),
    g_placeid character varying(300),
    g_formatted_address character varying(200),
    neighborhood character varying(100)
);


ALTER TABLE location OWNER TO northbri_devnexus;

--
-- Name: COLUMN location.region1; Type: COMMENT; Schema: public; Owner: northbri_devnexus
--

COMMENT ON COLUMN location.region1 IS 'In the US, put county here.';


--
-- Name: COLUMN location.region2; Type: COMMENT; Schema: public; Owner: northbri_devnexus
--

COMMENT ON COLUMN location.region2 IS 'In the US, put state here';


--
-- Name: message_id_seq; Type: SEQUENCE; Schema: public; Owner: northbri_devnexus
--

CREATE SEQUENCE message_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE message_id_seq OWNER TO northbri_devnexus;

--
-- Name: message; Type: TABLE; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

CREATE TABLE message (
    id integer DEFAULT nextval('message_id_seq'::regclass) NOT NULL,
    sender_fk integer NOT NULL,
    subject character varying(30),
    message character varying(1100),
    reply_to_fk integer,
    create_dttm timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE message OWNER TO northbri_devnexus;

--
-- Name: COLUMN message.sender_fk; Type: COMMENT; Schema: public; Owner: northbri_devnexus
--

COMMENT ON COLUMN message.sender_fk IS 'Indicates the sender of the message.';


--
-- Name: COLUMN message.reply_to_fk; Type: COMMENT; Schema: public; Owner: northbri_devnexus
--

COMMENT ON COLUMN message.reply_to_fk IS 'Indicates which message this message is in reply to, if any.';


--
-- Name: message_recipient; Type: TABLE; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

CREATE TABLE message_recipient (
    message_fk integer NOT NULL,
    recipient_fk integer NOT NULL,
    uuid uuid NOT NULL,
    status character varying(10) DEFAULT 'PENDING'::character varying NOT NULL
);


ALTER TABLE message_recipient OWNER TO northbri_devnexus;

--
-- Name: organization; Type: TABLE; Schema: public; Owner: northbri_devnexus; Tablespace: 
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
    logo character varying(100) DEFAULT ''::character varying,
    uid character(8),
    forum_id character varying(4),
    public_forum_id character varying(4),
    forum_user_group numeric,
    community_group_fk integer,
    network_forum_id character varying(4),
    public_global_invite_fk integer,
    size character varying(20)
);


ALTER TABLE organization OWNER TO northbri_devnexus;

--
-- Name: organization_account_id_seq; Type: SEQUENCE; Schema: public; Owner: northbri_devnexus
--

CREATE SEQUENCE organization_account_id_seq
    START WITH 7
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE organization_account_id_seq OWNER TO northbri_devnexus;

--
-- Name: organization_account; Type: TABLE; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

CREATE TABLE organization_account (
    id integer DEFAULT nextval('organization_account_id_seq'::regclass) NOT NULL,
    organization_fk integer NOT NULL,
    account_type character varying(10) NOT NULL
);


ALTER TABLE organization_account OWNER TO northbri_devnexus;

--
-- Name: organization_affiliation_id_seq; Type: SEQUENCE; Schema: public; Owner: northbri_devnexus
--

CREATE SEQUENCE organization_affiliation_id_seq
    START WITH 119
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE organization_affiliation_id_seq OWNER TO northbri_devnexus;

--
-- Name: organization_affiliation; Type: TABLE; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

CREATE TABLE organization_affiliation (
    id integer DEFAULT nextval('organization_affiliation_id_seq'::regclass) NOT NULL,
    organization_fk integer NOT NULL,
    affiliation_fk integer NOT NULL
);


ALTER TABLE organization_affiliation OWNER TO northbri_devnexus;

--
-- Name: organization_contact_id_seq; Type: SEQUENCE; Schema: public; Owner: northbri_devnexus
--

CREATE SEQUENCE organization_contact_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE organization_contact_id_seq OWNER TO northbri_devnexus;

--
-- Name: organization_contact; Type: TABLE; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

CREATE TABLE organization_contact (
    id integer DEFAULT nextval('organization_contact_id_seq'::regclass) NOT NULL,
    organization_fk integer NOT NULL,
    contact_fk integer NOT NULL
);


ALTER TABLE organization_contact OWNER TO northbri_devnexus;

--
-- Name: organization_ethnicity_id_seq; Type: SEQUENCE; Schema: public; Owner: northbri_devnexus
--

CREATE SEQUENCE organization_ethnicity_id_seq
    START WITH 119
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE organization_ethnicity_id_seq OWNER TO northbri_devnexus;

--
-- Name: organization_ethnicity; Type: TABLE; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

CREATE TABLE organization_ethnicity (
    id integer DEFAULT nextval('organization_ethnicity_id_seq'::regclass) NOT NULL,
    organization_fk integer NOT NULL,
    ethnicity_fk integer NOT NULL
);


ALTER TABLE organization_ethnicity OWNER TO northbri_devnexus;

--
-- Name: organization_id_seq; Type: SEQUENCE; Schema: public; Owner: northbri_devnexus
--

CREATE SEQUENCE organization_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE organization_id_seq OWNER TO northbri_devnexus;

--
-- Name: organization_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: northbri_devnexus
--

ALTER SEQUENCE organization_id_seq OWNED BY organization.id;


--
-- Name: organization_language_id_seq; Type: SEQUENCE; Schema: public; Owner: northbri_devnexus
--

CREATE SEQUENCE organization_language_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE organization_language_id_seq OWNER TO northbri_devnexus;

--
-- Name: organization_language; Type: TABLE; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

CREATE TABLE organization_language (
    id integer DEFAULT nextval('organization_language_id_seq'::regclass) NOT NULL,
    organization_fk integer NOT NULL,
    language_fk integer NOT NULL
);


ALTER TABLE organization_language OWNER TO northbri_devnexus;

--
-- Name: organization_location_id_seq; Type: SEQUENCE; Schema: public; Owner: northbri_devnexus
--

CREATE SEQUENCE organization_location_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE organization_location_id_seq OWNER TO northbri_devnexus;

--
-- Name: organization_location; Type: TABLE; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

CREATE TABLE organization_location (
    id integer DEFAULT nextval('organization_location_id_seq'::regclass) NOT NULL,
    organization_fk integer NOT NULL,
    location_fk integer NOT NULL
);


ALTER TABLE organization_location OWNER TO northbri_devnexus;

--
-- Name: organization_organization; Type: TABLE; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

CREATE TABLE organization_organization (
    id integer NOT NULL,
    organization_from_fk integer NOT NULL,
    organization_to_fk integer NOT NULL,
    relationship character varying(10) NOT NULL,
    create_dttm timestamp with time zone DEFAULT now() NOT NULL,
    update_dttm timestamp with time zone
);


ALTER TABLE organization_organization OWNER TO northbri_devnexus;

--
-- Name: organization_organization_id_seq; Type: SEQUENCE; Schema: public; Owner: northbri_devnexus
--

CREATE SEQUENCE organization_organization_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE organization_organization_id_seq OWNER TO northbri_devnexus;

--
-- Name: organization_organization_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: northbri_devnexus
--

ALTER SEQUENCE organization_organization_id_seq OWNED BY organization_organization.id;


--
-- Name: organization_program_id_seq; Type: SEQUENCE; Schema: public; Owner: northbri_devnexus
--

CREATE SEQUENCE organization_program_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE organization_program_id_seq OWNER TO northbri_devnexus;

--
-- Name: organization_program; Type: TABLE; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

CREATE TABLE organization_program (
    id integer DEFAULT nextval('organization_program_id_seq'::regclass) NOT NULL,
    organization_fk integer NOT NULL,
    program_fk integer NOT NULL
);


ALTER TABLE organization_program OWNER TO northbri_devnexus;

--
-- Name: organization_topic_id_seq; Type: SEQUENCE; Schema: public; Owner: northbri_devnexus
--

CREATE SEQUENCE organization_topic_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE organization_topic_id_seq OWNER TO northbri_devnexus;

--
-- Name: organization_topic; Type: TABLE; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

CREATE TABLE organization_topic (
    id integer DEFAULT nextval('organization_topic_id_seq'::regclass) NOT NULL,
    organization_fk integer NOT NULL,
    program_fk integer,
    topic_fk integer NOT NULL
);


ALTER TABLE organization_topic OWNER TO northbri_devnexus;

--
-- Name: COLUMN organization_topic.program_fk; Type: COMMENT; Schema: public; Owner: northbri_devnexus
--

COMMENT ON COLUMN organization_topic.program_fk IS 'Optional to constrain this topic to a particular program. ';


--
-- Name: person_id_seq; Type: SEQUENCE; Schema: public; Owner: northbri_devnexus
--

CREATE SEQUENCE person_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE person_id_seq OWNER TO northbri_devnexus;

--
-- Name: privilege; Type: TABLE; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

CREATE TABLE privilege (
    id integer NOT NULL,
    name character varying(20) NOT NULL,
    description character varying(100)
);


ALTER TABLE privilege OWNER TO northbri_devnexus;

--
-- Name: privilege_id_seq; Type: SEQUENCE; Schema: public; Owner: northbri_devnexus
--

CREATE SEQUENCE privilege_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE privilege_id_seq OWNER TO northbri_devnexus;

--
-- Name: privilege_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: northbri_devnexus
--

ALTER SEQUENCE privilege_id_seq OWNED BY privilege.id;


--
-- Name: program_id_seq; Type: SEQUENCE; Schema: public; Owner: northbri_devnexus
--

CREATE SEQUENCE program_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE program_id_seq OWNER TO northbri_devnexus;

--
-- Name: program; Type: TABLE; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

CREATE TABLE program (
    id integer DEFAULT nextval('program_id_seq'::regclass) NOT NULL,
    description character varying(1000) DEFAULT ''::character varying,
    name character varying(50) DEFAULT ''::character varying,
    size character varying(20),
    eligibility character varying(250),
    services character varying(1000),
    involvement character varying(250),
    partner_interest character varying(250),
    partner_descr character varying(250),
    hours character varying(50),
    ada boolean
);


ALTER TABLE program OWNER TO northbri_devnexus;

--
-- Name: program_contact_id_seq; Type: SEQUENCE; Schema: public; Owner: northbri_devnexus
--

CREATE SEQUENCE program_contact_id_seq
    START WITH 534
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE program_contact_id_seq OWNER TO northbri_devnexus;

--
-- Name: program_contact; Type: TABLE; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

CREATE TABLE program_contact (
    id integer DEFAULT nextval('program_contact_id_seq'::regclass) NOT NULL,
    program_fk integer NOT NULL,
    contact_fk integer NOT NULL
);


ALTER TABLE program_contact OWNER TO northbri_devnexus;

--
-- Name: program_language_id_seq; Type: SEQUENCE; Schema: public; Owner: northbri_devnexus
--

CREATE SEQUENCE program_language_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE program_language_id_seq OWNER TO northbri_devnexus;

--
-- Name: program_language; Type: TABLE; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

CREATE TABLE program_language (
    id integer DEFAULT nextval('program_language_id_seq'::regclass) NOT NULL,
    program_fk integer NOT NULL,
    language_fk integer NOT NULL
);


ALTER TABLE program_language OWNER TO northbri_devnexus;

--
-- Name: program_location_id_seq; Type: SEQUENCE; Schema: public; Owner: northbri_devnexus
--

CREATE SEQUENCE program_location_id_seq
    START WITH 703
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE program_location_id_seq OWNER TO northbri_devnexus;

--
-- Name: program_location; Type: TABLE; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

CREATE TABLE program_location (
    id integer DEFAULT nextval('program_location_id_seq'::regclass) NOT NULL,
    program_fk integer NOT NULL,
    location_fk integer NOT NULL
);


ALTER TABLE program_location OWNER TO northbri_devnexus;


--
-- Name: role; Type: TABLE; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

CREATE TABLE role (
    id integer NOT NULL,
    name character varying(15) NOT NULL,
    description character varying(100) NOT NULL
);


ALTER TABLE role OWNER TO northbri_devnexus;

--
-- Name: role_id_seq; Type: SEQUENCE; Schema: public; Owner: northbri_devnexus
--

CREATE SEQUENCE role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE role_id_seq OWNER TO northbri_devnexus;

--
-- Name: role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: northbri_devnexus
--

ALTER SEQUENCE role_id_seq OWNED BY role.id;


--
-- Name: role_privilege; Type: TABLE; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

CREATE TABLE role_privilege (
    role_id_fk integer NOT NULL,
    privilege_id_fk integer NOT NULL
);


ALTER TABLE role_privilege OWNER TO northbri_devnexus;

--
-- Name: spatial_ref_sys; Type: TABLE; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

CREATE TABLE spatial_ref_sys (
    srid integer NOT NULL,
    auth_name character varying(256),
    auth_srid integer,
    srtext character varying(2048),
    proj4text character varying(2048),
    CONSTRAINT spatial_ref_sys_srid_check CHECK (((srid > 0) AND (srid <= 998999)))
);


ALTER TABLE spatial_ref_sys OWNER TO northbri_devnexus;

--
-- Name: status; Type: TABLE; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

CREATE TABLE status (
    id integer NOT NULL,
    name character varying(10) NOT NULL,
    description character varying(100)
);


ALTER TABLE status OWNER TO northbri_devnexus;

--
-- Name: status_id_seq; Type: SEQUENCE; Schema: public; Owner: northbri_devnexus
--

CREATE SEQUENCE status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE status_id_seq OWNER TO northbri_devnexus;

--
-- Name: status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: northbri_devnexus
--

ALTER SEQUENCE status_id_seq OWNED BY status.id;


--
-- Name: topic_id_seq; Type: SEQUENCE; Schema: public; Owner: northbri_devnexus
--

CREATE SEQUENCE topic_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE topic_id_seq OWNER TO northbri_devnexus;

--
-- Name: topic; Type: TABLE; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

CREATE TABLE topic (
    id integer DEFAULT nextval('topic_id_seq'::regclass) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE topic OWNER TO northbri_devnexus;

--
-- Name: user; Type: TABLE; Schema: public; Owner: northbri_devnexus; Tablespace: 
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
    sms character varying(20) DEFAULT ''::character varying NOT NULL,
    enable_email boolean DEFAULT false NOT NULL,
    enable_sms boolean DEFAULT false NOT NULL,
    contact_fk integer,
    cryptimpl character varying(5) DEFAULT 'None'::character varying NOT NULL,
    salt character varying(32),
    crypt_dttm timestamp with time zone,
    conference_link character varying(100) DEFAULT ''::character varying,
    publish_email boolean DEFAULT false NOT NULL,
    publish_sms boolean DEFAULT false NOT NULL,
    descr character varying(250) DEFAULT ''::character varying,
    phone character varying(20) DEFAULT ''::character varying,
    publish_phone boolean DEFAULT false NOT NULL,
    custom_profile character varying(500)
);


ALTER TABLE "user" OWNER TO northbri_devnexus;

--
-- Name: COLUMN "user".email; Type: COMMENT; Schema: public; Owner: northbri_devnexus
--

COMMENT ON COLUMN "user".email IS 'Drop this in favor of user_contact';


--
-- Name: COLUMN "user".sms; Type: COMMENT; Schema: public; Owner: northbri_devnexus
--

COMMENT ON COLUMN "user".sms IS 'Drop this in favor of user_contact';


--
-- Name: COLUMN "user".cryptimpl; Type: COMMENT; Schema: public; Owner: northbri_devnexus
--

COMMENT ON COLUMN "user".cryptimpl IS 'Identify the system-specific implementation of the hash algorithm';


--
-- Name: COLUMN "user".crypt_dttm; Type: COMMENT; Schema: public; Owner: northbri_devnexus
--

COMMENT ON COLUMN "user".crypt_dttm IS 'Date the password was last encrypted.';


--
-- Name: user_group_id_seq; Type: SEQUENCE; Schema: public; Owner: northbri_devnexus
--

CREATE SEQUENCE user_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_group_id_seq OWNER TO northbri_devnexus;

--
-- Name: user_group; Type: TABLE; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

CREATE TABLE user_group (
    id integer DEFAULT nextval('user_group_id_seq'::regclass) NOT NULL,
    user_fk integer NOT NULL,
    create_dttm timestamp with time zone DEFAULT now() NOT NULL,
    update_dttm timestamp with time zone,
    group_fk integer NOT NULL,
    role_fk integer
);


ALTER TABLE user_group OWNER TO northbri_devnexus;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: northbri_devnexus
--

CREATE SEQUENCE user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_id_seq OWNER TO northbri_devnexus;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: northbri_devnexus
--

ALTER SEQUENCE user_id_seq OWNED BY "user".id;


--
-- Name: user_organization; Type: TABLE; Schema: public; Owner: northbri_devnexus; Tablespace: 
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


ALTER TABLE user_organization OWNER TO northbri_devnexus;

--
-- Name: user_organization_id_seq; Type: SEQUENCE; Schema: public; Owner: northbri_devnexus
--

CREATE SEQUENCE user_organization_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_organization_id_seq OWNER TO northbri_devnexus;

--
-- Name: user_organization_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: northbri_devnexus
--

ALTER SEQUENCE user_organization_id_seq OWNED BY user_organization.id;


--
-- Name: user_password_id_seq; Type: SEQUENCE; Schema: public; Owner: northbri_devnexus
--

CREATE SEQUENCE user_password_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_password_id_seq OWNER TO northbri_devnexus;

--
-- Name: user_password; Type: TABLE; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

CREATE TABLE user_password (
    id integer DEFAULT nextval('user_password_id_seq'::regclass) NOT NULL,
    user_fk integer NOT NULL,
    activity character varying(10) NOT NULL,
    create_dttm timestamp with time zone DEFAULT now() NOT NULL,
    response_dttm timestamp with time zone,
    uuid uuid
);


ALTER TABLE user_password OWNER TO northbri_devnexus;

--
-- Name: user_session_id_seq; Type: SEQUENCE; Schema: public; Owner: northbri_devnexus
--

CREATE SEQUENCE user_session_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_session_id_seq OWNER TO northbri_devnexus;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

CREATE TABLE user_session (
    id integer DEFAULT nextval('user_session_id_seq'::regclass) NOT NULL,
    user_fk integer,
    ip inet,
    create_dttm timestamp with time zone NOT NULL
);


ALTER TABLE user_session OWNER TO northbri_devnexus;

--
-- Name: COLUMN user_session.create_dttm; Type: COMMENT; Schema: public; Owner: northbri_devnexus
--

COMMENT ON COLUMN user_session.create_dttm IS 'Indicates when the login activity occurred.';


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY event ALTER COLUMN id SET DEFAULT nextval('event_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY invitation ALTER COLUMN id SET DEFAULT nextval('invitation_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY invitation_organization ALTER COLUMN id SET DEFAULT nextval('invitation_organization_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY organization ALTER COLUMN id SET DEFAULT nextval('organization_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY organization_organization ALTER COLUMN id SET DEFAULT nextval('organization_organization_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY privilege ALTER COLUMN id SET DEFAULT nextval('privilege_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY role ALTER COLUMN id SET DEFAULT nextval('role_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY status ALTER COLUMN id SET DEFAULT nextval('status_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY "user" ALTER COLUMN id SET DEFAULT nextval('user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY user_organization ALTER COLUMN id SET DEFAULT nextval('user_organization_id_seq'::regclass);


--
-- Data for Name: affiliation; Type: TABLE DATA; Schema: public; Owner: northbri_devnexus
--

INSERT INTO affiliation VALUES (13, 'African Methodist Episcopal');
INSERT INTO affiliation VALUES (14, 'African Methodist Episcopal Zion');
INSERT INTO affiliation VALUES (15, 'Apostolic');
INSERT INTO affiliation VALUES (16, 'Assemblies of God');
INSERT INTO affiliation VALUES (17, 'Baptist');
INSERT INTO affiliation VALUES (18, 'Baptist-American');
INSERT INTO affiliation VALUES (19, 'Baptist-Missionary');
INSERT INTO affiliation VALUES (20, 'Baptist-Southern');
INSERT INTO affiliation VALUES (21, 'Buddhist');
INSERT INTO affiliation VALUES (22, 'Catholic-Roman');
INSERT INTO affiliation VALUES (23, 'Christian Methodist Episcopal');
INSERT INTO affiliation VALUES (24, 'Christian Science');
INSERT INTO affiliation VALUES (25, 'Church of God in Christ');
INSERT INTO affiliation VALUES (26, 'Church of the Brethren');
INSERT INTO affiliation VALUES (27, 'Congregational Church');
INSERT INTO affiliation VALUES (28, 'Disciples of Christ-Christian Church');
INSERT INTO affiliation VALUES (29, 'Episcopal Church');
INSERT INTO affiliation VALUES (30, 'Evangelical Covenent Church');
INSERT INTO affiliation VALUES (31, 'Evangelical Free Church');
INSERT INTO affiliation VALUES (32, 'Friends-Society of Friends-Quaker');
INSERT INTO affiliation VALUES (33, 'Hindu');
INSERT INTO affiliation VALUES (34, 'Jehovah Witness');
INSERT INTO affiliation VALUES (35, 'Jewish');
INSERT INTO affiliation VALUES (36, 'Lutheran-ELCA');
INSERT INTO affiliation VALUES (37, 'Lutheran-Missouri Synod');
INSERT INTO affiliation VALUES (38, 'Mennonite');
INSERT INTO affiliation VALUES (39, 'Methodist-United');
INSERT INTO affiliation VALUES (40, 'Mormon-Church Jesus Christ Latter Day Saints');
INSERT INTO affiliation VALUES (41, 'Muslim');
INSERT INTO affiliation VALUES (42, 'Nation of Islam');
INSERT INTO affiliation VALUES (43, 'Non-Denominational');
INSERT INTO affiliation VALUES (44, 'Orthodox-Greek');
INSERT INTO affiliation VALUES (45, 'Orthodox-Russian');
INSERT INTO affiliation VALUES (46, 'Pentecostal');
INSERT INTO affiliation VALUES (47, 'Presbyterian-United Presbyterian Church of America');
INSERT INTO affiliation VALUES (48, 'Reformed-Christian Reformed Church');
INSERT INTO affiliation VALUES (49, 'Reformed-Reformed Church in America');
INSERT INTO affiliation VALUES (50, 'Seventh Day Adventists');
INSERT INTO affiliation VALUES (51, 'Shinto');
INSERT INTO affiliation VALUES (52, 'Sikh');
INSERT INTO affiliation VALUES (53, 'Unitarian Universalist');
INSERT INTO affiliation VALUES (54, 'United Church of Christ');
INSERT INTO affiliation VALUES (55, 'Baha''i Faith');


--
-- Name: affiliation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbri_devnexus
--

SELECT pg_catalog.setval('affiliation_id_seq', 55, true);


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: northbri_devnexus
--

INSERT INTO category VALUES (1, 'Health Program Topics', 18);


--
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbri_devnexus
--

SELECT pg_catalog.setval('category_id_seq', 1, true);


--
-- Data for Name: category_topic; Type: TABLE DATA; Schema: public; Owner: northbri_devnexus
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
-- Name: category_topic_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbri_devnexus
--

SELECT pg_catalog.setval('category_topic_id_seq', 41, true);


--
-- Data for Name: contact; Type: TABLE DATA; Schema: public; Owner: northbri_devnexus
--

INSERT INTO contact VALUES (65, 'sistuhgsp@yahoo.com', '', '7733738500', '', NULL, '3128649007', '', 'Geraldine Peacock, Health Ministry Coordinator');
INSERT INTO contact VALUES (67, 'revcwj2000@sbcglobal.net', '', '7735224812', '', NULL, '7735224812', '', 'Cynthia Johnson, Pastor');
INSERT INTO contact VALUES (238, 'office@churchonthepark.com', '', '8472556687', '', NULL, '8472556388', '', '');
INSERT INTO contact VALUES (49, 'darlene.zec@advocatehealth.com', '', '', '', NULL, '', '', 'Darlene Zec');
INSERT INTO contact VALUES (78, 'dderylak@ctschicago.edu', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (11, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (51, 'nancy.durbin@advocatehealth.com', '', '8473843749', 'http://www.advocatehealth.com/', NULL, '8476960239', '', 'Nancy Durbin Director, Parish Nurse Ministry');
INSERT INTO contact VALUES (45, '', '', '', '', NULL, '', '', 'Rev. Marilyn Pagan Banks');
INSERT INTO contact VALUES (54, 'beverly.kimmons@alz.org', '', '8479332413', '', NULL, '', '', 'Beverly Kimmons');
INSERT INTO contact VALUES (274, 'jlewis6@gmail.com', '', '7737860249', '', NULL, '7737860256', '', 'Janine Lewis, Director of Health Promotions');
INSERT INTO contact VALUES (62, '', '', '3122248172', '', NULL, '3122389464', '', '');
INSERT INTO contact VALUES (226, '', '', '7732572324', '', NULL, '7732575680', '', '');
INSERT INTO contact VALUES (48, '', '', '', '', NULL, '', '', 'Corky DeBoer, Manager of Spiritual Services');
INSERT INTO contact VALUES (52, '', '', '', '', NULL, '', '', 'Minister Chris Church');
INSERT INTO contact VALUES (270, '', '', '3129964656', '', NULL, '3129963848', '', 'Bertha Paul, School and Community Health Educator');
INSERT INTO contact VALUES (55, '', '', '7734167328', '', NULL, '', '', '');
INSERT INTO contact VALUES (214, '', '', '3124134609', '', NULL, '3124134503', '', '');
INSERT INTO contact VALUES (222, '', '', '8007570202', '', NULL, '3129426116', '', '');
INSERT INTO contact VALUES (64, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (69, 'TraceyKite@jcfs.org', '', '8475685216', 'http://www.jcfs.org/', NULL, '5475685100', '', 'Tracey Kite Director, Jewish Healing Network of Chicago');
INSERT INTO contact VALUES (68, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (73, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (224, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (225, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (228, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (230, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (231, '', '', '', '', NULL, '', '', 'Rev. Thomas Bishop');
INSERT INTO contact VALUES (232, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (233, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (234, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (91, 'pastorcucc@sbcglobal.net', '', '', 'http://www.congucc.org/', NULL, '', '', 'Pastor Rex Piercy');
INSERT INTO contact VALUES (237, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (101, 'epworthchicago@gmail.com', '', '', 'http://www.epworthchicago.org/', NULL, '', '', 'Rev. Amos Olidapo');
INSERT INTO contact VALUES (239, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (241, '', '', '', '', NULL, '', '', 'Erik Christensen, Rev.');
INSERT INTO contact VALUES (242, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (243, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (245, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (160, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (162, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (210, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (211, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (71, 'yahmeihsieh@gmail.com', '', '6309636601', 'http://www.us.tzuchi.org/', NULL, '', '', 'Ms. Yahmei Hsieh');
INSERT INTO contact VALUES (213, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (215, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (219, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (220, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (221, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (271, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (272, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (273, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (124, 'gracevillapark@yahoo.com', '', '', '', NULL, '', '', 'Pastor Jade Yi');
INSERT INTO contact VALUES (114, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (117, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (119, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (120, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (122, 'rodneycwalker@yahoo.com', '', '7737835145', '', NULL, '', '', 'Rev. Rodney C. Walker');
INSERT INTO contact VALUES (123, 'rodneycwalker@yahoo.com', '', '7737835145', '', NULL, '', '', 'Rev. Rodney C. Walker');
INSERT INTO contact VALUES (121, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (126, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (127, '', '', '', '', NULL, '', '', 'Charlayne Guy Moore');
INSERT INTO contact VALUES (128, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (129, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (130, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (111, 'pastorfbc@yahoo.com', '', '7087482566', 'http://www.fbcparkforest.org/', NULL, '', '', 'Rev. Carol Jamieson Brown');
INSERT INTO contact VALUES (110, 'fbclagrange@sbcglobal.net', '', '', 'http://www.fbclagrange.com/', NULL, '', '', 'Rev. Michael Strickland');
INSERT INTO contact VALUES (113, 'bshereos@firstfree.com', '', '', 'http://www.firstfree.com/', NULL, '', '', 'Rev. Bill Shereos');
INSERT INTO contact VALUES (115, 'newbethlehem@gmail.com', '', '7734886053', '', NULL, '7736021559', '', 'The Rev. Rickey Kendrick, Executive Director');
INSERT INTO contact VALUES (247, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (250, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (256, 'sghughes@uic.edu', '', '3124137500', '', NULL, '', '', 'Contact: Sharon Greene-Hughes, Antenatal Testing Specialist, Maternal Fetal Medicine High Risk Nurse');
INSERT INTO contact VALUES (251, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (252, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (257, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (53, 'pastor@africancommunityumc.org', '', '7732627881', 'http://www.africancommunityumc.org/', NULL, '', '', 'Rev. Amos Olidapo');
INSERT INTO contact VALUES (258, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (259, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (260, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (261, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (264, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (266, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (269, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (61, '', '', '3124766619', '', NULL, '', '', 'Debra Davis, Director of Cultural Health Initiatives');
INSERT INTO contact VALUES (46, '', '', '', 'http://www.accessliving.org/', NULL, '', '', 'Ms. Rahnee Patrick');
INSERT INTO contact VALUES (227, '', '', '7087984150', '', NULL, '', '', 'Re. Kris Orr');
INSERT INTO contact VALUES (56, 'kim.blechschmidt@ageoptions.org', '', '7083830258', 'http://www.ageoptions.org/', NULL, '', '', 'Ms. Lisa Blechschmidt');
INSERT INTO contact VALUES (229, '', '', '3123377111', '', NULL, '', '', '');
INSERT INTO contact VALUES (240, '', '', '7732355420', '', NULL, '', '', '');
INSERT INTO contact VALUES (246, '', '', '7734834300', '', NULL, '', '', '');
INSERT INTO contact VALUES (254, '', '', '7083662633', '', NULL, '', '', '');
INSERT INTO contact VALUES (265, '', '', '7083381150', '', NULL, '', '', '');
INSERT INTO contact VALUES (57, '', '', '', 'http://www.alexianbrothershealth.org/parishservices', NULL, '', '', 'Rita Tippentrop, Assistant Director');
INSERT INTO contact VALUES (223, '', '', '7733712300', '', NULL, '', '', '');
INSERT INTO contact VALUES (275, '', '', '7083969777', '', NULL, '', '', '');
INSERT INTO contact VALUES (79, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (81, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (83, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (84, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (85, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (97, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (66, 'rabbi@bybs.org', '', '7087994110', 'http://www.bybs.org/', NULL, '', '', 'Rabbi Ellen Dreyfus');
INSERT INTO contact VALUES (100, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (107, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (159, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (112, '', '', '', 'http://www.wscongo.org/', NULL, '', '', 'Deborah Stankiewicz, AHC Parish Nurse');
INSERT INTO contact VALUES (125, '', '', '', 'http://www.graceriverforest.org/', NULL, '', '', 'Dr. MaryBeth Buschmann');
INSERT INTO contact VALUES (95, 'BROM-ChurchRelations@advocatehealth.com', '', '3092685499', 'http://www.advocatehealth.com/bromenn/churchrelations', NULL, '', '', 'The Rev. Cheree'' Johnson');
INSERT INTO contact VALUES (99, 'macphie@sbcglobal.net', '', '7735614748', 'http://www.edgewaterpres.org/', NULL, '', '', 'Rev. Dr. Barb Cathey');
INSERT INTO contact VALUES (102, 'hesed333@yahoo.com', '', '8475374449', 'http://www.egreenpc.org/', NULL, '', '', 'Rev. Yun Chun Han');
INSERT INTO contact VALUES (47, '', '', '7737828464', 'http://www.familialatinaunida.org/', NULL, '', '', '');
INSERT INTO contact VALUES (50, '', '', '6305729393', 'http://www.advocatehealth.com/', NULL, '', '', 'Rev. Bonnie Condon');
INSERT INTO contact VALUES (168, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (169, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (170, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (174, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (175, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (180, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (181, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (183, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (178, 'cnicholas@kidneyfund.org', '', '3122248172', '', NULL, '', '', 'Courtney Nicholas, Associate Director');
INSERT INTO contact VALUES (184, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (185, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (186, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (189, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (192, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (193, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (194, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (197, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (200, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (201, '', '', '', '', NULL, '', '', 'Dana Bright Community Health Coordinator');
INSERT INTO contact VALUES (202, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (182, 'info@mosquefoundation.org', '', '', 'http://www.mosquefoundation.org/', NULL, '', '', 'Imam Kifah Mustapha');
INSERT INTO contact VALUES (209, 'office@pilgrimfaith.org', '', '', 'http://www.pilgrimfaith.org/', NULL, '', '', '');
INSERT INTO contact VALUES (176, '', '', '', 'http://www.advocatehealth.com/lgch/', NULL, '', '', 'Rev. Kathi Bender Schwich');
INSERT INTO contact VALUES (177, '', '', '', 'http://www.lssi.org/', NULL, '', '', 'Daniel Schwick, V.P Church and Community');
INSERT INTO contact VALUES (133, 'ksidd@hamdardcenter.org', '', '7734654600', 'http://www.hamdardcenter.org/', NULL, '', '', 'Ms. Kiran Siddiqui');
INSERT INTO contact VALUES (140, '', '', '', 'http://www.idph.state.il.us/planready/index.htm', NULL, '', '', 'Dr. Leon Dingle');
INSERT INTO contact VALUES (139, 'eric.chua@juno.com', '', '7732882677', 'http://www.hydeparkcrc.org/', NULL, '', '', 'Mr. Eric Chua');
INSERT INTO contact VALUES (167, 'illconfmontes@aol.com', '', '7083444470', 'http://www.uccillconf.org/', NULL, '7083444564', '', 'Jorge Montes, Reverend');
INSERT INTO contact VALUES (103, '', '', '8472089544', 'http://www.exoduschurch.org/', NULL, '', '', 'Rev. Dr. Jeremiah Yi');
INSERT INTO contact VALUES (118, '', '', '3124551000', '', NULL, '3124559674', '', 'Heather Dudzinski, Community Outreach Coordinator');
INSERT INTO contact VALUES (131, '', '', '7735224812', '', NULL, '7735224812', '', '');
INSERT INTO contact VALUES (134, '', '', '7084848541', '', NULL, '7084843179', '', 'Carmen Carrizales, Health Initiatives Representative');
INSERT INTO contact VALUES (143, '', '', '3125031764', '', NULL, '3125061764', '', 'Sarah Bristol-Gould Director, Research Programs; IL Women''s Health Registry');
INSERT INTO contact VALUES (146, '', '', '3125031308', '', NULL, '3125031764', '', '');
INSERT INTO contact VALUES (165, '', '', '3129156811', '', NULL, '3129156485', '', 'Mary Burns, Community Projects Director');
INSERT INTO contact VALUES (142, 'alozanoff@illinoispirg.org', '', '3122910441', '', NULL, '', '', '');
INSERT INTO contact VALUES (149, 'nizar.jiwani@gmail.com', '', '7732621616', '', NULL, '', '', 'Mr. Nizar Jawani');
INSERT INTO contact VALUES (150, 'nizar.jiwani@gmail.com', '', '3123995713', '', NULL, '', '', 'Mr. Nizar Jiwani, Communications Director');
INSERT INTO contact VALUES (158, 'joytobefitboom@sbcaol.com', '', '7083662633', '', NULL, '', '', 'Stephanie Jackson-Rowe, Founder and President');
INSERT INTO contact VALUES (116, '', '', '7087982800', '', NULL, '', '', '');
INSERT INTO contact VALUES (137, '', '', '3122797278', '', NULL, '', '', 'Desmond Konadu, Senior Health Initiatives Representative');
INSERT INTO contact VALUES (141, '', '', '3124918161', '', NULL, '', '', '');
INSERT INTO contact VALUES (144, '', '', '7732752520', '', NULL, '', '', '');
INSERT INTO contact VALUES (155, '', '', '7732572324', '', NULL, '', '', 'Maureen Benjamins Senior Epidemiologist');
INSERT INTO contact VALUES (203, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (204, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (205, '', '', '', '', NULL, '', '', 'Brett McCleneghan, Senior Minister');
INSERT INTO contact VALUES (206, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (207, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (153, '', '', '', 'http://www.juf.org/guide/category.aspx?id=31892', NULL, '', '', 'Ms. Charlotte Mallon');
INSERT INTO contact VALUES (145, 'shamar@imancentral.org', '', '7734344626', 'http://www.imancentral.org/', NULL, '', '', 'Mr. Shamar Hemphill');
INSERT INTO contact VALUES (152, '', '', '7734673700', 'http://www.jcfs.org/', NULL, '', '', 'Ms. Robin Levine');
INSERT INTO contact VALUES (196, 'cmvetty@northshorebaptist.org', '', '7737284200', 'http://www.northshorebaptist.org/', NULL, '', '', 'Ms. Dawn Noldan/Mrs. Emy Kosmas');
INSERT INTO contact VALUES (216, 'davidwu@puitak.org', '', '3123281188', 'http://www.puitak.org/', NULL, '', '', 'Mr. David Wu');
INSERT INTO contact VALUES (217, 'admin@rahabshouse.net', '', '7735935896', 'http://www.rahabshouse.net/', NULL, '', '', 'Denise Henley, Rev./President');
INSERT INTO contact VALUES (154, '', '', '8475685216', 'http://www.jcfs.org/', NULL, '8475685125', '', '');
INSERT INTO contact VALUES (199, 'goodnewskitchen@sbcglobal.net', '', '7732622297', 'http://www.gnck.org/', NULL, '7732627872', '', 'Marilyn Pagan-Banks, Executive Director');
INSERT INTO contact VALUES (218, 'Info@RainbowHospice.org', '', '8476859900', 'http://www.rainbowhospice.org/', NULL, '8472949613', '', 'Dave Samson');
INSERT INTO contact VALUES (166, '', '', '3129156811', 'http://www.leadsafeillinois.org/', NULL, '3129156485', '', '');
INSERT INTO contact VALUES (82, 'sguy178525@aol.com', '', '3129393720', '', NULL, '3123213027', '', 'Sandra Guy, Leadership team member');
INSERT INTO contact VALUES (135, 'mbcukley@hcionline.org', '', '7088419515', '', NULL, '7088419713', '', 'Mayme Buckley, Associate Director, Interfaith and Development');
INSERT INTO contact VALUES (86, '', '', '3129066196', '', NULL, '3129066123', '', 'Marty Hatlie, CEO');
INSERT INTO contact VALUES (96, '', '', '6306827979', '', NULL, '6304629085', '', '');
INSERT INTO contact VALUES (98, '', '', '7735618496', '', NULL, '7735618001', '', '');
INSERT INTO contact VALUES (161, '', '', '7083444470', '', NULL, '7083444564', '', '');
INSERT INTO contact VALUES (164, '', '', '7083969777', '', NULL, '7083969732', '', '');
INSERT INTO contact VALUES (74, 'dave_roth@lcfs.org', '', '7084885581', '', NULL, '', '', 'Rev. Dave Roth');
INSERT INTO contact VALUES (77, 'chicagochinbaptistchurch@gmail.com', '', '7736033263', '', NULL, '', '', 'Pastor Danny Bawi Thianhlun');
INSERT INTO contact VALUES (87, 'blwater@dupagehealth.org', '', '6306827979', '', NULL, '', '', 'Bette Lawrence Water, Program Manager');
INSERT INTO contact VALUES (58, '', '', '8479332413', '', NULL, '', '', '');
INSERT INTO contact VALUES (132, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (136, 'Laura@HealthyDinning.org', '', '3126669979', '', NULL, '', '', '');
INSERT INTO contact VALUES (147, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (148, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (151, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (92, '', '', '3125737749', '', NULL, '', '', 'Rev. James Kenady, Lead Community Liaison');
INSERT INTO contact VALUES (106, '', '', '7738461056', '', NULL, '', '', '');
INSERT INTO contact VALUES (108, '', '', '3129884850', '', NULL, '', '', '');
INSERT INTO contact VALUES (109, '', '', '7087498800', '', NULL, '', '', 'Rev. Dr. Damon Jones');
INSERT INTO contact VALUES (156, '', '', '7735330034', '', NULL, '', '', '');
INSERT INTO contact VALUES (208, '', '', '7737846633', '', NULL, '', '', 'Rev. Jean Darling');
INSERT INTO contact VALUES (76, 'pastor@iglesiabautistacentral.org', '', '7733420836', 'http://www.iglesiabautistacentral.org/', NULL, '', '', 'Rev. Shakespeare Osorio');
INSERT INTO contact VALUES (80, 'pillaishanker@gmail.com', '', '6306533370', 'http://www.mychinmaya.org/', NULL, '', '', 'Mr. Shanker Pillai');
INSERT INTO contact VALUES (93, 'sramsey@jpusa.org', '', '7735066396', 'http://www.ccolife.org/', NULL, '', '', 'Ms. Sandy Ramsey');
INSERT INTO contact VALUES (72, 'faithcaucus@cbhconline.org', '', '3129139449', 'http://www.cbhconline.org/faith', NULL, '3129139559', '', 'Laura Leon, Director of Faith Initiatives');
INSERT INTO contact VALUES (88, 'MAriyo@cityforce.org', '', '7734734100', 'http://www.ilfba.org/', NULL, '7734734200', '', 'Michele Ariyo');
INSERT INTO contact VALUES (89, 'kirsten.peachey@advocatehealth.com', '', '8473843552', 'http://www.advocatehealth.com/', NULL, '8476960239', '', 'Rev. Kirsten Peachey');
INSERT INTO contact VALUES (90, 'veronica@faithinplace.org', '', '3127334640', 'http://faithinplace.org/', NULL, '3127334610', '', '');
INSERT INTO contact VALUES (104, 'lleon@cbhconline.org', '', '3129139449', 'http://www.cbhconline.org/issues/hcjc/faith.html', NULL, '3129139559', '', '');
INSERT INTO contact VALUES (138, 'maria.oquendo@advocatehealth.com', '', '7732967157', 'http://www.hispanocare.org/', NULL, '7733278208', '', 'Maria Oquendo, Coordinator');
INSERT INTO contact VALUES (75, '', '', '7732446201', 'http://www.northpark.edu/sem/academics/faculty/mchasez.html', NULL, '7732446244', '', 'Mary Chase-Ziolek, PhD, RN Director, Professor of Health Ministries');
INSERT INTO contact VALUES (105, '', '', '3127264948', 'http://www.faithinplace.org/', NULL, '3127266108', '', '');
INSERT INTO contact VALUES (163, '', '', '3123649071', 'http://www.networkofstrength.org/illinois', NULL, '3123649066', '', 'Judy Guitelman, Program Coordinator');
INSERT INTO contact VALUES (171, '', '', '3124551000', 'http://www.littlebrotherschicago.org/', NULL, '3124559674', '', '');
INSERT INTO contact VALUES (70, '', '', '3123649071', 'http://www.networkofstrength.org/illinois', NULL, '3123649066', '', '');
INSERT INTO contact VALUES (212, '', '', '3123649071', 'http://www.networkofstrength.org/illinois', NULL, '3123649066', '', 'Gabriela Kowalczyk, Program Coordinator');
INSERT INTO contact VALUES (195, '', '', '7732446201', '', NULL, '7732446244', '', '');
INSERT INTO contact VALUES (236, 'stjames.pastor@gmail.com', '', '', 'http://www.stjamesws.org/', NULL, '', '', 'Pastor Erin Clausen');
INSERT INTO contact VALUES (244, 'jvg001@sbcglobal.net', '', '', 'http://www.stpaulsbylake.org/', NULL, '', '', 'Ms. Judith Gramer');
INSERT INTO contact VALUES (263, 'bliss@imaginechicago.org', '', '', 'http://www.ubumama.org/', NULL, '', '', 'Bliss Browne, President');
INSERT INTO contact VALUES (276, 'zehra_zamshope@yahoo.com', '', '', 'http://www.zamshope.net/', NULL, '', '', '');
INSERT INTO contact VALUES (63, '', '', '', 'http://www.antiochteleguchurch.org/', NULL, '', '', 'Rev. David Sagar');
INSERT INTO contact VALUES (235, 'mjh816@sbcglobal.net', '', '7735615343', 'http://www.saintita.org/', NULL, '', '', 'Sr. Mary Jeanne Hayes');
INSERT INTO contact VALUES (248, 'stsylvester@archchicago.org', '', '7732353646', 'http://stsylvesterparish.com/', NULL, '', '', 'Dora Albert');
INSERT INTO contact VALUES (253, 'rev.eshin.patti23@gmail.com', '', '7733344661', 'http://www.budtempchi.org/', NULL, '', '', 'Rev. Patti Nakai');
INSERT INTO contact VALUES (262, '', '', '', 'http://www.tpoint.org/', NULL, '', '', 'Ms. Ann Fisher Raney');
INSERT INTO contact VALUES (267, 'unitylutheran@ameritech.net', '', '7738784747', 'http://www.unitylutheranchicago.org/', NULL, '', '', 'Rev. Fred Kinsey');
INSERT INTO contact VALUES (268, '', '', '', 'http://www.unitynorthwest.org/', NULL, '', '', 'Rev. Greg Barrette');
INSERT INTO contact VALUES (60, '', '', '8002272345', 'http://www.cancer.org/', NULL, '', '', '');
INSERT INTO contact VALUES (249, '', '', '6306827979', 'http://www.scimc.org/', NULL, '', '', 'Mr. Bob Skrocki');
INSERT INTO contact VALUES (255, '', '', '8472530501', 'http://www.thesouthchurch.com/', NULL, '', '', 'Rev. Rick Kessler');
INSERT INTO contact VALUES (94, '', '', '', 'http://www.ciogc.org/', NULL, '', '', 'Ms. Ahlam Jbara');
INSERT INTO contact VALUES (157, '', '', '', 'http://www.journeytogether.org/', NULL, '', '', 'Rev. Daniel Park');
INSERT INTO contact VALUES (172, '', '', '7733791750', '', NULL, '', '', '');
INSERT INTO contact VALUES (173, '', '', '7736554357', '', NULL, '', '', '');
INSERT INTO contact VALUES (179, '', '', '7086477658', '', NULL, '', '', 'Vicki Burke, Founder of the Ministry to New Moms');
INSERT INTO contact VALUES (187, '', '', '7734931847', '', NULL, '', '', 'Rev. Dr. Biak Mang');
INSERT INTO contact VALUES (188, '', '', '3123942860', '', NULL, '', '', '');
INSERT INTO contact VALUES (190, '', '', '7738389470', '', NULL, '', '', '');
INSERT INTO contact VALUES (191, '', '', '7733847113', '', NULL, '', '', '');
INSERT INTO contact VALUES (198, '', '', '8478085700', '', NULL, '', '', 'Rev. Bumhoon (John) Lee');
INSERT INTO contact VALUES (59, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (277, 'contact@northbridgetech.org', '', '8668489224', 'http://northbridgetech.org', NULL, '', 'CEO', 'Kathy Flint');
INSERT INTO contact VALUES (278, 'janedoe@test.com', '', '111222333', 'http://kittens.com', NULL, '', 'Rev.', 'Jane Doe');
INSERT INTO contact VALUES (279, 'kenneth.cavness@gmail.com', '', '773-412-0657', 'http://www.cnn.com', NULL, '', 'Grand Disorganizer', 'Kenneth Cavness');
INSERT INTO contact VALUES (280, 'contact@northbridgetech.org', '', '1112223333', 'http://northbridgetech.org', NULL, '', 'Rev.', 'Darconville');
INSERT INTO contact VALUES (281, 'test@test.com', '', '', 'http://comcast.net', NULL, '', '', '');
INSERT INTO contact VALUES (282, 'test@test.com', '', '', 'http://comcast.net', NULL, '', '', '');
INSERT INTO contact VALUES (283, 'janedoe@test.com', '', '', 'http://comcast.net', NULL, '', '', '');
INSERT INTO contact VALUES (284, 'test@test.com', '', '', 'http://comcast.net', NULL, '', '', '');
INSERT INTO contact VALUES (285, 'helpme@gmail.com', '', '1234567890', 'www.google.com', NULL, '', 'Lou', 'Lou;s Cat');
INSERT INTO contact VALUES (286, 'kenneth.cavness@gmail.com', '', '17734120657', 'http://www.cats.com', NULL, '', 'Grand Purr-bah', 'Kenneth Catness');
INSERT INTO contact VALUES (287, 'test@test.com', '', '', 'http://comcast.net', NULL, '', '', '');
INSERT INTO contact VALUES (288, 'test@test.com', '', '', 'http://comcast.net', NULL, '', '', '');
INSERT INTO contact VALUES (289, 'test@test.com', '', '', 'http://comcast.net', NULL, '', '', '');
INSERT INTO contact VALUES (290, 'test@test.com', '', '', 'http://comcast.net', NULL, '', '', '');
INSERT INTO contact VALUES (291, 'test@test.com', '', '', 'http://comcast.net', NULL, '', '', '');
INSERT INTO contact VALUES (292, 'helpme@gmail.com', '', '(123) 456-7890', 'www.google.com', NULL, '', '', 'Lou''s Cat');
INSERT INTO contact VALUES (293, 'test@test.com', '', '', 'http://comcast.net', NULL, '', '', '');
INSERT INTO contact VALUES (294, 'helpme@gmail.com', '', '(123) 456-7890', 'www.google.com', NULL, '', '', 'Lou''s Cat');
INSERT INTO contact VALUES (295, 'contact@northbridgetech.org', '', '(111) 222-3333', 'http://northbridgetech.org', NULL, '', '', 'Darconville');
INSERT INTO contact VALUES (296, 'test@test.com', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (297, 'test@test.com', '', '', 'http://comcast.net', NULL, '', '', '');
INSERT INTO contact VALUES (298, 'kenneth.cavness@gmail.com', '', '17734120657', 'http://www.cats.com', NULL, '', '', 'Kenneth George Cavness');
INSERT INTO contact VALUES (299, 'kenneth.cavness@gmail.com', '', '17734120657', 'http://www.cats.com', NULL, '', '', 'Kenneth George Cavness');
INSERT INTO contact VALUES (300, 'test@test.com', '', '17734120657', 'http://comcast.net', NULL, '', '', 'Kenneth George Cavness');
INSERT INTO contact VALUES (301, 'test@test.com', '', '17734120657', 'http://comcast.net', NULL, '', '', 'Kenneth George Cavness');
INSERT INTO contact VALUES (302, 'test@test.com', '', '17734120657', 'http://comcast.net', NULL, '', '', 'Kenneth George Cavness');
INSERT INTO contact VALUES (303, 'test@test.com', '', '17734120657', 'http://www.cats.com', NULL, '', '', 'Kenneth George Cavness');
INSERT INTO contact VALUES (304, 'test@test.com', '', '17734120657', 'http://www.cats.com', NULL, '', '', 'Kenneth George Cavness');
INSERT INTO contact VALUES (305, 'test@test.com', '', '17734120657', 'http://www.cats.com', NULL, '', '', 'Kenneth George Cavness');
INSERT INTO contact VALUES (306, 'test@test.com', '', '17734120657', 'http://www.cats.com', NULL, '', '', 'Kenneth George Cavness');
INSERT INTO contact VALUES (307, 'test@test.com', '', '17734120657', 'http://www.cats.com', NULL, '', '', 'Kenneth George Cavness');
INSERT INTO contact VALUES (308, 'test@test.com', '', '17734120657', 'http://www.cats.com', NULL, '', '', 'Kenneth George Cavness');
INSERT INTO contact VALUES (309, 'kenneth.cavness@gmail.com', '', '8173541522', 'http://www.cnn.com', NULL, '', '', 'Kenneth Cavness');
INSERT INTO contact VALUES (310, 'kenneth.cavness@gmail.com', '', '(817) 354-1522', 'http://www.cnn.com', NULL, '', '', 'Kenneth Cavness');
INSERT INTO contact VALUES (311, 'test@test.com', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (312, 'test@test.com', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (313, 'janedoe@test.com', '', '1112223333', 'http://comcast.net', NULL, '', 'Incognito', 'Jane Doe');
INSERT INTO contact VALUES (314, 'test@test.com', '', '1112223333', 'http://comcast.net', NULL, '', 'Admin', 'Kathy Flint');
INSERT INTO contact VALUES (315, 'test@test.com', '', '(111) 222-3333', 'http://comcast.net', NULL, '', '', 'Kathy Flint');
INSERT INTO contact VALUES (316, 'test@test.com', '', '1112223333', 'http://jojo.com', NULL, '', 'Admin', 'Jane Do');
INSERT INTO contact VALUES (317, 'test@test.com', '', '(111) 222-3333', 'http://jojo.com', NULL, '', '', 'Jane Do');
INSERT INTO contact VALUES (318, 'test@test.com', '', '2345678901', 'http://comcast.net', NULL, '', 'MOTU', 'Full Test');
INSERT INTO contact VALUES (319, 'kenneth.cavness@gmail.com', '', '(773) 412-0657', 'http://www.cnn.com', NULL, '', '', 'Kenneth Cavness');
INSERT INTO contact VALUES (320, 'kenneth.cavness@gmail.com', '', '(773) 412-0657', 'http://www.cnn.com', NULL, '', '', 'Kenneth Cavness');
INSERT INTO contact VALUES (321, 'test@test.com', '', '(234) 567-8901', 'http://comcast.net', NULL, '', '', 'Full Test');
INSERT INTO contact VALUES (322, 'test@test.com', '', '', 'http://comcast.net', NULL, '', '', '');
INSERT INTO contact VALUES (323, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (324, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (325, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (326, 'test@test.com', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (327, '', '', '', '', NULL, '', '', '');
INSERT INTO contact VALUES (328, 'kenneth.cavness@gmail.com', '', '(817) 354-1522', 'http://www.cnn.com', NULL, '', '', 'Kenneth Cavness');


--
-- Name: contact_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbri_devnexus
--

SELECT pg_catalog.setval('contact_id_seq', 328, true);


--
-- Data for Name: ethnicity; Type: TABLE DATA; Schema: public; Owner: northbri_devnexus
--

INSERT INTO ethnicity VALUES (13, 'European American');
INSERT INTO ethnicity VALUES (14, 'African American');
INSERT INTO ethnicity VALUES (15, 'Mexican');
INSERT INTO ethnicity VALUES (16, 'Puerto Rican');
INSERT INTO ethnicity VALUES (17, 'Other Latino');
INSERT INTO ethnicity VALUES (18, 'Asian/Pacific Islander');
INSERT INTO ethnicity VALUES (19, 'South Asian (Indian, Pakistani)');
INSERT INTO ethnicity VALUES (20, 'African');
INSERT INTO ethnicity VALUES (21, 'Arab');
INSERT INTO ethnicity VALUES (22, 'Eastern European (e.g. Polish, Lithuanian)');
INSERT INTO ethnicity VALUES (23, 'Other European');
INSERT INTO ethnicity VALUES (24, 'Native American');


--
-- Name: ethnicity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbri_devnexus
--

SELECT pg_catalog.setval('ethnicity_id_seq', 24, true);


--
-- Data for Name: event; Type: TABLE DATA; Schema: public; Owner: northbri_devnexus
--

INSERT INTO event VALUES (28, 'a2c6200f-7ad8-15d9-f7ff-a4a3cd7e8cfc', '2015-09-14 17:45:00+00', '01:00:00', 'Test', '', 234, NULL, 'America/Denver', 'MDT', '2015-09-14 17:45:37.89476+00', NULL, true, 'collaboration', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (29, '758a198a-adb4-c965-2e46-40087d3c0029', '2015-09-27 15:16:00+00', '01:00:00', 'Kenneth Room Reservation Test 1', '', 232, NULL, 'America/Denver', 'MDT', '2015-09-27 15:16:37.221068+00', NULL, false, 'collaboration', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (1, '89f69a46-0958-5031-5f9f-c834aa47f66f', '2015-08-30 04:00:00+00', '01:00:00', 'Hello world', '', 234, NULL, 'Europe/Helsinki', 'EEST', '2015-08-04 20:21:19.306834+00', NULL, true, 'collaboration', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (3, '8df1e3a7-b387-0cfe-f5b1-5907d7212661', '2015-08-10 11:00:00+00', '01:00:00', 'Take this: &#60;script&#62;alert&#40;&#34;Gotcha&#34;&#41;;&#60;/script&#62;', '', 234, NULL, 'America/Chicago', 'CDT', '2015-08-04 20:35:33.620147+00', NULL, true, 'collaboration', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (4, 'da0c09c4-c48e-d502-972c-c6c25b5036bf', '2015-08-05 15:00:00+00', '00:30:00', 'Testing', '', 174, NULL, 'America/Chicago', 'CDT', '2015-08-05 01:17:31.688124+00', NULL, false, 'collaboration', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (5, '356079c1-02df-b3ad-76de-d334015d5d75', '2015-08-03 13:30:00+00', '01:00:00', 'Kenneth Room Reservation Test 1', '', 232, NULL, 'America/Los_Angeles', 'PDT', '2015-08-09 20:34:04.303184+00', NULL, true, 'collaboration', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (6, '5f8292b3-3b34-604c-4a20-8d6bec2d9f29', '2015-08-09 20:30:00+00', '03:00:00', 'Kenneth Room Reservation Test 2', '', 232, NULL, 'America/Los_Angeles', 'PDT', '2015-08-09 20:35:20.284747+00', NULL, true, 'collaboration', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (7, '053d8bee-4301-e516-bdd5-6fa6d3e4a80e', '2015-08-10 17:00:00+00', '02:00:00', 'Kenneth Room Reservation Test 3', '', 232, NULL, 'America/Los_Angeles', 'PDT', '2015-08-09 20:36:06.385704+00', NULL, false, 'collaboration', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (8, '2d373b85-096d-0d21-6e58-319287c9a590', '2015-08-19 02:00:00+00', '00:30:00', 'Test 2', '', 234, NULL, 'America/Chicago', 'CDT', '2015-08-19 02:01:32.027668+00', NULL, false, 'collaboration', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (9, '13fbd106-d585-0344-d2c8-88d97823a9ba', '2015-08-24 00:05:00+00', '00:30:00', 'Reservation Now Test', '', 234, NULL, 'America/Denver', 'MDT', '2015-08-24 00:05:57.886835+00', NULL, false, 'collaboration', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (10, '1c8bd7dd-fe11-2e62-6878-81956c63b3f6', '2015-09-30 16:30:00+00', '02:00:00', 'Board Meeting', '', 234, NULL, 'America/Chicago', 'CDT', '2015-08-28 02:26:15.585004+00', NULL, true, 'video chat', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (11, '79447f39-f2b2-8496-be34-a7b28679778a', '2015-08-28 02:26:00+00', '00:30:00', 'test', '', 234, NULL, 'America/Denver', 'MDT', '2015-08-28 02:26:32.239954+00', NULL, false, 'video chat', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (12, '54190355-ad70-93b0-f902-b2448bc587d8', '2015-08-28 02:31:00+00', '00:30:00', 'Reservation Now Test', '', 234, NULL, 'America/Denver', 'MDT', '2015-08-28 02:31:11.428842+00', NULL, true, 'collaboration', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (13, '0bde6c04-fdb3-4a18-8c3f-580d9cd4531a', '2015-08-29 15:00:00+00', '03:30:00', 'asd', '', 234, NULL, 'America/Phoenix', 'MST', '2015-08-28 23:00:54.314522+00', NULL, true, 'video chat', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (14, '3442f44d-98fb-990f-317f-a84e7ef16c70', '2015-08-03 13:00:00+00', '01:00:00', 'Kenneth Room Reservation Past Test 1', '', 232, NULL, 'America/Los_Angeles', 'PDT', '2015-09-01 23:29:40.874196+00', NULL, true, 'collaboration', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (15, 'ad6bf1ee-b38b-a032-ab68-6894764ad904', '2015-09-02 00:00:00+00', '01:30:00', 'Kenneth Room Reservation Test 1', '', 232, NULL, 'America/Los_Angeles', 'PDT', '2015-09-01 23:50:23.381245+00', NULL, false, 'collaboration', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (16, '992f60fd-759a-c6ca-fbfe-7d68eb91007d', '2015-09-02 00:00:00+00', '01:00:00', 'Kenneth Room Video Test 1', '', 232, NULL, 'America/Los_Angeles', 'PDT', '2015-09-01 23:55:11.755623+00', NULL, false, 'video chat', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (17, '1b1cb840-c068-ee82-a57d-f3f80f8eece5', '2015-09-03 00:48:00+00', '00:30:00', 'Test', '', 234, NULL, 'America/Denver', 'MDT', '2015-09-03 00:48:28.697803+00', NULL, false, 'collaboration', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (18, 'c9df2c50-2056-8b72-f5ba-b34022b39484', '2015-09-09 16:00:00+00', '01:00:00', 'One on One', '', 260, NULL, 'America/Denver', 'MDT', '2015-09-09 16:00:57.301917+00', NULL, true, 'video chat', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (19, 'fcefcdc0-da1d-c2d7-4ad7-9ceaa1806ca9', '2015-09-09 22:03:00+00', '00:30:00', 'Test Meeting', '', 234, NULL, 'America/Denver', 'MDT', '2015-09-09 22:03:05.275026+00', NULL, true, 'video chat', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (20, '48cc1bdd-eb85-3ba6-b8f8-1c8a3cad1594', '2015-09-09 22:58:00+00', '00:30:00', 'Reservation Now Test', '', 234, NULL, 'America/Denver', 'MDT', '2015-09-09 22:58:13.340651+00', NULL, false, 'video chat', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (21, '6e4306ed-a73f-a6a0-5c54-93ea35f88b43', '2015-09-09 23:02:00+00', '00:30:00', 'test', '', 234, NULL, 'America/Denver', 'MDT', '2015-09-09 23:02:01.549961+00', NULL, true, 'collaboration', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (22, '4c820548-cb3c-05e6-0af5-7c611503cae6', '2015-09-11 20:00:00+00', '01:00:00', 'Chit Chat', '', 260, NULL, 'America/Chicago', 'CDT', '2015-09-11 13:53:06.569389+00', NULL, false, 'video chat', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (23, 'be324b3f-b469-e52f-481f-faf21fccfba8', '2015-09-11 19:00:00+00', '01:00:00', 'Chit Chat', '', 260, NULL, 'America/Chicago', 'CDT', '2015-09-11 13:53:44.676399+00', NULL, false, 'collaboration', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (24, 'e2136a79-668c-bc21-b72f-399506150909', '2015-09-11 15:25:00+00', '00:30:00', 'test', '', 272, NULL, 'America/Denver', 'MDT', '2015-09-11 15:25:46.422057+00', NULL, false, 'video chat', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (25, '16f87163-8d10-eddd-ad3b-d4c7222c4e8c', '2015-09-11 21:55:00+00', '00:30:00', 'Test Meeting', '', 290, NULL, 'America/Denver', 'MDT', '2015-09-11 21:55:03.133323+00', NULL, true, 'collaboration', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (26, 'afef91a2-b7f6-dfad-3d24-f813f9973930', '2015-09-12 17:30:00+00', '00:30:00', 'Test Meeting', '', 234, NULL, 'America/Denver', 'MDT', '2015-09-12 17:30:47.100065+00', NULL, false, 'video chat', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (27, '057e9fcd-e4fa-9ba7-06fa-558918df1fd6', '2015-09-14 17:02:00+00', '00:30:00', 'Test Meeting', '', 234, NULL, 'America/Denver', 'MDT', '2015-09-14 17:02:29.977789+00', NULL, false, 'video chat', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (30, '51742d23-ab76-bfe5-a5f5-840d23dd0741', '2015-10-03 18:19:00+00', '01:00:00', 'Test Meeting', '', 234, NULL, 'America/Denver', 'MDT', '2015-10-03 18:19:20.173909+00', NULL, false, 'video tether', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (31, '06354d3b-a361-9c98-96eb-92933b285f53', '2015-10-03 18:29:00+00', '00:30:00', 'Test Meeting', '', 234, NULL, 'America/Denver', 'MDT', '2015-10-03 18:29:51.48424+00', NULL, false, 'video chat', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (32, '7344f964-aeb6-2c64-ffea-dee8e7ddd410', '2015-10-03 18:30:00+00', '00:30:00', 'Test Meeting', '', 234, NULL, 'America/Denver', 'MDT', '2015-10-03 18:30:20.417209+00', NULL, true, 'collaboration', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (37, '3f501056-30e6-493d-4af9-8bd27f0a8955', '2015-10-13 16:52:00+00', '00:30:00', 'Testing', '', 260, NULL, 'America/Denver', 'MDT', '2015-10-13 16:52:48.507032+00', NULL, false, 'video chat', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (38, '6553b815-3039-6060-c6dc-14e5d8878776', '2015-10-13 17:01:00+00', '00:30:00', 'Testing', '', 260, NULL, 'America/Denver', 'MDT', '2015-10-13 17:01:03.327699+00', NULL, false, 'video tether', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (39, '94df7820-2686-88d5-dda0-de105605d924', '2015-10-13 17:07:00+00', '00:30:00', 'Testing', '', 260, NULL, 'America/Denver', 'MDT', '2015-10-13 17:07:59.205367+00', NULL, false, 'collaboration', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (40, '46503bc5-9fa9-0977-a897-dd4bc06a21b9', '2015-10-13 17:25:00+00', '00:30:00', 'Tes', '', 260, NULL, 'America/Denver', 'MDT', '2015-10-13 17:25:32.593424+00', NULL, false, 'video tether', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (50, '1550e252-8d86-1c0e-8525-a4973455eaff', '2015-10-13 18:14:00+00', '00:30:00', 'Testing', '', 260, NULL, 'America/Denver', 'MDT', '2015-10-13 18:14:16.771777+00', NULL, false, 'video tether', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (36, '963cfc5c-d574-b04f-73e0-5a05644dcb86', '2015-10-13 16:44:00+00', '00:30:00', 'Testing', '', 260, NULL, 'America/Denver', 'MDT', '2015-10-13 16:44:37.521815+00', NULL, false, 'video tether', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (41, 'e8e4b936-918e-7f79-e979-f5125bce3d41', '2015-10-13 17:26:00+00', '00:30:00', 'Testing', '', 260, NULL, 'America/Denver', 'MDT', '2015-10-13 17:26:30.022438+00', NULL, false, 'video chat', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (42, 'ecabf452-eb61-53ea-ce70-74291f2f7629', '2015-10-13 17:30:00+00', '00:30:00', 'Testing', '', 260, NULL, 'America/Denver', 'MDT', '2015-10-13 17:30:18.150991+00', NULL, false, 'video chat', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (43, 'ad817289-c18a-bc29-9a87-38fc22a6c7e9', '2015-10-13 17:33:00+00', '00:30:00', 'Testing', '', 260, NULL, 'America/Denver', 'MDT', '2015-10-13 17:33:30.760347+00', NULL, false, 'video tether', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (44, 'd1ad0d26-cb94-922b-856a-d17936240ff0', '2015-10-13 17:34:00+00', '00:30:00', 'Testing', '', 260, NULL, 'America/Denver', 'MDT', '2015-10-13 17:34:35.553828+00', NULL, false, 'video tether', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (45, '0627743e-a5a7-9440-d9e7-e6cb33db1288', '2015-10-13 17:36:00+00', '00:30:00', 'Testing', '', 260, NULL, 'America/Denver', 'MDT', '2015-10-13 17:36:46.670082+00', NULL, false, 'collaboration', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (46, 'f1d85702-fda8-6962-149d-82d4847faa04', '2015-10-13 17:41:00+00', '00:30:00', 'Testing', '', 260, NULL, 'America/Denver', 'MDT', '2015-10-13 17:41:48.95022+00', NULL, false, 'video chat', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (47, 'fbee2c48-bf23-72e9-2439-edb20099f7a2', '2015-10-13 17:48:00+00', '00:30:00', 'Testing', '', 260, NULL, 'America/Denver', 'MDT', '2015-10-13 17:48:57.844701+00', NULL, false, 'video tether', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (48, 'e1e223b1-2fd6-dab7-28a7-7c6081a7203f', '2015-10-13 17:54:00+00', '01:00:00', 'Testing', '', 260, NULL, 'America/Denver', 'MDT', '2015-10-13 17:54:32.105534+00', NULL, false, 'collaboration', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (49, 'bef59510-b81f-72fe-fe82-77ff57d1cc8f', '2015-10-13 18:11:00+00', '00:30:00', 'Testing', '', 260, NULL, 'America/Denver', 'MDT', '2015-10-13 18:11:22.491827+00', NULL, false, 'video chat', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (52, 'f6d507a3-64f6-4750-0421-75b70de1094d', '2015-10-15 15:31:00+00', '00:30:00', 'One on One', '', 260, NULL, 'America/Denver', 'MDT', '2015-10-15 15:31:24.127299+00', NULL, true, 'video chat', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (51, '6847cc64-8a9d-9fe5-d512-a0c07b344a59', '2015-10-13 18:15:00+00', '00:30:00', 'Testing', '', 260, NULL, 'America/Denver', 'MDT', '2015-10-13 18:15:37.042325+00', NULL, true, 'collaboration', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (53, 'd083ba60-10a5-1280-a92a-0b2b04efda32', '2015-10-18 16:24:00+00', '00:30:00', 'Kenneth Video Link Room Test 1', '', 232, NULL, 'America/Denver', 'MDT', '2015-10-18 16:24:17.447212+00', NULL, false, 'video tether', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (54, 'd661ed63-a290-7bc3-b069-c15a3bfce768', '2015-10-18 16:27:00+00', '00:30:00', 'Kenneth Video Chat Room Test 1', '', 232, NULL, 'America/Denver', 'MDT', '2015-10-18 16:27:18.556591+00', NULL, false, 'video chat', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (55, '33841718-ce13-e479-b0fe-6aae582c139b', '2015-10-18 16:31:00+00', '00:30:00', 'Kenneth Collaboration Room Test 1', '', 232, NULL, 'America/Denver', 'MDT', '2015-10-18 16:31:56.825804+00', NULL, true, 'collaboration', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (56, 'e05fb934-092e-0df0-290d-4df37c60c591', '2015-10-22 22:51:00+00', '00:30:00', 'test', '', 234, NULL, 'America/Denver', 'MDT', '2015-10-22 22:51:22.043119+00', NULL, false, 'collaboration', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (57, '1ec96527-92cf-3713-05ff-5357257e592b', '2015-10-22 22:51:00+00', '00:30:00', 'test', '', 234, NULL, 'America/Denver', 'MDT', '2015-10-22 22:51:57.066161+00', NULL, false, 'video tether', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (58, '013a0741-1413-e669-8ca3-9ff4e8fcb81c', '2015-10-22 22:52:00+00', '00:30:00', 'test', '', 234, NULL, 'America/Denver', 'MDT', '2015-10-22 22:52:24.999479+00', NULL, false, 'video chat', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (34, '49baa4f2-359c-1171-1add-427d8aadff6c', '2016-03-08 01:00:00+00', '02:00:00', 'Quarterly Board Meeting', '', 294, NULL, 'America/Chicago', 'CDT', '2015-10-05 18:38:57.397921+00', NULL, true, 'video tether', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (59, '31f0e633-0795-835d-13bf-43dcc5db2f25', '2015-10-22 22:59:00+00', '00:30:00', 'test', '', 234, NULL, 'America/Denver', 'MDT', '2015-10-22 22:59:59.332194+00', NULL, true, 'video tether', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (85, '291012f4-a3b7-5236-cdfa-0677fd999bac', '2015-12-07 00:42:00+00', '04:00:00', 'Test Meeting', '', 234, NULL, 'America/Denver', 'MST', '2015-12-07 00:42:45.344429+00', NULL, true, 'video chat', '', true, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (60, '90b44474-e33b-86c9-2e26-d568311a577e', '2015-11-05 12:30:00+00', '00:30:00', 'Test Meeting', 'Test meeting description. &#60;script&#62; alert&#40;&#34;hi&#34;&#41;; &#60;/script&#62;', 234, NULL, 'America/Chicago', 'CST', '2015-11-03 19:21:24.517336+00', NULL, false, NULL, '', false, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (61, '246fb9d7-5e3b-516f-539d-fc7b8d3a929d', '2015-11-05 13:00:00+00', '00:30:00', 'Test Meeting', 'Test meeting description.', 234, NULL, 'America/Chicago', 'CST', '2015-11-03 19:26:37.783706+00', NULL, false, NULL, '', false, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (62, 'e27a8b14-a34b-e42f-b8b8-ac9d88b73236', '2015-11-05 13:00:00+00', '01:00:00', 'Test Meeting', 'Test description.', 234, NULL, 'America/Chicago', 'CST', '2015-11-03 19:33:18.997779+00', NULL, false, NULL, '', false, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (63, 'de42aa22-1622-c767-8edd-03c282508e4d', '2015-11-09 18:00:00+00', '02:00:00', 'Sample Event 1 -- Kenneth', 'This is a sample event about which I am sampling and eventing', 232, NULL, 'America/Los_Angeles', 'PST', '2015-11-08 16:48:07.684263+00', NULL, false, NULL, '¯&#92_&#40;ツ&#41;_/¯', false, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (65, '68e62b28-ab70-8f0b-dab9-c8016cf92e25', '2015-11-09 17:00:00+00', '02:00:00', 'Sample Event 2 -- Kenneth', 'Being eventy', 232, NULL, 'America/Los_Angeles', 'PST', '2015-11-08 17:05:53.780673+00', NULL, false, NULL, '', false, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (64, '0b679f58-7486-b072-ebba-3f39df680ea7', '2015-11-09 16:00:00+00', '02:30:00', 'Sample Event 1 -- Kenneth', '', 232, NULL, 'America/Los_Angeles', 'PST', '2015-11-08 17:05:09.968468+00', NULL, false, NULL, 'East BFE', false, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (86, 'ac8dddc8-236b-d5b6-dc0d-4fedef19ad5b', '2015-12-07 11:58:00+00', '04:00:00', 'Test Meeting', '', 234, NULL, 'America/Denver', 'MST', '2015-12-07 11:58:14.413612+00', NULL, true, 'video tether', '', true, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (68, '589e6019-285c-435f-bc91-a49c9cbb3a6e', '2015-12-31 07:00:00+00', '30:00:00', 'Public Test Meeting', 'test test test test', 307, NULL, 'America/Chicago', 'CDT', '2015-11-10 13:25:12.819924+00', NULL, true, 'collaboration', 'location', false, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (70, '5807c186-4927-4be4-a1c8-74a885433912', '2016-01-02 07:00:00+00', '30:00:00', 'Public Test Meeting', 'test test test test <script>alert(''hello'');</script>', 307, NULL, 'America/Chicago', 'CDT', '2015-11-10 13:31:03.034877+00', NULL, true, 'collaboration', 'location', false, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (71, '2aeaf271-3d14-4027-8457-717f903e63da', '2016-01-03 07:00:00+00', '30:00:00', 'Public Test Meeting', 'test test test test', 307, NULL, 'America/Chicago', 'CDT', '2015-11-10 13:31:03.034877+00', NULL, true, 'collaboration', '', false, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (72, '7023e99c-41da-49db-a4b3-57b24075b1e0', '2016-01-04 07:00:00+00', '30:00:00', 'Public Test Meeting', '', 307, NULL, 'America/Chicago', 'CDT', '2015-11-10 13:31:03.034877+00', NULL, true, 'collaboration', 'location', false, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (73, '70fd11ee-6908-4630-9228-a732095c0a53', '2016-01-05 07:00:00+00', '30:00:00', 'Public Test Meeting', 'test test test test', 307, NULL, 'America/Chicago', 'CDT', '2015-11-10 13:31:03.034877+00', NULL, true, 'collaboration', 'location', false, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (75, 'e96efd6e-b763-f5b7-7607-828564699593', '2015-11-19 00:43:00+00', '00:30:00', 'awd', '', 234, NULL, 'America/Denver', 'MST', '2015-11-19 00:43:39.287446+00', NULL, true, 'video chat', '', true, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (87, '0e1f5dda-c8e9-c616-6c61-9459d3c9babd', '2015-12-07 17:22:00+00', '04:00:00', 'test meeting', '', 234, NULL, 'America/Denver', 'MST', '2015-12-07 17:22:34.765217+00', NULL, true, 'collaboration', '', true, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (88, 'b278716c-338c-9367-1045-c87163108ec3', '2015-12-31 13:00:00+00', '01:00:00', 'Test Meeting Future', '', 234, NULL, 'America/Chicago', 'CST', '2015-12-07 20:08:09.08607+00', NULL, true, 'video chat', '', true, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (76, 'cc241dc5-4a60-7c77-f069-ae2c766d0a58', '2015-11-27 12:30:00+00', '01:00:00', 'Hello', '', 260, NULL, 'America/Chicago', 'CST', '2015-11-22 20:38:45.061587+00', NULL, false, 'video chat', '', true, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (89, '81c5a496-420b-425d-43d6-deb9d3643ab1', '2015-12-07 22:45:00+00', '04:00:00', 'Test Meeting', '', 234, NULL, 'America/Denver', 'MST', '2015-12-07 22:45:12.954899+00', NULL, true, 'video chat', '', true, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (77, '27bdca63-65f4-9de1-7ffa-728b6aedf6bb', '2015-12-01 19:42:00+00', '04:00:00', 'Test Meeting', '', 234, NULL, 'America/Denver', 'MST', '2015-12-01 19:42:46.301938+00', NULL, true, 'collaboration', '', true, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (78, '2364e146-b016-fa92-c826-224b35727603', '2015-12-02 02:13:00+00', '04:00:00', 'Test Meeting', '', 234, NULL, 'America/Denver', 'MST', '2015-12-02 02:13:10.605667+00', NULL, true, 'video tether', '', true, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (90, 'b0ce751b-5840-fbeb-ce03-1731ea850a65', '2015-12-08 03:46:00+00', '00:30:00', 'Test Meeting', '', 234, NULL, 'America/Denver', 'MST', '2015-12-08 03:46:31.233377+00', NULL, true, 'video chat', '', true, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (80, 'abb447f0-629f-c8fc-5caf-8bf1e0a67d3e', '2015-12-02 11:57:00+00', '01:00:00', 'Test Meeting', '', 234, NULL, 'America/Chicago', 'CST', '2015-12-02 20:41:52.295136+00', NULL, true, 'collaboration', '', true, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (79, '186104bc-2bf7-08dd-8bd9-c5430c811dc7', '2015-12-02 20:40:00+00', '04:00:00', 'Test Meeting', '', 234, NULL, 'America/Denver', 'MST', '2015-12-02 20:40:06.130843+00', NULL, false, 'video tether', '', true, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (91, '124da39f-5723-8035-8266-41b71e10d4a4', '2015-12-08 15:36:00+00', '02:00:00', '1-1 SC:KF', '', 234, NULL, 'America/Denver', 'MST', '2015-12-08 15:36:59.069841+00', NULL, true, 'video chat', '', true, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (81, 'd6a77bbc-4914-3e54-4abf-b11ff06a718c', '2015-12-03 00:20:00+00', '00:01:00', 'Test Meeting', '', 234, NULL, 'America/Denver', 'MST', '2015-12-03 00:02:28.775763+00', NULL, true, 'video chat', '', true, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (82, '7419a4d6-cec7-3a01-1425-5fd847e903dc', '2015-12-05 19:12:00+00', '01:00:00', 'Test Meeting', '', 234, NULL, 'America/Denver', 'MST', '2015-12-05 19:12:34.978601+00', NULL, true, 'video chat', '', true, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (83, 'e23f22a3-c746-c74e-1d6d-42de36c8a2cc', '2015-12-06 04:22:00+00', '01:00:00', 'Test meeting', '', 234, NULL, 'America/Denver', 'MST', '2015-12-06 04:22:02.945009+00', NULL, true, 'video chat', '', true, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (84, 'c1f13eda-801b-e4a3-c4cb-9ffadc961985', '2015-12-07 00:07:00+00', '00:30:00', 'Test Meeting', '', 234, NULL, 'America/Denver', 'MST', '2015-12-07 00:07:50.32138+00', NULL, true, 'video chat', '', true, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (92, '87470ae4-7dd6-5ae3-cde6-24e052ebfd25', '2015-12-15 11:30:00+00', '00:30:00', 'Another Test', '', 234, NULL, 'America/New_York', 'EST', '2015-12-08 21:51:48.922733+00', NULL, true, 'collaboration', '', true, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (93, 'b8463c42-9b80-827c-7b2a-f58aca19f3f2', '2015-12-08 21:52:00+00', '00:30:00', 'Test Now', '', 234, NULL, 'America/Denver', 'MST', '2015-12-08 21:52:08.373129+00', NULL, true, 'video chat', '', true, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (94, '6bd91167-522a-73f7-38eb-33769045ba3d', '2015-12-08 23:59:00+00', '00:30:00', 'Test Meeting', '', 234, NULL, 'America/Denver', 'MST', '2015-12-08 23:59:49.53796+00', NULL, true, 'video chat', '', true, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (95, 'cc9348b4-75ec-7673-fb43-60419283ef54', '2015-12-16 00:25:00+00', '00:30:00', 'OK', '', 234, NULL, 'America/Denver', 'MST', '2015-12-16 00:25:29.496243+00', NULL, true, 'collaboration', '', true, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (97, '6160e9c2-a58d-4480-9d8a-52b9c2408724', '2015-12-05 17:00:00+00', '03:00:00', 'Honest, Open, Proud (HOP) Workshop ', 'Participants in the program will attend three two-hour workshops that guide people through the process of making disclosure decisions. A leader with lived experience will run the group.', 88, 88, 'America/Chicago', 'CST', '2015-12-18 00:48:02.82047+00', NULL, true, 'collaboration', 'NAMI Chicago, 1536 W. Chicago Ave., Chicago, IL  60642', false, 'Registration is closed. The workshop is free to participants. Contact Kyra Wilson to register for the Honest, Open, Proud workshop at 312-563-0445 or Kyra@namichicago.org', 'http://www.chicagofaithandhealth.org/app/files/public/439/Honest-Open-Proud-HOP.pdf', '', '', NULL, NULL);
INSERT INTO event VALUES (101, '7847efd5-fc27-b4e5-da9e-ef0d60ce5ca6', '2016-01-19 12:30:00+00', '02:30:00', 'Test Event', 'Come to this really great meeting&#33', 312, NULL, 'America/Chicago', 'CST', '2016-01-17 22:41:03.25089+00', NULL, true, NULL, '', false, 'Registration is $1000.', 'http://google.com', 'kathy.d.flint@gmail.com', 'http://northbridgetech.org', 'pdf', NULL);
INSERT INTO event VALUES (98, '3ee2a56c-6f6b-5698-a257-06d4ea1efd2b', '2016-01-15 19:55:00+00', '00:30:00', 'Test', '', 234, NULL, 'America/Denver', 'MST', '2016-01-15 19:55:58.197605+00', NULL, true, 'video chat', '', true, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (96, '9311d590-8692-4bd9-811b-f3204de53ba5', '2016-12-16 00:25:00+00', '00:30:00', 'Test Event', '', 88, NULL, 'America/Chicago', 'CST', '2015-12-16 02:01:00.164868+00', NULL, true, 'collaboration', '740 Monroe Street', false, NULL, NULL, NULL, NULL, 'pdf', NULL);
INSERT INTO event VALUES (35, '71330398-7341-943c-e2c5-987fcc751fc5', '2016-03-21 17:30:00+00', '00:30:00', 'Development Committee Meeting', '', 295, NULL, 'America/Chicago', 'CDT', '2015-10-05 18:41:23.262593+00', NULL, true, 'video chat', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (100, '378262bd-2a93-1019-7253-df073107fda8', '2016-01-15 21:20:00+00', '01:00:00', 'Test', '', 234, NULL, 'America/Denver', 'MST', '2016-01-15 21:20:37.493133+00', NULL, true, 'video chat', '', true, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (99, '2fef1961-1b9c-d8df-8916-de9ee380bca1', '2016-01-20 14:00:00+00', '02:00:00', 'Test', '', 234, NULL, 'America/Chicago', 'CST', '2016-01-15 21:20:16.796512+00', NULL, false, 'video chat', '', true, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (105, '868ea637-3fdc-050a-8677-7605e4e8edc2', '2016-01-18 22:30:00+00', '01:30:00', 'Validation Test', '', 234, NULL, 'Australia/Darwin', 'ACST', '2016-01-17 23:09:44.507777+00', NULL, true, 'video tether', '', true, NULL, NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (106, '57af4096-e260-d15d-22c1-83d749e367ad', '2016-01-17 23:09:00+00', '00:30:00', 'test', '', 234, NULL, 'America/Denver', 'MST', '2016-01-17 23:09:57.194568+00', NULL, true, 'collaboration', '', true, NULL, NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (102, 'ee18092f-99dc-9eb9-ef86-8afc3c4f4cf4', '2016-01-19 12:30:00+00', '01:00:00', 'Test Event 2', 'Again with the awesome meeting.', 312, NULL, 'America/Chicago', 'CST', '2016-01-17 22:55:10.320279+00', NULL, true, NULL, '', false, '', 'http://google.com', 'test@test.com', 'http://northbridgetech.org', 'png', NULL);
INSERT INTO event VALUES (107, '3c5dc392-5fd6-57c8-8fc5-4c96958e110f', '2016-01-18 16:30:00+00', '00:30:00', 'Production Validation 2', '', 234, NULL, 'Pacific/Honolulu', 'HST', '2016-01-17 23:12:20.670988+00', NULL, true, 'video chat', '', true, NULL, NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (135, '1849dd46-3f64-29cd-3409-e9d05a10aaff', '2016-02-08 00:00:00+00', '01:00:00', 'Kenneth Test Meeting 1', '', 232, NULL, 'America/Los_Angeles', 'PST', '2016-02-07 23:34:00.407167+00', NULL, false, 'video chat', '', true, NULL, NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (127, 'bb8eede1-462f-317a-ea81-9f87db8cad4b', '2016-01-25 01:30:00+00', '00:30:00', 'Test Meeting', '', 260, NULL, 'America/Chicago', 'CST', '2016-01-25 00:07:58.657476+00', NULL, true, 'video chat', '', true, NULL, NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (130, '43ae0081-834a-876c-9817-9e806428e4b0', '2016-01-30 23:36:00+00', '00:30:00', 'Test', '', 234, NULL, 'America/Denver', 'MST', '2016-01-30 23:36:52.326097+00', NULL, true, 'collaboration', '', true, NULL, NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (131, '4d15bda0-a459-8160-9c23-7c2ceed4012e', '2016-01-31 00:07:00+00', '00:30:00', 'Test', '', 234, NULL, 'America/Denver', 'MST', '2016-01-31 00:07:26.88627+00', NULL, true, 'collaboration', '', true, NULL, NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (33, '35828332-52c2-3b24-1fad-6f2e9b25944b', '2016-03-01 16:10:04.831296+00', '04:00:00', 'Demo Meeting &#40;click orange arrow to join&#41;', '', 293, NULL, 'America/Chicago', 'CDT', '2015-10-05 18:37:22.996201+00', NULL, true, 'collaboration', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO event VALUES (129, '7b9c2266-6cd3-41aa-f428-b704ebeb7cc1', '2016-02-01 00:00:00+00', '01:00:00', 'Harass Kenneth', '', 260, NULL, 'America/Chicago', 'CST', '2016-01-30 02:35:51.27302+00', NULL, false, 'video tether', '', true, NULL, NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (128, 'f4b1da4c-db55-055f-218e-e3e73a7d85f3', '2016-01-30 16:00:00+00', '02:00:00', 'Harass Kenneth', '', 260, NULL, 'America/Chicago', 'CST', '2016-01-30 02:33:57.086684+00', NULL, false, 'collaboration', '', true, NULL, NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (119, '83cce81d-c482-41d6-b7ec-e2196b5afb2e', '2016-01-25 22:00:00+00', '01:00:00', 'Kenneth Test Meeting 1', 'Test Meeting', 308, NULL, 'America/Los_Angeles', 'PST', '2016-01-24 17:34:04.920679+00', NULL, false, NULL, '', false, '', NULL, NULL, '', '', NULL);
INSERT INTO event VALUES (138, '2a5a0a81-83a3-f3a7-308e-c8500005db61', '2016-04-01 21:02:00+00', '00:30:00', 'Test', '', 234, NULL, 'America/New_York', 'EDT', '2016-04-01 21:02:35.52689+00', NULL, false, 'video chat', '', true, NULL, NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (141, '63251444-34f7-5199-5c0e-045479f73c4d', '2016-04-01 21:00:00+00', '00:30:00', 'Test Meeting', '', 234, NULL, 'America/Chicago', 'CDT', '2016-04-01 21:25:37.576518+00', NULL, true, 'video chat', '', true, NULL, NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (142, '2912cdda-08cb-8f7a-c9a3-a468bd06b93d', '2016-04-01 20:30:00+00', '00:30:00', 'Test Meeting', '', 234, NULL, 'America/Chicago', 'CDT', '2016-04-01 21:26:11.665511+00', NULL, true, 'video chat', '', true, NULL, NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (139, 'eabcf339-a693-3f0a-a5ec-dc89cfb5ee45', '2016-04-01 21:30:00+00', '01:30:00', 'Test Meeting', '', 234, NULL, 'America/Chicago', 'CDT', '2016-04-01 21:13:38.507955+00', NULL, false, 'video chat', '', true, NULL, NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (140, '3b5b3ea1-2287-3b7b-214e-22ae429596bb', '2016-04-01 22:00:00+00', '00:30:00', 'Test Meeting', '', 234, NULL, 'America/Chicago', 'CDT', '2016-04-01 21:25:06.701061+00', NULL, false, 'video chat', '', true, NULL, NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (143, '45c1dc92-728d-f8ff-b0bb-28afda67ff6f', '2016-04-02 16:00:00+00', '00:30:00', 'Test Meeting', '', 234, NULL, 'America/Chicago', 'CDT', '2016-04-02 16:22:43.595511+00', NULL, false, 'video chat', '', true, NULL, NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (144, '8e1bea81-534a-6a88-2c38-4973d9093501', '2016-04-03 04:00:00+00', '00:30:00', 'Test Meeting', '', 234, NULL, 'America/Chicago', 'CDT', '2016-04-03 03:41:11.755816+00', NULL, false, 'video chat', '', true, NULL, NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (145, 'a0a1153e-b222-37ee-3131-06fcfc239c17', '2016-04-04 19:18:00+00', '00:30:00', 'Test', '', 234, NULL, 'America/New_York', 'EDT', '2016-04-04 19:18:34.087949+00', NULL, true, 'collaboration', '', true, NULL, NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (146, '5b911315-7a36-cdce-f26d-9c6aec4bf9d0', '2016-04-06 11:30:00+00', '02:00:00', 'Test', '', 234, NULL, 'America/Chicago', 'CDT', '2016-04-04 19:57:03.428035+00', NULL, true, 'video tether', '', true, NULL, NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (120, '60696f94-7bf8-b870-c72b-68db77be698f', '2016-01-26 01:00:00+00', '02:30:00', 'Kenneth Test Meeting 1', 'test meeting', 308, NULL, 'America/Los_Angeles', 'PST', '2016-01-24 17:36:28.4245+00', NULL, false, NULL, '', false, '', NULL, NULL, '', '', NULL);
INSERT INTO event VALUES (110, 'c82d3557-541d-f96e-e230-9985facd9d58', '2016-01-19 13:00:00+00', '02:00:00', 'Test', 'Test', 313, NULL, 'America/Chicago', 'CST', '2016-01-18 19:23:40.063324+00', NULL, true, NULL, '', false, '', NULL, 'test@test.com', '', 'pdf', NULL);
INSERT INTO event VALUES (112, '0bd7ea68-c171-c917-8b18-660164f6bfeb', '2016-01-19 12:30:00+00', '01:00:00', 'Test3', 'Test 3 description', 313, NULL, 'America/Chicago', 'CST', '2016-01-18 19:59:38.982746+00', NULL, false, NULL, '', false, '', NULL, 'test@test.com', '', '', NULL);
INSERT INTO event VALUES (114, 'ad6f41a0-4a96-32e7-bdb8-9501a2063933', '2016-01-29 13:00:00+00', '01:30:00', 'Test5', 'small gathering', 313, NULL, 'America/Chicago', 'CST', '2016-01-18 21:05:04.11359+00', NULL, true, NULL, '', false, '', NULL, 'joe@test.com', '', '', NULL);
INSERT INTO event VALUES (116, '82e9e363-f577-726b-0b4c-69821d9b1787', '2016-01-27 14:30:00+00', '01:00:00', 'TEst 8', 'iuh', 313, NULL, 'America/Chicago', 'CST', '2016-01-18 21:31:28.859285+00', NULL, true, NULL, '', false, '', NULL, 'test@test.com', '', '', NULL);
INSERT INTO event VALUES (117, 'e0121043-8f2a-3ea1-5dba-7eb3f7a93713', '2016-01-27 14:30:00+00', '02:00:00', 'ok', 'ok', 313, NULL, 'America/Chicago', 'CST', '2016-01-18 21:32:32.517656+00', NULL, true, NULL, '', false, '', NULL, 'test@test.com', '', '', NULL);
INSERT INTO event VALUES (118, '0d6c37af-dd3a-fb0c-95bf-8a17339b8485', '2016-01-19 13:30:00+00', '02:00:00', 'Test Delete', 'test', 313, NULL, 'America/Chicago', 'CST', '2016-01-18 21:38:23.495633+00', NULL, false, NULL, '', false, '', NULL, 'test@test.com', '', '', NULL);
INSERT INTO event VALUES (121, '443d6380-23e7-70c9-4df6-e8bf1edcec55', '2016-01-25 14:30:00+00', '01:00:00', 'Kenneth Test Meeting 1', 'test meeting', 308, NULL, 'America/Los_Angeles', 'PST', '2016-01-24 17:37:45.919764+00', NULL, false, NULL, '', false, '', NULL, NULL, '', '', NULL);
INSERT INTO event VALUES (111, '9c650dda-b195-065d-952e-35c7b1524362', '2016-02-18 13:30:00+00', '00:30:00', 'Test2', 'Description of a really great meeting.', 313, NULL, 'America/Chicago', 'CST', '2016-01-18 19:58:43.030821+00', NULL, true, NULL, '400 South Blvd, Unit A, Evanston IL  60202', false, 'Registration is $1500', 'http://northbridgetech.org', 'test@test.com', 'http://google.com', 'pdf', NULL);
INSERT INTO event VALUES (113, '65251a58-2953-b223-465b-a3773634233e', '2016-01-21 12:30:00+00', '02:00:00', 'Test 4', 'Description', 313, NULL, 'America/Chicago', 'CST', '2016-01-18 20:43:22.319701+00', NULL, false, NULL, '400 South Blvd, Unit A, Evanston IL  60202', false, 'Registration info', 'http://northbridgetech.org', 'kathy@test.com', 'http://google.com', 'pdf', NULL);
INSERT INTO event VALUES (156, 'dfc68c0e-38c1-6741-4fdf-c714512ed993', '2016-05-05 12:30:00+00', '01:00:00', 'Test', '', 234, NULL, 'America/Chicago', 'CDT', '2016-05-04 21:53:27.643663+00', NULL, false, 'video chat', '', true, NULL, NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (157, 'd6e55641-7fbf-2a38-ee75-00e06f28be9e', '2016-05-04 21:53:00+00', '01:30:00', 'Test now', '', 234, NULL, 'America/New_York', 'EDT', '2016-05-04 21:53:54.478758+00', NULL, false, 'video chat', '', true, NULL, NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (147, '99a23fa5-900e-eadc-a49a-05e486ad25af', '2016-04-18 13:00:00+00', '01:00:00', 'Test Meeting', '', 260, NULL, 'America/Chicago', 'CDT', '2016-04-17 23:50:32.520553+00', NULL, true, 'collaboration', '', true, NULL, NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (150, '4e916972-0b41-cdf0-1ce8-9b84a5602e85', '2016-04-17 23:57:00+00', '01:30:00', 'Test Meeting 3', '', 308, NULL, 'America/New_York', 'EDT', '2016-04-17 23:57:37.739709+00', NULL, true, 'collaboration', '', true, NULL, NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (151, '6805701c-3d22-5a7f-c2de-25f48615f6f2', '2016-04-17 23:58:00+00', '01:30:00', 'Test Meeting 3', '', 260, NULL, 'America/New_York', 'EDT', '2016-04-17 23:58:09.64012+00', NULL, true, 'collaboration', '', true, NULL, NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (152, 'e9e56f03-193b-e3a1-14a3-64293cebbc1e', '2016-04-24 23:32:00+00', '00:30:00', 'test', '', 293, NULL, 'America/New_York', 'EDT', '2016-04-24 23:32:43.391995+00', NULL, true, 'video chat', '', true, NULL, NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (153, 'f36ad741-a4eb-df8f-92ab-70c05b32d1e7', '2016-04-27 13:00:00+00', '02:00:00', 'Test', '', 234, NULL, 'America/Chicago', 'CDT', '2016-04-26 21:23:18.52144+00', NULL, true, 'video chat', '', true, NULL, NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (154, 'cdaf2b47-b3fd-2a63-a452-254cc954b170', '2016-04-26 21:23:00+00', '00:30:00', 'Test', '', 234, NULL, 'America/New_York', 'EDT', '2016-04-26 21:23:41.361951+00', NULL, true, 'video chat', '', true, NULL, NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (159, 'f4718615-1ce9-7ff8-9122-db0dcbb1108b', '2016-05-07 15:12:00+00', '00:30:00', 'test', '', 293, NULL, 'America/New_York', 'EDT', '2016-05-07 15:12:55.271089+00', NULL, true, 'video chat', '', true, NULL, NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (148, '20db8e0e-4924-d04b-7c2a-3d35d76d60ab', '2016-04-18 13:00:00+00', '01:00:00', 'Test Meeting', 'Test~Meeting~Description', 308, NULL, 'America/Chicago', 'CDT', '2016-04-17 23:52:58.851722+00', NULL, true, NULL, 'Your Computer', false, '123', 'http://northbridgetech.org/dev/nexus/web/login.php?oid=12345678&mid=99a23fa5-900e-eadc-a49a-05e486ad', NULL, 'http://www.google.com', 'png', NULL);
INSERT INTO event VALUES (161, '909e7996-ebc8-ea5a-9538-f7c7aa8cf857', '2016-05-22 15:30:00+00', '01:00:00', 'Kenneth Test Meeting', '', 226, NULL, 'America/Los_Angeles', 'PDT', '2016-05-22 14:12:24.940107+00', NULL, false, 'collaboration', '', true, NULL, NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (162, '5fc53ea0-df35-3468-c991-c8a8c2333846', '2016-05-22 15:00:00+00', '01:00:00', 'teset', '', 226, NULL, 'America/Los_Angeles', 'PDT', '2016-05-22 14:14:42.909454+00', NULL, true, 'collaboration', '', true, NULL, NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (136, 'c18eb547-4b34-d60a-cf61-ee2f9ef165bf', '2017-03-22 12:00:00+00', '01:00:00', 'Test meeting with a really really long name to see how the truncation will work etcetera etcetera et', 'Line 1~Line 2~~Line 3~~me to see how the truncation will work etcetera etcetera Will this work? https://www.google.com. test kathy.flint@northbridgetech.org http://northbridgetech.org~~Line9: test@test.com~joe@illinois.gov~http://evanston.org', 313, NULL, 'America/Chicago', 'CDT', '2016-03-22 01:36:51.007119+00', NULL, false, NULL, '', false, '', NULL, 'test@test.com', '', '', NULL);
INSERT INTO event VALUES (165, 'dfc8d9e0-d3ae-594b-39ad-6f718a113759', '2016-05-31 17:00:00+00', '04:00:00', 'Time Zone Test #1', 'This meeting was put in as 2:00 - 3:30 PM CDT.~~1&#38;#38;#41; Someone out west named Kenneth should open it up and see if it shows equivalent PST time. Then, edit the time. Note here what you changed it to.~~2&#38;#38;#41; Someone out west named Kenneth opened it up and saw that it showed equivalent PST time.~~12:00 PM - 1:30 PM PDT~~3&#38;#41; I have now put in this time as 10-2 PST.~~12:00 PM - 1:30 PM PDT', 308, NULL, 'America/Los_Angeles', 'PDT', '2016-05-24 01:15:30.535091+00', NULL, true, NULL, 'my house', false, '', 'https://www.google.com/search?q=google+images&source=lnms&tbm=isch&sa=X&ved=0ahUKEwjez-XKxPHMAhXC6YMKHUUfCYIQ_AUIBygB&biw=1221&bih=887#tbm=isch&q=dynamite', NULL, 'https://www.google.com/search?q=google+images&source=lnms&tbm=isch&sa=X&ved=0ahUKEwjez-XKxPHMAhXC6YMKHUUfCYIQ_AUIBygB&biw=1221&bih=887#tbm=isch&q=dynamite', '', NULL);
INSERT INTO event VALUES (168, '013d71ba-b51c-3599-8fa1-32876c64c149', '2016-05-31 21:41:00+00', '00:30:00', 'Test Refresh 1', '', 234, NULL, 'America/New_York', 'EDT', '2016-05-31 21:41:39.137942+00', NULL, true, 'video tether', '', true, NULL, NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (173, '6972c874-f70b-80da-8a5b-915eb13ee41f', '2016-06-02 11:30:00+00', '00:30:00', 'Url test', 'url test', 308, NULL, 'America/Chicago', 'CDT', '2016-06-01 18:17:00.117372+00', NULL, true, NULL, '400 South Blvd, Unit A, Evanston IL  60202', false, '', 'https://paypal.com', NULL, '', '', NULL);
INSERT INTO event VALUES (122, 'a60299fb-04d4-9080-f5e0-7df71be9deac', '2016-01-25 16:00:00+00', '01:00:00', 'Kenneth Test Meeting 1', 'test meeting 1', 308, NULL, 'America/Los_Angeles', 'PST', '2016-01-24 17:39:52.177425+00', NULL, false, NULL, '', false, '', 'http://www.cnn.com', NULL, '', '', NULL);
INSERT INTO event VALUES (123, '0af4f4d0-86b7-21a2-daf5-f302420311ba', '2016-01-25 15:00:00+00', '01:00:00', 'Kenneth Test Meeting 1', 'test', 308, NULL, 'America/Los_Angeles', 'PST', '2016-01-24 17:41:07.493921+00', NULL, false, NULL, '', false, '', 'http://www.cnn', NULL, '', '', NULL);
INSERT INTO event VALUES (169, '6972c874-f70b-80da-8a5b-915eb13ee41f', '2016-06-02 11:30:00+00', '00:30:00', 'Url test', 'url test', 308, NULL, 'America/Chicago', 'CDT', '2016-06-01 18:13:25.062955+00', NULL, false, NULL, '400 South Blvd, Unit A, Evanston IL  60202', false, '', 'http://northbridgetech.org', NULL, 'https://northbridgetech.org', '', NULL);
INSERT INTO event VALUES (171, '6972c874-f70b-80da-8a5b-915eb13ee41f', '2016-06-02 11:30:00+00', '00:30:00', 'Url test', 'url test', 308, NULL, 'America/Chicago', 'CDT', '2016-06-01 18:15:46.824258+00', NULL, false, NULL, '400 South Blvd, Unit A, Evanston IL  60202', false, '', 'http://northbridgetech.org', NULL, '', '', NULL);
INSERT INTO event VALUES (172, '6972c874-f70b-80da-8a5b-915eb13ee41f', '2016-06-02 11:30:00+00', '00:30:00', 'Url test', 'url test', 308, NULL, 'America/Chicago', 'CDT', '2016-06-01 18:16:27.681134+00', NULL, false, NULL, '400 South Blvd, Unit A, Evanston IL  60202', false, '', 'http://northbridgetech.org', NULL, '', '', NULL);
INSERT INTO event VALUES (104, '48be4852-9889-45cf-ddf2-ef8d843b0710', '2016-01-18 12:30:00+00', '02:00:00', 'Another test', 'c', 312, NULL, 'America/Chicago', 'CST', '2016-01-17 23:07:18.679037+00', NULL, true, NULL, '', false, '', NULL, 'test@test.com', '', '', NULL);
INSERT INTO event VALUES (124, 'c316d254-f960-4b58-301c-a10607d809bf', '2016-01-25 15:00:00+00', '01:00:00', 'Kenneth Test Meeting 1', 'test', 308, NULL, 'America/Los_Angeles', 'PST', '2016-01-24 17:44:37.021761+00', NULL, false, NULL, '', false, '', NULL, NULL, '', 'txt', NULL);
INSERT INTO event VALUES (125, '4d832169-8677-0fa1-cb33-d8dabea15060', '2016-01-25 16:00:00+00', '00:30:00', 'Kenneth Test Meeting 1', 'test', 308, NULL, 'America/Los_Angeles', 'PST', '2016-01-24 17:45:33.425748+00', NULL, false, NULL, '', false, '', NULL, NULL, '', '', NULL);
INSERT INTO event VALUES (132, 'fe8ceba2-7b41-fa2a-606c-8efc510bcdcf', '2016-01-31 22:00:00+00', '01:00:00', 'x', 'x', 308, NULL, 'America/Chicago', 'CST', '2016-01-31 19:19:58.934019+00', NULL, false, NULL, '', false, '', NULL, NULL, '', '', NULL);
INSERT INTO event VALUES (133, 'd12a6f9a-0bda-840d-e4ee-163ca3093ef4', '2016-01-31 21:00:00+00', '01:00:00', 'x', 'x', 308, NULL, 'America/Los_Angeles', 'PST', '2016-01-31 19:25:25.436688+00', NULL, true, NULL, '', false, '', NULL, NULL, '', '', NULL);
INSERT INTO event VALUES (137, 'f91d3a29-b9fd-af94-0b4d-d4f0d235404a', '2016-03-25 01:30:00+00', '11:30:00', 'ukyiluyh', ';lokjkjh', 308, NULL, 'America/Chicago', 'CDT', '2016-03-25 01:11:17.209899+00', NULL, false, NULL, '', false, '', NULL, NULL, '', '', NULL);
INSERT INTO event VALUES (69, '1f5fc268-117a-4bd1-94a6-626879622867', '2016-01-01 07:00:00+00', '30:00:00', 'Public Test Meeting With a Longer Name', 'Test meeting description. The maximum length of a meeting description is however many characters will fit in this box. This we are still playing with.', 307, NULL, 'America/Chicago', 'CDT', '2015-11-10 13:31:03.034877+00', NULL, true, 'collaboration', '400 South Blvd., Evanston IL', false, 'Registration is free but seating is limited.', 'http://northbridgetech.org', NULL, 'http://eventbrite.com', NULL, NULL);
INSERT INTO event VALUES (103, '2f2d2571-6cbc-b7c7-7848-16f9f8fe3cdf', '2016-02-17 14:00:00+00', '22:00:00', 'Test Event 3', 'Another awesome event.', 312, NULL, 'America/Chicago', 'CST', '2016-01-17 23:00:39.802012+00', NULL, true, NULL, '', false, '', 'http://google.com', 'test@test.com', 'http://northbridgetech.org', '', NULL);
INSERT INTO event VALUES (134, 'f28ec20e-c7af-c68f-fec5-56525f2c235a', '2016-02-05 20:30:00+00', '04:30:00', 'test', 'x', 313, NULL, 'America/Chicago', 'CST', '2016-02-05 19:56:37.840696+00', NULL, true, NULL, '', false, '', 'http://verylongurl.comverylongurl.comverylongurl.comverylongurl.comverylongurl.comverylongurl.comver', 'test@test.com', 'http://verylongurl.comverylongurl.comverylongurl.comverylongurl.comverylongurl.comverylongurl.comver', '', NULL);
INSERT INTO event VALUES (149, 'f9c4cc40-f5a5-3668-339f-d4f36e6b560e', '2016-04-19 15:00:00+00', '01:00:00', 'Test Meeting', 'Test~Meeting~Hi', 308, NULL, 'America/Chicago', 'CDT', '2016-04-17 23:54:22.678822+00', NULL, true, NULL, 'My computer', false, 'Northbridge Link', 'http://northbridgetech.org/dev/nexus/web/login.php?oid=12345678&mid=99a23fa5-900e-eadc-a49a-05e486ad', NULL, 'http://northbridgetech.org/dev/nexus/web/login.php', '', NULL);
INSERT INTO event VALUES (158, 'aeb28052-3d6f-7f70-b17d-3236805baf00', '2016-05-07 00:00:00+00', '00:30:00', 'Kenneth SmokeTest', 'King Trump will allow His Obedient Subjects the ability to pay obeisance for him in the town of Peoria this week.', 308, NULL, 'America/Los_Angeles', 'PDT', '2016-05-06 00:28:48.571354+00', NULL, true, NULL, 'Peoria, IL', false, 'Registration is free to all white Americans', 'http://www.slate.com/blogs/the_slatest/2016/05/05/donald_trump_could_lose_republicans_the_senate.htm', NULL, 'http://www.cnn.com/2016/05/05/politics/mitt-romney-skips-republican-convention/', 'jpg', NULL);
INSERT INTO event VALUES (155, 'dfc8d9e0-d3ae-594b-39ad-6f718a113759', '2016-06-01 11:30:00+00', '04:00:00', 'Smoketest', 'Smoketesting this evening''s deployment to dev.~~Isn''t it grand&#33', 308, NULL, 'America/Chicago', 'CDT', '2016-04-27 02:29:59.331061+00', NULL, false, NULL, '400 South Blvd, Unit A, Evanston IL  60202', false, 'Registration will cost $15,000 dollars.', 'http://google.com', NULL, 'http://projects.fivethirtyeight.com/election-2016/delegate-targets/democrats/', 'PDF', NULL);
INSERT INTO event VALUES (166, '88582578-03c0-90da-c4ca-36ffa94459e2', '2016-05-31 15:00:00+00', '02:00:00', 'Kenneth Test Meeting 0523', 'Test Meeting Description', 308, NULL, 'America/Los_Angeles', 'PDT', '2016-05-24 01:23:33.202952+00', NULL, false, NULL, 'Portland, OR', false, 'Test Registration Info', 'http://www.cnn.com', NULL, 'http://www.google.com', 'jpg', NULL);
INSERT INTO event VALUES (126, '1b2ca971-520c-42b6-5800-13ccf8ebf4c7', '2016-01-25 15:30:00+00', '01:00:00', 'Kenneth Test Meeting 1', 'test', 308, NULL, 'America/Los_Angeles', 'PST', '2016-01-24 17:47:16.709981+00', NULL, false, NULL, 'Podunksville', false, 'test', NULL, NULL, 'http://www.cnn', '', NULL);
INSERT INTO event VALUES (115, '88582578-03c0-90da-c4ca-36ffa94459e2', '2016-08-03 12:30:00+00', '04:00:00', 'Test6', 'cvb', 308, NULL, 'America/Chicago', 'CST', '2016-01-18 21:29:06.914229+00', NULL, false, NULL, '', false, '', NULL, 'test@test.com', '', '', NULL);
INSERT INTO event VALUES (160, 'dfc8d9e0-d3ae-594b-39ad-6f718a113759', '2016-05-31 19:00:00+00', '01:30:00', 'Time Zone Test #1', 'This meeting was put in as 2:00 - 3:30 PM CDT.~~Someone out west named Kenneth should open it up and see if it shows equivalent PST time. Then, edit the time. Note here what you changed it to.', 308, NULL, 'America/Chicago', 'CDT', '2016-05-16 00:38:14.976005+00', NULL, false, NULL, 'my house', false, '', NULL, NULL, '', '', NULL);
INSERT INTO event VALUES (163, 'dfc8d9e0-d3ae-594b-39ad-6f718a113759', '2016-05-31 17:00:00+00', '04:00:00', 'Time Zone Test #1', 'This meeting was put in as 2:00 - 3:30 PM CDT.~~1&#41; Someone out west named Kenneth should open it up and see if it shows equivalent PST time. Then, edit the time. Note here what you changed it to.~~2&#41; Someone out west named Kenneth opened it up and saw that it showed equivalent PST time.~~12:00 PM - 1:30 PM PDT', 308, NULL, 'America/Los_Angeles', 'PDT', '2016-05-24 01:11:40.001361+00', NULL, false, NULL, 'my house', false, '', NULL, NULL, '', '', NULL);
INSERT INTO event VALUES (167, '88582578-03c0-90da-c4ca-36ffa94459e2', '2016-05-31 19:00:00+00', '05:30:00', 'Kenneth Test Meeting 0523.2', 'Test Meeting Description.2', 308, NULL, 'America/Los_Angeles', 'PDT', '2016-05-24 01:26:28.55617+00', NULL, true, NULL, '', false, '', NULL, NULL, '', '', NULL);
INSERT INTO event VALUES (164, 'dfc8d9e0-d3ae-594b-39ad-6f718a113759', '2016-05-31 17:00:00+00', '04:00:00', 'Time Zone Test #1', 'This meeting was put in as 2:00 - 3:30 PM CDT.~~1&#38;#41; Someone out west named Kenneth should open it up and see if it shows equivalent PST time. Then, edit the time. Note here what you changed it to.~~2&#38;#41; Someone out west named Kenneth opened it up and saw that it showed equivalent PST time.~~12:00 PM - 1:30 PM PDT~~3&#41; I have now put in this time as 10-2 PST.~~12:00 PM - 1:30 PM PDT', 308, NULL, 'America/Los_Angeles', 'PDT', '2016-05-24 01:12:18.957813+00', NULL, false, NULL, 'my house', false, '', NULL, NULL, '', '', NULL);
INSERT INTO event VALUES (170, '6972c874-f70b-80da-8a5b-915eb13ee41f', '2016-06-02 11:30:00+00', '00:30:00', 'Url test', 'url test', 308, NULL, 'America/Chicago', 'CDT', '2016-06-01 18:14:18.371821+00', NULL, false, NULL, '400 South Blvd, Unit A, Evanston IL  60202', false, '', NULL, NULL, 'https://northbridgetech.org', '', NULL);
INSERT INTO event VALUES (174, 'aa27f9ef-00c6-969f-a94f-8fe69779c105', '2016-06-30 12:30:00+00', '01:00:00', 'New Test', 'The meeting url has been entered w/o protocol.~~', 308, NULL, 'America/Chicago', 'CDT', '2016-06-02 01:47:09.800575+00', NULL, false, NULL, '', false, 'The registration url has been entered with https protocol.~~&#60;script&#62;alert&#40;&#41;;&#60;/script&#62;', 'google.com', NULL, 'https://paypal.com', '', NULL);
INSERT INTO event VALUES (175, 'aa27f9ef-00c6-969f-a94f-8fe69779c105', '2016-06-30 12:30:00+00', '01:00:00', 'New Test', 'The meeting url has been entered w/o protocol.~~', 308, NULL, 'America/Chicago', 'CDT', '2016-06-02 01:47:22.463648+00', NULL, true, NULL, 'added location', false, 'The registration url has been entered with https protocol.~~&#60;script&#62;alert&#40;&#41;;&#60;/script&#62;', 'google.com', NULL, 'https://paypal.com', '', NULL);
INSERT INTO event VALUES (176, '3e8c4a16-743f-8d5e-6a40-03e85f127ef1', '2016-06-29 13:00:00+00', '01:00:00', 'Another one for the hell of it', '&#40;parens&#41;', 308, NULL, 'America/Chicago', 'CDT', '2016-06-02 01:50:25.3758+00', NULL, true, NULL, '', false, '', '', NULL, '', '', NULL);
INSERT INTO event VALUES (177, 'e9efa77a-3391-c10a-5f95-d45236ea0c23', '2016-06-02 14:30:00+00', '00:30:00', 'Test Refresh', '', 234, NULL, 'America/Chicago', 'CDT', '2016-06-02 13:26:22.891003+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (179, 'ae244172-fde1-1a9e-12a8-e00bad7e4639', '2016-06-02 16:00:00+00', '00:30:00', 'Test Refresh 3', '', 234, NULL, 'America/Chicago', 'CDT', '2016-06-02 14:24:51.60824+00', NULL, true, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (178, '7688a9dd-880e-8de1-ed61-3dc26cb1ad1c', '2016-06-02 15:00:00+00', '00:30:00', 'Test Refresh', '', 234, NULL, 'America/Chicago', 'CDT', '2016-06-02 14:21:40.14799+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (188, '35c92ee0-cd12-eaed-da78-b6b80c60e5ed', '2016-06-14 21:45:00+00', '00:30:00', 'Test Meeting', '', 234, NULL, 'America/New_York', 'EDT', '2016-06-14 21:45:34.260307+00', NULL, true, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (180, 'f3b8dd58-bb9c-e898-09d8-d6d185faeb4b', '2016-06-07 22:30:00+00', '02:00:00', 'Kenneth Test Meeting 1', 'The Glorious Test', 308, NULL, 'America/Los_Angeles', 'PDT', '2016-06-07 22:26:17.389415+00', NULL, false, NULL, 'Your house', false, 'register here&#33', 'https://www.google.com/maps', NULL, 'https://www.google.com/maps/@45.4558071,-122.5565024,15z', 'jpg', NULL);
INSERT INTO event VALUES (181, 'f3b8dd58-bb9c-e898-09d8-d6d185faeb4b', '2016-06-07 23:00:00+00', '01:30:00', 'Kenneth Test Meeting 1', 'The Glorious Test &#40;is glorious&#41;', 308, NULL, 'America/Los_Angeles', 'PDT', '2016-06-07 22:30:18.361559+00', NULL, false, NULL, 'Your house', false, 'register here&#33', 'https://www.google.com/maps', NULL, 'https://www.google.com/maps/@45.4558071,-122.5565024,15z', '', NULL);
INSERT INTO event VALUES (189, '0ac2371f-b7ac-f453-de2e-3145535219fb', '2016-06-20 00:00:00+00', '00:30:00', 'Test', '', 234, NULL, 'America/New_York', 'EDT', '2016-06-20 00:00:43.517132+00', NULL, false, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (190, '171532fc-b865-ec7f-5b4a-54424cb2dec1', '2016-06-20 00:30:00+00', '00:30:00', 'Test Meeting', '', 234, NULL, 'America/Chicago', 'CDT', '2016-06-20 00:01:31.088415+00', NULL, true, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (182, 'a6869542-7cef-074c-9d5c-b1196b15e8f6', '2016-06-08 00:30:00+00', '01:00:00', 'Kenneth Test Meeting 2', 'Yo yo yo homeslice', 308, NULL, 'America/Los_Angeles', 'PDT', '2016-06-07 23:23:53.047214+00', NULL, false, NULL, '', false, '', '', NULL, '', '', NULL);
INSERT INTO event VALUES (183, 'a6869542-7cef-074c-9d5c-b1196b15e8f6', '2016-06-08 02:30:00+00', '01:00:00', 'Kenneth Test Meeting 2', 'Yo yo yo homeslice', 308, NULL, 'America/Los_Angeles', 'PDT', '2016-06-07 23:25:04.307531+00', NULL, false, NULL, '', false, '', '', NULL, '', '', NULL);
INSERT INTO event VALUES (184, 'a6869542-7cef-074c-9d5c-b1196b15e8f6', '2016-06-08 03:30:00+00', '01:00:00', 'Kenneth Test Meeting 2', 'Yo yo yo homeslice', 308, NULL, 'America/Los_Angeles', 'PDT', '2016-06-07 23:25:32.07764+00', NULL, false, NULL, '', false, '', '', NULL, '', '', NULL);
INSERT INTO event VALUES (185, 'a800da69-6548-1804-53cd-d9df15b2ecea', '2016-06-08 23:00:00+00', '01:00:00', 'Kenneth Test Meeting 3', 'Hi', 308, NULL, 'America/Los_Angeles', 'PDT', '2016-06-07 23:26:46.81749+00', NULL, true, NULL, '', false, '', '', NULL, '', '', NULL);
INSERT INTO event VALUES (186, '955f2432-8b2d-e11a-ea88-4a133f98eab8', '2016-06-07 23:28:00+00', '01:00:00', 'Kenneth Test Meeting 4', '', 232, NULL, 'America/New_York', 'EDT', '2016-06-07 23:28:50.073472+00', NULL, true, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (187, '97c7aab8-d388-5b29-aeb1-59c788f33779', '2016-06-08 00:30:00+00', '01:00:00', 'Kenneth Test Meeting 5 IN THE FUTURE', '', 232, NULL, 'America/Los_Angeles', 'PDT', '2016-06-07 23:30:46.71464+00', NULL, true, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (191, '94ffb8f3-9c4c-30b3-a9f0-da8e77e34701', '2016-06-20 16:30:00+00', '00:30:00', 'Test Meeting', '', 234, NULL, 'America/Chicago', 'CDT', '2016-06-20 15:59:11.852851+00', NULL, true, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (193, '4f5b24c4-c1a9-1a27-4a41-777315b139b6', '2016-06-20 18:00:00+00', '00:30:00', 'Test', '', 234, NULL, 'America/Chicago', 'CDT', '2016-06-20 17:13:02.743851+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (192, '4d01346c-de13-ea3b-385d-3e8dbfe1a062', '2016-06-20 17:30:00+00', '00:30:00', 'Test', '', 234, NULL, 'America/Chicago', 'CDT', '2016-06-20 16:59:24.138638+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (194, '589ed2ae-8e9b-1595-08d6-3526dd87ea86', '2016-06-20 18:30:00+00', '00:30:00', 'Test', '', 234, NULL, 'America/Chicago', 'CDT', '2016-06-20 17:47:59.41036+00', NULL, true, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (195, '7389a41f-dbb0-1bda-7aba-dc6171cae5ac', '2016-06-20 17:48:00+00', '01:00:00', 'Test', '', 234, NULL, 'America/New_York', 'EDT', '2016-06-20 17:48:13.678321+00', NULL, false, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (196, '037c4aeb-3fb9-4869-6a91-d438b3935f7f', '2016-06-22 23:00:00+00', '00:30:00', 'Test Meeting', '', 234, NULL, 'America/Chicago', 'CDT', '2016-06-22 22:39:03.758221+00', NULL, false, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (197, 'f1286089-e33b-72c8-f99c-cd5ed214fedb', '2016-06-22 23:30:00+00', '00:30:00', 'Test Meeting', '', 234, NULL, 'America/Chicago', 'CDT', '2016-06-22 22:41:28.283625+00', NULL, true, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (198, 'e97f68f4-1b7b-94c7-98ff-6a26d7bb366c', '2016-06-24 17:58:00+00', '04:00:00', 'Test Meeting', '', 234, NULL, 'America/New_York', 'EDT', '2016-06-24 17:58:21.826987+00', NULL, true, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (199, '87fe61f1-d51d-a7ea-fb67-67d0e04c3c10', '2016-06-27 11:00:00+00', '00:30:00', 'Test Meeting', '', 234, NULL, 'America/Chicago', 'CDT', '2016-06-24 17:58:51.458254+00', NULL, true, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (203, '0717ca39-198d-25de-5c00-d8407eb3c521', '2016-07-12 11:00:00+00', '00:30:00', 'Test', '', 234, NULL, 'America/Chicago', 'CDT', '2016-07-10 16:18:34.142782+00', NULL, true, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (204, '490907bb-a297-1195-afba-46b21fa8a4b4', '2016-07-16 16:00:00+00', '00:30:00', 'Test Meeting', '', 234, NULL, 'America/Chicago', 'CDT', '2016-07-16 14:57:11.057042+00', NULL, true, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (205, 'cacae8b1-22bb-8d19-5210-14b0c456762a', '2017-11-30 12:00:00+00', '01:30:00', 'Test Meeting', 'required', 308, NULL, 'America/Chicago', 'CST', '2016-11-29 23:03:29.668179+00', NULL, false, NULL, 'Location, location, location.', false, '', 'http://google.com', NULL, '', '', NULL);
INSERT INTO event VALUES (206, 'cacae8b1-22bb-8d19-5210-14b0c456762a', '2017-11-30 12:00:00+00', '01:30:00', 'Test Meeting', 'required more', 308, NULL, 'America/Chicago', 'CST', '2016-11-30 01:23:48.685122+00', NULL, true, NULL, 'Location, location, location.', false, '', 'http://google.com', NULL, '', 'png', NULL);
INSERT INTO event VALUES (207, 'c2ac8212-dd32-be64-4691-e5fd98234343', '2017-11-01 11:00:00+00', '00:30:00', 'Hello', 'descr', 308, NULL, 'America/Chicago', 'CST', '2016-11-30 01:25:07.754573+00', NULL, false, NULL, 'Location', false, '', 'google.com', NULL, '', 'png', NULL);
INSERT INTO event VALUES (208, 'c2ac8212-dd32-be64-4691-e5fd98234343', '2017-11-01 11:00:00+00', '00:30:00', 'Hello more', 'descr', 308, NULL, 'America/Chicago', 'CST', '2016-11-30 01:25:38.394097+00', NULL, true, NULL, 'Location', false, '', 'google.com', NULL, '', '', NULL);
INSERT INTO event VALUES (247, '38114a19-9828-6c1a-88d5-7b27477deaf5', '2017-02-28 13:30:00+00', '01:00:00', 'tre', 'tre', 308, NULL, 'America/Chicago', 'CST', '2017-02-26 23:43:25.515527+00', NULL, true, NULL, '400 South Blvd, Unit A, Evanston IL  60202', false, '', '', 'contact@northbridgetech.org', '', '', NULL);
INSERT INTO event VALUES (248, '4c7a672b-9ea9-b985-8d13-e38a180a7707', '2017-02-28 14:00:00+00', '00:30:00', 'tyuio', 'ertyu', 313, NULL, 'America/Chicago', 'CST', '2017-02-26 23:49:26.169173+00', NULL, false, NULL, '', false, '', '', 'contACT@GMAIL.COM', '', 'PDF', NULL);
INSERT INTO event VALUES (217, '66e83cfc-38b1-a105-50bd-e9c84e86d62a', '2016-12-03 14:00:00+00', '01:00:00', '#3', 'descr', 313, NULL, 'America/Chicago', 'CST', '2016-11-30 16:55:09.714211+00', NULL, false, NULL, 'loc', false, '', '', 'contact@northbridgetech.org', '', '', NULL);
INSERT INTO event VALUES (210, '491935b6-c437-5f6f-24cb-3e4ec8726f8c', '2018-03-01 12:00:00+00', '01:00:00', 'Test of new stuff', 'descr', 313, NULL, 'America/Chicago', 'CST', '2016-11-30 01:40:48.319469+00', NULL, false, NULL, 'Location test', false, '', '', 'kathy.flint@northbridgetech.org', '', 'xcf', NULL);
INSERT INTO event VALUES (211, '491935b6-c437-5f6f-24cb-3e4ec8726f8c', '2016-11-30 12:00:00+00', '01:00:00', 'Test of new stuff edit', 'descr new edit', 308, NULL, 'America/Chicago', 'CST', '2016-11-30 01:43:26.763074+00', NULL, false, NULL, 'Location test edit', false, '', '', 'kathy.flint@northbridgetech.org', '', '', NULL);
INSERT INTO event VALUES (212, '491935b6-c437-5f6f-24cb-3e4ec8726f8c', '2016-11-30 12:00:00+00', '01:00:00', 'Test of new stuff edit', 'descr new edit', 308, NULL, 'America/Chicago', 'CST', '2016-11-30 01:53:16.351925+00', NULL, true, NULL, 'Location test edit', false, '', '', 'kathy.flint@northbridgetech.org', '', 'png', NULL);
INSERT INTO event VALUES (214, '597a6d66-5830-d061-284a-86ac61faaa4e', '2016-11-30 05:00:00+00', '01:00:00', 'Test of new stuff edit', '', 234, NULL, 'Europe/Andorra', 'CET', '2016-11-30 01:56:40.509663+00', NULL, true, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (213, 'dc5eaa36-8bdf-5be3-cbe2-91b364711813', '2016-11-30 01:55:00+00', '00:30:00', 'Test #3 - Disregard', '', 234, NULL, 'America/New_York', 'EST', '2016-11-30 01:55:49.972214+00', NULL, false, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (222, '66e83cfc-38b1-a105-50bd-e9c84e86d62a', '2016-12-03 14:00:00+00', '01:00:00', '#3', 'descr', 308, NULL, 'America/Chicago', 'CST', '2016-11-30 17:43:09.070748+00', NULL, false, NULL, 'loc', false, '', '', 'contact@northbridgetech.org', '', '', NULL);
INSERT INTO event VALUES (223, '66e83cfc-38b1-a105-50bd-e9c84e86d62a', '2016-12-03 14:00:00+00', '01:00:00', '#3 edit', 'descr', 308, NULL, 'America/Chicago', 'CST', '2016-11-30 17:43:24.456235+00', NULL, false, NULL, 'loc', false, '', '', 'contact@northbridgetech.org', '', '', NULL);
INSERT INTO event VALUES (209, 'c18eb547-4b34-d60a-cf61-ee2f9ef165bf', '2017-03-22 12:00:00+00', '01:00:00', 'Test meeting with a really really long name to see how the truncation will work etcetera etcetera et', 'Line 1~Line 2~~Line 3~~me to see how the truncation will work etcetera etcetera Will this work? https://www.google.com. test kathy.flint@northbridgetech.org http://northbridgetech.org~~Line9: test@test.com~joe@illinois.gov~http://evanston.org', 308, NULL, 'America/Chicago', 'CST', '2016-11-30 01:37:31.748779+00', NULL, false, NULL, 'Location test', false, '', 'http://google.com', 'test@test.com', 'google.com', 'png', NULL);
INSERT INTO event VALUES (224, 'c18eb547-4b34-d60a-cf61-ee2f9ef165bf', '2017-03-22 12:00:00+00', '01:00:00', 'Test meeting with a really really long name to see how the truncation will work etcetera etcetera et', 'Line 1~Line 2~~Line 3 edited~~me to see how the truncation will work etcetera etcetera Will this work? https://www.google.com. test kathy.flint@northbridgetech.org http://northbridgetech.org~~Line9: test@test.com~joe@illinois.gov~http://evanston.org', 308, NULL, 'America/Chicago', 'CST', '2016-12-01 00:43:22.130082+00', NULL, true, NULL, 'Location test', false, '', 'http://google.com', 'test@test.com', 'google.com', '', NULL);
INSERT INTO event VALUES (225, '2d25c522-dd21-5b35-12be-5211f32a495d', '2016-12-28 13:00:00+00', '00:30:00', 'Recur Test', 'recur test descr', 313, NULL, 'America/Chicago', 'CST', '2016-12-27 01:02:26.141459+00', NULL, true, NULL, '', false, '', '', 'contact@northbridgetech.org', '', 'jpg', 221);
INSERT INTO event VALUES (226, '7e70a74d-6778-de0a-a299-5cbec4a373d4', '2016-12-27 19:36:00+00', '01:30:00', 'noe', '', 234, NULL, 'America/New_York', 'EST', '2016-12-27 19:36:53.88704+00', NULL, true, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (227, '64715c25-3fc9-0339-7c95-1e1830d05faa', '2016-12-30 06:00:00+00', '01:30:00', 'test future', '', 234, NULL, 'Africa/Monrovia', 'GMT', '2016-12-27 19:37:53.388587+00', NULL, true, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (215, '978a25bd-8c09-9275-2bf6-db808fffa139', '2017-12-01 17:00:00+00', '00:30:00', '#1', 'descr #1', 313, NULL, 'America/Chicago', 'CST', '2016-11-30 16:34:58.892015+00', NULL, false, NULL, 'loc', false, 'regr #1', 'google.com', 'contact@northbridgetech.org', 'http://google.com', 'txt', NULL);
INSERT INTO event VALUES (218, '978a25bd-8c09-9275-2bf6-db808fffa139', '2017-12-01 17:00:00+00', '00:30:00', '#1', 'descr #1', 308, NULL, 'America/Chicago', 'CST', '2016-11-30 16:56:43.685465+00', NULL, false, NULL, 'loc', false, 'regr #1', 'google.com', 'contact@northbridgetech.org', 'http://google.com', '', NULL);
INSERT INTO event VALUES (216, '7ec37f70-4b9c-f4a7-1928-8748730b4e31', '2016-12-30 23:00:00+00', '04:00:00', '#2', 'descr', 313, NULL, 'Asia/Jakarta', 'WIB', '2016-11-30 16:36:49.123215+00', NULL, false, NULL, 'loc', false, 'regr', 'http://comcast.net', 'contact@northbridgetech.org', 'http://northbridgetech.org', 'png', NULL);
INSERT INTO event VALUES (219, '7ec37f70-4b9c-f4a7-1928-8748730b4e31', '2016-12-30 23:00:00+00', '04:00:00', '#2', 'descr', 313, NULL, 'America/Chicago', 'CST', '2016-11-30 17:29:48.646808+00', NULL, false, NULL, 'loc', false, 'regr', 'http://comcast.net', 'contact@northbridgetech.org', 'http://northbridgetech.org', 'pdf', NULL);
INSERT INTO event VALUES (220, '7ec37f70-4b9c-f4a7-1928-8748730b4e31', '2016-12-30 23:00:00+00', '04:00:00', '#2', 'descr', 308, NULL, 'America/Chicago', 'CST', '2016-11-30 17:31:06.446745+00', NULL, false, NULL, 'loc', false, 'regr', 'http://comcast.net', 'contact@northbridgetech.org', 'http://northbridgetech.org', 'pdf', NULL);
INSERT INTO event VALUES (221, '7ec37f70-4b9c-f4a7-1928-8748730b4e31', '2016-12-31 01:00:00+00', '02:00:00', '#2 edit', 'descr', 308, NULL, 'America/Chicago', 'CST', '2016-11-30 17:35:15.243676+00', NULL, false, NULL, 'loc', false, 'regr', 'http://comcast.net', 'contact@northbridgetech.org', 'http://northbridgetech.org', 'png', NULL);
INSERT INTO event VALUES (235, '95153b0d-1fe7-1460-1aa0-ad5d94f3301e', '2017-01-12 12:00:00+00', '00:30:00', 'valid', '', 234, NULL, 'America/Chicago', 'CST', '2017-01-11 22:05:41.622923+00', NULL, true, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (236, 'accdf426-cbc2-1fb0-cfed-04fbb6da4f86', '2017-01-19 13:30:00+00', '00:30:00', 'sdfgh', 'descr to test in IE', 313, NULL, 'America/Chicago', 'CST', '2017-01-19 02:27:59.053123+00', NULL, true, NULL, '', false, '', '', 'contact@northbridgetech.org', '', '', NULL);
INSERT INTO event VALUES (228, 'f68ce89f-3e06-b2d9-cdfe-ec39621c75a5', '2017-12-27 15:00:00+00', '04:30:00', 'Prod validation', 'prod validation', 313, NULL, 'America/Chicago', 'CST', '2016-12-30 17:40:20.749936+00', NULL, false, NULL, '', false, 'register now for prizes', 'http://comcast.net', 'contact@northbridgetech.org', 'http://google.com', 'png', 222);
INSERT INTO event VALUES (229, 'f68ce89f-3e06-b2d9-cdfe-ec39621c75a5', '2017-12-27 15:00:00+00', '04:30:00', 'Prod validation', 'prod validation', 308, NULL, 'America/Chicago', 'CST', '2016-12-30 18:11:01.225189+00', NULL, true, NULL, '', false, 'register now for prizes', 'http://comcast.net', 'contact@northbridgetech.org', 'http://google.com', '', 223);
INSERT INTO event VALUES (230, '18686c80-39b1-c9ea-ac41-9881ab7ec433', '2017-01-12 13:30:00+00', '00:30:00', 'test file', 'qwertyu', 313, NULL, 'America/Chicago', 'CST', '2017-01-11 20:26:00.048351+00', NULL, false, NULL, '', false, '', '', 'contact@northbridgetech.org', '', 'png', NULL);
INSERT INTO event VALUES (231, '18686c80-39b1-c9ea-ac41-9881ab7ec433', '2017-01-12 13:30:00+00', '00:30:00', 'test file', 'qwertyu', 308, NULL, 'America/Chicago', 'CST', '2017-01-11 20:26:49.533528+00', NULL, true, NULL, '', false, '', '', 'contact@northbridgetech.org', '', '', NULL);
INSERT INTO event VALUES (232, 'bfa96310-8905-97c3-9251-3c14ed6f5c1b', '2017-01-12 12:30:00+00', '00:30:00', 'valid', 'wer', 313, NULL, 'America/Chicago', 'CST', '2017-01-11 21:51:44.631615+00', NULL, false, NULL, '', false, 'wer', 'qwer', 'contact@northbridgetech.org', 'wer', 'png', NULL);
INSERT INTO event VALUES (233, 'bfa96310-8905-97c3-9251-3c14ed6f5c1b', '2017-01-12 12:30:00+00', '00:30:00', 'valid', 'wer', 308, NULL, 'America/Chicago', 'CST', '2017-01-11 22:00:06.887229+00', NULL, true, NULL, '', false, 'wer', 'qwer', 'contact@northbridgetech.org', 'wer', 'png', NULL);
INSERT INTO event VALUES (234, 'cb44d9be-9cf9-16b8-f5a0-88d2168649da', '2017-01-11 22:05:00+00', '01:00:00', 'valid', '', 234, NULL, 'America/New_York', 'EST', '2017-01-11 22:05:18.72276+00', NULL, true, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (237, '7d5b7c57-635e-e7d7-b6e2-bf8dc340bae6', '2017-01-19 02:30:00+00', '00:30:00', 'fghj', '', 293, NULL, 'America/New_York', 'EST', '2017-01-19 02:30:16.289541+00', NULL, true, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (238, '6871a184-b775-5411-78c3-ab4459cc0932', '2017-02-28 14:00:00+00', '01:30:00', 'Test Deploy', 'Testing for Sunday''s testing', 339, NULL, 'America/Chicago', 'CST', '2017-02-26 17:27:37.285929+00', NULL, false, NULL, 'Willow Wellness Center, 1400 Renaissance Dr., Suite 401, Park Ridge, IL 60068', false, '', '', '', '', 'jpg', 224);
INSERT INTO event VALUES (239, '6871a184-b775-5411-78c3-ab4459cc0932', '2017-02-28 14:00:00+00', '01:30:00', 'Test Deploy', 'Testing for Sunday''s testing', 340, NULL, 'America/Chicago', 'CST', '2017-02-26 17:48:27.99172+00', NULL, true, NULL, 'Willow Wellness Center, 1400 Renaissance Dr., Suite 401, Park Ridge, IL 60068', false, '', '', '', '', 'jpg', 225);
INSERT INTO event VALUES (240, 'f5e3a618-c90c-4032-d6c0-60b0d3ad55c1', '2017-02-26 19:27:00+00', '00:30:00', 'sdfgh', '', 293, NULL, 'America/New_York', 'EST', '2017-02-26 19:27:05.84927+00', NULL, true, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (241, 'acdfdf1b-5f7c-af08-6afc-0602deb9e674', '2017-02-26 19:27:00+00', '01:00:00', 'Hello?', '', 293, NULL, 'America/New_York', 'EST', '2017-02-26 19:27:53.032216+00', NULL, true, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (242, 'f713607b-74ac-2bc3-b79c-746e3e1a65ac', '2017-02-26 19:29:00+00', '00:30:00', 'hello', '', 234, NULL, 'America/New_York', 'EST', '2017-02-26 19:29:27.572665+00', NULL, true, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (243, '95a06561-219b-d124-8dbb-005c4b7a9549', '2017-02-26 19:46:00+00', '01:00:00', 'fghj', '', 234, NULL, 'America/New_York', 'EST', '2017-02-26 19:46:29.63263+00', NULL, true, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (244, '2d5c1bfc-f33a-bf26-acc1-cdc31749b2f8', '2017-02-26 19:46:00+00', '01:00:00', 'vbnm', '', 234, NULL, 'America/New_York', 'EST', '2017-02-26 19:46:43.75273+00', NULL, true, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (245, '15075f6b-0aeb-748b-c22a-fffd1279af71', '2017-02-28 13:30:00+00', '02:00:00', 'waaa', '', 234, NULL, 'America/Chicago', 'CST', '2017-02-26 19:48:34.293184+00', NULL, true, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (246, '38114a19-9828-6c1a-88d5-7b27477deaf5', '2017-02-28 13:30:00+00', '01:00:00', 'tre', 'tre', 313, NULL, 'America/Chicago', 'CST', '2017-02-26 23:09:46.705489+00', NULL, false, NULL, '400 South Blvd, Unit A, Evanston IL  60202', false, '', '', 'contact@northbridgetech.org', '', '', NULL);
INSERT INTO event VALUES (249, '4c7a672b-9ea9-b985-8d13-e38a180a7707', '2017-02-28 14:00:00+00', '00:30:00', 'tyuio', 'ertyu', 308, NULL, 'America/Chicago', 'CST', '2017-02-26 23:50:08.794431+00', NULL, true, NULL, '', false, '', '', 'contACT@GMAIL.COM', '', 'PDF', NULL);
INSERT INTO event VALUES (250, '08941f40-27e6-c720-cf92-01cb00e13cc4', '2018-02-20 13:00:00+00', '01:30:00', 'ghjkl', 'ghjkl', 308, NULL, 'America/Chicago', 'CST', '2017-02-26 23:51:13.237832+00', NULL, true, NULL, '', false, '', '', '', '', '', NULL);
INSERT INTO event VALUES (251, '5b54c861-9941-f4e4-d728-2a2c87362294', '2017-02-28 13:00:00+00', '01:00:00', 'maybe?', 'maybe', 308, NULL, 'America/Chicago', 'CST', '2017-02-27 00:03:21.198288+00', NULL, true, NULL, '', false, '', '', '', '', '', NULL);
INSERT INTO event VALUES (252, '4b1c0c38-b180-fe00-7de9-ad181515376f', '2017-02-28 13:00:00+00', '01:30:00', 'dfghjk', 'sdfgj', 308, NULL, 'America/Chicago', 'CST', '2017-02-27 00:08:23.529589+00', NULL, true, NULL, '', false, '', '', '', '', '', NULL);
INSERT INTO event VALUES (253, 'db44f3b7-90fc-b70e-0eda-35b56f6a8485', '2017-03-02 23:46:00+00', '00:30:00', 'Test', '', 353, NULL, 'America/New_York', 'EST', '2017-03-02 23:46:37.55206+00', NULL, true, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (254, '3092a7c8-d555-29e9-b6cb-dae45d55a28c', '2017-03-06 02:02:00+00', '01:00:00', 'Test meeting', '', 234, NULL, 'America/New_York', 'EST', '2017-03-06 02:02:35.278517+00', NULL, true, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (255, '4a6b58cc-ba08-6b25-c626-e01c9c3b061c', '2017-03-07 12:30:00+00', '02:00:00', 'test', '', 357, NULL, 'America/Chicago', 'CST', '2017-03-06 02:30:03.578845+00', NULL, true, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (256, '464285a0-0bb6-b1c7-fea7-9c16df419fcc', '2017-03-20 12:00:00+00', '01:00:00', 'Deploy valid', 'Deploy valid', 338, NULL, 'America/Chicago', 'CST', '2017-03-08 01:35:59.931109+00', NULL, false, NULL, '400 South Blvd, Unit A, Evanston IL  60202', false, '', '', 'contact@northbridgetech.org', '', '', NULL);
INSERT INTO event VALUES (257, '464285a0-0bb6-b1c7-fea7-9c16df419fcc', '2017-03-20 12:00:00+00', '01:00:00', 'Deploy valid', 'Deploy valid', 339, NULL, 'America/Chicago', 'CST', '2017-03-08 01:41:59.225051+00', NULL, true, NULL, '400 South Blvd, Unit A, Evanston IL  60202', false, '', '', 'contact@northbridgetech.org', '', '', NULL);
INSERT INTO event VALUES (260, '4eb4623c-8d1d-6732-e9ae-4b8cf08202d2', '2017-03-30 12:00:00+00', '01:00:00', 'Test #3', 'Test #3', 338, NULL, 'America/Chicago', 'CST', '2017-03-08 01:51:29.430277+00', NULL, false, NULL, '', false, '', '', 'contact@northbridgetech.org', '', '', 227);
INSERT INTO event VALUES (259, '489eb75f-bf8e-f6d4-815d-a680e8a3965d', '2017-03-30 12:00:00+00', '01:00:00', 'Test #3', 'Test #3', 338, NULL, 'America/Chicago', 'CST', '2017-03-08 01:49:10.939005+00', NULL, false, NULL, '', false, '', '', 'contact@northbridgetech.org', '', '', 226);
INSERT INTO event VALUES (262, '489eb75f-bf8e-f6d4-815d-a680e8a3965d', '2017-03-30 12:00:00+00', '01:00:00', 'Test #3', 'Test #3', 339, NULL, 'America/Chicago', 'CST', '2017-03-08 01:57:44.962388+00', NULL, true, NULL, '', false, '', '', 'contact@northbridgetech.org', '', '', 228);
INSERT INTO event VALUES (261, '07b66539-7618-9c29-9c9a-12e404cdfe42', '2017-03-23 12:00:00+00', '01:30:00', 'Test #4', 'Test #4', 338, NULL, 'America/Chicago', 'CST', '2017-03-08 01:56:42.446258+00', NULL, false, NULL, '', false, '', '', 'contact@northbridgetech.org', '', 'pdf', NULL);
INSERT INTO event VALUES (263, '07b66539-7618-9c29-9c9a-12e404cdfe42', '2017-03-23 12:00:00+00', '01:30:00', 'Test #4', 'Test #4', 339, NULL, 'America/Chicago', 'CST', '2017-03-08 01:57:52.607268+00', NULL, true, NULL, '', false, '', '', 'contact@northbridgetech.org', '', 'pdf', NULL);
INSERT INTO event VALUES (258, '5c10b9de-d2cf-3a09-584a-27aa39955441', '2017-03-14 13:00:00+00', '00:30:00', 'Test #2', 'Test #2', 338, NULL, 'America/Chicago', 'CST', '2017-03-08 01:44:32.713904+00', NULL, false, NULL, '400 South Blvd, Unit A, Evanston IL  60202', false, '', '', 'contact@northbridgetech.org', '', '', NULL);
INSERT INTO event VALUES (264, '5c10b9de-d2cf-3a09-584a-27aa39955441', '2017-03-14 13:00:00+00', '00:30:00', 'Test #2', 'Test #2', 339, NULL, 'America/Chicago', 'CST', '2017-03-08 01:58:03.070161+00', NULL, true, NULL, '400 South Blvd, Unit A, Evanston IL  60202', false, '', '', 'contact@northbridgetech.org', '', '', NULL);
INSERT INTO event VALUES (265, 'de6c0c11-1310-e2cb-f1b8-440f191523cc', '2017-03-08 02:16:00+00', '00:30:00', 'now', '', 234, NULL, 'America/New_York', 'EST', '2017-03-08 02:16:42.130308+00', NULL, true, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (266, 'd82574b7-3250-98be-8358-e6c5400f01be', '2017-03-13 03:49:00+00', '00:30:00', 'sdf', '', 293, NULL, 'America/New_York', 'EDT', '2017-03-13 03:49:11.566233+00', NULL, true, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (267, '0c9fbf96-ab85-fd32-fbff-42689e6af0cd', '2017-03-29 11:30:00+00', '01:00:00', 'Test', 'ertyuiop', 338, NULL, 'America/Chicago', 'CDT', '2017-03-18 21:02:56.999037+00', NULL, false, NULL, '', false, '', '', '', '', 'png', NULL);
INSERT INTO event VALUES (268, '0c9fbf96-ab85-fd32-fbff-42689e6af0cd', '2017-03-29 11:30:00+00', '01:00:00', 'Test', 'ertyuiop', 339, NULL, 'America/Chicago', 'CDT', '2017-03-18 21:03:35.82641+00', NULL, true, NULL, '', false, '', '', '', '', 'png', NULL);
INSERT INTO event VALUES (269, 'aa64eec0-dcbd-f72e-462b-5b8332419feb', '2017-03-29 23:27:00+00', '00:30:00', 'Now', '', 234, NULL, 'America/New_York', 'EDT', '2017-03-29 23:27:41.907955+00', NULL, true, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (270, 'f6cf4a49-2dbb-182b-512c-5529e52f93fc', '2017-05-02 21:39:00+00', '00:30:00', 'prod validation', '', 234, NULL, 'America/New_York', 'EDT', '2017-05-02 21:39:53.764741+00', NULL, true, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (271, 'b2812612-0dbe-1999-19d1-d9294b4710e8', '2017-06-08 15:01:00+00', '00:30:00', 'Validation testing', '', 234, NULL, 'America/New_York', 'EDT', '2017-06-08 15:01:38.653266+00', NULL, true, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (272, '42b04a4e-0e1d-7f7b-8319-0ba58e03718a', '2017-06-13 17:59:00+00', '00:30:00', 'Test #2', '', 293, NULL, 'America/New_York', 'EDT', '2017-06-13 17:59:30.416327+00', NULL, true, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (273, 'e47990d0-67d3-9238-4d26-1cd78b592c94', '2017-06-13 18:40:00+00', '00:30:00', 'Test', '', 234, NULL, 'America/New_York', 'EDT', '2017-06-13 18:40:29.785067+00', NULL, true, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (274, '4453822a-0dc3-a6cf-3d66-5bb5222842d9', '2017-06-13 19:19:00+00', '00:30:00', 'Test #3', '', 234, NULL, 'America/New_York', 'EDT', '2017-06-13 19:19:16.727463+00', NULL, true, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (275, '0422c1a4-5437-d7cd-71b7-51b56fe97358', '2017-07-10 00:14:00+00', '00:30:00', 'Test #10', '', 234, NULL, 'America/New_York', 'EDT', '2017-07-10 00:14:05.661288+00', NULL, true, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (276, '56f1d2b1-b26a-c836-8c16-3a5fbc5fb892', '2017-07-15 00:00:00+00', '00:30:00', 'Hemalatha Meeting', '', 361, NULL, 'America/New_York', 'EDT', '2017-07-10 01:17:15.488252+00', NULL, true, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (277, 'a03498ef-a401-4f23-f12c-348e420e17a5', '2017-07-10 01:18:00+00', '00:30:00', 'Current Meeting', '', 361, NULL, 'America/New_York', 'EDT', '2017-07-10 01:18:50.455776+00', NULL, true, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (278, '5911c81e-77f2-9a43-1b62-3d1433feca82', '2017-07-31 11:30:00+00', '01:00:00', 'hemalatha', '', 361, NULL, 'America/New_York', 'EDT', '2017-07-22 14:54:33.915851+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (279, '1acbaf15-f2db-df54-a0a8-af3d61fbee90', '2017-07-23 11:00:00+00', '00:30:00', 'Test Meeting', '', 361, NULL, 'America/New_York', 'EDT', '2017-07-22 15:21:14.156402+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (280, 'ded6cdc5-edd9-27f6-94a6-2f5d598fb27a', '2017-08-04 16:00:00+00', '01:00:00', 'new', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-02 21:15:07.969115+00', NULL, false, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (281, '65bd22d5-e78a-fd6b-af8e-8922bf808784', '2017-08-04 16:30:00+00', '00:30:00', 'new meet', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-02 21:19:18.783348+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (282, '7227ccf8-790f-2e52-e672-4461faac5cdc', '2017-08-13 17:00:00+00', '01:30:00', 'new meeting', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-02 21:24:40.843126+00', NULL, false, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (283, '0d0757cc-3989-fbe5-69bb-c9b439a3868e', '2017-08-04 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-02 21:48:16.108626+00', NULL, true, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (284, 'aabb2939-de6d-c6ab-01cc-8d8c12b12d2c', '2017-08-04 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-02 22:12:54.523973+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (286, '444cea81-13f4-9e63-1309-83ac08effe20', '2017-08-04 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-03 02:52:08.652212+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (285, '75a83781-24e8-4d93-c57f-42624f389b98', '2017-08-04 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-03 00:04:23.772287+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (287, 'b9a43268-b0c5-a11d-7fd6-b9f9faedaf7a', '2017-08-04 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-03 16:07:48.166666+00', NULL, true, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (288, '655a9eb5-1cca-be59-7b14-be3fcdb42d3d', '2017-08-04 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-04 02:11:05.803591+00', NULL, true, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (289, '614b096c-d285-7c04-2c30-d5aa402d6bdb', '2017-08-04 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-04 02:51:39.694627+00', NULL, true, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (290, 'f25bdc9c-cd94-a9b0-4b52-283d0894e549', '2017-08-04 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-04 03:04:42.858791+00', NULL, true, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (292, '5d48f762-d687-fc06-a49b-ce32a741886a', '2017-08-20 11:00:00+00', '01:30:00', 'new for delete', '', 361, NULL, 'America/New_York', 'EDT', '2017-08-07 01:31:23.238671+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (291, '63560f8d-74ac-15a1-2af0-4dfbb70358fb', '2017-08-13 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-07 01:13:57.640541+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (293, '2c3366d8-3f18-9bcf-7495-476da0157730', '2017-08-27 10:00:00+00', '01:00:00', 'latest', '', 361, NULL, 'America/New_York', 'EDT', '2017-08-07 01:35:14.62944+00', NULL, false, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (294, 'b907a7bc-2a31-3861-3acf-c23a2b6e0316', '2017-08-13 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-07 01:45:43.281417+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (295, '170ee7d5-2d30-d0bc-11ea-166c3778bb02', '2017-08-07 20:39:00+00', '01:30:00', 'test ', '', 361, NULL, 'America/New_York', 'EDT', '2017-08-07 20:39:56.334616+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (297, '32a61eea-27bd-2512-0419-e856a9571346', '2017-08-13 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-08 21:13:30.852461+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (298, '44fe00a1-b5a5-4cc1-1803-3f6e8c84a1f1', '2017-08-13 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-08 21:18:05.789313+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (319, '4d26b209-f1d2-b851-a7d2-d356f5c576dc', '2017-08-09 21:58:00+00', '00:30:00', 'Hello', '', 293, NULL, 'America/New_York', 'EDT', '2017-08-09 21:58:50.382168+00', NULL, true, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (320, '279a5138-2347-9067-a849-27f48cac0fdf', '2017-08-09 22:13:00+00', '01:30:00', 'latest ', '', 361, NULL, 'America/New_York', 'EDT', '2017-08-09 22:13:06.066709+00', NULL, true, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (321, '8630072f-64af-9e9c-4a05-f0c4a89b4ff0', '2017-08-10 02:11:00+00', '01:30:00', 'latest', '', 361, NULL, 'America/New_York', 'EDT', '2017-08-10 02:11:20.262553+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (322, '589c2259-f918-9882-00fb-81efa804de40', '2017-08-10 02:21:00+00', '01:30:00', 'new', '', 361, NULL, 'America/New_York', 'EDT', '2017-08-10 02:21:16.870812+00', NULL, false, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (312, '61459584-91b3-ada0-de12-d48baf11271d', '2017-08-13 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-09 01:33:54.704547+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (323, '2ee337f6-cd8d-8584-501b-52f8dae4647b', '2017-08-10 02:24:00+00', '01:30:00', 'latest', '', 361, NULL, 'America/New_York', 'EDT', '2017-08-10 02:24:20.482099+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (324, '259bfad5-ec90-1cfa-7742-2bedf79663c7', '2017-08-10 02:25:00+00', '01:30:00', 'latest', '', 361, NULL, 'America/New_York', 'EDT', '2017-08-10 02:25:39.697849+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (325, '697f614a-436d-0a2b-fb26-2b6d9bc53249', '2017-08-10 02:27:00+00', '01:30:00', 'latest', '', 361, NULL, 'America/New_York', 'EDT', '2017-08-10 02:27:02.836319+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (296, '29117f85-8ee3-fa1b-79d0-35fa358eb19a', '2017-08-13 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-08 02:34:01.975844+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (299, '250ab1eb-135e-ef69-ce32-403202ba2b13', '2017-08-13 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-08 22:04:48.946362+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (300, '4dc82a3c-49e9-0f77-8b35-888c1220163d', '2017-08-13 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-08 22:05:58.730516+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (301, 'db788563-d138-545c-e876-990e293d0302', '2017-08-13 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-08 22:13:36.253056+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (302, '51a3fd4b-9e25-8ad0-f692-31f2d4900a6b', '2017-08-13 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-08 22:14:00.174672+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (303, 'a13d3a1a-a446-dba1-f0af-35f19f09cdf5', '2017-08-13 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-08 23:31:50.624564+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (304, 'bcf9ef9c-3a62-142f-7228-83bd28353380', '2017-08-13 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-08 23:34:05.702526+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (305, 'ace0b167-8f93-c903-a0e8-31390cd84bf0', '2017-08-13 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-09 01:04:44.120408+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (306, '3c6f7bbc-439a-b77a-64fa-e61a04d563d4', '2017-08-13 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-09 01:05:52.466791+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (307, 'f54eec26-8ff2-96cb-fa40-419368a64a25', '2017-08-13 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-09 01:12:18.678732+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (308, 'a0bb5dd3-44ad-f2b5-c242-a1675f77af88', '2017-08-13 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-09 01:13:27.673121+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (309, 'd4533717-1846-8d9d-ea6d-ca46aff0be41', '2017-08-13 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-09 01:23:09.339804+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (310, '1fe4fb97-9381-600a-8021-99a0eca6823f', '2017-08-13 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-09 01:28:01.669978+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (311, 'bb9ede42-298a-e8da-62cc-acb9f96e0c5b', '2017-08-13 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-09 01:29:39.894859+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (318, 'c66627ef-a8c7-e3eb-45a6-b571a709239f', '2017-08-13 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-09 17:07:44.495382+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (313, 'f72a27a9-a4c3-2b20-a1b4-a7c5f24df77a', '2017-08-13 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-09 01:45:07.444351+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (314, '0998ac6c-7182-d644-f4fb-9e9de086941c', '2017-08-13 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-09 01:49:54.530096+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (315, '108beb69-eb4b-bf71-a5dc-eea14cb80339', '2017-08-13 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-09 16:54:16.351928+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (316, 'e0da4033-7733-6dac-4e4c-ccebb99b6a0d', '2017-08-13 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-09 17:04:37.176964+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (317, '9e23b06e-fa08-ca53-aff1-62a17c901342', '2017-08-13 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-09 17:05:52.182677+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (326, 'ea034d8d-cb89-3730-5072-7c9fa3981902', '2017-08-10 02:33:00+00', '01:30:00', 'latest', '', 361, NULL, 'America/New_York', 'EDT', '2017-08-10 02:33:44.982909+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (327, '30e590bd-ea88-8db8-e230-334c72270468', '2017-08-10 02:48:00+00', '01:30:00', 'latest', '', 361, NULL, 'America/New_York', 'EDT', '2017-08-10 02:48:01.532114+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (328, '18d365ad-2bb6-16d9-99ab-eeef326a3d35', '2017-08-10 02:49:00+00', '01:30:00', 'latest', '', 361, NULL, 'America/New_York', 'EDT', '2017-08-10 02:49:09.08798+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (329, 'f274b61a-ccb6-7ee7-1187-dcb12d9836e6', '2017-08-10 02:52:00+00', '01:30:00', 'latest', '', 361, NULL, 'America/New_York', 'EDT', '2017-08-10 02:52:56.745788+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (330, '09b72a61-3aa2-a958-55f0-a7d976a77e21', '2017-08-10 02:56:00+00', '01:30:00', 'latest', '', 361, NULL, 'America/New_York', 'EDT', '2017-08-10 02:56:29.553427+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (331, '8c3c3899-0577-ed60-7155-311d29502dda', '2017-08-10 02:59:00+00', '01:30:00', 'latest', '', 361, NULL, 'America/New_York', 'EDT', '2017-08-10 02:59:30.698808+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (332, 'c5352c3e-49a9-aa29-881c-9dc00437dd76', '2017-08-10 03:03:00+00', '01:30:00', 'latest', '', 361, NULL, 'America/New_York', 'EDT', '2017-08-10 03:03:38.818713+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (333, '0370cbc7-a83d-83b8-5c0c-629fda93feff', '2017-08-10 03:04:00+00', '01:30:00', 'latest', '', 361, NULL, 'America/New_York', 'EDT', '2017-08-10 03:04:47.653806+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (334, '5fa2bfea-f2fa-2b3b-cbb1-7e9ed4f0c793', '2017-08-10 03:05:00+00', '01:30:00', 'latest', '', 361, NULL, 'America/New_York', 'EDT', '2017-08-10 03:05:58.243105+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (335, '06a0b181-7240-26a5-e174-305943e1524d', '2017-08-10 03:07:00+00', '01:30:00', 'latest', '', 361, NULL, 'America/New_York', 'EDT', '2017-08-10 03:07:09.154573+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (336, '60ca8dd8-bb06-4a41-3bc9-afc9247e6ee2', '2017-08-10 03:09:00+00', '01:30:00', 'latest', '', 361, NULL, 'America/New_York', 'EDT', '2017-08-10 03:09:18.50058+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (338, '803abecb-6dd9-0436-fe62-7113d6fe0b3d', '2017-08-10 03:16:00+00', '01:30:00', 'latest', '', 361, NULL, 'America/New_York', 'EDT', '2017-08-10 03:16:51.797422+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (341, '5fbfb523-30af-09ff-f413-eed636e74ebd', '2017-08-10 03:24:00+00', '01:30:00', 'latest', '', 361, NULL, 'America/New_York', 'EDT', '2017-08-10 03:24:49.041658+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (337, 'eb06e63f-0990-3487-9db8-63eee55b0d67', '2017-08-13 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-10 03:12:57.540125+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (339, 'b4823117-56bf-41bc-3a46-e8e91376a12b', '2017-08-13 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-10 03:17:46.35903+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (340, '789aa538-fbe8-9f05-51a8-7c79a6a3248e', '2017-08-13 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-10 03:23:29.430493+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (343, '5314a6ba-0b10-76be-3851-806b86fb1c2b', '2017-08-10 03:29:00+00', '01:30:00', 'latest', '', 361, NULL, 'America/New_York', 'EDT', '2017-08-10 03:29:26.537807+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (344, '2e887603-fe5a-c07f-5eeb-f20229ab7838', '2017-08-13 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-10 03:30:14.686428+00', NULL, true, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (346, '3e234f00-df32-442d-f510-58988eb3b68d', '2017-08-10 03:32:00+00', '01:30:00', 'latest', '', 361, NULL, 'America/New_York', 'EDT', '2017-08-10 03:32:15.671328+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (342, 'ee4585fa-3eba-19a2-498f-81fe6b0cbfc5', '2017-08-13 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-10 03:25:41.081412+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (345, 'a7a56a7d-2bf9-60ba-38ab-099c369613ca', '2017-08-13 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-10 03:31:55.432489+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (347, '8a83fe6f-8d9e-ad68-26ca-44e2784fd9a5', '2017-08-13 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-10 21:13:24.860022+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (348, 'c31783ab-727e-5eba-6b06-dde40dcf099d', '2017-08-13 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-10 21:16:02.249295+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (349, 'bdb56a19-af90-e5e4-9849-f6bf6f41bdbd', '2017-08-10 21:16:00+00', '01:30:00', 'latest', '', 361, NULL, 'America/New_York', 'EDT', '2017-08-10 21:16:22.509373+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (350, 'bd4c7206-ad3c-4f5c-a812-421c570261f1', '2017-08-10 21:20:00+00', '01:30:00', 'latest', '', 361, NULL, 'America/New_York', 'EDT', '2017-08-10 21:20:49.942826+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (352, '13af228e-6ae9-ea36-be55-7d75eb2cc895', '2017-08-10 21:31:00+00', '01:30:00', 'latest', '', 361, NULL, 'America/New_York', 'EDT', '2017-08-10 21:31:01.260363+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (353, '2be7a684-3b36-a255-5b4c-633aeff871f2', '2017-08-25 12:00:00+00', '00:30:00', 'Test', 'description', 313, NULL, 'America/Chicago', 'CDT', '2017-08-11 21:33:14.716551+00', NULL, false, NULL, 'asdf', false, 'Register here', 'http://comcast.net', 'contact@test.com', 'http://yahoo.com', '', NULL);
INSERT INTO event VALUES (354, '2be7a684-3b36-a255-5b4c-633aeff871f2', '2017-08-25 12:00:00+00', '00:30:00', 'Test', 'description', 308, NULL, 'America/Chicago', 'CDT', '2017-08-11 21:33:37.656147+00', NULL, true, NULL, 'asdf', false, 'Register here', 'http://comcast.net', 'contact@test.com', 'http://yahoo.com', '', NULL);
INSERT INTO event VALUES (355, '3180e789-ddb6-dbb3-ae5e-d9ae9fd88a2e', '2017-08-11 22:51:00+00', '00:30:00', 'Test for public display', '', 293, NULL, 'America/New_York', 'EDT', '2017-08-11 22:51:25.805556+00', NULL, true, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (351, '4575228c-90ac-e6e2-b907-377311aed7f2', '2017-08-13 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-10 21:30:41.094643+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (356, '00e53bd9-785f-3bb1-43b1-6fdf8821b609', '2017-08-21 10:00:00+00', '00:30:00', 'latest', '', 361, NULL, 'America/New_York', 'EDT', '2017-08-12 01:47:25.791405+00', NULL, false, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (358, '7c4830b1-f769-4c13-0cc2-18c30a0411ed', '2017-08-13 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-12 02:16:08.624987+00', NULL, true, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (357, '5a4dc376-5162-ae9f-8fe2-80584e9aa101', '2017-08-13 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-12 02:14:23.060846+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (359, 'ee9c2627-e5d3-9692-cacc-189d4aaf9ac5', '2017-08-12 02:16:00+00', '01:30:00', 'latest', '', 361, NULL, 'America/New_York', 'EDT', '2017-08-12 02:16:38.34616+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (360, '51b735c9-1233-42f5-208e-db86767bda74', '2017-08-27 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-12 02:17:41.463152+00', NULL, true, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (361, '3215f48e-2b21-f488-5ceb-ac0e5bc5b8d7', '2017-08-15 15:05:00+00', '00:30:00', 'Test', '', 293, NULL, 'America/New_York', 'EDT', '2017-08-15 15:05:21.362107+00', NULL, true, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (375, '5b6c0492-6173-46c7-4945-f26f53a32c7f', '2017-08-27 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-27 02:21:59.695807+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (363, 'd165f2f9-b039-ceca-1eee-12454bdd3d79', '2017-08-23 12:30:00+00', '01:00:00', '8.15 #2', 'descr', 339, NULL, 'America/Chicago', 'CDT', '2017-08-15 15:13:24.581623+00', NULL, false, 'video chat', '', true, '', '', '', '', '', NULL);
INSERT INTO event VALUES (365, 'd165f2f9-b039-ceca-1eee-12454bdd3d79', '2017-08-23 12:30:00+00', '01:00:00', '8.15 #2', 'descr', 339, NULL, 'America/Chicago', 'CDT', '2017-08-15 15:34:48.198634+00', NULL, true, NULL, '', false, '', '', '', '', '', NULL);
INSERT INTO event VALUES (362, 'efb3d8a2-545c-a21e-6443-594c87d5670c', '2017-08-16 12:30:00+00', '00:30:00', '8.15 #1', 'descr', 339, NULL, 'America/Chicago', 'CDT', '2017-08-15 15:12:45.325359+00', NULL, false, 'video tether', '', true, '', '', '', '', '', NULL);
INSERT INTO event VALUES (364, 'efb3d8a2-545c-a21e-6443-594c87d5670c', '2017-08-16 12:30:00+00', '00:30:00', '8.15 #3', 'descr', 339, NULL, 'America/Chicago', 'CDT', '2017-08-15 15:34:00.646065+00', NULL, true, 'video tether', '', true, '', '', '', '', '', 229);
INSERT INTO event VALUES (366, 'a55b0895-ced0-42ac-ecb1-d7c8f6718dd1', '2017-08-27 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-23 16:11:16.892962+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (367, '7f82c390-ab0e-0dc1-86a9-95c95f220c60', '2017-08-23 16:11:00+00', '01:30:00', 'latest', '', 361, NULL, 'America/New_York', 'EDT', '2017-08-23 16:11:46.982523+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (368, '4611706c-2989-b0ca-9f66-4e9a7233cc08', '2017-08-27 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-24 16:07:05.935876+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (369, 'ed758df6-028b-702a-b749-36771ed739ad', '2017-08-24 16:07:00+00', '01:30:00', 'latest', '', 361, NULL, 'America/New_York', 'EDT', '2017-08-24 16:07:35.421595+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (370, 'eca880da-7645-e6e8-dcd1-66e5bf4258e0', '2017-08-27 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-27 02:14:07.697032+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (371, 'b766e228-2370-d6cf-8241-819ff3f2e6a1', '2017-08-27 02:14:00+00', '01:30:00', 'latest', '', 361, NULL, 'America/New_York', 'EDT', '2017-08-27 02:14:42.011183+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (372, '8e110d74-0a30-1a7e-0f42-1354aa20924d', '2017-08-27 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-27 02:18:15.898502+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (373, 'b91276cd-9eb6-d9cf-e54d-70ac037d58c7', '2017-08-27 02:18:00+00', '01:30:00', 'latest', '', 361, NULL, 'America/New_York', 'EDT', '2017-08-27 02:18:49.046606+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (374, '26f615a3-03b6-574f-c6a7-0211c3322e62', '2017-08-27 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-27 02:20:35.659439+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (376, 'bfb3ef42-9718-f757-1643-064ba880d5c6', '2017-08-27 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-27 02:26:09.772259+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (377, '6a010b0b-5b0c-7c3d-e71a-6611a46dec3e', '2017-08-27 02:26:00+00', '01:30:00', 'latest', '', 361, NULL, 'America/New_York', 'EDT', '2017-08-27 02:26:40.83193+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (378, 'ed1ea953-3970-7767-7ac6-cef1f12df2ad', '2017-08-27 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-27 02:40:32.221238+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (379, 'beae74f7-6110-2b2c-d547-8e02018d3a22', '2017-08-27 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-27 02:42:24.623845+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (380, '0157adb2-e4ee-5a63-abd8-48a672562f3d', '2017-08-27 02:43:00+00', '01:30:00', 'latest', '', 361, NULL, 'America/New_York', 'EDT', '2017-08-27 02:43:01.765661+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (381, '7818d288-3c5b-ca2c-c2cf-8935823f3aaf', '2017-08-27 02:55:00+00', '01:30:00', 'latest', '', 361, NULL, 'America/New_York', 'EDT', '2017-08-27 02:55:32.979147+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (382, 'df436bd9-5987-550a-9a6e-a14ddd4e12de', '2017-08-27 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-27 02:56:34.834368+00', NULL, true, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (383, '7b916206-e7c1-34cc-3f89-c913324f9439', '2017-08-31 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-27 02:57:26.277171+00', NULL, true, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (384, 'feaf400b-9d8f-527b-3f33-06bff5b3c435', '2017-08-31 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-28 00:41:09.634485+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (385, '034353e5-a61e-8936-8a17-6e8474e22232', '2017-08-31 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-28 00:45:14.292708+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (386, '76a1c50a-ed6c-dfe4-73df-442b9b8f7f52', '2017-08-28 00:45:00+00', '01:30:00', 'latest', '', 361, NULL, 'America/New_York', 'EDT', '2017-08-28 00:45:47.092983+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (387, '85d02266-6ad2-9d56-e99d-bfd961853995', '2017-08-31 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-08-29 02:53:50.757352+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (388, '5fafba0c-088e-4b3f-2583-d9ffe50a7d80', '2017-08-29 02:54:00+00', '01:30:00', 'latest', '', 361, NULL, 'America/New_York', 'EDT', '2017-08-29 02:54:23.913113+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (389, '1c25bb40-2e4b-b14d-a9d4-a60ba7ff642d', '2017-09-30 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-09-09 16:31:39.656514+00', NULL, true, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (390, '9a8a9a3f-637b-1c56-95d6-37434794a36a', '2017-09-11 19:29:00+00', '04:00:00', 'Demo now', '', 293, NULL, 'America/New_York', 'EDT', '2017-09-11 19:29:34.526062+00', NULL, true, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (391, 'f97dece0-e9f7-f5f8-c4e0-7e7e860e7d0d', '2017-09-30 12:00:00+00', '00:30:00', 'test.1', 'lkj', 339, NULL, 'America/Chicago', 'CDT', '2017-09-12 19:53:16.07968+00', NULL, true, 'video chat', 'lkj', true, '', '', '', '', '', NULL);
INSERT INTO event VALUES (392, 'd98e511a-84d4-14c7-7f65-bf766881a674', '2017-09-28 12:30:00+00', '01:00:00', 'test.2', 'jhg', 339, NULL, 'America/Chicago', 'CDT', '2017-09-12 20:17:54.684562+00', NULL, true, 'video chat', '', false, '', '', '', '', '', NULL);
INSERT INTO event VALUES (393, '9c9cac9f-0bc3-4fbd-481f-50fdd9395826', '2017-09-23 14:00:00+00', '04:00:00', 'Chat Module test', 'lkj', 339, NULL, 'America/Chicago', 'CDT', '2017-09-19 15:08:03.844568+00', NULL, true, NULL, '', false, '', '', '', '', '', NULL);
INSERT INTO event VALUES (394, '2d914192-13f3-bfd0-efc5-3af29639555d', '2017-09-30 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-09-21 02:55:49.765652+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (395, 'de47d6d8-6af6-fbbb-36f1-9953983c394e', '2017-09-21 02:56:00+00', '01:30:00', 'latest', '', 361, NULL, 'America/New_York', 'EDT', '2017-09-21 02:56:23.034846+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (396, '2f0c3c2a-21ce-23bd-6165-c866da87bae8', '2017-09-30 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-09-22 02:26:34.872298+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (397, '9f19b46d-5572-edaf-0d4b-3728682cc347', '2017-09-22 02:27:00+00', '01:30:00', 'latest', '', 361, NULL, 'America/New_York', 'EDT', '2017-09-22 02:27:11.166019+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (398, '39303ea8-ecdd-8364-b119-7492307f6538', '2017-09-30 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 361, NULL, 'Pacific/Honolulu', 'HST', '2017-09-22 03:14:49.719696+00', NULL, true, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (399, '1728b0fd-db11-9dac-d015-fc872b28aab2', '2017-09-29 23:10:00+00', '00:30:00', 'Test for public display', '', 329, NULL, 'America/New_York', 'EDT', '2017-09-29 23:10:31.769162+00', NULL, true, 'webinar', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (400, 'a86da061-5841-dfe7-28b9-930da98866fe', '2017-09-29 23:10:00+00', '00:30:00', 'test public', '', 329, NULL, 'America/New_York', 'EDT', '2017-09-29 23:10:54.508052+00', NULL, true, 'webinar', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (401, '91423bce-d908-0b75-bfcb-491ee414f813', '2017-09-29 23:11:00+00', '01:00:00', 'Test', '', 329, NULL, 'America/New_York', 'EDT', '2017-09-29 23:11:25.435387+00', NULL, true, 'webinar', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (402, '2ccbf62a-dff6-a0dc-2955-1a3afda5c9b1', '2017-09-29 23:24:00+00', '01:00:00', 'Demo now', '', 329, NULL, 'America/New_York', 'EDT', '2017-09-29 23:24:14.498359+00', NULL, true, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (403, '73deac73-0192-da12-4e7c-1ff556b53acb', '2017-09-29 23:24:00+00', '00:30:00', 'test 5', '', 329, NULL, 'America/New_York', 'EDT', '2017-09-29 23:24:49.251535+00', NULL, true, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (404, 'f74d1b3d-0d12-81cd-0645-f63dfb68f4a4', '2017-09-29 23:30:00+00', '00:30:00', 'Test', '', 329, NULL, 'America/Chicago', 'CDT', '2017-09-29 23:25:49.641758+00', NULL, true, 'webinar', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (405, 'ecd37635-2f1e-5a26-0f4d-d34e6a255fe2', '2017-09-30 02:00:00+00', '00:30:00', 'Whaaat?', '', 329, NULL, 'America/Chicago', 'CDT', '2017-09-29 23:32:47.66001+00', NULL, true, 'webinar', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (406, '6ea0be61-ab0a-0979-063a-5b9806117efb', '2017-09-30 00:06:00+00', '00:30:00', 'test me now', '', 329, NULL, 'America/New_York', 'EDT', '2017-09-30 00:06:13.637727+00', NULL, false, 'webinar', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (407, '1edda9c1-c8b0-149b-fca2-b49103253104', '2017-09-30 12:00:00+00', '02:00:00', 'test 2', 'test', 339, NULL, 'America/Chicago', 'CDT', '2017-09-30 00:11:22.753496+00', NULL, true, NULL, '', false, '', '', '', '', '', NULL);
INSERT INTO event VALUES (408, '85b098e3-00d0-3de0-88c8-07b113750302', '2017-09-30 22:30:00+00', '01:30:00', 'public submit', 'lkjh', 338, NULL, 'America/Chicago', 'CDT', '2017-09-30 00:13:05.853278+00', NULL, false, NULL, '', false, '', '', 'kathy.flint@northbridgetech.org', '', '', NULL);
INSERT INTO event VALUES (409, '85b098e3-00d0-3de0-88c8-07b113750302', '2017-09-30 22:30:00+00', '01:30:00', 'public submit', 'lkjh', 339, NULL, 'America/Chicago', 'CDT', '2017-09-30 00:13:52.568821+00', NULL, true, NULL, '', false, '', '', 'kathy.flint@northbridgetech.org', '', '', NULL);
INSERT INTO event VALUES (414, 'c5d10915-097f-c2a9-8fcd-f850e254b5cd', '2017-10-02 01:03:00+00', '00:30:00', 'test', '', 329, NULL, 'America/New_York', 'EDT', '2017-10-02 01:03:07.558657+00', NULL, true, 'webinar', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (420, '5bd396d4-06ee-8d73-76f1-9b9d6d6e6114', '2017-10-03 12:00:00+00', '01:00:00', 'Test', '', 329, NULL, 'America/Chicago', 'CDT', '2017-10-02 21:46:38.5017+00', NULL, true, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (418, 'e6fb7929-26ae-81ee-0506-e646403c576e', '2017-10-23 01:30:00+00', '00:30:00', 'test 1', '', 373, NULL, 'Asia/Kabul', '+0430', '2017-10-02 16:09:19.650581+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (411, '735bced5-5be0-f6fc-af58-d130c4c4bddd', '2017-10-23 11:30:00+00', '00:30:00', 'hema Test 2', '', 373, NULL, 'America/New_York', 'EDT', '2017-10-01 21:00:55.888216+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (410, 'a1a947d2-f85e-27ee-b89a-dd75f00dd344', '2017-10-24 11:00:00+00', '01:00:00', 'hema Test', '', 373, NULL, 'America/New_York', 'EDT', '2017-10-01 20:58:16.48458+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (422, '9d7675f0-f2e3-86e7-cccb-7d9995adaa1d', '2017-10-03 14:49:00+00', '00:30:00', 'test ', '', 373, NULL, 'America/New_York', 'EDT', '2017-10-03 14:49:45.147463+00', NULL, true, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (421, '2e29c99f-59fb-9a8b-8468-0abe14062efb', '2017-10-18 05:30:00+00', '01:30:00', 'test', '', 373, NULL, 'Africa/Algiers', 'CET', '2017-10-03 14:27:10.670413+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (417, 'aeeeaebc-5efa-c971-956e-5cde5794c00e', '2017-10-23 01:30:00+00', '01:00:00', 'tets ', '', 373, NULL, 'Asia/Kabul', '+0430', '2017-10-02 15:54:26.284261+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (415, 'db79e247-37ac-a3fd-d6f1-ba7f8edff9fb', '2017-10-24 07:00:00+00', '01:00:00', 'test 1', '', 373, NULL, 'Africa/Algiers', 'CET', '2017-10-02 15:44:32.978063+00', NULL, false, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (413, '5c7c8b82-8d0c-a71b-f20a-eaea9b43499f', '2017-10-25 11:00:00+00', '01:30:00', 'hem test4', '', 373, NULL, 'America/New_York', 'EDT', '2017-10-01 21:02:44.032012+00', NULL, false, 'webinar', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (419, '8003e311-db39-867f-7c79-e968cade7265', '2017-10-30 05:30:00+00', '02:30:00', 'test 1', '', 373, NULL, 'Europe/Helsinki', 'EEST', '2017-10-02 16:10:07.471172+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (424, '20a16f78-8fb3-f075-a8dc-1323504bcaba', '2017-10-03 17:24:00+00', '00:30:00', 'Test Now', '', 375, NULL, 'America/New_York', 'EDT', '2017-10-03 17:24:17.223148+00', NULL, false, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (426, 'a83f18e6-254f-5699-6396-9513f97c29b2', '2017-10-03 17:29:00+00', '00:30:00', 'Kathy Admin Now', '', 374, NULL, 'America/New_York', 'EDT', '2017-10-03 17:29:19.165935+00', NULL, true, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (425, 'a5eb15d1-5c0d-a198-b7a2-da09554e739c', '2017-10-12 12:30:00+00', '01:00:00', 'Kathy Non-Admin Test', '', 374, NULL, 'America/Chicago', 'CDT', '2017-10-03 17:29:08.009592+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (427, 'b6e2f46d-5a9a-9019-24fc-4116e7f72765', '2017-10-05 16:17:00+00', '01:30:00', 'webinar test', '', 374, NULL, 'America/New_York', 'EDT', '2017-10-05 16:17:39.566609+00', NULL, true, 'webinar', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (423, '45328848-de69-8c80-39cf-45ea8884cdb6', '2017-10-12 12:30:00+00', '03:00:00', 'Kathy Non-Admin Test', '', 375, NULL, 'America/Chicago', 'CDT', '2017-10-03 17:23:29.870317+00', NULL, false, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (412, '25f1d3b7-b7b2-25c8-880b-fd985abfb668', '2017-10-31 12:00:00+00', '02:30:00', 'hem test 3', '', 373, NULL, 'America/New_York', 'EDT', '2017-10-01 21:01:58.760965+00', NULL, false, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (416, '8f1d7857-8c31-f9e4-a3d9-d580c449ad97', '2017-10-30 17:30:00+00', '02:00:00', 'Test 2', '', 373, NULL, 'Pacific/Pago_Pago', 'SST', '2017-10-02 15:45:14.057994+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (428, 'a85e9866-8f65-2e1e-9987-86c116232923', '2017-10-24 10:30:00+00', '01:00:00', 'test1', '', 361, NULL, 'America/New_York', 'EDT', '2017-10-10 16:15:45.070053+00', NULL, true, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (429, '43102f2e-b113-ca39-3544-4ff289584b43', '2017-10-12 03:30:00+00', '00:30:00', 'hema non admin', '', 373, NULL, 'Europe/Helsinki', 'EEST', '2017-10-10 16:16:20.236289+00', NULL, true, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (430, 'eaef9ee7-f328-45bf-2be2-fffbc6bcc0ec', '2017-10-28 12:00:00+00', '02:00:00', 'Kathy Non-Admin Test', '', 375, NULL, 'America/Chicago', 'CDT', '2017-10-11 16:33:01.902455+00', NULL, true, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (431, '90e1b2b1-3e95-0872-335a-d72a373870a1', '2017-10-23 03:00:00+00', '01:00:00', 'hema Test non admin', '', 373, NULL, 'Europe/Helsinki', 'EEST', '2017-10-11 17:39:30.720082+00', NULL, true, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (432, 'eec2f890-db21-0a8a-84cf-7c7b2f06f98f', '2017-10-25 04:00:00+00', '02:30:00', 'non admin linked in', '', 373, NULL, 'Europe/Tirane', 'CEST', '2017-10-11 18:14:07.3716+00', NULL, true, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (433, '6e867ea3-e4b2-df09-d74e-04983502e97e', '2017-10-25 11:30:00+00', '03:00:00', 'latest test 14 ', '', 361, NULL, 'America/New_York', 'EDT', '2017-10-15 23:36:38.515072+00', NULL, true, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (434, '9c91413c-a107-1fbe-3951-749d8c169a3c', '2017-10-26 12:30:00+00', '02:00:00', 'Non admin - retest ', '', 373, NULL, 'America/New_York', 'EDT', '2017-10-15 23:39:27.162257+00', NULL, true, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (435, 'dad0230e-de0a-9bb3-b6c6-6345d5d8d7be', '2017-10-24 11:30:00+00', '02:30:00', 'retest ', '', 373, NULL, 'America/New_York', 'EDT', '2017-10-15 23:40:17.530411+00', NULL, true, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (436, '547a88ee-84af-eb21-fde3-7cdb561a053f', '2017-10-30 12:00:00+00', '03:00:00', 'Retest linkedin', '', 373, NULL, 'America/New_York', 'EDT', '2017-10-15 23:41:43.302552+00', NULL, true, 'webinar', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (437, '106015d9-05ad-5ccf-9e1e-40734ee01755', '2017-10-29 12:30:00+00', '01:30:00', 'test-video', '', 361, NULL, 'America/New_York', 'EDT', '2017-10-16 00:03:04.808111+00', NULL, true, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (438, 'a67b3afb-939f-202a-1680-9f7d8c930121', '2017-10-30 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 373, NULL, 'Pacific/Honolulu', 'HST', '2017-10-16 00:19:51.510764+00', NULL, true, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (439, '53af493b-2665-46db-7846-86b25c1b2eb5', '2017-10-30 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 373, NULL, 'Pacific/Honolulu', 'HST', '2017-10-16 00:22:30.520863+00', NULL, true, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (440, 'cb1e8dea-d7db-8776-9333-759678c7e001', '2017-10-30 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 373, NULL, 'Pacific/Honolulu', 'HST', '2017-10-16 00:31:23.353569+00', NULL, true, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (441, '3f5409c1-4b60-7887-4476-49316a17c84d', '2017-10-30 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 373, NULL, 'Pacific/Honolulu', 'HST', '2017-10-16 00:56:36.341478+00', NULL, true, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (442, 'b9b6df17-bfba-652a-abb2-5c0a5beb391c', '2017-10-30 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 373, NULL, 'Pacific/Honolulu', 'HST', '2017-10-16 00:56:58.58571+00', NULL, true, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (443, 'cbe3ef4d-1644-cc7f-a01e-86760f3d1ae0', '2017-10-30 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 373, NULL, 'Pacific/Honolulu', 'HST', '2017-10-16 00:57:21.678434+00', NULL, true, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (444, '5f49a0c5-1523-f576-96e6-fd58d90b584b', '2017-10-30 16:30:00+00', '00:30:00', 'New Meeting Demo', '', 373, NULL, 'Pacific/Honolulu', 'HST', '2017-10-16 00:57:44.573765+00', NULL, true, 'webinar', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (445, '6bad3fbe-29a6-8ba9-e56b-cf0027f5bff1', '2017-11-08 12:00:00+00', '01:00:00', 'Test', 'description', 339, NULL, 'America/Chicago', 'CDT', '2017-10-30 18:12:55.986206+00', NULL, true, 'webinar', '', true, '', '', '', '', '', NULL);
INSERT INTO event VALUES (446, '1a01e4d5-54c0-9b09-425c-66618c738131', '2017-11-09 01:05:00+00', '00:30:00', 'Recording Test', '', 375, NULL, 'America/New_York', 'EST', '2017-11-09 01:05:43.970535+00', NULL, true, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (447, 'd259057c-94ca-ff44-d383-25ca09d8c177', '2017-11-09 01:39:00+00', '00:30:00', 'Test recording #2', '', 374, NULL, 'America/New_York', 'EST', '2017-11-09 01:39:07.499826+00', NULL, true, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (448, '12901532-2b94-9e6a-6c12-2aff6a4c9139', '2017-11-09 19:22:00+00', '01:00:00', 'Puppy Love', '', 374, NULL, 'America/New_York', 'EST', '2017-11-09 19:22:24.410855+00', NULL, true, 'webinar', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (450, '63394575-a921-7cfb-22c9-18b6299f7ff6', '2017-11-10 15:53:00+00', '00:30:00', 'Meet 1', '', 361, NULL, 'America/New_York', 'EST', '2017-11-10 15:53:14.841866+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (451, '152be73a-b3c1-df92-2e16-2aa9b9e93de7', '2017-11-11 04:00:00+00', '01:00:00', 'hema', '', 361, NULL, 'America/New_York', 'EST', '2017-11-10 15:55:17.196455+00', NULL, false, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (452, '012541f2-73df-0578-87dc-6391202c306a', '2017-11-10 18:00:00+00', '01:30:00', 'meet 1', '', 361, NULL, 'America/New_York', 'EST', '2017-11-10 16:03:33.328347+00', NULL, true, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (449, '8151524c-4dd8-2436-2d40-8ed2a86023ce', '2017-11-28 11:00:00+00', '01:00:00', 'meet 1', '', 361, NULL, 'America/New_York', 'EST', '2017-11-09 19:27:55.258289+00', NULL, false, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (453, 'caecb212-bac2-7a9e-f376-c02f00d40a22', '2017-11-15 20:01:00+00', '01:00:00', 'Hema test demo', '', 361, NULL, 'America/New_York', 'EST', '2017-11-15 20:01:13.086031+00', NULL, true, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (454, 'fa1c74e1-989c-1f38-dc10-f869935f647d', '2017-11-17 17:44:00+00', '00:30:00', 'test 1', '', 361, NULL, 'America/New_York', 'EST', '2017-11-17 17:44:58.804+00', NULL, true, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (455, '848b1184-42f1-a9f5-8530-9d65dc5a0ef1', '2017-11-17 18:30:00+00', '02:00:00', 'meet 1', '', 361, NULL, 'America/New_York', 'EST', '2017-11-17 18:30:24.511279+00', NULL, true, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (456, '4ba90fde-2f71-92d6-61dd-eb026ffcb929', '2017-11-17 20:42:00+00', '01:00:00', 'Instructions Test', '', 375, NULL, 'America/New_York', 'EST', '2017-11-17 20:42:43.611288+00', NULL, true, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (457, 'c09b42ae-f970-077e-317d-0b340bd2f75a', '2017-11-21 05:19:00+00', '00:30:00', 'Temp', '', 361, NULL, 'America/New_York', 'EST', '2017-11-21 05:19:01.138346+00', NULL, true, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (458, 'a8e33f87-5984-6273-25eb-6feaf63568bc', '2017-11-26 23:22:00+00', '00:30:00', 'Test', '', 361, NULL, 'America/New_York', 'EST', '2017-11-26 23:22:31.954347+00', NULL, true, 'webinar', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (459, '08870f93-40d4-4fd2-1f90-3fef6a6a5a66', '2017-12-07 03:31:00+00', '00:30:00', 'hema test 1', '', 361, NULL, 'America/New_York', 'EST', '2017-12-07 03:31:23.317569+00', NULL, true, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (460, 'e10655c2-17b6-661a-3348-667355737cce', '2017-12-19 21:40:00+00', '01:30:00', 'meet 1', '', 361, NULL, 'America/New_York', 'EST', '2017-12-19 21:40:28.821996+00', NULL, false, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (489, '19c99f39-dadd-86c0-d451-b9db33c999f6', '2018-03-31 11:00:00+00', '01:00:00', 'oih', '', 374, NULL, 'America/Chicago', 'CDT', '2018-03-31 00:55:46.992532+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (461, 'e8d70169-30e6-b7ce-bfb0-c5dd248b34af', '2017-12-19 22:30:00+00', '00:30:00', 'meet 1', '', 361, NULL, 'America/New_York', 'EST', '2017-12-19 22:30:30.119713+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (462, '04a16b75-b8d1-5c83-557f-22089a33075e', '2017-12-19 22:33:00+00', '00:30:00', 'meet 1', '', 361, NULL, 'America/New_York', 'EST', '2017-12-19 22:33:45.93088+00', NULL, false, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (463, '698d142d-2079-49e9-b233-79aa084e3a73', '2017-12-19 22:34:00+00', '00:30:00', 'meet 1', '', 361, NULL, 'America/New_York', 'EST', '2017-12-19 22:34:54.79549+00', NULL, false, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (464, 'a852a947-2b51-9f42-9264-32b31f06083e', '2017-12-19 22:36:00+00', '01:00:00', 'meet 1', '', 361, NULL, 'America/New_York', 'EST', '2017-12-19 22:36:06.612178+00', NULL, true, 'webinar', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (465, '5e6b5bca-0cf3-f3bd-4a59-920344527249', '2017-12-20 19:24:00+00', '02:00:00', 'meet 1', '', 361, NULL, 'America/New_York', 'EST', '2017-12-20 19:24:04.97269+00', NULL, true, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (466, 'fcb1a932-0f8a-2650-b454-101dda2570b0', '2018-02-10 13:01:00+00', '00:30:00', 'Test', '', 374, NULL, 'America/New_York', 'EST', '2018-02-10 13:01:10.706183+00', NULL, true, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (467, 'e90e2772-820e-da82-1e48-1de529228a2b', '2018-02-10 13:36:00+00', '00:30:00', 'Test', '', 374, NULL, 'America/New_York', 'EST', '2018-02-10 13:36:12.689221+00', NULL, true, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (468, 'ed975a88-9095-404c-adae-d45c6ea41f6d', '2018-02-21 11:30:00+00', '01:00:00', 'meet 1', '', 361, NULL, 'America/New_York', 'EST', '2018-02-14 23:54:40.320717+00', NULL, true, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (469, 'f57ac0af-dda8-352f-ccb4-9975d432c45b', '2018-02-20 18:30:00+00', '01:00:00', 'meet1', '', 361, NULL, 'Pacific/Pago_Pago', 'SST', '2018-02-14 23:55:36.705356+00', NULL, true, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (470, '46c3726d-65e0-838a-7b95-a12f2865faa5', '2018-02-28 11:30:00+00', '03:30:00', 'meet3', '', 361, NULL, 'America/New_York', 'EST', '2018-02-14 23:56:34.462576+00', NULL, true, 'webinar', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (471, '19c7bef9-2c2a-09c4-682e-82ed3a86f56a', '2018-02-16 15:45:00+00', '00:30:00', 'Test', '', 374, NULL, 'America/New_York', 'EST', '2018-02-16 15:45:30.786959+00', NULL, true, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (472, '17a0dfa5-a755-000f-7fe2-85fc5ec770f5', '2018-02-16 17:04:00+00', '00:30:00', 'Test', '', 374, NULL, 'America/New_York', 'EST', '2018-02-16 17:04:05.551604+00', NULL, true, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (473, '6cd23dd3-c329-ee37-e68e-5128376064f1', '2018-02-16 21:12:00+00', '00:30:00', 'Test', '', 374, NULL, 'America/New_York', 'EST', '2018-02-16 21:12:38.861269+00', NULL, true, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (474, '515b2a3b-940f-5d3f-9146-14656c98b1b4', '2018-02-17 23:31:00+00', '00:30:00', 'test', '', 374, NULL, 'America/New_York', 'EST', '2018-02-17 23:31:21.076447+00', NULL, true, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (475, '7f6361bb-6722-2e90-3497-746da61ce33c', '2018-02-22 12:30:00+00', '01:30:00', 'Test Training', 'test', 339, NULL, 'America/Chicago', 'CST', '2018-02-21 19:56:30.845333+00', NULL, true, 'webinar', '', true, '', '', '', '', '', NULL);
INSERT INTO event VALUES (476, '4d7e3b33-0bd5-6eb6-671e-c94975bf1c0c', '2018-02-22 00:03:00+00', '01:00:00', 'Test', '', 374, NULL, 'America/New_York', 'EST', '2018-02-22 00:03:57.459269+00', NULL, true, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (477, '73dc006f-5d3c-41b3-5ec7-2db96814d734', '2018-02-28 17:08:00+00', '00:30:00', 'Test', '', 293, NULL, 'America/New_York', 'EST', '2018-02-28 17:08:18.2636+00', NULL, true, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (478, '4b61d531-49b8-bfb9-d1be-5974c89f4d3c', '2018-02-28 17:21:00+00', '00:30:00', 'Test', '', 374, NULL, 'America/New_York', 'EST', '2018-02-28 17:21:16.760701+00', NULL, true, 'webinar', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (479, 'e9458d9d-e571-cc73-96ef-6d0c4bf77bd2', '2018-03-20 11:30:00+00', '01:30:00', 'Test', 'Test', 339, NULL, 'America/Chicago', 'CDT', '2018-03-18 23:20:51.525595+00', NULL, true, 'video chat', '', true, '', '', '', '', '', NULL);
INSERT INTO event VALUES (480, '18c4376d-7011-868b-e324-6445a4dafe58', '2018-03-28 04:00:00+00', '01:00:00', 'test', '', 374, NULL, 'Asia/Riyadh', '+03', '2018-03-27 00:13:42.265582+00', NULL, false, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (482, 'f0cd086e-555d-051d-fc80-03afdfb5e420', '2018-03-31 11:30:00+00', '02:30:00', 'meet test 1', '', 361, NULL, 'America/New_York', 'EDT', '2018-03-29 22:16:46.328874+00', NULL, true, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (483, '4b62a947-c60b-6005-ec19-a19a83d78dd5', '2018-03-31 12:30:00+00', '03:00:00', 'Meet test 2', '', 361, NULL, 'America/New_York', 'EDT', '2018-03-29 22:17:17.748188+00', NULL, true, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (484, '74c98c6a-8ffc-5ab4-e752-601e411b65b5', '2018-03-30 04:00:00+00', '01:00:00', 'meet test 3', '', 361, NULL, 'Europe/Tirane', 'CEST', '2018-03-29 22:17:52.766112+00', NULL, true, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (481, '69d261d5-8b62-8684-de21-12bfef68ef45', '2018-03-31 11:00:00+00', '02:00:00', 'meet test 4', '', 361, NULL, 'America/New_York', 'EDT', '2018-03-29 22:16:13.842414+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (486, 'c0612f59-9606-998b-3530-47e1baa2ef72', '2018-03-31 11:30:00+00', '02:00:00', 'test kathy', '', 374, NULL, 'America/Chicago', 'CDT', '2018-03-30 14:58:25.605596+00', NULL, false, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (485, '69d6104c-5d32-445f-e86e-b5b6bcf6d13b', '2018-03-30 14:50:00+00', '00:30:00', 'test kathy', '', 374, NULL, 'America/New_York', 'EDT', '2018-03-30 14:50:42.487434+00', NULL, false, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (488, '38d6e967-e985-4eb2-e9f5-ee580dafe25d', '2018-03-30 15:20:00+00', '00:30:00', 'test kathy', '', 374, NULL, 'America/New_York', 'EDT', '2018-03-30 15:20:56.831342+00', NULL, true, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (487, '2f8a1e7d-e70a-8603-0a85-c500d1eba92a', '2018-03-31 11:30:00+00', '00:30:00', 'test kathy', '', 374, NULL, 'America/Chicago', 'CDT', '2018-03-30 14:58:58.534324+00', NULL, false, 'video chat', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (490, 'f4badded-950a-a9ca-89fe-d0f2bad47f0c', '2018-04-24 10:00:00+00', '01:30:00', 'meet test 1', '', 361, NULL, 'America/New_York', 'EDT', '2018-04-02 18:39:23.133503+00', NULL, true, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (491, '548b2873-a480-5edb-f263-167af7cecc4d', '2018-04-18 11:00:00+00', '02:00:00', 'Meet  2', '', 361, NULL, 'America/New_York', 'EDT', '2018-04-02 18:39:55.372194+00', NULL, true, 'video tether', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (493, 'f5a4cdc7-9af4-5bc4-dffc-2ac7c334a75f', '2018-04-17 05:30:00+00', '03:00:00', 'Spanish  Meet 1', '', 361, NULL, 'Europe/Andorra', 'CEST', '2018-04-03 14:08:05.808889+00', NULL, true, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);
INSERT INTO event VALUES (492, '075c96e5-05f7-0185-476b-11a15b88338d', '2018-04-04 06:30:00+00', '01:30:00', 'Meet 3', '', 361, NULL, 'Africa/Algiers', 'CET', '2018-04-02 18:40:27.868851+00', NULL, false, 'collaboration', '', true, '', NULL, NULL, NULL, '', NULL);


--
-- Data for Name: event_group; Type: TABLE DATA; Schema: public; Owner: northbri_devnexus
--

INSERT INTO event_group VALUES (7, 28, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (8, 29, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (9, 1, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (10, 3, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (11, 4, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (12, 5, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (13, 6, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (14, 7, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (15, 8, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (16, 9, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (17, 10, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (18, 11, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (19, 12, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (20, 13, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (21, 14, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (22, 15, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (23, 16, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (24, 17, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (25, 18, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (26, 19, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (27, 20, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (28, 21, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (29, 22, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (30, 23, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (31, 24, 6, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (32, 25, 10, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (33, 26, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (34, 27, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (35, 30, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (36, 31, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (37, 32, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (38, 37, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (39, 38, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (40, 39, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (41, 40, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (42, 50, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (43, 36, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (44, 41, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (45, 42, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (46, 43, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (47, 44, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (48, 45, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (49, 46, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (50, 47, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (51, 48, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (52, 49, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (53, 52, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (54, 51, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (55, 53, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (56, 33, 12, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (57, 34, 12, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (58, 54, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (59, 55, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (60, 56, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (61, 57, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (62, 58, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (63, 59, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (64, 60, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (65, 61, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (66, 62, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (67, 35, 12, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (68, 63, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (69, 65, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (70, 64, 1, '2015-11-10 01:53:06.64889+00', NULL, 1);
INSERT INTO event_group VALUES (71, 68, 13, '2015-11-10 13:42:02.714948+00', NULL, 1);
INSERT INTO event_group VALUES (72, 69, 13, '2015-11-10 13:42:02.714948+00', NULL, 1);
INSERT INTO event_group VALUES (73, 70, 13, '2015-11-10 13:42:02.714948+00', NULL, 1);
INSERT INTO event_group VALUES (74, 71, 13, '2015-11-10 13:42:02.714948+00', NULL, 1);
INSERT INTO event_group VALUES (75, 72, 13, '2015-11-10 13:42:02.714948+00', NULL, 1);
INSERT INTO event_group VALUES (76, 73, 13, '2015-11-10 13:42:02.714948+00', NULL, 1);
INSERT INTO event_group VALUES (77, 75, 1, '2015-11-19 00:43:39.300499+00', NULL, 1);
INSERT INTO event_group VALUES (78, 76, 1, '2015-11-22 20:38:45.090754+00', NULL, 1);
INSERT INTO event_group VALUES (79, 77, 1, '2015-12-01 19:42:46.325818+00', NULL, 1);
INSERT INTO event_group VALUES (80, 78, 1, '2015-12-02 02:13:10.623607+00', NULL, 1);
INSERT INTO event_group VALUES (81, 79, 1, '2015-12-02 20:40:06.155836+00', NULL, 1);
INSERT INTO event_group VALUES (82, 80, 1, '2015-12-02 20:41:52.307787+00', NULL, 1);
INSERT INTO event_group VALUES (83, 81, 1, '2015-12-03 00:02:28.787304+00', NULL, 1);
INSERT INTO event_group VALUES (84, 82, 1, '2015-12-05 19:12:34.99498+00', NULL, 1);
INSERT INTO event_group VALUES (85, 83, 1, '2015-12-06 04:22:02.961617+00', NULL, 1);
INSERT INTO event_group VALUES (86, 84, 1, '2015-12-07 00:07:50.341364+00', NULL, 1);
INSERT INTO event_group VALUES (87, 85, 1, '2015-12-07 00:42:45.359092+00', NULL, 1);
INSERT INTO event_group VALUES (88, 86, 1, '2015-12-07 11:58:14.439302+00', NULL, 1);
INSERT INTO event_group VALUES (89, 87, 1, '2015-12-07 17:22:34.843051+00', NULL, 1);
INSERT INTO event_group VALUES (90, 88, 1, '2015-12-07 20:08:09.106819+00', NULL, 1);
INSERT INTO event_group VALUES (91, 89, 1, '2015-12-07 22:45:13.09763+00', NULL, 1);
INSERT INTO event_group VALUES (92, 90, 1, '2015-12-08 03:46:31.2485+00', NULL, 1);
INSERT INTO event_group VALUES (93, 91, 1, '2015-12-08 15:36:59.097921+00', NULL, 1);
INSERT INTO event_group VALUES (94, 92, 1, '2015-12-08 21:51:48.937788+00', NULL, 1);
INSERT INTO event_group VALUES (95, 93, 1, '2015-12-08 21:52:08.383497+00', NULL, 1);
INSERT INTO event_group VALUES (96, 94, 1, '2015-12-08 23:59:49.552552+00', NULL, 1);
INSERT INTO event_group VALUES (97, 95, 1, '2015-12-16 00:25:29.512062+00', NULL, 1);
INSERT INTO event_group VALUES (98, 96, 16, '2015-12-16 02:01:19.158263+00', NULL, 1);
INSERT INTO event_group VALUES (99, 97, 16, '2015-12-18 00:49:08.998887+00', NULL, 1);
INSERT INTO event_group VALUES (100, 98, 1, '2016-01-15 19:55:58.388076+00', NULL, 1);
INSERT INTO event_group VALUES (101, 99, 1, '2016-01-15 21:20:16.81147+00', NULL, 1);
INSERT INTO event_group VALUES (102, 100, 1, '2016-01-15 21:20:37.504504+00', NULL, 1);
INSERT INTO event_group VALUES (103, 101, 16, '2016-01-17 22:41:03.269314+00', NULL, 1);
INSERT INTO event_group VALUES (104, 102, 16, '2016-01-17 22:55:10.340207+00', NULL, 1);
INSERT INTO event_group VALUES (105, 103, 16, '2016-01-17 23:00:39.813285+00', NULL, 1);
INSERT INTO event_group VALUES (106, 104, 16, '2016-01-17 23:07:18.694317+00', NULL, 3);
INSERT INTO event_group VALUES (107, 105, 1, '2016-01-17 23:09:44.520591+00', NULL, 1);
INSERT INTO event_group VALUES (108, 106, 1, '2016-01-17 23:09:57.206967+00', NULL, 1);
INSERT INTO event_group VALUES (109, 107, 1, '2016-01-17 23:12:20.681826+00', NULL, 1);
INSERT INTO event_group VALUES (110, 110, 17, '2016-01-18 19:23:40.078509+00', NULL, 1);
INSERT INTO event_group VALUES (112, 112, 17, '2016-01-18 19:59:38.992967+00', NULL, 3);
INSERT INTO event_group VALUES (111, 111, 17, '2016-01-18 19:58:43.047841+00', NULL, 1);
INSERT INTO event_group VALUES (113, 113, 17, '2016-01-18 20:43:22.333759+00', NULL, 3);
INSERT INTO event_group VALUES (114, 114, 17, '2016-01-18 21:05:04.132547+00', NULL, 1);
INSERT INTO event_group VALUES (115, 115, 5, '2016-01-18 21:29:06.935246+00', NULL, 1);
INSERT INTO event_group VALUES (116, 116, 17, '2016-01-18 21:31:28.872896+00', NULL, 1);
INSERT INTO event_group VALUES (117, 117, 17, '2016-01-18 21:32:32.528299+00', NULL, 1);
INSERT INTO event_group VALUES (118, 118, 17, '2016-01-18 21:38:23.509252+00', NULL, 3);
INSERT INTO event_group VALUES (119, 119, 5, '2016-01-24 17:34:04.937752+00', NULL, 1);
INSERT INTO event_group VALUES (120, 120, 5, '2016-01-24 17:36:28.436642+00', NULL, 1);
INSERT INTO event_group VALUES (121, 121, 5, '2016-01-24 17:37:45.933534+00', NULL, 1);
INSERT INTO event_group VALUES (122, 122, 5, '2016-01-24 17:39:52.189665+00', NULL, 1);
INSERT INTO event_group VALUES (123, 123, 5, '2016-01-24 17:41:07.506691+00', NULL, 1);
INSERT INTO event_group VALUES (124, 124, 5, '2016-01-24 17:44:37.033597+00', NULL, 1);
INSERT INTO event_group VALUES (125, 125, 5, '2016-01-24 17:45:33.507306+00', NULL, 1);
INSERT INTO event_group VALUES (126, 126, 5, '2016-01-24 17:47:16.719987+00', NULL, 1);
INSERT INTO event_group VALUES (127, 127, 1, '2016-01-25 00:07:58.68616+00', NULL, 1);
INSERT INTO event_group VALUES (128, 128, 1, '2016-01-30 02:33:57.103287+00', NULL, 1);
INSERT INTO event_group VALUES (129, 129, 1, '2016-01-30 02:35:51.284958+00', NULL, 1);
INSERT INTO event_group VALUES (130, 130, 1, '2016-01-30 23:36:52.343672+00', NULL, 1);
INSERT INTO event_group VALUES (131, 131, 1, '2016-01-31 00:07:26.89826+00', NULL, 1);
INSERT INTO event_group VALUES (132, 132, 5, '2016-01-31 19:19:58.950194+00', NULL, 1);
INSERT INTO event_group VALUES (133, 133, 5, '2016-01-31 19:25:25.448195+00', NULL, 1);
INSERT INTO event_group VALUES (134, 134, 17, '2016-02-05 19:56:37.86772+00', NULL, 3);
INSERT INTO event_group VALUES (135, 135, 1, '2016-02-07 23:34:00.425764+00', NULL, 1);
INSERT INTO event_group VALUES (136, 136, 17, '2016-03-22 01:36:51.020358+00', NULL, 1);
INSERT INTO event_group VALUES (137, 137, 5, '2016-03-25 01:11:17.226841+00', NULL, 1);
INSERT INTO event_group VALUES (138, 138, 1, '2016-04-01 21:02:35.531937+00', NULL, 1);
INSERT INTO event_group VALUES (139, 139, 1, '2016-04-01 21:13:38.531926+00', NULL, 1);
INSERT INTO event_group VALUES (140, 140, 1, '2016-04-01 21:25:06.711495+00', NULL, 1);
INSERT INTO event_group VALUES (141, 141, 1, '2016-04-01 21:25:37.58699+00', NULL, 1);
INSERT INTO event_group VALUES (142, 142, 1, '2016-04-01 21:26:11.68797+00', NULL, 1);
INSERT INTO event_group VALUES (143, 143, 1, '2016-04-02 16:22:43.609582+00', NULL, 1);
INSERT INTO event_group VALUES (144, 144, 1, '2016-04-03 03:41:11.777414+00', NULL, 1);
INSERT INTO event_group VALUES (145, 145, 1, '2016-04-04 19:18:34.092783+00', NULL, 1);
INSERT INTO event_group VALUES (146, 146, 1, '2016-04-04 19:57:03.442472+00', NULL, 1);
INSERT INTO event_group VALUES (147, 147, 1, '2016-04-17 23:50:32.543666+00', NULL, 1);
INSERT INTO event_group VALUES (148, 148, 5, '2016-04-17 23:52:58.855954+00', NULL, 1);
INSERT INTO event_group VALUES (149, 149, 5, '2016-04-17 23:54:22.69314+00', NULL, 1);
INSERT INTO event_group VALUES (150, 150, 5, '2016-04-17 23:57:37.751282+00', NULL, 1);
INSERT INTO event_group VALUES (151, 151, 1, '2016-04-17 23:58:09.656864+00', NULL, 1);
INSERT INTO event_group VALUES (152, 152, 12, '2016-04-24 23:32:43.425448+00', NULL, 1);
INSERT INTO event_group VALUES (153, 153, 1, '2016-04-26 21:23:18.534076+00', NULL, 1);
INSERT INTO event_group VALUES (154, 154, 1, '2016-04-26 21:23:41.376456+00', NULL, 1);
INSERT INTO event_group VALUES (155, 155, 5, '2016-04-27 02:29:59.349945+00', NULL, 1);
INSERT INTO event_group VALUES (156, 156, 1, '2016-05-04 21:53:27.671911+00', NULL, 1);
INSERT INTO event_group VALUES (157, 157, 1, '2016-05-04 21:53:54.500637+00', NULL, 1);
INSERT INTO event_group VALUES (158, 158, 5, '2016-05-06 00:28:48.590579+00', NULL, 1);
INSERT INTO event_group VALUES (159, 159, 12, '2016-05-07 15:12:55.291751+00', NULL, 1);
INSERT INTO event_group VALUES (160, 160, 5, '2016-05-16 00:38:14.981772+00', NULL, 1);
INSERT INTO event_group VALUES (161, 161, 6, '2016-05-22 14:12:24.967905+00', NULL, 1);
INSERT INTO event_group VALUES (162, 162, 6, '2016-05-22 14:14:42.928199+00', NULL, 1);
INSERT INTO event_group VALUES (163, 163, 5, '2016-05-24 01:11:40.005991+00', NULL, 1);
INSERT INTO event_group VALUES (164, 164, 5, '2016-05-24 01:12:18.961958+00', NULL, 1);
INSERT INTO event_group VALUES (165, 165, 5, '2016-05-24 01:15:30.538974+00', NULL, 1);
INSERT INTO event_group VALUES (166, 166, 5, '2016-05-24 01:23:33.207743+00', NULL, 1);
INSERT INTO event_group VALUES (167, 167, 5, '2016-05-24 01:26:28.56133+00', NULL, 1);
INSERT INTO event_group VALUES (168, 168, 1, '2016-05-31 21:41:39.162113+00', NULL, 1);
INSERT INTO event_group VALUES (169, 169, 5, '2016-06-01 18:13:25.067539+00', NULL, 1);
INSERT INTO event_group VALUES (170, 170, 5, '2016-06-01 18:14:18.3839+00', NULL, 1);
INSERT INTO event_group VALUES (171, 171, 5, '2016-06-01 18:15:46.829267+00', NULL, 1);
INSERT INTO event_group VALUES (172, 172, 5, '2016-06-01 18:16:27.686213+00', NULL, 1);
INSERT INTO event_group VALUES (173, 173, 5, '2016-06-01 18:17:00.121754+00', NULL, 1);
INSERT INTO event_group VALUES (174, 174, 5, '2016-06-02 01:47:09.811696+00', NULL, 1);
INSERT INTO event_group VALUES (175, 175, 5, '2016-06-02 01:47:22.467767+00', NULL, 1);
INSERT INTO event_group VALUES (176, 176, 5, '2016-06-02 01:50:25.412803+00', NULL, 1);
INSERT INTO event_group VALUES (177, 177, 1, '2016-06-02 13:26:22.9064+00', NULL, 1);
INSERT INTO event_group VALUES (178, 178, 1, '2016-06-02 14:21:40.156669+00', NULL, 1);
INSERT INTO event_group VALUES (179, 179, 1, '2016-06-02 14:24:51.613033+00', NULL, 1);
INSERT INTO event_group VALUES (180, 180, 5, '2016-06-07 22:26:17.393705+00', NULL, 1);
INSERT INTO event_group VALUES (181, 181, 5, '2016-06-07 22:30:18.366184+00', NULL, 1);
INSERT INTO event_group VALUES (182, 182, 5, '2016-06-07 23:23:53.056731+00', NULL, 1);
INSERT INTO event_group VALUES (183, 183, 5, '2016-06-07 23:25:04.311539+00', NULL, 1);
INSERT INTO event_group VALUES (184, 184, 5, '2016-06-07 23:25:32.081957+00', NULL, 1);
INSERT INTO event_group VALUES (185, 185, 5, '2016-06-07 23:26:46.838176+00', NULL, 1);
INSERT INTO event_group VALUES (186, 186, 1, '2016-06-07 23:28:50.084197+00', NULL, 1);
INSERT INTO event_group VALUES (187, 187, 1, '2016-06-07 23:30:46.738299+00', NULL, 1);
INSERT INTO event_group VALUES (188, 188, 1, '2016-06-14 21:45:34.273947+00', NULL, 1);
INSERT INTO event_group VALUES (189, 189, 1, '2016-06-20 00:00:43.529575+00', NULL, 1);
INSERT INTO event_group VALUES (190, 190, 1, '2016-06-20 00:01:31.099457+00', NULL, 1);
INSERT INTO event_group VALUES (191, 191, 1, '2016-06-20 15:59:11.857089+00', NULL, 1);
INSERT INTO event_group VALUES (192, 192, 1, '2016-06-20 16:59:24.143221+00', NULL, 1);
INSERT INTO event_group VALUES (193, 193, 1, '2016-06-20 17:13:02.755379+00', NULL, 1);
INSERT INTO event_group VALUES (194, 194, 1, '2016-06-20 17:47:59.428349+00', NULL, 1);
INSERT INTO event_group VALUES (195, 195, 1, '2016-06-20 17:48:13.709446+00', NULL, 1);
INSERT INTO event_group VALUES (196, 196, 1, '2016-06-22 22:39:03.77468+00', NULL, 1);
INSERT INTO event_group VALUES (197, 197, 1, '2016-06-22 22:41:28.303982+00', NULL, 1);
INSERT INTO event_group VALUES (198, 198, 1, '2016-06-24 17:58:21.833451+00', NULL, 1);
INSERT INTO event_group VALUES (199, 199, 1, '2016-06-24 17:58:51.463919+00', NULL, 1);
INSERT INTO event_group VALUES (200, 203, 1, '2016-07-10 16:18:34.153444+00', NULL, 1);
INSERT INTO event_group VALUES (201, 204, 1, '2016-07-16 14:57:11.067983+00', NULL, 1);
INSERT INTO event_group VALUES (202, 205, 5, '2016-11-29 23:03:29.67544+00', NULL, 1);
INSERT INTO event_group VALUES (203, 206, 5, '2016-11-30 01:23:48.689836+00', NULL, 1);
INSERT INTO event_group VALUES (204, 207, 5, '2016-11-30 01:25:07.80967+00', NULL, 1);
INSERT INTO event_group VALUES (205, 208, 5, '2016-11-30 01:25:38.39902+00', NULL, 1);
INSERT INTO event_group VALUES (206, 209, 17, '2016-11-30 01:37:31.753483+00', NULL, 1);
INSERT INTO event_group VALUES (207, 210, 17, '2016-11-30 01:40:48.364467+00', NULL, 3);
INSERT INTO event_group VALUES (208, 211, 17, '2016-11-30 01:43:26.769109+00', NULL, 1);
INSERT INTO event_group VALUES (209, 212, 17, '2016-11-30 01:53:16.357026+00', NULL, 1);
INSERT INTO event_group VALUES (210, 213, 1, '2016-11-30 01:55:49.982733+00', NULL, 1);
INSERT INTO event_group VALUES (211, 214, 1, '2016-11-30 01:56:40.526872+00', NULL, 1);
INSERT INTO event_group VALUES (212, 215, 17, '2016-11-30 16:34:58.917596+00', NULL, 3);
INSERT INTO event_group VALUES (213, 216, 17, '2016-11-30 16:36:49.146012+00', NULL, 3);
INSERT INTO event_group VALUES (214, 217, 17, '2016-11-30 16:55:09.737981+00', NULL, 3);
INSERT INTO event_group VALUES (215, 218, 17, '2016-11-30 16:56:43.699853+00', NULL, 1);
INSERT INTO event_group VALUES (216, 219, 17, '2016-11-30 17:29:48.650879+00', NULL, 3);
INSERT INTO event_group VALUES (217, 220, 17, '2016-11-30 17:31:06.451584+00', NULL, 1);
INSERT INTO event_group VALUES (218, 221, 17, '2016-11-30 17:35:15.249636+00', NULL, 1);
INSERT INTO event_group VALUES (219, 222, 17, '2016-11-30 17:43:09.075481+00', NULL, 1);
INSERT INTO event_group VALUES (220, 223, 17, '2016-11-30 17:43:24.469646+00', NULL, 1);
INSERT INTO event_group VALUES (221, 224, 17, '2016-12-01 00:43:22.135046+00', NULL, 1);
INSERT INTO event_group VALUES (222, 225, 17, '2016-12-27 01:02:26.169798+00', NULL, 3);
INSERT INTO event_group VALUES (223, 226, 1, '2016-12-27 19:36:53.91148+00', NULL, 1);
INSERT INTO event_group VALUES (224, 227, 1, '2016-12-27 19:37:53.417327+00', NULL, 1);
INSERT INTO event_group VALUES (225, 228, 17, '2016-12-30 17:40:20.756503+00', NULL, 3);
INSERT INTO event_group VALUES (226, 229, 17, '2016-12-30 18:11:01.230688+00', NULL, 1);
INSERT INTO event_group VALUES (227, 230, 17, '2017-01-11 20:26:00.084526+00', NULL, 3);
INSERT INTO event_group VALUES (228, 231, 17, '2017-01-11 20:26:49.53814+00', NULL, 1);
INSERT INTO event_group VALUES (229, 232, 17, '2017-01-11 21:51:44.650653+00', NULL, 3);
INSERT INTO event_group VALUES (230, 233, 17, '2017-01-11 22:00:06.894729+00', NULL, 1);
INSERT INTO event_group VALUES (231, 234, 1, '2017-01-11 22:05:18.742832+00', NULL, 1);
INSERT INTO event_group VALUES (232, 235, 1, '2017-01-11 22:05:41.646156+00', NULL, 1);
INSERT INTO event_group VALUES (233, 236, 17, '2017-01-19 02:27:59.107337+00', NULL, 3);
INSERT INTO event_group VALUES (234, 237, 12, '2017-01-19 02:30:16.376757+00', NULL, 1);
INSERT INTO event_group VALUES (236, 238, 21, '2017-02-26 17:45:14.503634+00', NULL, 1);
INSERT INTO event_group VALUES (237, 239, 21, '2017-02-26 17:48:27.997472+00', NULL, 1);
INSERT INTO event_group VALUES (241, 243, 1, '2017-02-26 19:46:29.66753+00', NULL, 1);
INSERT INTO event_group VALUES (242, 244, 1, '2017-02-26 19:46:44.383218+00', NULL, 1);
INSERT INTO event_group VALUES (243, 245, 1, '2017-02-26 19:48:34.317732+00', NULL, 1);
INSERT INTO event_group VALUES (244, 246, 17, '2017-02-26 23:09:46.739236+00', NULL, 3);
INSERT INTO event_group VALUES (245, 247, 17, '2017-02-26 23:43:25.521381+00', NULL, 1);
INSERT INTO event_group VALUES (246, 248, 17, '2017-02-26 23:49:26.188819+00', NULL, 3);
INSERT INTO event_group VALUES (247, 249, 17, '2017-02-26 23:50:08.798776+00', NULL, 1);
INSERT INTO event_group VALUES (248, 250, 5, '2017-02-26 23:51:13.280576+00', NULL, 1);
INSERT INTO event_group VALUES (249, 251, 5, '2017-02-27 00:03:21.21748+00', NULL, 1);
INSERT INTO event_group VALUES (250, 252, 17, '2017-02-27 00:08:23.53859+00', NULL, 1);
INSERT INTO event_group VALUES (251, 253, 24, '2017-03-02 23:46:37.571393+00', NULL, 1);
INSERT INTO event_group VALUES (252, 254, 1, '2017-03-06 02:02:35.305793+00', NULL, 1);
INSERT INTO event_group VALUES (253, 255, 1, '2017-03-06 02:30:03.613236+00', NULL, 1);
INSERT INTO event_group VALUES (254, 256, 21, '2017-03-08 01:35:59.936251+00', NULL, 3);
INSERT INTO event_group VALUES (255, 257, 21, '2017-03-08 01:41:59.250842+00', NULL, 1);
INSERT INTO event_group VALUES (256, 258, 21, '2017-03-08 01:44:32.732766+00', NULL, 3);
INSERT INTO event_group VALUES (257, 259, 21, '2017-03-08 01:49:10.949413+00', NULL, 3);
INSERT INTO event_group VALUES (258, 260, 21, '2017-03-08 01:51:29.436096+00', NULL, 3);
INSERT INTO event_group VALUES (259, 261, 21, '2017-03-08 01:56:42.476486+00', NULL, 3);
INSERT INTO event_group VALUES (260, 262, 21, '2017-03-08 01:57:44.966889+00', NULL, 1);
INSERT INTO event_group VALUES (261, 263, 21, '2017-03-08 01:57:52.612822+00', NULL, 1);
INSERT INTO event_group VALUES (262, 264, 21, '2017-03-08 01:58:03.078891+00', NULL, 1);
INSERT INTO event_group VALUES (263, 265, 1, '2017-03-08 02:16:42.137311+00', NULL, 1);
INSERT INTO event_group VALUES (264, 266, 12, '2017-03-13 03:49:11.590059+00', NULL, 1);
INSERT INTO event_group VALUES (265, 267, 22, '2017-03-18 21:02:57.015406+00', NULL, 3);
INSERT INTO event_group VALUES (266, 268, 22, '2017-03-18 21:03:35.831269+00', NULL, 1);
INSERT INTO event_group VALUES (267, 269, 1, '2017-03-29 23:27:41.928605+00', NULL, 1);
INSERT INTO event_group VALUES (268, 270, 1, '2017-05-02 21:39:53.786332+00', NULL, 1);
INSERT INTO event_group VALUES (269, 271, 1, '2017-06-08 15:01:38.697801+00', NULL, 1);
INSERT INTO event_group VALUES (270, 272, 12, '2017-06-13 17:59:30.434031+00', NULL, 1);
INSERT INTO event_group VALUES (271, 273, 1, '2017-06-13 18:40:29.805514+00', NULL, 1);
INSERT INTO event_group VALUES (272, 274, 1, '2017-06-13 19:19:16.751919+00', NULL, 1);
INSERT INTO event_group VALUES (273, 275, 1, '2017-07-10 00:14:05.702966+00', NULL, 1);
INSERT INTO event_group VALUES (274, 276, 1, '2017-07-10 01:17:15.493787+00', NULL, 1);
INSERT INTO event_group VALUES (275, 277, 1, '2017-07-10 01:18:50.460545+00', NULL, 1);
INSERT INTO event_group VALUES (276, 278, 1, '2017-07-22 14:54:33.938075+00', NULL, 1);
INSERT INTO event_group VALUES (277, 279, 1, '2017-07-22 15:21:14.179136+00', NULL, 1);
INSERT INTO event_group VALUES (278, 280, 1, '2017-08-02 21:15:08.005815+00', NULL, 1);
INSERT INTO event_group VALUES (279, 281, 1, '2017-08-02 21:19:18.787646+00', NULL, 1);
INSERT INTO event_group VALUES (280, 282, 1, '2017-08-02 21:24:40.864109+00', NULL, 1);
INSERT INTO event_group VALUES (281, 283, 1, '2017-08-02 21:48:16.118621+00', NULL, 1);
INSERT INTO event_group VALUES (282, 284, 1, '2017-08-02 22:12:54.534108+00', NULL, 1);
INSERT INTO event_group VALUES (283, 285, 1, '2017-08-03 00:04:23.777049+00', NULL, 1);
INSERT INTO event_group VALUES (284, 286, 1, '2017-08-03 02:52:08.658937+00', NULL, 1);
INSERT INTO event_group VALUES (285, 287, 1, '2017-08-03 16:07:48.176394+00', NULL, 1);
INSERT INTO event_group VALUES (286, 288, 1, '2017-08-04 02:11:05.810217+00', NULL, 1);
INSERT INTO event_group VALUES (287, 289, 1, '2017-08-04 02:51:39.699866+00', NULL, 1);
INSERT INTO event_group VALUES (288, 290, 1, '2017-08-04 03:04:42.863236+00', NULL, 1);
INSERT INTO event_group VALUES (289, 291, 1, '2017-08-07 01:13:57.645436+00', NULL, 1);
INSERT INTO event_group VALUES (290, 292, 1, '2017-08-07 01:31:23.25422+00', NULL, 1);
INSERT INTO event_group VALUES (291, 293, 1, '2017-08-07 01:35:14.649305+00', NULL, 1);
INSERT INTO event_group VALUES (292, 294, 1, '2017-08-07 01:45:43.28595+00', NULL, 1);
INSERT INTO event_group VALUES (293, 295, 1, '2017-08-07 20:39:56.371535+00', NULL, 1);
INSERT INTO event_group VALUES (294, 296, 1, '2017-08-08 02:34:01.985843+00', NULL, 1);
INSERT INTO event_group VALUES (295, 297, 1, '2017-08-08 21:13:30.878044+00', NULL, 1);
INSERT INTO event_group VALUES (296, 298, 1, '2017-08-08 21:18:05.79435+00', NULL, 1);
INSERT INTO event_group VALUES (297, 299, 1, '2017-08-08 22:04:48.951844+00', NULL, 1);
INSERT INTO event_group VALUES (298, 300, 1, '2017-08-08 22:05:58.734857+00', NULL, 1);
INSERT INTO event_group VALUES (299, 301, 1, '2017-08-08 22:13:36.259573+00', NULL, 1);
INSERT INTO event_group VALUES (300, 302, 1, '2017-08-08 22:14:00.182089+00', NULL, 1);
INSERT INTO event_group VALUES (301, 303, 1, '2017-08-08 23:31:50.630661+00', NULL, 1);
INSERT INTO event_group VALUES (302, 304, 1, '2017-08-08 23:34:05.707159+00', NULL, 1);
INSERT INTO event_group VALUES (303, 305, 1, '2017-08-09 01:04:44.12505+00', NULL, 1);
INSERT INTO event_group VALUES (304, 306, 1, '2017-08-09 01:05:52.470989+00', NULL, 1);
INSERT INTO event_group VALUES (305, 307, 1, '2017-08-09 01:12:18.684324+00', NULL, 1);
INSERT INTO event_group VALUES (306, 308, 1, '2017-08-09 01:13:27.677501+00', NULL, 1);
INSERT INTO event_group VALUES (307, 309, 1, '2017-08-09 01:23:09.344193+00', NULL, 1);
INSERT INTO event_group VALUES (308, 310, 1, '2017-08-09 01:28:01.674691+00', NULL, 1);
INSERT INTO event_group VALUES (309, 311, 1, '2017-08-09 01:29:39.899148+00', NULL, 1);
INSERT INTO event_group VALUES (310, 312, 1, '2017-08-09 01:33:54.709235+00', NULL, 1);
INSERT INTO event_group VALUES (311, 313, 1, '2017-08-09 01:45:07.449148+00', NULL, 1);
INSERT INTO event_group VALUES (312, 314, 1, '2017-08-09 01:49:54.534802+00', NULL, 1);
INSERT INTO event_group VALUES (313, 315, 1, '2017-08-09 16:54:16.358526+00', NULL, 1);
INSERT INTO event_group VALUES (314, 316, 1, '2017-08-09 17:04:37.183092+00', NULL, 1);
INSERT INTO event_group VALUES (315, 317, 1, '2017-08-09 17:05:52.187942+00', NULL, 1);
INSERT INTO event_group VALUES (316, 318, 1, '2017-08-09 17:07:44.519899+00', NULL, 1);
INSERT INTO event_group VALUES (317, 319, 12, '2017-08-09 21:58:50.408127+00', NULL, 1);
INSERT INTO event_group VALUES (318, 320, 1, '2017-08-09 22:13:06.097804+00', NULL, 1);
INSERT INTO event_group VALUES (319, 321, 1, '2017-08-10 02:11:20.267869+00', NULL, 1);
INSERT INTO event_group VALUES (320, 322, 1, '2017-08-10 02:21:16.901478+00', NULL, 1);
INSERT INTO event_group VALUES (321, 323, 1, '2017-08-10 02:24:20.48678+00', NULL, 1);
INSERT INTO event_group VALUES (322, 324, 1, '2017-08-10 02:25:39.712866+00', NULL, 1);
INSERT INTO event_group VALUES (323, 325, 1, '2017-08-10 02:27:02.840985+00', NULL, 1);
INSERT INTO event_group VALUES (324, 326, 1, '2017-08-10 02:33:44.987692+00', NULL, 1);
INSERT INTO event_group VALUES (325, 327, 1, '2017-08-10 02:48:01.536756+00', NULL, 1);
INSERT INTO event_group VALUES (326, 328, 1, '2017-08-10 02:49:09.092684+00', NULL, 1);
INSERT INTO event_group VALUES (327, 329, 1, '2017-08-10 02:52:56.751033+00', NULL, 1);
INSERT INTO event_group VALUES (328, 330, 1, '2017-08-10 02:56:29.568725+00', NULL, 1);
INSERT INTO event_group VALUES (329, 331, 1, '2017-08-10 02:59:30.704047+00', NULL, 1);
INSERT INTO event_group VALUES (330, 332, 1, '2017-08-10 03:03:38.830367+00', NULL, 1);
INSERT INTO event_group VALUES (331, 333, 1, '2017-08-10 03:04:47.684099+00', NULL, 1);
INSERT INTO event_group VALUES (332, 334, 1, '2017-08-10 03:05:58.256214+00', NULL, 1);
INSERT INTO event_group VALUES (333, 335, 1, '2017-08-10 03:07:09.185876+00', NULL, 1);
INSERT INTO event_group VALUES (334, 336, 1, '2017-08-10 03:09:18.514111+00', NULL, 1);
INSERT INTO event_group VALUES (335, 337, 1, '2017-08-10 03:12:57.546224+00', NULL, 1);
INSERT INTO event_group VALUES (336, 338, 1, '2017-08-10 03:16:51.808921+00', NULL, 1);
INSERT INTO event_group VALUES (337, 339, 1, '2017-08-10 03:17:46.374899+00', NULL, 1);
INSERT INTO event_group VALUES (338, 340, 1, '2017-08-10 03:23:29.449151+00', NULL, 1);
INSERT INTO event_group VALUES (339, 341, 1, '2017-08-10 03:24:49.09628+00', NULL, 1);
INSERT INTO event_group VALUES (340, 342, 1, '2017-08-10 03:25:41.085992+00', NULL, 1);
INSERT INTO event_group VALUES (341, 343, 1, '2017-08-10 03:29:26.542682+00', NULL, 1);
INSERT INTO event_group VALUES (342, 344, 1, '2017-08-10 03:30:14.692204+00', NULL, 1);
INSERT INTO event_group VALUES (343, 345, 1, '2017-08-10 03:31:55.439404+00', NULL, 1);
INSERT INTO event_group VALUES (344, 346, 1, '2017-08-10 03:32:15.676219+00', NULL, 1);
INSERT INTO event_group VALUES (345, 347, 1, '2017-08-10 21:13:24.872318+00', NULL, 1);
INSERT INTO event_group VALUES (346, 348, 1, '2017-08-10 21:16:02.253778+00', NULL, 1);
INSERT INTO event_group VALUES (347, 349, 1, '2017-08-10 21:16:22.513898+00', NULL, 1);
INSERT INTO event_group VALUES (348, 350, 1, '2017-08-10 21:20:49.959153+00', NULL, 1);
INSERT INTO event_group VALUES (349, 351, 1, '2017-08-10 21:30:41.099374+00', NULL, 1);
INSERT INTO event_group VALUES (350, 352, 1, '2017-08-10 21:31:01.266245+00', NULL, 1);
INSERT INTO event_group VALUES (351, 353, 17, '2017-08-11 21:33:14.743022+00', NULL, 3);
INSERT INTO event_group VALUES (352, 354, 17, '2017-08-11 21:33:37.660405+00', NULL, 1);
INSERT INTO event_group VALUES (353, 355, 12, '2017-08-11 22:51:25.826682+00', NULL, 1);
INSERT INTO event_group VALUES (354, 356, 1, '2017-08-12 01:47:25.82405+00', NULL, 1);
INSERT INTO event_group VALUES (355, 357, 1, '2017-08-12 02:14:23.068122+00', NULL, 1);
INSERT INTO event_group VALUES (356, 358, 1, '2017-08-12 02:16:08.652842+00', NULL, 1);
INSERT INTO event_group VALUES (357, 359, 1, '2017-08-12 02:16:38.388247+00', NULL, 1);
INSERT INTO event_group VALUES (358, 360, 1, '2017-08-12 02:17:41.469269+00', NULL, 1);
INSERT INTO event_group VALUES (359, 361, 12, '2017-08-15 15:05:21.38395+00', NULL, 1);
INSERT INTO event_group VALUES (360, 362, 23, '2017-08-15 15:12:45.354542+00', NULL, 1);
INSERT INTO event_group VALUES (361, 363, 22, '2017-08-15 15:13:24.627217+00', NULL, 1);
INSERT INTO event_group VALUES (362, 364, 22, '2017-08-15 15:34:00.672712+00', NULL, 1);
INSERT INTO event_group VALUES (363, 365, 23, '2017-08-15 15:34:48.25705+00', NULL, 1);
INSERT INTO event_group VALUES (364, 366, 1, '2017-08-23 16:11:16.921384+00', NULL, 1);
INSERT INTO event_group VALUES (365, 367, 1, '2017-08-23 16:11:46.987815+00', NULL, 1);
INSERT INTO event_group VALUES (366, 368, 1, '2017-08-24 16:07:05.943288+00', NULL, 1);
INSERT INTO event_group VALUES (367, 369, 1, '2017-08-24 16:07:35.427748+00', NULL, 1);
INSERT INTO event_group VALUES (368, 370, 1, '2017-08-27 02:14:07.891026+00', NULL, 1);
INSERT INTO event_group VALUES (369, 371, 1, '2017-08-27 02:14:42.050985+00', NULL, 1);
INSERT INTO event_group VALUES (370, 372, 1, '2017-08-27 02:18:15.949262+00', NULL, 1);
INSERT INTO event_group VALUES (371, 373, 1, '2017-08-27 02:18:49.053496+00', NULL, 1);
INSERT INTO event_group VALUES (372, 374, 1, '2017-08-27 02:20:35.683971+00', NULL, 1);
INSERT INTO event_group VALUES (373, 375, 1, '2017-08-27 02:21:59.701413+00', NULL, 1);
INSERT INTO event_group VALUES (374, 376, 1, '2017-08-27 02:26:09.776844+00', NULL, 1);
INSERT INTO event_group VALUES (375, 377, 1, '2017-08-27 02:26:40.839937+00', NULL, 1);
INSERT INTO event_group VALUES (376, 378, 1, '2017-08-27 02:40:32.264285+00', NULL, 1);
INSERT INTO event_group VALUES (377, 379, 1, '2017-08-27 02:42:24.631763+00', NULL, 1);
INSERT INTO event_group VALUES (378, 380, 1, '2017-08-27 02:43:01.786266+00', NULL, 1);
INSERT INTO event_group VALUES (379, 381, 1, '2017-08-27 02:55:33.020302+00', NULL, 1);
INSERT INTO event_group VALUES (380, 382, 1, '2017-08-27 02:56:34.838511+00', NULL, 1);
INSERT INTO event_group VALUES (381, 383, 1, '2017-08-27 02:57:26.282418+00', NULL, 1);
INSERT INTO event_group VALUES (382, 384, 1, '2017-08-28 00:41:09.655539+00', NULL, 1);
INSERT INTO event_group VALUES (383, 385, 1, '2017-08-28 00:45:14.308033+00', NULL, 1);
INSERT INTO event_group VALUES (384, 386, 1, '2017-08-28 00:45:47.099768+00', NULL, 1);
INSERT INTO event_group VALUES (385, 387, 1, '2017-08-29 02:53:50.763595+00', NULL, 1);
INSERT INTO event_group VALUES (386, 388, 1, '2017-08-29 02:54:23.918788+00', NULL, 1);
INSERT INTO event_group VALUES (387, 389, 1, '2017-09-09 16:31:39.661648+00', NULL, 1);
INSERT INTO event_group VALUES (388, 390, 12, '2017-09-11 19:29:34.554355+00', NULL, 1);
INSERT INTO event_group VALUES (389, 391, 23, '2017-09-12 19:53:16.119448+00', NULL, 1);
INSERT INTO event_group VALUES (390, 392, 23, '2017-09-12 20:17:54.721837+00', NULL, 1);
INSERT INTO event_group VALUES (391, 393, 23, '2017-09-19 15:08:03.849945+00', NULL, 1);
INSERT INTO event_group VALUES (392, 394, 1, '2017-09-21 02:55:49.771807+00', NULL, 1);
INSERT INTO event_group VALUES (393, 395, 1, '2017-09-21 02:56:23.049173+00', NULL, 1);
INSERT INTO event_group VALUES (394, 396, 1, '2017-09-22 02:26:34.908583+00', NULL, 1);
INSERT INTO event_group VALUES (395, 397, 1, '2017-09-22 02:27:11.171462+00', NULL, 1);
INSERT INTO event_group VALUES (396, 398, 1, '2017-09-22 03:14:49.724991+00', NULL, 1);
INSERT INTO event_group VALUES (397, 399, 1, '2017-09-29 23:10:31.781856+00', NULL, 3);
INSERT INTO event_group VALUES (398, 400, 1, '2017-09-29 23:10:54.533325+00', NULL, 3);
INSERT INTO event_group VALUES (399, 401, 1, '2017-09-29 23:11:25.44752+00', NULL, 3);
INSERT INTO event_group VALUES (400, 402, 1, '2017-09-29 23:24:14.520323+00', NULL, 3);
INSERT INTO event_group VALUES (401, 403, 1, '2017-09-29 23:24:49.265648+00', NULL, 3);
INSERT INTO event_group VALUES (402, 404, 1, '2017-09-29 23:25:49.657976+00', NULL, 3);
INSERT INTO event_group VALUES (403, 405, 1, '2017-09-29 23:32:47.685083+00', NULL, 3);
INSERT INTO event_group VALUES (404, 406, 1, '2017-09-30 00:06:13.672464+00', NULL, 1);
INSERT INTO event_group VALUES (405, 407, 22, '2017-09-30 00:11:22.781522+00', NULL, 1);
INSERT INTO event_group VALUES (406, 408, 22, '2017-09-30 00:13:05.867998+00', NULL, 3);
INSERT INTO event_group VALUES (407, 409, 22, '2017-09-30 00:13:52.574112+00', NULL, 1);
INSERT INTO event_group VALUES (408, 410, 1, '2017-10-01 20:58:16.508501+00', NULL, 1);
INSERT INTO event_group VALUES (409, 411, 1, '2017-10-01 21:00:55.912022+00', NULL, 1);
INSERT INTO event_group VALUES (410, 412, 1, '2017-10-01 21:01:58.782399+00', NULL, 1);
INSERT INTO event_group VALUES (411, 413, 1, '2017-10-01 21:02:44.049313+00', NULL, 1);
INSERT INTO event_group VALUES (412, 414, 1, '2017-10-02 01:03:07.593018+00', NULL, 1);
INSERT INTO event_group VALUES (413, 415, 1, '2017-10-02 15:44:33.007659+00', NULL, 1);
INSERT INTO event_group VALUES (414, 416, 1, '2017-10-02 15:45:14.094999+00', NULL, 1);
INSERT INTO event_group VALUES (415, 417, 1, '2017-10-02 15:54:26.304678+00', NULL, 1);
INSERT INTO event_group VALUES (416, 418, 1, '2017-10-02 16:09:19.667218+00', NULL, 1);
INSERT INTO event_group VALUES (417, 419, 1, '2017-10-02 16:10:07.480842+00', NULL, 1);
INSERT INTO event_group VALUES (418, 420, 1, '2017-10-02 21:46:38.511484+00', NULL, 1);
INSERT INTO event_group VALUES (419, 421, 1, '2017-10-03 14:27:10.705568+00', NULL, 1);
INSERT INTO event_group VALUES (420, 422, 1, '2017-10-03 14:49:45.168214+00', NULL, 1);
INSERT INTO event_group VALUES (421, 423, 1, '2017-10-03 17:23:29.88893+00', NULL, 1);
INSERT INTO event_group VALUES (422, 424, 1, '2017-10-03 17:24:17.242781+00', NULL, 1);
INSERT INTO event_group VALUES (423, 425, 1, '2017-10-03 17:29:08.039943+00', NULL, 1);
INSERT INTO event_group VALUES (424, 426, 1, '2017-10-03 17:29:19.191004+00', NULL, 1);
INSERT INTO event_group VALUES (425, 427, 1, '2017-10-05 16:17:39.572547+00', NULL, 1);
INSERT INTO event_group VALUES (426, 428, 1, '2017-10-10 16:15:45.075044+00', NULL, 1);
INSERT INTO event_group VALUES (427, 429, 1, '2017-10-10 16:16:20.242334+00', NULL, 1);
INSERT INTO event_group VALUES (428, 430, 1, '2017-10-11 16:33:01.943079+00', NULL, 1);
INSERT INTO event_group VALUES (429, 431, 1, '2017-10-11 17:39:30.740402+00', NULL, 1);
INSERT INTO event_group VALUES (430, 432, 1, '2017-10-11 18:14:07.400398+00', NULL, 1);
INSERT INTO event_group VALUES (431, 433, 1, '2017-10-15 23:36:38.549643+00', NULL, 1);
INSERT INTO event_group VALUES (432, 434, 1, '2017-10-15 23:39:27.194044+00', NULL, 1);
INSERT INTO event_group VALUES (433, 435, 1, '2017-10-15 23:40:17.561621+00', NULL, 1);
INSERT INTO event_group VALUES (434, 436, 1, '2017-10-15 23:41:43.307067+00', NULL, 1);
INSERT INTO event_group VALUES (435, 437, 1, '2017-10-16 00:03:04.825767+00', NULL, 1);
INSERT INTO event_group VALUES (436, 438, 1, '2017-10-16 00:19:51.517054+00', NULL, 1);
INSERT INTO event_group VALUES (437, 439, 1, '2017-10-16 00:22:30.529743+00', NULL, 1);
INSERT INTO event_group VALUES (438, 440, 1, '2017-10-16 00:31:23.358895+00', NULL, 1);
INSERT INTO event_group VALUES (439, 441, 1, '2017-10-16 00:56:36.345847+00', NULL, 1);
INSERT INTO event_group VALUES (440, 442, 1, '2017-10-16 00:56:58.59116+00', NULL, 1);
INSERT INTO event_group VALUES (441, 443, 1, '2017-10-16 00:57:21.685276+00', NULL, 1);
INSERT INTO event_group VALUES (442, 444, 1, '2017-10-16 00:57:44.579925+00', NULL, 1);
INSERT INTO event_group VALUES (443, 445, 23, '2017-10-30 18:12:55.991527+00', NULL, 1);
INSERT INTO event_group VALUES (444, 446, 1, '2017-11-09 01:05:43.982239+00', NULL, 1);
INSERT INTO event_group VALUES (445, 447, 1, '2017-11-09 01:39:07.506952+00', NULL, 1);
INSERT INTO event_group VALUES (446, 448, 1, '2017-11-09 19:22:24.453445+00', NULL, 1);
INSERT INTO event_group VALUES (447, 449, 1, '2017-11-09 19:27:55.263501+00', NULL, 1);
INSERT INTO event_group VALUES (448, 450, 1, '2017-11-10 15:53:14.93076+00', NULL, 1);
INSERT INTO event_group VALUES (449, 451, 1, '2017-11-10 15:55:17.204344+00', NULL, 1);
INSERT INTO event_group VALUES (450, 452, 1, '2017-11-10 16:03:33.334766+00', NULL, 1);
INSERT INTO event_group VALUES (451, 453, 1, '2017-11-15 20:01:13.093866+00', NULL, 1);
INSERT INTO event_group VALUES (452, 454, 1, '2017-11-17 17:44:58.811287+00', NULL, 1);
INSERT INTO event_group VALUES (453, 455, 1, '2017-11-17 18:30:24.518089+00', NULL, 1);
INSERT INTO event_group VALUES (454, 456, 1, '2017-11-17 20:42:43.617541+00', NULL, 1);
INSERT INTO event_group VALUES (455, 457, 1, '2017-11-21 05:19:01.147114+00', NULL, 1);
INSERT INTO event_group VALUES (456, 458, 1, '2017-11-26 23:22:31.960694+00', NULL, 1);
INSERT INTO event_group VALUES (457, 459, 1, '2017-12-07 03:31:23.32524+00', NULL, 1);
INSERT INTO event_group VALUES (458, 460, 1, '2017-12-19 21:40:28.830645+00', NULL, 1);
INSERT INTO event_group VALUES (459, 461, 1, '2017-12-19 22:30:30.124162+00', NULL, 1);
INSERT INTO event_group VALUES (460, 462, 1, '2017-12-19 22:33:45.939237+00', NULL, 1);
INSERT INTO event_group VALUES (461, 463, 1, '2017-12-19 22:34:54.804566+00', NULL, 1);
INSERT INTO event_group VALUES (462, 464, 1, '2017-12-19 22:36:06.667485+00', NULL, 1);
INSERT INTO event_group VALUES (463, 465, 1, '2017-12-20 19:24:04.984913+00', NULL, 1);
INSERT INTO event_group VALUES (464, 466, 1, '2018-02-10 13:01:10.723035+00', NULL, 1);
INSERT INTO event_group VALUES (465, 467, 1, '2018-02-10 13:36:12.694305+00', NULL, 1);
INSERT INTO event_group VALUES (466, 468, 1, '2018-02-14 23:54:40.330273+00', NULL, 1);
INSERT INTO event_group VALUES (467, 469, 1, '2018-02-14 23:55:36.711575+00', NULL, 1);
INSERT INTO event_group VALUES (468, 470, 1, '2018-02-14 23:56:34.468807+00', NULL, 1);
INSERT INTO event_group VALUES (469, 471, 1, '2018-02-16 15:45:30.793664+00', NULL, 1);
INSERT INTO event_group VALUES (470, 472, 1, '2018-02-16 17:04:05.583975+00', NULL, 1);
INSERT INTO event_group VALUES (471, 473, 1, '2018-02-16 21:12:38.924823+00', NULL, 1);
INSERT INTO event_group VALUES (472, 474, 1, '2018-02-17 23:31:21.084059+00', NULL, 1);
INSERT INTO event_group VALUES (473, 475, 23, '2018-02-21 19:56:30.867158+00', NULL, 1);
INSERT INTO event_group VALUES (474, 476, 1, '2018-02-22 00:03:57.4924+00', NULL, 1);
INSERT INTO event_group VALUES (475, 477, 12, '2018-02-28 17:08:18.272789+00', NULL, 1);
INSERT INTO event_group VALUES (476, 478, 1, '2018-02-28 17:21:16.766169+00', NULL, 1);
INSERT INTO event_group VALUES (477, 479, 23, '2018-03-18 23:20:51.534887+00', NULL, 1);
INSERT INTO event_group VALUES (478, 480, 1, '2018-03-27 00:13:42.274973+00', NULL, 1);
INSERT INTO event_group VALUES (479, 481, 1, '2018-03-29 22:16:13.848906+00', NULL, 1);
INSERT INTO event_group VALUES (480, 482, 1, '2018-03-29 22:16:46.347929+00', NULL, 1);
INSERT INTO event_group VALUES (481, 483, 1, '2018-03-29 22:17:17.757054+00', NULL, 1);
INSERT INTO event_group VALUES (482, 484, 1, '2018-03-29 22:17:52.771381+00', NULL, 1);
INSERT INTO event_group VALUES (483, 485, 1, '2018-03-30 14:50:42.495447+00', NULL, 1);
INSERT INTO event_group VALUES (484, 486, 1, '2018-03-30 14:58:25.611801+00', NULL, 1);
INSERT INTO event_group VALUES (485, 487, 1, '2018-03-30 14:58:58.57304+00', NULL, 1);
INSERT INTO event_group VALUES (486, 488, 1, '2018-03-30 15:20:56.836798+00', NULL, 1);
INSERT INTO event_group VALUES (487, 489, 1, '2018-03-31 00:55:47.001058+00', NULL, 1);
INSERT INTO event_group VALUES (488, 490, 1, '2018-04-02 18:39:23.143488+00', NULL, 1);
INSERT INTO event_group VALUES (489, 491, 1, '2018-04-02 18:39:55.377726+00', NULL, 1);
INSERT INTO event_group VALUES (490, 492, 1, '2018-04-02 18:40:27.874353+00', NULL, 1);
INSERT INTO event_group VALUES (491, 493, 1, '2018-04-03 14:08:05.852969+00', NULL, 1);


--
-- Name: event_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbri_devnexus
--

SELECT pg_catalog.setval('event_group_id_seq', 491, true);


--
-- Name: event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbri_devnexus
--

SELECT pg_catalog.setval('event_id_seq', 493, true);


--
-- Data for Name: event_recur; Type: TABLE DATA; Schema: public; Owner: northbri_devnexus
--

INSERT INTO event_recur VALUES (221, 'weekly', 3, '2017-01-18 13:30:00+00');
INSERT INTO event_recur VALUES (222, 'weekdays', 8, '2018-01-08 07:30:00+00');
INSERT INTO event_recur VALUES (223, 'weekdays', 8, '2018-01-08 07:30:00+00');
INSERT INTO event_recur VALUES (224, 'daily', 8, '2017-03-07 15:30:00+00');
INSERT INTO event_recur VALUES (225, 'daily', 8, '2017-03-07 15:30:00+00');
INSERT INTO event_recur VALUES (226, 'daily', 8, '2017-04-06 13:00:00+00');
INSERT INTO event_recur VALUES (227, 'daily', 8, '2017-04-06 13:00:00+00');
INSERT INTO event_recur VALUES (228, 'daily', 8, '2017-04-06 13:00:00+00');
INSERT INTO event_recur VALUES (229, 'daily', 2, '2017-08-17 13:00:00+00');


--
-- Name: event_recur_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbri_devnexus
--

SELECT pg_catalog.setval('event_recur_id_seq', 229, true);


--
-- Data for Name: forum_poll; Type: TABLE DATA; Schema: public; Owner: northbri_devnexus
--

INSERT INTO forum_poll VALUES ('2017-05-04 18:45:01.553944+00', '2017-06-13 17:15:02.17846+00', '2017-06-13 17:15:02.326444+00');


--
-- Data for Name: forum_user; Type: TABLE DATA; Schema: public; Owner: northbri_devnexus
--

INSERT INTO forum_user VALUES (72, 176, 'lou', 'lou1', 'lou lou', 'coach.lou@northbridgetech.org');
INSERT INTO forum_user VALUES (79, 184, 'jj', 'abc123', 'jj jj', '184.jafar.ahmad.71@gmail.com');
INSERT INTO forum_user VALUES (120, 225, 'Elizabeth', 'turtle67', 'Elizabeth Eckhardt', 'auntizzie22@yahoo.com');
INSERT INTO forum_user VALUES (121, 226, 'Will', '4lst()N', 'Will Alston', 'wjalston2@yahoo.com');
INSERT INTO forum_user VALUES (12, 88, 'Administrator', 'admin', 'Administrator', 'kathy.flint@northbridgetech.org');
INSERT INTO forum_user VALUES (70, 174, 'Gretchen', 'helloworld', 'Gretchen Saylor', 'gretchen.saylor@gmail.com');
INSERT INTO forum_user VALUES (127, 232, 'kdf', 'LjPPk995%', 'kdf Test1', '232.kathy.flint@northbridgetech.org');
INSERT INTO forum_user VALUES (128, 233, 'kdf', 'LjPPk995%', 'kdf Test2', 'kathy.d.flint@gmail.com');
INSERT INTO forum_user VALUES (129, 234, 'kdf', 'LjPPk995%', 'kdf Test3', '234.kathy.flint@northbridgetech.org');
INSERT INTO forum_user VALUES (143, 248, 'kdf', 'LjPPk995%', 'kdf Test4', 'ksflint@comcast.net');


--
-- Name: forum_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbri_devnexus
--

SELECT pg_catalog.setval('forum_user_id_seq', 146, true);


--
-- Data for Name: group; Type: TABLE DATA; Schema: public; Owner: northbri_devnexus
--

INSERT INTO "group" VALUES (5, 'Antiracism Committee', 'Ths group is formed to evaluate the Nexus product for use by the Antiracism Committee.', '2015-07-23 21:06:31.893474+00', NULL, NULL, NULL, '', '11111111', NULL);
INSERT INTO "group" VALUES (2, 'Nexus Pilot User Group', 'Ths group is formed to evaluate the Nexus product for widespread use in the Episcopal Diocese of Chicago.', '2015-07-23 21:06:31.893474+00', NULL, NULL, NULL, '', '22222222', NULL);
INSERT INTO "group" VALUES (1, 'Training Workgroup', 'This group exists to demonstrate Nexus features.', '2015-07-23 21:06:31.893474+00', NULL, NULL, NULL, 'src="image/demo.jpg" height="120" width="120"', '33333333', NULL);
INSERT INTO "group" VALUES (6, 'The Test Group', NULL, '2015-09-09 23:38:07.705562+00', NULL, '2015-09-09 23:38:07.705562+00', NULL, '', '4449e711', NULL);
INSERT INTO "group" VALUES (10, 'The Sunflower Foundation (Australia) Inc.', NULL, '2015-09-11 15:45:05.381419+00', NULL, '2015-09-11 15:45:05.381419+00', NULL, '', '54fc6c40', NULL);
INSERT INTO "group" VALUES (12, 'Nexus Web Meet Demonstration', NULL, '2015-10-05 18:22:48.157134+00', NULL, '2015-10-05 18:22:48.157134+00', NULL, '', '0c442176', NULL);
INSERT INTO "group" VALUES (16, 'Public Group', 'This group is a placeholder for public c2007e9b', '2015-12-16 02:16:42.841082+00', NULL, '2015-12-16 02:16:42.841082+00', NULL, '', 'e6b56f36', NULL);
INSERT INTO "group" VALUES (15, 'Public Group', 'This group is a placeholder for public userdemo', '2015-12-16 02:13:28.226979+00', NULL, '2015-12-16 02:13:28.226979+00', NULL, '', '40f9ee6e', NULL);
INSERT INTO "group" VALUES (17, 'Public Group', 'This group allows public widget access for 87654321', '2016-01-18 19:20:40.440965+00', NULL, '2016-01-18 19:20:40.440965+00', NULL, NULL, '3d621973', NULL);
INSERT INTO "group" VALUES (18, 'Hunger Committee 2', NULL, '2016-05-10 19:42:05.611542+00', NULL, '2016-05-10 19:42:05.611542+00', NULL, '', '5ae96742', NULL);
INSERT INTO "group" VALUES (13, 'Public Group', 'This group is a placeholder for publicly visible things', '2015-11-10 13:07:43.058448+00', NULL, '2015-11-10 13:07:43.058448+00', NULL, '', '5d0754e7', NULL);
INSERT INTO "group" VALUES (19, 'Peace and Justice Committee', NULL, '2016-05-10 20:38:53.067673+00', NULL, '2016-05-10 20:38:53.067673+00', NULL, '', '31eb65fb', NULL);
INSERT INTO "group" VALUES (20, 'Trauma Informed Congregations Network', NULL, '2017-01-30 19:07:50.361884+00', NULL, '2017-01-30 19:07:50.361884+00', NULL, '', 'bf3ddd1c', NULL);
INSERT INTO "group" VALUES (21, 'Public Group', NULL, '2017-02-12 21:34:48.330761+00', NULL, '2017-02-12 21:34:48.330761+00', NULL, '', '2c4bf311', NULL);
INSERT INTO "group" VALUES (23, 'Network Group', NULL, '2017-02-26 15:29:09.238508+00', NULL, '2017-02-26 15:29:09.238508+00', NULL, '', 'a09908ad', NULL);
INSERT INTO "group" VALUES (24, 'Test NWM Automate Onboard', NULL, '2017-03-02 23:44:21.466103+00', NULL, '2017-03-02 23:44:21.466103+00', NULL, '', 'd90b3092', NULL);
INSERT INTO "group" VALUES (22, 'We Love Cats Public Enrolleable Group', NULL, '2017-02-26 15:18:11.521753+00', NULL, '2017-02-26 15:18:11.521753+00', NULL, '', '34giodty', NULL);
INSERT INTO "group" VALUES (25, 'Test Crm #1', NULL, '2017-07-20 00:41:28.525521+00', NULL, '2017-07-20 00:41:28.525521+00', NULL, '', 'c9a67fdf', NULL);
INSERT INTO "group" VALUES (26, 'Test Crm #1', NULL, '2017-07-20 00:42:21.988768+00', NULL, '2017-07-20 00:42:21.988768+00', NULL, '', '440eef31', NULL);
INSERT INTO "group" VALUES (27, 'Test Crm #2', NULL, '2017-07-20 00:52:01.849753+00', NULL, '2017-07-20 00:52:01.849753+00', NULL, '', '55c2008c', NULL);
INSERT INTO "group" VALUES (28, 'Test Crm #3', NULL, '2017-07-20 00:55:28.138095+00', NULL, '2017-07-20 00:55:28.138095+00', NULL, '', '9710c78a', NULL);
INSERT INTO "group" VALUES (29, 'Test Crm #4', NULL, '2017-07-20 01:22:16.830908+00', NULL, '2017-07-20 01:22:16.830908+00', NULL, '', '76266584', NULL);
INSERT INTO "group" VALUES (30, 'Test Crm #5', NULL, '2017-07-20 02:31:33.934064+00', NULL, '2017-07-20 02:31:33.934064+00', NULL, '', 'a21cdf24', NULL);
INSERT INTO "group" VALUES (31, 'Test Crm #6', NULL, '2017-07-20 02:56:56.483997+00', NULL, '2017-07-20 02:56:56.483997+00', NULL, '', '2015475f', NULL);
INSERT INTO "group" VALUES (32, 'Test Crm #6', NULL, '2017-07-26 19:17:58.577403+00', NULL, '2017-07-26 19:17:58.577403+00', NULL, '', '19313469', NULL);
INSERT INTO "group" VALUES (33, 'My Committee', NULL, '2017-07-26 19:28:10.193003+00', NULL, '2017-07-26 19:28:10.193003+00', NULL, '', '3a9f8d41', NULL);


--
-- Name: group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbri_devnexus
--

SELECT pg_catalog.setval('group_id_seq', 33, true);


--
-- Data for Name: invitation; Type: TABLE DATA; Schema: public; Owner: northbri_devnexus
--

INSERT INTO invitation VALUES (45, 'd91c8ecf-34a1-2ea5-94de-7464d10a8617', 'enroll1@test.com', '2015-08-10 03:12:36.515138+00', NULL, NULL, '2015-08-10 03:12:36.515138+00', 4, '2015-09-09', 234, 'single', 330, 1);
INSERT INTO invitation VALUES (46, '6a036914-953b-08fc-2766-51b558dd657e', 'kathy.flint@northbridgetech.org', '2015-08-10 03:13:49.80161+00', '2015-08-10 03:21:26.686342+00', NULL, '2015-08-10 03:13:49.80161+00', 5, '2015-09-09', 234, 'single', 330, 1);
INSERT INTO invitation VALUES (48, 'e58ccd5b-f710-66d4-9b64-6367bbc574c1', 'kathy.d.flint@gmail.com', '2015-08-10 03:34:03.990405+00', '2015-08-10 03:34:44.751469+00', NULL, '2015-08-10 03:34:03.990405+00', 5, '2015-09-09', 234, 'single', 330, 1);
INSERT INTO invitation VALUES (52, '672623dd-e36f-b7ac-324a-fe92d10fc6ac', 'kenneth.cavness@gmail.com', '2015-08-12 22:28:41.211543+00', '2015-08-12 23:53:26.990114+00', NULL, '2015-08-12 22:28:41.211543+00', 5, '2015-09-12', 232, 'single', 330, 1);
INSERT INTO invitation VALUES (49, '4ddc2184-a5d6-4eec-4720-d8eae7249ee1', 'kenneth.cavness@gmail.com', '2015-08-12 22:24:30.455292+00', '2015-08-12 23:55:04.179537+00', NULL, '2015-08-12 22:24:30.455292+00', 5, '2015-09-12', 232, 'single', 330, 1);
INSERT INTO invitation VALUES (50, '8335bf49-063b-454d-77b0-4d38ff56acdc', 'kenneth.cavness@gmail.com', '2015-08-12 22:24:55.72287+00', '2015-08-12 23:55:56.881561+00', NULL, '2015-08-12 22:24:55.72287+00', 5, '2015-09-12', 232, 'single', 330, 1);
INSERT INTO invitation VALUES (51, 'a7f1c64d-b3d2-d92c-3ab5-858313d58965', 'kenneth.cavness@gmail.com', '2015-08-12 22:25:24.274523+00', '2015-08-12 23:56:40.019545+00', NULL, '2015-08-12 22:25:24.274523+00', 5, '2015-09-12', 232, 'single', 330, 1);
INSERT INTO invitation VALUES (53, 'e2ec669d-66a5-79fb-398e-78f9076f79cf', 'kenneth.cavness@gmail.com', '2015-08-12 23:58:24.646413+00', '2015-08-13 00:00:00.824272+00', NULL, '2015-08-12 23:58:24.646413+00', 4, '2015-09-12', 232, 'single', 330, 1);
INSERT INTO invitation VALUES (54, 'd4e57dc6-5abe-5ec4-5cf0-92beb0abc953', 'kenneth.cavness@gmail.com', '2015-08-13 00:02:37.411741+00', '2015-08-13 00:10:51.158832+00', NULL, '2015-08-13 00:02:37.411741+00', 5, '2015-09-12', 232, 'single', 330, 1);
INSERT INTO invitation VALUES (55, 'e17fdb4a-7f79-956b-aa0f-8c60e18b2ffb', 'gretchen.saylor@gmail.com', '2015-08-17 00:55:19.066437+00', '2015-08-17 00:57:17.813791+00', NULL, '2015-08-17 00:55:19.066437+00', 4, '2015-09-16', 232, 'single', 330, 1);
INSERT INTO invitation VALUES (56, '94e30822-02b4-5168-8597-85f78881c4b2', 'kathy.flint@northbridgetech.org', '2015-08-31 20:42:51.656724+00', '2015-08-31 20:49:51.740187+00', NULL, '2015-08-31 20:42:51.656724+00', 4, '2015-10-01', 234, 'single', 330, 1);
INSERT INTO invitation VALUES (57, '7b2f9dd0-f3c2-a108-771f-935259f170dd', 'gretchen.manthey@gmail.com', '2015-09-01 15:12:38.615984+00', NULL, NULL, '2015-09-01 15:12:38.615984+00', 5, '2015-08-31', 260, 'single', 330, 1);
INSERT INTO invitation VALUES (58, '6b57e45e-4374-bbbf-76bf-40f291d93da9', 'gretchen.manthey@gmail.com', '2015-09-01 15:13:21.594616+00', NULL, NULL, '2015-09-01 15:13:21.594616+00', 5, '2015-08-31', 260, 'single', 330, 1);
INSERT INTO invitation VALUES (59, '556f806e-4b59-b57f-ac83-e0fb5fb7dd54', 'gretchen.manthey@gmail.com', '2015-09-01 15:15:54.677207+00', NULL, NULL, '2015-09-01 15:15:54.677207+00', 5, '2015-08-31', 260, 'single', 330, 1);
INSERT INTO invitation VALUES (60, 'f9785738-5f9a-b39c-743e-7243720dd9f3', 'gretchen.manthey@gmail.com', '2015-09-01 15:16:22.779291+00', NULL, NULL, '2015-09-01 15:16:22.779291+00', 5, '2015-08-31', 260, 'single', 330, 1);
INSERT INTO invitation VALUES (61, 'e1accba3-f8b0-c6ec-a92c-565e92fbb778', 'gretchen.manthey@gmail.com', '2015-09-01 20:16:17.350646+00', '2015-09-01 20:20:45.630651+00', NULL, '2015-09-01 20:16:17.350646+00', 5, '2015-10-02', 260, 'single', 330, 1);
INSERT INTO invitation VALUES (63, 'b21cd16c-6bb4-b581-d6e0-e2f050626070', 'kenneth.cavness@gmail.com', '2015-09-01 23:12:18.151587+00', '2015-09-01 23:13:31.523393+00', NULL, '2015-09-01 23:12:18.151587+00', 5, '2015-10-02', 232, 'single', 330, 1);
INSERT INTO invitation VALUES (64, 'c8ae8977-0dd6-5b06-1838-6ad573ed4766', 'kenneth.cavness@gmail.com', '2015-09-01 23:14:46.559995+00', '2015-09-01 23:15:16.618435+00', NULL, '2015-09-01 23:14:46.559995+00', 5, '2015-10-02', 232, 'single', 330, 1);
INSERT INTO invitation VALUES (65, '0d45071b-dcab-8a6e-c953-c6a6d6b9fbe2', 'kenneth.cavness@gmail.com', '2015-09-01 23:32:00.770163+00', '2015-09-01 23:32:31.328675+00', NULL, '2015-09-01 23:32:00.770163+00', 5, '2015-10-02', 232, 'single', 330, 1);
INSERT INTO invitation VALUES (66, '3498d7d9-1bde-bf24-9c27-b507a9da1fc8', 'kathy.flint@northbridgetech.org', '2015-09-03 00:21:49.784363+00', '2015-09-03 00:22:21.979581+00', NULL, '2015-09-03 00:21:49.784363+00', 5, '2015-10-03', 234, 'single', 330, 1);
INSERT INTO invitation VALUES (47, '894847c8-5d89-394a-79a7-21dfdcf39e80', 'kathy.d.flint@gmail.com', '2015-08-10 03:30:56.05799+00', NULL, NULL, '2015-08-10 03:30:56.05799+00', 5, '2015-09-01', 234, 'single', 330, 1);
INSERT INTO invitation VALUES (62, '428c2bd0-af95-0707-6b03-6faab07382f1', 'gretchen.manthey@gmail.com', '2015-09-01 20:24:11.563702+00', NULL, NULL, '2015-09-01 20:24:11.563702+00', 5, '2015-09-02', 260, 'single', 330, 1);
INSERT INTO invitation VALUES (67, 'ae488ea5-c855-3551-90ee-0d92a58c77db', 'gretchen.manthey@gmail.com', '2015-09-03 17:43:19.74935+00', NULL, NULL, '2015-09-03 17:43:19.74935+00', 5, '2015-09-02', 260, 'single', 330, 1);
INSERT INTO invitation VALUES (68, '5c2a0947-fc59-c124-dade-18e840580bea', 'gretchiesprite@gmail.com', '2015-09-03 17:47:36.094929+00', NULL, NULL, '2015-09-03 17:47:36.094929+00', 5, '2015-09-02', 260, 'single', 330, 1);
INSERT INTO invitation VALUES (70, '06f0ef9e-1e28-884e-c9c7-ae66fc66f466', 'shannon.cochran@northbridgetech.org', '2015-09-09 16:28:03.200017+00', '2015-09-09 16:48:43.281046+00', NULL, '2015-09-09 16:28:03.200017+00', 4, '2015-10-10', 234, 'single', 330, 1);
INSERT INTO invitation VALUES (74, 'a3248810-d512-e4f2-1c35-29e35be91930', 'kathy.flint@northbridgetech.org', '2015-09-09 23:30:01.257583+00', '2015-09-11 15:07:06.332448+00', NULL, '2015-09-09 23:30:01.257583+00', 5, '2015-10-10', 234, 'single', 330, 1);
INSERT INTO invitation VALUES (84, '0c0f09d0-9a3b-7cae-556e-5b9a39e09a3e', 'angelica.c.flint@gmail.com', '2015-09-11 17:53:05.50831+00', '2015-09-11 17:53:59.240528+00', NULL, '2015-09-11 17:53:05.50831+00', 4, '2015-10-12', 273, 'single', 332, 10);
INSERT INTO invitation VALUES (73, 'a42f29df-4205-41a6-b591-c03bf57e3592', 'ksflint@comcast.net', '2015-09-09 23:27:55.737797+00', '2015-09-11 15:24:43.10088+00', NULL, '2015-09-09 23:27:55.737797+00', 5, '2015-11-10', 234, 'single', 331, 6);
INSERT INTO invitation VALUES (75, '43afb3cd-31b5-477e-b636-945d88a8a9d9', 'angelica.c.flint@gmail.com', '2015-09-11 15:48:51.459708+00', '2015-09-11 15:57:56.927966+00', NULL, '2015-09-11 15:48:51.459708+00', 4, '2015-10-12', 85, 'single', 332, 10);
INSERT INTO invitation VALUES (76, '871a261e-a2ec-05a4-b9e9-ca50dc39f927', 'angelica.d.flint@gmail.com', '2015-09-11 16:11:43.925492+00', NULL, NULL, '2015-09-11 16:11:43.925492+00', 4, '2015-09-10', 273, 'single', 332, 10);
INSERT INTO invitation VALUES (77, 'a1d56bc0-68f8-631c-e2e9-6ec95a701393', 'angelica.c.flint@gmail.com', '2015-09-11 16:18:03.022697+00', '2015-09-11 16:19:13.567225+00', NULL, '2015-09-11 16:18:03.022697+00', 5, '2015-10-12', 273, 'single', 332, 10);
INSERT INTO invitation VALUES (78, '087e6457-bcaa-e677-7830-a6aaa46e5159', 'angelica.c.flint@gmail.com', '2015-09-11 17:07:51.90896+00', NULL, NULL, '2015-09-11 17:07:51.90896+00', 5, '2015-09-10', 273, 'single', 332, 10);
INSERT INTO invitation VALUES (79, '27b94e43-745c-d76e-7eeb-da7abf396392', 'angelica.c.flint@gmail.com', '2015-09-11 17:14:59.31589+00', NULL, NULL, '2015-09-11 17:14:59.31589+00', 5, '2015-09-10', 274, 'single', 332, 10);
INSERT INTO invitation VALUES (80, '9e4350a9-714d-20b4-e4bf-5ec9fb61be5e', 'angelica.c.flint@gmail.com', '2015-09-11 17:28:12.389479+00', '2015-09-11 17:31:33.205088+00', NULL, '2015-09-11 17:28:12.389479+00', 5, '2015-10-12', 273, 'single', 332, 10);
INSERT INTO invitation VALUES (81, '5d67a633-411e-12e7-7137-e515c69c60d4', 'angelica.c.flint@gmail.com', '2015-09-11 17:35:36.044506+00', '2015-09-11 17:36:21.792406+00', NULL, '2015-09-11 17:35:36.044506+00', 5, '2015-10-12', 273, 'single', 332, 10);
INSERT INTO invitation VALUES (89, '9c0c3e62-e852-1451-3cb3-fc5a9e5e71e5', 'angelica.c.flint@gmail.com', '2015-09-11 18:31:52.612343+00', '2015-09-11 18:33:00.6169+00', NULL, '2015-09-11 18:31:52.612343+00', 5, '2015-10-12', 273, 'single', 332, 10);
INSERT INTO invitation VALUES (90, '5dcd0d58-99ac-a0a2-d60b-bad0348b022a', 'angelica.c.flint@gmail.com', '2015-09-11 18:35:28.281657+00', '2015-09-11 18:36:17.88528+00', NULL, '2015-09-11 18:35:28.281657+00', 5, '2015-10-12', 273, 'single', 332, 10);
INSERT INTO invitation VALUES (82, '143f17b7-98b5-cfb7-32cd-575ba5bdcf22', 'angelica.c.flint@gmail.com', '2015-09-11 17:38:32.607879+00', NULL, NULL, '2015-09-11 17:38:32.607879+00', 5, '2015-09-10', 273, 'single', 332, 10);
INSERT INTO invitation VALUES (83, 'c62d05e7-4283-9a86-809c-7a0772c5409b', 'angelica.c.flint@gmail.com', '2015-09-11 17:44:54.399294+00', NULL, NULL, '2015-09-11 17:44:54.399294+00', 5, '2015-09-10', 273, 'single', 332, 10);
INSERT INTO invitation VALUES (85, 'e8e4e8e8-19d7-38e7-5257-2ce732df4c3e', 'angelica.c.flint@gmail.com', '2015-09-11 18:08:35.835499+00', '2015-09-11 18:09:45.647107+00', NULL, '2015-09-11 18:08:35.835499+00', 5, '2015-10-12', 273, 'single', 332, 10);
INSERT INTO invitation VALUES (86, '9c0a9e34-4fe5-712a-286c-27d55ca515bc', 'angelica.c.flint@gmail.com', '2015-09-11 18:13:52.163886+00', '2015-09-11 18:14:38.038347+00', NULL, '2015-09-11 18:13:52.163886+00', 5, '2015-10-12', 273, 'single', 332, 10);
INSERT INTO invitation VALUES (87, 'defe5121-b45d-278c-ed36-f37c31eacc68', 'angelica.c.flint@gmail.com', '2015-09-11 18:17:41.68698+00', '2015-09-11 18:18:44.169629+00', NULL, '2015-09-11 18:17:41.68698+00', 5, '2015-10-12', 273, 'single', 332, 10);
INSERT INTO invitation VALUES (88, 'c8aef155-fd49-ad21-9833-0fda59c0d90a', 'angelica.c.flint@gmail.com', '2015-09-11 18:25:26.233799+00', '2015-09-11 18:26:17.593738+00', NULL, '2015-09-11 18:25:26.233799+00', 5, '2015-10-12', 273, 'single', 332, 10);
INSERT INTO invitation VALUES (91, 'e49f6708-a5d2-fef3-abb6-76673402b38a', 'angelica.c.flint@gmail.com', '2015-09-11 18:38:34.955857+00', '2015-09-11 18:40:41.450729+00', NULL, '2015-09-11 18:38:34.955857+00', 5, '2015-10-12', 273, 'single', 332, 10);
INSERT INTO invitation VALUES (92, 'dabcc26a-22c1-b93b-71e2-7619f6897df2', 'bryce.m.flint@gmail.com', '2015-09-11 18:39:57.847739+00', '2015-09-11 18:45:40.132361+00', NULL, '2015-09-11 18:39:57.847739+00', 5, '2015-10-12', 273, 'single', 332, 10);
INSERT INTO invitation VALUES (94, 'd41b9825-9826-19e7-df4a-a6a9af046caa', 'kathy.flint@northbridgetech.org', '2015-09-11 21:36:25.486303+00', NULL, NULL, '2015-09-11 21:36:25.486303+00', 5, '2015-09-10', 234, 'single', 330, 1);
INSERT INTO invitation VALUES (93, 'd9975ba7-a0fa-dc24-3ecc-c7ada49daa5f', 'angelica.c.flint@gmail.com', '2015-09-11 18:59:38.802832+00', '2015-09-11 19:04:11.50276+00', NULL, '2015-09-11 18:59:38.802832+00', 5, '2015-10-12', 273, 'single', 332, 10);
INSERT INTO invitation VALUES (95, 'ac677e8c-b79b-1e8d-a62c-4ec5303018ee', 'kathy.flint@northbridgetech.org', '2015-09-11 21:38:47.090752+00', NULL, NULL, '2015-09-11 21:38:47.090752+00', 5, '2015-09-10', 234, 'single', 330, 1);
INSERT INTO invitation VALUES (96, '85ae50f6-9c69-b9b4-e26d-b19e20e4bd9a', 'kathy.flint@northbridgetech.org', '2015-09-11 21:40:34.655279+00', NULL, NULL, '2015-09-11 21:40:34.655279+00', 5, '2015-09-10', 273, 'single', 332, 10);
INSERT INTO invitation VALUES (97, 'a9b908bd-a253-72f8-0475-b3b9c72aad01', 'kathy.flint@northbridgetech.org', '2015-09-11 21:43:10.122285+00', '2015-09-12 20:06:16.326852+00', NULL, '2015-09-11 21:43:10.122285+00', 5, '2015-10-12', 273, 'single', 332, 10);
INSERT INTO invitation VALUES (98, '39757c57-b82d-aa81-af32-e48203493b76', 'kathy.flint@northbridgetech.org', '2015-09-14 21:50:58.855988+00', NULL, NULL, '2015-09-14 21:50:58.855988+00', 5, '2015-09-13', 234, 'single', 330, 1);
INSERT INTO invitation VALUES (99, 'fde597dc-c02c-4ce5-cd88-efd3da18fae2', 'kathy.flint@northbridgetech.org', '2015-09-14 21:51:14.189278+00', NULL, NULL, '2015-09-14 21:51:14.189278+00', 5, '2015-09-13', 234, 'single', 330, 1);
INSERT INTO invitation VALUES (101, 'c734e59f-ef75-9402-e065-bd2ce0bcd61e', 'kathy.flint@northbridgetech.org', '2015-09-14 21:57:03.333548+00', NULL, NULL, '2015-09-14 21:57:03.333548+00', 5, '2015-09-13', 234, 'single', 330, 1);
INSERT INTO invitation VALUES (69, '40a05835-2189-dd8c-87db-b03c9133924a', 'gretchen.manthey@gmail.com', '2015-09-03 17:48:00.043021+00', NULL, NULL, '2015-09-03 17:48:00.043021+00', 5, '2015-09-23', 260, 'single', 330, 1);
INSERT INTO invitation VALUES (100, '45ca3f1a-38f3-c86b-a6cd-d02d6de00bca', 'kathy.flint@northbridgetech.org', '2015-09-14 21:56:50.623183+00', NULL, NULL, '2015-09-14 21:56:50.623183+00', 5, '2015-09-13', 234, 'single', 330, 1);
INSERT INTO invitation VALUES (102, '80a16306-028b-81ac-9f1f-5f917ed8d7ce', 'kathy.flint@northbridgetech.org', '2015-09-14 21:58:23.689099+00', NULL, NULL, '2015-09-14 21:58:23.689099+00', 5, '2015-09-13', 234, 'single', 330, 1);
INSERT INTO invitation VALUES (103, '7c753613-11d9-9daa-6c25-fc156fc7139e', 'kathy.flint@northbridgetech.org', '2015-09-14 21:58:31.46706+00', NULL, NULL, '2015-09-14 21:58:31.46706+00', 5, '2015-09-13', 234, 'single', 330, 1);
INSERT INTO invitation VALUES (104, 'b69554ed-cf2d-d26f-c295-9c58d37fb18b', 'gretchen.saylor@northbridgetech.org', '2015-09-25 01:53:24.670639+00', NULL, NULL, '2015-09-25 01:53:24.670639+00', 5, '2015-09-23', 260, 'single', 330, 1);
INSERT INTO invitation VALUES (105, 'ad76766f-8946-437b-9bd0-b88939d5207f', '', '2015-10-04 00:26:18.069863+00', '2015-10-04 00:28:42.864198+00', NULL, '2015-10-04 00:26:18.069863+00', 4, '2015-11-03', 88, 'single', 331, 6);
INSERT INTO invitation VALUES (107, 'fa116fa0-5b8a-4356-bd36-1934963330e3', '', '2015-10-05 18:24:06.886235+00', '2015-10-05 18:25:49.101031+00', NULL, '2015-10-05 18:24:06.886235+00', 4, '2015-11-05', 88, 'single', 333, 12);
INSERT INTO invitation VALUES (108, '835c2ced-76e8-44df-aa41-366f07acfb5c', '', '2015-10-05 18:33:19.441894+00', '2015-10-05 18:34:32.045809+00', NULL, '2015-10-05 18:33:19.441894+00', 4, '2015-11-05', 88, 'single', 333, 12);
INSERT INTO invitation VALUES (109, '4ea91884-6367-4f6c-9b70-208a6300063e', '', '2015-10-05 18:33:19.441894+00', '2015-10-05 18:40:05.201267+00', NULL, '2015-10-05 18:33:19.441894+00', 4, '2015-11-05', 88, 'single', 333, 12);
INSERT INTO invitation VALUES (110, 'bf5901d3-06e5-4c04-9eb2-4053d8448fdf', '', '2015-10-05 18:33:19.441894+00', '2015-10-05 18:42:54.46372+00', NULL, '2015-10-05 18:33:19.441894+00', 5, '2015-11-05', 88, 'single', 333, 12);
INSERT INTO invitation VALUES (111, 'abb827b5-9c2e-4bf5-bbf1-20daf18290d6', '', '2015-10-05 18:33:19.441894+00', '2015-10-05 18:44:27.977426+00', NULL, '2015-10-05 18:33:19.441894+00', 5, '2015-11-05', 88, 'single', 333, 12);
INSERT INTO invitation VALUES (112, 'cbb827b5-9c2e-4bf5-bbf1-20daf18290d6', '', '2015-10-05 19:34:36.863595+00', '2015-10-05 19:35:50.505152+00', NULL, '2015-10-05 19:34:36.863595+00', 5, '2015-11-05', 88, 'single', 333, 12);
INSERT INTO invitation VALUES (113, '3b3c796d-480a-8287-1279-0a24715ce704', 'kathy.flint@northbridgetech.org', '2015-10-06 20:47:33.943473+00', '2015-10-06 20:55:20.168143+00', NULL, '2015-10-06 20:47:33.943473+00', 5, '2015-11-06', 234, 'single', 330, 1);
INSERT INTO invitation VALUES (114, 'd5e67a18-57f2-941e-a896-d3b5e3101a6f', 'kenneth.cavness@gmail.com', '2015-10-25 17:40:47.626883+00', '2015-10-25 17:41:18.750757+00', NULL, '2015-10-25 17:40:47.626883+00', 5, '2015-11-25', 232, 'single', 330, 1);
INSERT INTO invitation VALUES (115, 'fcc5b96d-6599-8df2-8b95-d5d61d4f5661', 'kenneth.cavness@gmail.com', '2015-10-25 17:41:48.906246+00', '2015-10-25 17:42:24.367127+00', NULL, '2015-10-25 17:41:48.906246+00', 5, '2015-11-25', 232, 'single', 330, 1);
INSERT INTO invitation VALUES (116, '46c31813-9ea5-dc6d-0b72-b23f3c72111e', 'kenneth.cavness@gmail.com', '2015-10-25 17:43:59.614019+00', '2015-10-25 17:45:11.204438+00', NULL, '2015-10-25 17:43:59.614019+00', 5, '2015-11-25', 232, 'single', 330, 1);
INSERT INTO invitation VALUES (117, 'f5de5ba9-cf9d-c502-63df-d98194951082', 'gretchen.saylor@gmail.com', '2015-10-26 01:10:56.472673+00', '2015-10-26 01:12:36.450283+00', NULL, '2015-10-26 01:10:56.472673+00', 5, '2015-11-25', 260, 'single', 330, 1);
INSERT INTO invitation VALUES (118, '55dc965a-403b-2a22-f0c2-4a8d807cf084', 'gretchen.saylor@gmail.com', '2015-10-26 01:13:31.127928+00', '2015-10-26 01:15:06.459584+00', NULL, '2015-10-26 01:13:31.127928+00', 5, '2015-11-25', 260, 'single', 330, 1);
INSERT INTO invitation VALUES (119, 'd6a88940-7428-2cf7-2ffb-b1510df3c5bd', 'gretchen.saylor@gmail.com', '2015-10-26 01:18:39.380548+00', '2015-10-26 01:19:55.713627+00', NULL, '2015-10-26 01:18:39.380548+00', 5, '2015-11-25', 260, 'single', 330, 1);
INSERT INTO invitation VALUES (120, 'b3870fc5-6049-ff60-835d-9274cc14629d', 'gretchen.saylor@gmail.com', '2015-10-26 01:25:58.765733+00', NULL, NULL, '2015-10-26 01:25:58.765733+00', 5, '2015-10-24', 260, 'single', 330, 1);
INSERT INTO invitation VALUES (121, 'c28fc7ce-0a9d-2525-ecea-6c921c96d9a5', 'gretchen.saylor@gmail.com', '2015-10-26 01:46:41.241671+00', '2015-10-26 01:48:22.238893+00', NULL, '2015-10-26 01:46:41.241671+00', 5, '2015-11-25', 260, 'single', 330, 1);
INSERT INTO invitation VALUES (122, 'b9dac6cf-fbd5-ccfe-fcde-79f6b1f1d4cd', 'kenneth.cavness@gmail.com', '2015-11-19 01:11:03.837411+00', '2015-11-19 01:12:28.653883+00', NULL, '2015-11-19 01:11:03.837411+00', 4, '2015-12-19', 232, 'single', 330, 1);
INSERT INTO invitation VALUES (123, '8640cec5-01c8-e3e8-e8da-9d60358b87d3', 'kdflint@yahoo.com', '2015-12-09 23:17:29.175592+00', NULL, NULL, '2015-12-09 23:17:29.175592+00', 5, '2015-12-08', 234, 'single', 330, 1);
INSERT INTO invitation VALUES (124, '152dae9b-ebfb-3c0f-5c7d-45a5300493c9', 'kathy.flint@yahoo.com', '2015-12-09 23:34:48.063893+00', '2015-12-09 23:37:18.342874+00', NULL, '2015-12-09 23:34:48.063893+00', 5, '2016-01-09', 234, 'single', 330, 1);
INSERT INTO invitation VALUES (125, '1883d193-544d-f30e-99a7-5e6f23a9c079', 'ksflint@comcast.net', '2016-05-04 22:07:58.533793+00', NULL, NULL, '2016-05-04 22:07:58.533793+00', 5, '2016-05-03', 234, 'single', 330, 1);
INSERT INTO invitation VALUES (126, '63219cd5-f276-0d4b-ec8e-730e351f8998', 'alsdf@teast.com', '2016-05-04 22:24:55.028623+00', NULL, NULL, '2016-05-04 22:24:55.028623+00', 5, '2016-05-03', 234, 'single', 330, 1);
INSERT INTO invitation VALUES (127, '8b0397cf-ad78-f9cc-4190-0b862adab43f', 'kathy.d.flint@gmail.com', '2016-05-10 18:44:41.695+00', '2016-05-10 18:46:20.561264+00', NULL, '2016-05-10 18:44:41.695+00', 5, '2016-06-10', 234, 'single', 330, 1);
INSERT INTO invitation VALUES (128, '0ece8e2b-9178-b82e-0a63-473bbc8aa78b', 'kathy.flint@yahoo.com', '2016-05-10 19:42:05.615065+00', '2016-05-10 19:43:13.264914+00', NULL, '2016-05-10 19:42:05.615065+00', 4, '2016-06-10', 88, 'single', 336, 18);
INSERT INTO invitation VALUES (129, '1e5da6eb-e34e-15bc-d9a2-affed81a3500', 'kathy.flint@northbridgetech.org', '2016-05-10 20:38:53.071924+00', '2016-05-10 20:39:46.355423+00', NULL, '2016-05-10 20:38:53.071924+00', 4, '2016-06-10', 88, 'single', 337, 19);
INSERT INTO invitation VALUES (130, '3d4d6430-c253-ad01-3d8e-f09bd343063d', 'northbridge.test@yahoo.com', '2016-05-25 01:37:09.510044+00', '2016-05-25 01:40:42.62811+00', NULL, '2016-05-25 01:37:09.510044+00', 5, '2016-06-25', 234, 'single', 330, 1);
INSERT INTO invitation VALUES (150, '881cf39c-7e1f-e41b-9a60-e018ea094df3', 'kathy.d.flint@gmail.com', '2017-07-20 00:55:28.141525+00', '2017-07-20 01:00:41.659656+00', 375, '2017-07-20 00:55:28.141525+00', 4, '2017-08-20', 88, 'single', 375, 28);
INSERT INTO invitation VALUES (131, '6e7e20c7-036c-0b2c-9241-0de37bb340fa', 'northbridge.test@yahoo.com', '2016-05-25 01:52:05.421264+00', '2016-05-25 01:53:01.41298+00', NULL, '2016-05-25 01:52:05.421264+00', 5, '2016-05-24', 234, 'single', 330, 1);
INSERT INTO invitation VALUES (139, 'ea3c7ae0-2c3f-15ac-344d-fe9954f949cb', 'kathy.flint@northbridgetech.org', '2017-02-26 20:02:33.245657+00', '2017-02-26 20:03:28.148933+00', NULL, '2017-02-26 20:02:33.245657+00', 4, '2017-02-25', 234, 'single', 330, 1);
INSERT INTO invitation VALUES (132, '3bd4657e-be7b-f849-5265-3a42a3f68b90', 'northbridge.test@yahoo.com', '2016-05-25 01:55:08.587497+00', '2016-05-25 01:57:14.054682+00', NULL, '2016-05-25 01:55:08.587497+00', 5, '2016-05-24', 234, 'single', 330, 1);
INSERT INTO invitation VALUES (133, 'd0178dea-dae5-07be-57b2-9baae239bbb7', 'coach.lou@northbridgetech.org', '2016-06-15 01:09:09.504902+00', NULL, NULL, '2016-06-15 01:09:09.504902+00', 4, '2016-07-16', 234, 'single', 330, 1);
INSERT INTO invitation VALUES (134, 'a45853cd-0987-6543-a4a4-dee5dbf05f5a', 'kathy.flint@northbridgetech.org', '2016-12-13 21:11:48.778871+00', '2016-12-13 21:14:20.400422+00', NULL, '2016-12-13 21:11:48.778871+00', 4, '2017-01-13', 88, 'single', 1, 5);
INSERT INTO invitation VALUES (140, '99e2eca5-2ac8-71b6-5bef-ff4608b0b96c', 'kathy.flint@northbridgetech.org', '2017-02-26 20:09:32.8335+00', '2017-02-26 20:19:19.48457+00', NULL, '2017-02-26 20:09:32.8335+00', 4, '2017-02-25', 234, 'single', 330, 1);
INSERT INTO invitation VALUES (136, '330cf316-c34d-29ea-be81-5ba0f6e751cf', 'kathy.d.flint@gmail.com', '2017-01-31 14:33:25.301458+00', '2017-01-31 14:35:02.055845+00', NULL, '2017-01-31 14:33:25.301458+00', 5, '2017-03-03', 234, 'single', 330, 1);
INSERT INTO invitation VALUES (141, '561f8b74-0523-dde1-188d-d8412022926a', 'kathy.d.flint@gmail.com', '2017-03-02 23:44:21.470928+00', '2017-03-02 23:44:56.031325+00', 340, '2017-03-02 23:44:21.470928+00', 4, '2017-04-02', 88, 'single', 340, 24);
INSERT INTO invitation VALUES (142, '869edc7c-99da-72d6-26e3-035d2cf4cdd1', 'kathy.flint@northbridgetech.org', '2017-03-02 23:45:16.396075+00', '2017-03-02 23:46:10.121957+00', NULL, '2017-03-02 23:45:16.396075+00', 5, '2017-04-02', 352, 'single', 340, 24);
INSERT INTO invitation VALUES (135, '15962d1f-24c3-4c89-b974-3afaa2494eb4', NULL, '2017-01-30 19:26:31.789369+00', NULL, 1, '2017-01-30 19:26:31.789369+00', 5, NULL, 88, 'global', 1, NULL);
INSERT INTO invitation VALUES (137, 'fb35345f-91e8-a1ab-8ac8-17a48ad284f5', 'kathy.d.flint@gmail.com', '2017-02-12 21:34:48.351257+00', '2017-02-12 21:55:15.207557+00', NULL, '2017-02-12 21:34:48.351257+00', 1, '2017-03-15', 88, 'single', 339, NULL);
INSERT INTO invitation VALUES (138, '6adb69af-943f-4e37-a8fb-3441c3ef88ce', '', '2017-02-12 22:09:27.131119+00', NULL, 339, '2017-02-12 22:09:27.131119+00', 5, NULL, 88, 'global', 339, NULL);
INSERT INTO invitation VALUES (143, '4c1af4c7-8e55-e869-61b2-ad6cecd263ef', 'gretchen.saylor@gmail.com', '2017-03-06 02:17:18.996808+00', '2017-03-06 02:18:02.516946+00', NULL, '2017-03-06 02:17:18.996808+00', 5, '2017-04-06', 234, 'single', 330, 1);
INSERT INTO invitation VALUES (144, '69a243d4-ab26-2494-c00c-e61c5fed94b4', 'coach.lou@northbridgetech.org', '2017-03-06 02:17:57.400072+00', '2017-03-06 02:20:55.965058+00', NULL, '2017-03-06 02:17:57.400072+00', 4, '2017-04-06', 234, 'single', 330, 1);
INSERT INTO invitation VALUES (146, 'ba2a8725-a604-582f-9997-e19a1398d0d1', 'hemalatha.nambiradje@gmail.com', '2017-07-10 00:13:43.961174+00', '2017-07-10 00:57:49.452252+00', NULL, '2017-07-10 00:13:43.961174+00', 4, '2017-08-10', 234, 'single', 330, 1);
INSERT INTO invitation VALUES (147, 'e0ef3c8e-981e-018f-32da-0de69ee77413', 'kathy.d.flint@gmail.com', '2017-07-20 00:41:28.529303+00', NULL, 372, '2017-07-20 00:41:28.529303+00', 4, '2017-08-20', 88, 'single', 372, 25);
INSERT INTO invitation VALUES (148, 'f54293ea-e799-802b-47bf-da0234d88817', 'kathy.d.flint@gmail.com', '2017-07-20 00:42:22.022622+00', NULL, 373, '2017-07-20 00:42:22.022622+00', 4, '2017-08-20', 88, 'single', 373, 26);
INSERT INTO invitation VALUES (149, 'caf86c83-66d6-f698-eb0e-f7fed68c5dbd', 'kathy.d.flint@gmail.com', '2017-07-20 00:52:01.853806+00', NULL, 374, '2017-07-20 00:52:01.853806+00', 4, '2017-08-20', 88, 'single', 374, 27);
INSERT INTO invitation VALUES (151, 'aae96c55-186c-c472-6c5f-89ef7c93ac67', 'kathy.flint@northbridgetech.org', '2017-07-20 01:22:16.835108+00', '2017-07-20 01:38:50.046022+00', 376, '2017-07-20 01:22:16.835108+00', 4, '2017-08-20', 88, 'single', 376, 29);
INSERT INTO invitation VALUES (152, '11f978be-fd55-2d5c-f7bb-e07a9821555d', 'kathy.flint@northbridgetech.org', '2017-07-20 02:31:33.937539+00', '2017-07-20 02:32:46.744451+00', 377, '2017-07-20 02:31:33.937539+00', 4, '2017-08-20', 88, 'single', 377, 30);
INSERT INTO invitation VALUES (153, '86af779f-b53a-c4d5-21fd-dfcb0d319b67', 'kathy.d.flint@gmail.com', '2017-07-20 02:56:56.48752+00', '2017-07-20 02:57:42.300259+00', 378, '2017-07-20 02:56:56.48752+00', 4, '2017-08-20', 88, 'single', 378, 31);
INSERT INTO invitation VALUES (145, '64509d7e-3b4f-724c-3de2-2b520cbbbb78', 'hansentamaradharmawan@gmail.com', '2017-07-10 00:13:05.544036+00', '2017-07-24 01:20:27.817572+00', NULL, '2017-07-10 00:13:05.544036+00', 4, '2017-08-10', 234, 'single', 330, 1);
INSERT INTO invitation VALUES (154, 'a026bf56-27b8-a6b8-3f32-2026e27844f0', 'northbridge.test@yahoo.com', '2017-07-26 19:17:58.581191+00', NULL, 379, '2017-07-26 19:17:58.581191+00', 4, '2017-08-26', 88, 'single', 379, 32);
INSERT INTO invitation VALUES (155, 'fd6d8fe3-f690-7701-1fd5-382f402e3c56', 'northbridge.test@yahoo.com', '2017-07-26 19:28:10.197451+00', NULL, 380, '2017-07-26 19:28:10.197451+00', 4, '2017-08-26', 88, 'single', 380, 33);
INSERT INTO invitation VALUES (156, 'e9905956-3882-c785-6778-6e1c9ee3cdb2', 'hansentamaradharmawan@gmail.com', '2017-08-07 20:38:43.387363+00', NULL, NULL, '2017-08-07 20:38:43.387363+00', 5, '2017-09-07', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (157, '558c1ebc-934d-50ad-2a4a-796b722c20a3', 'hemnam24@gmail.com', '2017-08-08 20:42:26.225539+00', NULL, NULL, '2017-08-08 20:42:26.225539+00', 4, '2017-08-07', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (159, '234511a3-99d0-5de7-bbb5-51e53d2d2fc5', 'hemnam24@gmail.com', '2017-08-08 20:43:51.196068+00', NULL, NULL, '2017-08-08 20:43:51.196068+00', 4, '2017-08-07', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (158, '97a59377-ad72-2436-7912-ed84d486a332', 'hemnam24@gmail.com', '2017-08-08 20:43:10.586429+00', NULL, NULL, '2017-08-08 20:43:10.586429+00', 4, '2017-08-07', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (160, '6fbbc00b-d6b9-c57f-8f18-f7c182d751fd', 'hemnam24@gmail.com', '2017-08-08 20:44:48.607935+00', NULL, NULL, '2017-08-08 20:44:48.607935+00', 4, '2017-08-07', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (162, '1bcdf099-1a53-9e22-06d9-8105aa370548', 'hemnam24@gmail.com', '2017-08-08 21:12:47.058029+00', NULL, NULL, '2017-08-08 21:12:47.058029+00', 4, '2017-08-08', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (161, 'fba29b01-db13-0d0f-a4fd-7d7aeb9a90c6', 'hemnam24@gmail.com', '2017-08-08 21:09:24.776527+00', NULL, NULL, '2017-08-08 21:09:24.776527+00', 4, '2017-08-08', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (163, '4bbc9254-d15f-e412-0041-7e8f35929ba3', 'hemnam24@gmail.com', '2017-08-08 21:16:15.182002+00', NULL, NULL, '2017-08-08 21:16:15.182002+00', 4, '2017-08-08', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (164, '24b7dd2a-7c16-bbdb-6f46-c6bc30871d86', 'hemnam24@gmail.com', '2017-08-08 21:19:43.600244+00', NULL, NULL, '2017-08-08 21:19:43.600244+00', 4, '2017-08-08', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (165, 'edeef373-7a78-8e13-97c0-3257cd4ead67', 'hemnam24@gmail.com', '2017-08-08 22:06:14.993648+00', NULL, NULL, '2017-08-08 22:06:14.993648+00', 4, '2017-08-08', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (166, '779027cd-3b42-1443-15fa-824d56285567', 'hemnam24@gmail.com', '2017-08-08 22:44:09.686909+00', NULL, NULL, '2017-08-08 22:44:09.686909+00', 4, '2017-08-08', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (167, 'e634c770-a782-052e-76a2-17d99ed7c9b7', 'hemnam24@gmail.com', '2017-08-09 01:13:32.649685+00', NULL, NULL, '2017-08-09 01:13:32.649685+00', 4, '2017-08-08', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (168, 'f9a15c6a-01c0-7a58-7044-7880128451fc', 'hemnam24@gmail.com', '2017-08-09 01:23:14.772479+00', NULL, NULL, '2017-08-09 01:23:14.772479+00', 4, '2017-08-08', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (169, 'fabbde4a-1742-ca66-abd5-4798c325d37d', 'hemnam24@gmail.com', '2017-08-09 01:33:08.414024+00', NULL, NULL, '2017-08-09 01:33:08.414024+00', 4, '2017-08-08', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (170, '22d6aa90-8080-ac66-d6ce-58c86dce932a', 'hemnam24@gmail.com', '2017-08-09 01:33:59.521974+00', NULL, NULL, '2017-08-09 01:33:59.521974+00', 4, '2017-08-08', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (171, '1fba6191-d5d2-98c4-83ca-f4d05748a548', 'hemnam24@gmail.com', '2017-08-09 01:45:14.268145+00', NULL, NULL, '2017-08-09 01:45:14.268145+00', 4, '2017-08-08', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (173, 'b955337c-d446-c1b3-939c-40f00fda810a', 'hemnam24@gmail.com', '2017-08-09 16:53:52.535887+00', NULL, NULL, '2017-08-09 16:53:52.535887+00', 4, '2017-08-08', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (172, '249296af-2beb-da99-d7ec-ea4bb17d8ba3', 'hemnam24@gmail.com', '2017-08-09 01:50:01.681923+00', NULL, NULL, '2017-08-09 01:50:01.681923+00', 4, '2017-08-08', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (174, '1cc451d6-c6c8-0fc6-7d7b-1e3294eb09cb', 'hemnam24@gmail.com', '2017-08-09 17:05:59.460542+00', NULL, NULL, '2017-08-09 17:05:59.460542+00', 4, '2017-08-08', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (175, '185582f1-e0e3-7b52-1603-9c48383ec4ba', 'hemnam24@gmail.com', '2017-08-09 17:07:53.237646+00', NULL, NULL, '2017-08-09 17:07:53.237646+00', 4, '2017-08-09', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (176, 'bd12c709-6fd5-41fd-7891-ef67433519e5', 'hemnam24@gmail.com', '2017-08-10 03:13:05.025193+00', NULL, NULL, '2017-08-10 03:13:05.025193+00', 4, '2017-08-09', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (177, 'e07646ff-0069-bbf2-7c66-f7ba24a3957a', 'hemnam24@gmail.com', '2017-08-10 03:17:54.137351+00', NULL, NULL, '2017-08-10 03:17:54.137351+00', 4, '2017-08-09', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (178, 'e77b12d0-f364-2ae8-9ea3-72ce8a0b354b', 'hemnam24@gmail.com', '2017-08-10 03:23:37.101569+00', NULL, NULL, '2017-08-10 03:23:37.101569+00', 4, '2017-08-09', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (179, 'd418ba84-c2c7-0c8a-b8fa-1d06fdd869b8', 'hemnam24@gmail.com', '2017-08-10 03:25:48.80797+00', NULL, NULL, '2017-08-10 03:25:48.80797+00', 4, '2017-08-09', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (180, 'a41f5851-ba7a-050a-2682-b7a237c15105', 'hemnam24@gmail.com', '2017-08-10 03:30:22.20244+00', NULL, NULL, '2017-08-10 03:30:22.20244+00', 4, '2017-08-09', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (181, '6821d32f-a296-ebd3-f404-aae0fb743fb8', 'hemnam24@gmail.com', '2017-08-10 03:32:02.994051+00', NULL, NULL, '2017-08-10 03:32:02.994051+00', 4, '2017-08-09', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (182, '2cf3ed97-6a66-f222-8557-09728cac47d8', 'hemnam24@gmail.com', '2017-08-10 21:16:09.56406+00', NULL, NULL, '2017-08-10 21:16:09.56406+00', 4, '2017-08-14', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (183, '56f011e2-dc6d-85fc-df8b-1255e86ec167', 'hemnam24@gmail.com', '2017-08-10 21:30:48.521287+00', NULL, NULL, '2017-08-10 21:30:48.521287+00', 4, '2017-08-14', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (184, '9a388371-b31a-7558-a3d6-a103dd22ac9c', 'hemnam24@gmail.com', '2017-08-12 02:16:25.253387+00', NULL, NULL, '2017-08-12 02:16:25.253387+00', 4, '2017-08-14', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (185, '0fdd1401-b135-b18a-8c30-4efe7a0ad977', 'hemnam24@gmail.com', '2017-08-15 19:48:42.553268+00', '2017-08-15 19:50:31.814582+00', NULL, '2017-08-15 19:48:42.553268+00', 4, '2017-09-15', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (186, '68a8ccc4-2152-2441-13f0-2cb4ae7afae0', 'hemnam24@gmail.com', '2017-08-23 16:11:34.044605+00', NULL, NULL, '2017-08-23 16:11:34.044605+00', 4, '2017-08-26', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (187, 'b5b29bd8-7c70-508a-80a7-67dc3f22f074', 'testuser1411988@gmail.com', '2017-08-24 16:07:22.716175+00', NULL, NULL, '2017-08-24 16:07:22.716175+00', 4, '2017-08-26', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (188, '1728c713-4cb7-e6b5-03c8-78b8d8abb832', 'testuser1411988@gmail.com', '2017-08-27 02:14:26.903725+00', NULL, NULL, '2017-08-27 02:14:26.903725+00', 4, '2017-08-26', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (189, '8cb9d367-488d-5976-137b-d624c7d4ee09', 'testuser1411988@gmail.com', '2017-08-27 02:18:35.108845+00', NULL, NULL, '2017-08-27 02:18:35.108845+00', 4, '2017-08-26', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (190, 'b4a8c303-5eec-329c-ba8c-d46368055ca1', 'testuser1411988@gmail.com', '2017-08-27 02:26:27.136354+00', NULL, NULL, '2017-08-27 02:26:27.136354+00', 4, '2017-08-26', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (191, '8402ecbb-3774-eff7-f30e-18ec7bcb4efd', 'testuser1411988@gmail.com', '2017-08-27 02:34:10.769594+00', NULL, NULL, '2017-08-27 02:34:10.769594+00', 4, '2017-08-26', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (192, '1d1afa0b-2833-9cec-c94e-97173cdd81a9', 'testuser1411988@gmail.com', '2017-08-27 02:40:50.650034+00', NULL, NULL, '2017-08-27 02:40:50.650034+00', 4, '2017-08-26', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (193, 'f4634f32-744b-db36-b158-b61614acfe2d', 'testuser1411988@gmail.com', '2017-08-27 02:42:43.055373+00', NULL, NULL, '2017-08-27 02:42:43.055373+00', 4, '2017-08-27', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (194, '06852920-dbd3-d2ce-6ea6-fb74e71b3b27', 'testuser1411988@gmail.com', '2017-08-28 00:41:25.594231+00', NULL, NULL, '2017-08-28 00:41:25.594231+00', 4, '2017-08-27', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (195, '1d3863a8-3c8f-edef-d1a8-d4da8f5bab4b', 'testuser1411988@gmail.com', '2017-08-28 00:45:29.989284+00', NULL, NULL, '2017-08-28 00:45:29.989284+00', 4, '2017-08-28', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (196, 'd5f69ce0-6783-1100-f51b-a5bc64380034', 'testuser1411988@gmail.com', '2017-08-29 02:26:45.802127+00', '2017-08-29 02:32:01.330349+00', NULL, '2017-08-29 02:26:45.802127+00', 5, '2017-09-29', 370, 'single', 330, 1);
INSERT INTO invitation VALUES (197, '6bcded25-47da-5b16-d9fa-e5f54566ea51', 'testuser1411988@gmail.com', '2017-08-29 02:32:30.073248+00', '2017-08-29 02:34:01.43109+00', NULL, '2017-08-29 02:32:30.073248+00', 5, '2017-09-29', 370, 'single', 330, 1);
INSERT INTO invitation VALUES (198, 'b2860ed9-98cb-086a-1d66-3e627ec2588e', 'testuser21111996@gmail.com', '2017-08-29 02:54:07.231196+00', NULL, NULL, '2017-08-29 02:54:07.231196+00', 4, '2017-08-28', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (199, 'ea84d248-a72f-99ad-fa02-c76a753025e6', 'testuser21111996@gmail.com', '2017-09-21 02:56:06.467671+00', NULL, NULL, '2017-09-21 02:56:06.467671+00', 4, '2017-10-22', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (200, 'a0699307-9d0a-00aa-9050-477e36a483f7', 'testuser21111996@gmail.com', '2017-09-22 02:26:52.553632+00', NULL, NULL, '2017-09-22 02:26:52.553632+00', 4, '2017-09-21', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (201, '0c12b53a-99c8-3ecb-cfa3-d9bf4e49ed15', 'hemnam24@gmail.com', '2017-09-25 15:48:57.684835+00', '2017-09-25 15:52:36.334233+00', NULL, '2017-09-25 15:48:57.684835+00', 5, '2017-10-26', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (203, 'fdc0102b-eb12-f668-47c9-f235871aa196', 'kathy.d.flint@gmail.com', '2017-10-03 17:18:47.536191+00', '2017-10-03 17:20:11.17922+00', NULL, '2017-10-03 17:18:47.536191+00', 4, '2017-11-03', 329, 'single', 330, 1);
INSERT INTO invitation VALUES (202, '28428e26-906a-89ee-f94d-22f4f0c8e9df', 'kathy.d.flint@gmail.com', '2017-10-03 17:18:35.616753+00', '2017-10-03 17:20:40.259667+00', NULL, '2017-10-03 17:18:35.616753+00', 5, '2017-11-03', 329, 'single', 330, 1);
INSERT INTO invitation VALUES (204, '08a79370-120f-b4f0-6890-824c408d9eb3', 'rodolfoj@hotmail.com', '2018-01-31 18:24:16.703459+00', '2018-02-13 04:31:24.178468+00', NULL, '2018-01-31 18:24:16.703459+00', 4, '2018-03-03', 374, 'single', 330, 1);
INSERT INTO invitation VALUES (206, '0396e2d6-ba72-916e-1045-d8c9ef891e9b', 'rashmjk@gmail.com', '2018-03-27 01:16:42.155359+00', '2018-03-27 01:28:43.555023+00', NULL, '2018-03-27 01:16:42.155359+00', 4, '2018-04-27', 374, 'single', 330, 1);
INSERT INTO invitation VALUES (205, '9d9e8a60-c813-ce91-cc70-e8ab3169e17e', 'renu.safernet@gmail.com', '2018-03-27 01:15:51.373609+00', '2018-03-27 01:44:54.577101+00', NULL, '2018-03-27 01:15:51.373609+00', 4, '2018-04-27', 374, 'single', 330, 1);
INSERT INTO invitation VALUES (207, 'f604a2fb-248a-2b49-116e-126515954eac', 'htd5cf@virginia.edu', '2018-03-27 01:17:42.240403+00', '2018-03-27 02:10:01.083344+00', NULL, '2018-03-27 01:17:42.240403+00', 4, '2018-04-27', 374, 'single', 330, 1);
INSERT INTO invitation VALUES (210, '2afee85b-5d91-2255-596e-00d40ee999cd', 'kathy.flint@northbridgetech.org', '2018-03-27 21:27:40.687768+00', '2018-03-27 21:28:38.673003+00', NULL, '2018-03-27 21:27:40.687768+00', 4, '2018-04-27', 374, 'single', 330, 1);
INSERT INTO invitation VALUES (208, 'd7b634a4-1f76-c33d-3131-705e937c6a1d', 'testuser1411988@gmail.com', '2018-03-27 21:19:11.022184+00', NULL, NULL, '2018-03-27 21:19:11.022184+00', 4, '2018-03-26', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (209, '94e3d72d-ef6a-f240-7f1d-83fb1c714ca0', 'testuser21111996@gmail.com', '2018-03-27 21:20:04.394163+00', NULL, NULL, '2018-03-27 21:20:04.394163+00', 5, '2018-03-26', 361, 'single', 330, 1);
INSERT INTO invitation VALUES (211, 'f2a19478-fece-3b37-5b52-cce9fa01ce25', 'kathy.flint@northbridgetech.org', '2018-03-31 01:11:45.985611+00', NULL, NULL, '2018-03-31 01:11:45.985611+00', 5, '2018-03-30', 374, 'single', 330, 1);
INSERT INTO invitation VALUES (212, '5e9e650c-3410-755d-0819-25243d9ac85a', 'test@test.com', '2018-04-03 00:34:28.150319+00', NULL, NULL, '2018-04-03 00:34:28.150319+00', 4, '2018-04-02', 374, 'single', 330, 1);
INSERT INTO invitation VALUES (213, '1ee8752e-fc0b-bd27-f538-a82f4dc7ea16', 'kathy.d.flint@gmail.com', '2018-04-03 23:45:06.882203+00', NULL, NULL, '2018-04-03 23:45:06.882203+00', 5, '2018-04-02', 374, 'single', 330, 1);
INSERT INTO invitation VALUES (214, '9b417b5b-643b-0bfa-b26c-ccc74d7abeee', 'kathy.flint@northbridgetech.org', '2018-04-03 23:46:40.307224+00', NULL, NULL, '2018-04-03 23:46:40.307224+00', 5, '2018-05-04', 374, 'single', 330, 1);


--
-- Name: invitation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbri_devnexus
--

SELECT pg_catalog.setval('invitation_id_seq', 214, true);


--
-- Data for Name: invitation_organization; Type: TABLE DATA; Schema: public; Owner: northbri_devnexus
--



--
-- Name: invitation_organization_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbri_devnexus
--

SELECT pg_catalog.setval('invitation_organization_id_seq', 32, true);


--
-- Data for Name: language; Type: TABLE DATA; Schema: public; Owner: northbri_devnexus
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
INSERT INTO language VALUES (14, 'American Sign');
INSERT INTO language VALUES (15, 'Cantonese');
INSERT INTO language VALUES (16, 'Mandarin');
INSERT INTO language VALUES (17, 'German');


--
-- Name: language_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbri_devnexus
--

SELECT pg_catalog.setval('language_id_seq', 17, true);


--
-- Data for Name: location; Type: TABLE DATA; Schema: public; Owner: northbri_devnexus
--

INSERT INTO location VALUES (300, '5144 S. Cornell Ave', '', 'Chicago', '', 'Illinois', 'US', '60615', '41.801036', '-87.58640', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (238, '1430 Plainfield Rd.', '', 'Darien', '', 'Illinois', 'US', '60561', '41.747691', '-87.97977', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (239, '1325 S. Wabash', 'Suite 305', 'Chicago', '', 'Illinois', 'US', '60605', '41.865197', '-87.62544', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (221, '2440 York', '', 'Blue Island', '', 'Illinois', 'US', '60406', '41.657412', '-87.68096', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (219, '2025 Windsor Drive', '', 'Oak Brook', '', 'Illinois', 'US', '60523', '41.850309', '-87.92404', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (220, '205 W. Touhy Ave.', 'Suite 127', 'Park Ridge', '', 'Illinois', 'US', '60068', '42.010962', '-87.82409', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (222, '8430 W. Bryn Mawr Avenue', 'Suite 800', 'Chicago', '', 'Illinois', 'US', '60631', '41.981946', '-87.83902', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (223, '2424 W. Lithuanian Plaza', '', 'Chicago', '', 'Illinois', 'US', '60629', '41.768583', '-87.68441', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (224, '1048 Lake St.', 'Suite 300', 'Oak Park', '', 'Illinois', 'US', '60301', '41.889215', '-87.80226', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (225, '25 E. Schaumburg Rd.', 'Suite 106', 'Schaumburg', '', 'Illinois', 'US', '60194', '42.027003', '-88.07800', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (226, '8430 W. Bryn Mawr Avenue', 'Suite 800', 'Chicago', '', 'Illinois', 'US', '60631', '41.981946', '-87.83902', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (227, '283 E. Lincoln Highway', '', 'Chicago Heights', '', 'Illinois', 'US', '60411', '41.506280', '-87.62331', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (228, '208 S. LaSalle Street', 'Suite 900', 'Chicago', '', 'Illinois', 'US', '60604', '41.879159', '-87.63262', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (8, '5730 W. Fullerton', '', 'Chicago', '', 'Illinois', 'US', '60639', '41.924512', '-87.77031', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (9, '7649 North Paulina Street', '', 'Chicago', '', 'Illinois', 'US', '60626', '42.020844', '-87.67250', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (10, '115 W. Chicago', '', 'Chicago', '', 'Illinois', 'US', '60654', '41.896293', '-87.63199', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (11, '2716 W Division St', '', 'Chicago', '', 'Illinois', 'US', '60622', '41.903255', '-87.69517', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (12, '4440 W. 95th St.', '', 'Oak Lawn', '', 'Illinois', 'US', '60453', '41.721988', '-87.73282', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (13, '2025 Windsor Drive', '', 'Oak Brook', '', 'Illinois', 'US', '60523', '41.850309', '-87.92404', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (229, '4259 S. Berkeley Avenue', '', 'Chicago', '', 'Illinois', 'US', '60653', '41.817259', '-87.59987', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (230, '2788 Wolf Rd.', '', 'Northlake', '', 'Illinois', 'US', '60164', '41.928610', '-87.90407', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (231, '3823 S. Indiana Ave', '', 'Chicago', '', 'Illinois', 'US', '60653', '41.825081', '-87.62102', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (232, '3823 South Ind. Ave.', '', 'Chicago', '', 'Illinois', 'US', '60653', '41.825081', '-87.62102', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (233, '1424 W. 183rd St.', '', 'Homewood', '', 'Illinois', 'US', '60430', '41.557893', '-87.65144', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (234, '4236 W. Cermak RD', '', 'Chicago', '', 'Illinois', 'US', '60623', '41.851765', '-87.73122', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (235, '5433 S. Austin', '', 'Chicago', '', 'Illinois', 'US', '60638', '41.793401', '-87.77138', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (236, '5150 Golf Road', '', 'Skokie', '', 'Illinois', 'US', '60077', '42.055566', '-87.75602', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (237, '300 W. Adams', 'Suite 430', 'Chicago', '', 'Illinois', 'US', '60606', '41.879676', '-87.63560', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (240, '7620 Madison Ave.', '%LCFS', 'River Forest', '', 'Illinois', 'US', '60305', '41.879235', '-87.81487', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (241, '3225 W. Foster Ave.', '', 'Chicago', '', 'Illinois', 'US', '60625', '41.974827', '-87.71040', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (242, '2417 N. Campbell', '', 'Chicago', '', 'Illinois', 'US', '60647', '41.925204', '-87.69007', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (243, '5255 N. Ashland', '', 'Chicago', '', 'Illinois', 'US', '60660', '41.977926', '-87.66910', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (244, '5757 S. University Avenue', '', 'Chicago', '', 'Illinois', 'US', '60637', '41.789921', '-87.59733', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (245, '4720 N. Sheridan Rd.', '', 'Chicago', '', 'Illinois', 'US', '60641', '41.968017', '-87.65497', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (246, '11 S 80 Rte. 83', '', 'Willowbrook', '', 'Illinois', 'US', '60527', '41.729908', '-87.94406', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (247, '14 S. Ashland Ave.', '', 'Chicago', '', 'Illinois', 'US', '60607', '41.880895', '-87.66729', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (248, '4100 N. Long Ave.', '', 'Chicago', '', 'Illinois', 'US', '60641', '41.955369', '-87.76358', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (249, '10724 S Ewing Ave', '', 'Chicago', '', 'Illinois', 'US', '60617', '41.700137', '-87.53563', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (250, '3235 W. Wrightwood', '', 'Chicago', '', 'Illinois', 'US', '60647', '41.928228', '-87.70867', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (251, '111 N. County Farm Road', '', 'Wheaton', '', 'Illinois', 'US', '60187', '41.865846', '-88.14143', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (252, '9 N. Cicero', '', 'Chicago', '', 'Illinois', 'US', '60644', '41.881046', '-87.74512', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (253, '205 W. Touhy Ave', 'Suite 127', 'Park Ridge', '', 'Illinois', 'US', '60068', '42.010962', '-87.82409', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (254, '2532 W. Warren', '', 'Chicago', '', 'Illinois', 'US', '60612', '41.882460', '-87.68976', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (255, '1001 W. Kirchhoff Rd.', '', 'Arlington Heights', '', 'Illinois', 'US', '60005', '42.070804', '-87.99529', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (256, '2300 Children''s Plaza', '#157', 'Chicago', '', 'Illinois', 'US', '60614', '41.925160', '-87.64675', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (257, '4615 N. Clifton Ave.', '', 'Chicago', '', 'Illinois', 'US', '60640', '41.966292', '-87.65843', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (258, '231 S. State St.', '', 'Chicago', '', 'Illinois', 'US', '60604', '41.878744', '-87.62720', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (259, '1304 Franklin Ave.', '', 'Normal', '', 'Illinois', 'US', '61761', '40.496466', '-88.99112', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (260, '111 W. County Farm Road', '', 'Wheaton', '', 'Illinois', 'US', '60187', '41.865846', '-88.14143', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (261, '4919 W. Lexington', '', 'Chicago', '', 'Illinois', 'US', '60644', '41.870881', '-87.74781', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (262, '1650 W. Foster', '', 'Chicago', '', 'Illinois', 'US', '60643', '41.976591', '-87.67128', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (263, '1020 W. Bryn Mawr', '', 'Chicago', '', 'Illinois', 'US', '60660', '41.983891', '-87.65631', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (264, '6554 N. Rockwell Street', '', 'Chicago', '', 'Illinois', 'US', '60645', '42.001172', '-87.69504', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (265, '5253 N. Kenmore Ave.', '', 'Chicago', '', 'Illinois', 'US', '60640', '41.978006', '-87.65645', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (266, '196 Highland Ave.', '', 'Wheeling', '', 'Illinois', 'US', '60090', '42.136415', '-87.91189', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (267, '385 S. Buffalo Grove Rd.', '', 'Buffalo Grove', '', 'Illinois', 'US', '60089', '42.14643,', '-87.95796', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (268, '1325 S. Wabash', '#305', 'Chicago', '', 'Illinois', 'US', '60605', '41.865197', '-87.62544', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (269, '70 E. Lake St,', 'Suite 920', 'Chicago', '', 'Illinois', 'US', '60612', '41.886067', '-87.62569', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (270, '7158 South Peoria Street', '', 'Chicago', '', 'Illinois', 'US', '60612', '41.763689', '-87.64714', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (271, '15015 Grant St', '', 'Dolton', '', 'Illinois', 'US', '60419', '41.621807', '-87.60587', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (272, '6916 W. 34th St.', '', 'Berwyn', '', 'Illinois', 'US', '60402', '41.830398', '-87.79642', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (273, '20 N. Ashland Ave.', '', 'LaGrange', '', 'Illinois', 'US', '60525', '41.816737', '-87.87252', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (274, '80 N. Orchard Ave.', '', 'Park Forest', '', 'Illinois', 'US', '60466', '41.490860', '-87.68255', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (275, '1106 Chestnut St.', '', 'Western Springs', '', 'Illinois', 'US', '60558', '41.812836', '-87.90332', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (276, '5255 N. Ashland', '', 'Chicago', '', 'Illinois', 'US', '60640', '41.977926', '-87.66910', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (277, '4134 W. Grenshaw Street', '', 'Chicago', '', 'Illinois', 'US', '60624', '41.867289', '-87.72901', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (278, '325 East 69th Street', '', 'Chicago', '', 'Illinois', 'US', '60637-4601', '41.769045', '-87.61744', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (279, '2218 Hutchison Road', '', 'Flossmoor', '', 'Illinois', 'US', '60422', '41.545316', '-87.66978', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (280, '26 E. Chestnut Street', '', 'Chicago', '', 'Illinois', 'US', '60611', '41.898347', '-87.62719', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (281, '355 N Ashland Avenue', '', 'Chicago', '', 'Illinois', 'US', '60607-1019', '41.888186', '-87.66623', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (282, '2201 Foster St', '', 'Evanston', '', 'Illinois', 'US', '60201', '42.053676', '-87.70367', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (283, '1133 Pfinsten Rd.', '', 'Northbrook', '', 'Illinois', 'US', '60062', '42.132105', '-87.84743', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (284, '1100 Greenwood Ave', '', 'Ford Heights', '', 'Illinois', 'US', '60411', '41.511678', '-87.59006', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (285, '7800 South Loomis Blvd', '', 'Chicago', '', 'Illinois', 'US', '60620', '41.752220', '-87.65862', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (286, '7800 South Loomis Blvd.', '', 'Chicago', '', 'Illinois', 'US', '60620', '41.752220', '-87.65862', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (287, '5 N. Princeton Ave.', '', 'Villa Park', '', 'Illinois', 'US', '60181', '41.890217', '-87.97985', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (288, '7300 Division St.', '', 'River Forest', '', 'Illinois', 'US', '60305', '41.901081', '-87.80770', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (289, '1308 W. Independence Blvd', '', 'Chicago', '', 'Illinois', 'US', '60623', '41.864002', '-87.72051', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (290, '1308 S. Independence Blvd.', '', 'Chicago', '', 'Illinois', 'US', '60623', '41.864002', '-87.72051', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (291, '1301 S. Sawyer Ave.', '', 'Chicago', '', 'Illinois', 'US', '60623', '41.864472', '-87.70629', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (292, '1625 S. Lawndale', '', 'Chicago', '', 'Illinois', 'US', '60623', '41.858132', '-87.71727', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (293, '1256 N. Waller', '', 'Chicago', '', 'Illinois', 'US', '60651', '41.903821', '-87.76833', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (294, '4236 W. Cermak Road', '', 'Chicago', '', 'Illinois', 'US', '60623', '41.851765', '-87.73122', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (295, '8422 S. Damen', '', 'Chicago', '', 'Illinois', 'US', '60620', '41.740750', '-87.67305', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (296, '1542 West Devon Ave', '', 'Chicago', '', 'Illinois', 'US', '60626', '41.998351', '-87.66966', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (297, '7234 W. Ogden Ave', 'Suite 35', 'Riverside', '', 'Illinois', 'US', '60546', '41.823597', '-87.80450', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (298, '225 North Michigan Avenue', '#1210', 'Chicago', '', 'Illinois', 'US', '60601-7833', '41.886607', '-87.62314', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (299, '836 W. Wellington', 'Suite 159', 'Chicago', '', 'Illinois', 'US', '60657', '41.936792', '-87.65193', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (301, '122 S. Michigan', 'Suite 2009', 'Chicago', '', 'Illinois', 'US', '60603', '41.879915', '-87.62480', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (302, '407 S. Dearborn', 'Suite 701', 'Chicago', '', 'Illinois', 'US', '60605', '41.876610', '-87.62899', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (303, '300 E Superior St', '', 'Chicago', '', 'Illinois', 'US', '60611', '41.896466', '-87.61999', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (304, '910 W Castlewood Terrace', '', 'Chicago', '', 'Illinois', 'US', '60640', '41.971062', '-87.65297', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (305, '2744 W. 63rd St', '', 'Chicago', '', 'Illinois', 'US', '60629', '41.779425', '-87.69269', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (306, '300 E Superior St', '', 'Chicago', '', 'Illinois', 'US', '60611', '41.896466', '-87.61999', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (307, '480 Potter Rd', '', 'Des Plaines', '', 'Illinois', 'US', '60016', '42.045695', '-87.86068', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (308, '300 W. Highridge Rd', '', 'Villa Park', '', 'Illinois', 'US', '60181', '41.868168', '-87.98582', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (309, '6259 N. Broadway Ave', '', 'Chicago', '', 'Illinois', 'US', '60660', '41.996192', '-87.66007', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (310, '100 Shermer Road', '', 'Glenview', '', 'Illinois', 'US', '60025', '42.057623', '-87.81479', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (311, '208 Lake Street', '', 'Waukegan', '', 'Illinois', 'US', '60085', '42.356513', '-87.83156', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (312, '3145 W. Pratt Blvd', '', 'Chicago', '', 'Illinois', 'US', '60645', '42.003927', '-87.70856', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (313, '3145 W. Praat Blvd', '', 'Chicago', '', 'Illinois', 'US', '60645', '42.003927', '-87.70856', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (314, '5150 Golf Road', '', 'Skokie', '', 'Illinois', 'US', '60077', '42.055566', '-87.75602', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (315, '1500 S. California Ave', '', 'Chicago', '', 'Illinois', 'US', '60608', '41.861110', '-87.69401', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (316, '3255 W. Carroll Avenue', '', 'Chicago', '', 'Illinois', 'US', '60624', '41.887194', '-87.70846', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (317, '9600 Capitol Dr.', '', 'Wheeling', '', 'Illinois', 'US', '60090', '42.110610', '-87.90937', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (318, '4608 S. Greenwood Ave', '', 'Chicago', '', 'Illinois', 'US', '60653', '41.811334', '-87.59941', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (319, '2324 N. Kimball Avenue', '', 'Chicago', '', 'Illinois', 'US', '60647', '41.923638', '-87.71218', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (320, '1840 Westchester Blvd', 'Suite 200', 'Westchester', '', 'Illinois', 'US', '60154', '41.853001', '-87.87715', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (321, '716 W. Addison', '', 'Chicago', '', 'Illinois', 'US', '60613', '41.947738', '-87.64754', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (322, '300 W. Adams', 'Suite 35', 'Chicago', '', 'Illinois', 'US', '60606', '41.879676', '-87.63560', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (323, '2813 W. 147th Street', '', 'Posen', '', 'Illinois', 'US', '60469', '41.625824', '-87.68929', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (326, '1840 Westchester Blvd', 'Suite 200', 'Westchester', '', 'Illinois', 'US', '60154', '41.853001', '-87.87715', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (327, '4849 S. King Dr.', '', 'Chicago', '', 'Illinois', 'US', '60615', '41.806144', '-87.61557', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (328, '649 W. 113th Street', '', 'Chicago', '', 'Illinois', 'US', '60628', '41.688548', '-87.63958', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (329, '2242 South Damen Avenue', '', 'Chicago', '', 'Illinois', 'US', '60608', '41.850882', '-87.67596', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (330, '355 N Ashland Avenue', '', 'Chicago', '', 'Illinois', 'US', '60607-1019', '41.888186', '-87.66623', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (331, '4938 W. Chicago Avenue', '', 'Chicago', '', 'Illinois', 'US', '60651', '41.895293', '-87.74985', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (332, '6554 N. Rockwell Street', '', 'Chicago', '', 'Illinois', 'US', '60645', '42.001172', '-87.69504', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (333, '909 East Main Street', '', 'Barrington', '', 'Illinois', 'US', '60010', '42.153421', '-88.12038', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (334, '460 Sunset Ridge Rd', '', 'Northfield', '', 'Illinois', 'US', '60093', '42.104848', '-87.79085', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (335, '1775 W. Dempster', '', 'Park Ridge', '', 'Illinois', 'US', '60068', '42.039452', '-87.84564', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (336, '1001 E. Touhy Ave.', '', 'Illinois', '', 'Illinois', 'US', '60018', '42.008964', '-87.89692', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (337, '4259 S. Berkeley Avenue', '', 'Chicago', '', 'Illinois', 'US', '60653', '41.817259', '-87.59987', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (338, '2218 Hutchison Road', '', 'Flossmoor', '', 'Illinois', 'US', '60422', '41.545316', '-87.66978', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (339, '4411 N. Melvina Ave', '', 'Chicago', '', 'Illinois', 'US', '60630', '41.960694', '-87.78156', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (340, '2750 W. Columbus Ave', '', 'Chicago', '', 'Illinois', 'US', '60652', '41.757121', '-87.68984', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (341, '7360 West 93rd Street', '', 'Bridgeview', '', 'Illinois', 'US', '60455-2171', '41.722978', '-87.80257', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (342, '11405 S. Michigan Avenue', '', 'Chicago', '', 'Illinois', 'US', '60628', '41.686874', '-87.62054', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (343, '450 Keller Avenue', '', 'Waukegan', '', 'Illinois', 'US', '60085', '42.352594', '-87.86510', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (344, '1259 W. 111th Place', '', 'Chicago', '', 'Illinois', 'US', '60643', '41.691301', '-87.65433', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (345, '1813 Church Street', '', 'Evanston', '', 'Illinois', 'US', '60201', '42.048409', '-87.69806', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (346, '501 S. Emerson St.', '', 'Mt Prospect', '', 'Illinois', 'US', '60056', '42.057240', '-87.93473', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (347, '1137 N. Leavitt St.', '', 'Chicago', '', 'Illinois', 'US', '60622', '41.902406', '-87.68181', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (348, '11026 S. Indiana Ave.', '', 'Chicago', '', 'Illinois', 'US', '60628', '41.693574', '-87.61862', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (349, '2704 W. North Ave.', '', 'Chicago', '', 'Illinois', 'US', '60647', '41.910729', '-87.69486', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (350, '32 E. 113th Place', '', 'Chicago', '', 'Illinois', 'US', '60628', '41.688175', '-87.62184', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (351, '4301 W. Washington Blvd', '', 'Chicago', '', 'Illinois', 'US', '60624', '41.881632', '-87.73329', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (352, '11300 South Indiana Avenue', '', 'Chicago', '', 'Illinois', 'US', '60628', '41.688844', '-87.61856', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (353, '3225 W. Foster Ave', '', 'Chicago', '', 'Illinois', 'US', '60625-4895', '41.974827', '-87.71040', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (354, '326 Julian St', '', 'Waukegan', '', 'Illinois', 'US', '60085', '42.366271', '-87.83329', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (355, '100 N. Northgate Pkwy.', '', 'Wheeling', '', 'Illinois', 'US', '60090', '42.141285', '-87.92738', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (356, '7649 North Paulina Street', '', 'Chicago', '', 'Illinois', 'US', '60626', '42.020844', '-87.67250', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (357, '2415 North Butrick', '', 'Waukegan', '', 'Illinois', 'US', '60085', '42.396332', '-87.84723', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (358, '710 S Paulina Street', '4th Floor', 'Chicago', '', 'Illinois', 'US', '60612', '41.872518', '-87.66936', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (359, '3845 S. California Ave', '', 'Chicago', '', 'Illinois', 'US', '60632', '41.823498', '-87.69462', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (360, '601 Talma Street', '', 'Aurora', '', 'Illinois', 'US', '60505', '41.743445', '-88.31138', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (361, '7000 S. King Drive', '', 'Chicago', '', 'Illinois', 'US', '60637', '41.767515', '-87.61528', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (362, '100 S. Courtland Ave', '', 'Park Ridge', '', 'Illinois', 'US', '60068', '42.008862', '-87.83132', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (363, '21W500 Butterfield Rd', '', 'Lombard', '', 'Illinois', 'US', '60148', '41.832859', '-88.04567', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (364, '3570 West Fifth Avenue', '', 'Chicago', '', 'Illinois', 'US', '60624', '41.876279', '-87.71501', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (365, '941 W. Lawrence Ave', '', 'Chicago', '', 'Illinois', 'US', '60640', '41.969022', '-87.65372', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (366, '7438 W. 62nd Place', '', 'Summit Argo', '', 'Illinois', 'US', '60501', '41.778318', '-87.80725', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (367, '116 S. Central Ave.', '', 'Chicago', '', 'Illinois', 'US', '60644', '41.878661', '-87.76496', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (368, '300 W. Adams', 'Suite 35', 'Chicago', '', 'Illinois', 'US', '60606', '41.879676', '-87.63560', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (369, '1305 N. Hamlin', '', 'Chicago', '', 'Illinois', 'US', '60651', '41.904957', '-87.72091', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (370, '1601 W. Taylor', '', 'Chicago', '', 'Illinois', 'US', '60612', '41.868619', '-87.66747', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (371, '3658 South Wentworth Avenue', '', 'Chicago', '', 'Illinois', 'US', '60609', '41.827599', '-87.63182', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (372, '2216 S. Wentworkth', '', 'Chicago', '', 'Illinois', 'US', '60616', '41.852396', '-87.63229', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (373, '1550 Bishop Court', '', 'Mount Prospect', '', 'Illinois', 'US', '60056', '42.080222', '-87.90996', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (374, 'PO Box 621', '', 'Blue Island', '', 'Illinois', 'US', '60406', '41.677433', '-87.65056', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (375, '11310 S. Forest Avenue', '', 'Chicago', '', 'Illinois', 'US', '60628', '41.688772', '-87.61581', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (376, '127 N. Leamington Ave', '', 'Chicago', '', 'Illinois', 'US', '60644', '41.882571', '-87.75374', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (377, '710 S Paulina Street', '4th Floor', 'Chicago', '', 'Illinois', 'US', '60612', '41.872518', '-87.66936', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (378, '752 E. 114th St', '', 'Chicago', '', 'Illinois', 'US', '60628', '41.688526', '-87.60297', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (379, '800 S. Genessee St.', '', 'Waukegan', '', 'Illinois', 'US', '60085', '42.344974', '-87.83277', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (380, '10540 S. Halsted', '', 'Chicago', '', 'Illinois', 'US', '60628', '41.701906', '-87.64285', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (381, '1500 S. California Ave', '', 'Chicago', '', 'Illinois', 'US', '60608', '41.861110', '-87.69401', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (382, '2640 Park Dr.', 'St. John the Evangelist', 'Flossmoor', '', 'Illinois', 'US', '60422', '41.544965', '-87.68215', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (383, '1507 W. Sunnyside,', '', 'Chicago', '', 'Illinois', 'US', '60640', '41.963271', '-87.66815', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (384, '1000 N. Orleans St', '', 'Chicago', '', 'Illinois', 'US', '60610', '41.901182', '-87.63746', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (385, '9015 South Harper,', '', 'Chicago', '', 'Illinois', 'US', '60619', '41.731275', '-87.58632', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (386, '120 Els St', '', 'Barrington', '', 'Illinois', 'US', '60010', '42.155506', '-88.13361', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (387, '2508 Walnut St.', '', 'Blue Island', '', 'Illinois', 'US', '60406', '41.660025', '-87.68318', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (388, '813 W. Roosevelt Rd.', '', 'Chicago', '', 'Illinois', 'US', '60608', '41.867001', '-87.64755', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (389, '2451 N. Lamon', '', 'Chicago', '', 'Illinois', 'US', '60639', '41.925443', '-87.74879', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (390, '1220 W. Catalpa', '', 'Chicago', '', 'Illinois', 'US', '60640', '41.981799', '-87.66091', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (391, '5129 Wolf Rd', '', 'Western Springs', '', 'Illinois', 'US', '60558', '41.795748', '-87.89680', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (392, '211 E. 115th St.', '', 'Chicago', '', 'Illinois', 'US', '60628', '41.685298', '-87.61711', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (393, '10501 S. Torrence Ave.', '', 'Chicago', '', 'Illinois', 'US', '60617', '41.704556', '-87.55960', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (394, '2649 N. Francisco Ave.', '', 'Chicago', '', 'Illinois', 'US', '60647', '41.930255', '-87.69976', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (395, '2649 N. Francisco Ave.', '', 'Chicago', '', 'Illinois', 'US', '60647', '41.930255', '-87.69976', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (396, '832 N. Leclaire Ave', '', 'Chicago', '', 'Illinois', 'US', '60651', '41.896046', '-87.75346', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (397, '144 E Palatine Rd', '', 'Palatine', '', 'Illinois', 'US', '60067', '42.110979', '-88.03937', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (398, '7100 N. Ashland Ave.', '', 'Chicago', '', 'Illinois', 'US', '60626', '42.011483', '-87.67015', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (399, '1910 S. Ashland Ave', '', 'Chicago', '', 'Illinois', 'US', '60622', '41.914879', '-87.66785', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (400, '1210 W. 78th Place', '', 'Chicago', '', 'Illinois', 'US', '60620', '41.751804', '-87.65417', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (401, '3042 W. Washington', '', 'Chicago', '', 'Illinois', 'US', '60612', '41.882831', '-87.70291', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (402, '2157 N. Humboldt Blvd', '', 'Chicago', '', 'Illinois', 'US', '60647', '41.921225', '-87.70163', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (403, '111 N. County Farm Rd', '', 'Wheaton', '', 'Illinois', 'US', '60187', '41.865846', '-88.14143', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (404, '351 S. Kilbourn', '', 'Chicago', '', 'Illinois', 'US', '60624', '41.875308', '-87.73751', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (405, '6201 S Wolcott Ave', '', 'Chicago', '', 'Illinois', 'US', '60636', '41.781044', '-87.67116', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (406, '208 S. LaSalle Street', 'Suite 900', 'Chicago', '', 'Illinois', 'US', '60604', '41.879159', '-87.63262', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (407, '1151 W. Leland Ave', '', 'Chicago', '', 'Illinois', 'US', '60640', '41.967119', '-87.65914', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (408, '501 S. Emerson', '', 'Mt Prospect', '', 'Illinois', 'US', '60056', '42.057240', '-87.93473', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (439, '1801 West Taylor Street', '4th Floor', 'Chicago', '', 'Illinois', 'US', '60612', '41.869704', '-87.67154', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (440, '1551 W. 95th St.', '', 'Chicago', '', 'Illinois', 'US', '60643', '41.721075', '-87.66115', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (441, '1415 West 104th Street', '', 'Chicago', '', 'Illinois', 'US', '60643', '41.704789', '-87.65798', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (442, '210 South Avenue', '', 'Waukegan', '', 'Illinois', 'US', '60085', '42.349542', '-87.83230', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (443, '400 W. 95th Street', '', 'Chicago', '', 'Illinois', 'US', '60628', '41.722369', '-87.63424', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (444, '1107 N Pulaski Rd', '', 'Chicago', '', 'Illinois', 'US', '60651', '41.901138', '-87.72589', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (445, '8324 N. Skokie Blvd', '', 'Skokie', '', 'Illinois', 'US', '60077', '42.032332', '-87.74779', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (446, '910 W Castlewood Terrace', '', 'Chicago', '', 'Illinois', 'US', '60640', '41.971062', '-87.65297', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (447, '4242 W. Roosevelt', '', 'Chicago', '', 'Illinois', 'US', '60624', '41.866283', '-87.73147', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (448, '40 S. 19th Ave.', '', 'Maywood', '', 'Illinois', 'US', '60153', '41.888610', '-87.85672', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (454, '6525 W. Irving Park Rd.', '', 'Chicago', '', 'Illinois', 'US', '60634', '41.952762', '-87.78977', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (455, '1212 W. Balmoral Ave.', '', 'Chicago', '', 'Illinois', 'US', '60640', '41.980242', '-87.66082', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (456, '259 E. Central Rd', '', 'Des Plaines', '', 'Illinois', 'US', '60016', '42.065851', '-87.91711', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (457, '15704 Park Ave.', '', 'Harvey', '', 'Illinois', 'US', '60426', '41.604236', '-87.64673', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (459, '845 S. Damen', '5th Floor', 'Chicago', '', 'Illinois', 'US', '60612', '41.870043', '-87.67547', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (460, '2902 W. 159th Street', '', 'Markham', '', 'Illinois', 'US', '60428', '41.600908', '-87.68749', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (461, '3456 W. Flournoy Ave', '', 'Chicago', '', 'Illinois', 'US', '60624', '41.873024', '-87.71289', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (462, '201 E. 95th St.', '', 'Chicago', '', 'Illinois', 'US', '60619', '41.721755', '-87.61893', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (463, '4800 W. Chicago', '', 'Chicago', '', 'Illinois', 'US', '60651', '41.895480', '-87.74592', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (465, '6401 N. Artesian Ave.', '', 'Chicago', '', 'Illinois', 'US', '60654', '41.998043', '-87.69085', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (464, '2813 W. 147th St.', '', 'Posen', '', 'Illinois', 'US', '60469', '41.625824', '-87.68929', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (325, '25 E. Pearson St.', '', 'Chicago', '', 'Illinois', 'US', '60611', '41.897677', '-87.62704', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (324, '25 E. Pearson St.', '', 'Chicago', '', 'Illinois', 'US', '60611', '41.897677', '-87.62704', NULL, NULL, NULL, NULL);
INSERT INTO location VALUES (466, '', '', 'Washington', '', 'District of Columbia', 'US', '20003', '38.8791981', '-76.9818437', NULL, 'ChIJjf41p7S5t4kRccykrHctqME', '1600 Pennsylvania Ave SE, Washington, DC 20003, USA', 'Southeast Washington');
INSERT INTO location VALUES (467, '', '', 'Washington', '', 'District of Columbia', 'US', '20003', '38.8791981', '-76.9818437', NULL, 'ChIJjf41p7S5t4kRccykrHctqME', '1600 Pennsylvania Ave SE, Washington, DC 20003, USA', 'Southeast Washington');
INSERT INTO location VALUES (468, '', '', 'Happy Valley', 'Clackamas County', 'Oregon', 'US', '97086', '45.4294153', '-122.4974471', NULL, 'ChIJ91JVl2-elVQRoKzl-jtFZ98', '16000 SE Misty Dr, Happy Valley, OR 97086, USA', 'Rock Creek');
INSERT INTO location VALUES (469, '', '', 'Washington', '', 'District of Columbia', 'US', '20003', '38.8791981', '-76.9818437', NULL, 'ChIJjf41p7S5t4kRccykrHctqME', '1600 Pennsylvania Ave SE, Washington, DC 20003, USA', 'Southeast Washington');
INSERT INTO location VALUES (470, '', '', 'Washington', '', 'District of Columbia', 'US', '20003', '38.8791981', '-76.9818437', NULL, 'ChIJjf41p7S5t4kRccykrHctqME', '1600 Pennsylvania Ave SE, Washington, DC 20003, USA', 'Southeast Washington');
INSERT INTO location VALUES (471, '', '', 'Evanston', 'Cook County', 'Illinois', 'US', '60202', '42.026978', '-87.675194', NULL, 'Eik0MDAgU291dGggQmx2ZCBhLCBFdmFuc3RvbiwgSUwgNjAyMDIsIFVTQQ', '400 South Blvd a, Evanston, IL 60202, USA', '');
INSERT INTO location VALUES (472, '', '', 'Washington', '', 'District of Columbia', 'US', '20003', '38.8791981', '-76.9818437', NULL, 'ChIJjf41p7S5t4kRccykrHctqME', '1600 Pennsylvania Ave SE, Washington, DC 20003, USA', 'Southeast Washington');
INSERT INTO location VALUES (473, '', '', 'Evanston', 'Cook County', 'Illinois', 'US', '60202', '42.026978', '-87.675194', NULL, 'Eik0MDAgU291dGggQmx2ZCBhLCBFdmFuc3RvbiwgSUwgNjAyMDIsIFVTQQ', '400 South Blvd a, Evanston, IL 60202, USA', '');
INSERT INTO location VALUES (474, '', '', 'Chicago', 'Cook County', 'Illinois', 'US', '60604', '41.879044', '-87.6318635', NULL, 'ChIJiXkyQrwsDogRq9ODnpBjFBY', '209 S LaSalle St, Chicago, IL 60604, USA', 'Chicago Loop');
INSERT INTO location VALUES (475, '', '', 'Happy Valley', 'Clackamas County', 'Oregon', 'US', '97086', '45.4572', '-122.5623907', NULL, 'Ejw5NzAxIFNFIEpvaG5zb24gQ3JlZWsgQmx2ZCBtMjAxLCBIYXBweSBWYWxsZXksIE9SIDk3MDg2LCBVU0E', '9701 SE Johnson Creek Blvd m201, Happy Valley, OR 97086, USA', 'West Mount Scott');
INSERT INTO location VALUES (476, '', '', 'Evanston', 'Cook County', 'Illinois', 'US', '60202', '42.026978', '-87.675194', NULL, 'Eik0MDAgU291dGggQmx2ZCBhLCBFdmFuc3RvbiwgSUwgNjAyMDIsIFVTQQ', '400 South Blvd a, Evanston, IL 60202, USA', '');
INSERT INTO location VALUES (477, '', '', 'Evanston', 'Cook County', 'Illinois', 'US', '60202', '42.026978', '-87.675194', NULL, 'Eik0MDAgU291dGggQmx2ZCBhLCBFdmFuc3RvbiwgSUwgNjAyMDIsIFVTQQ', '400 South Blvd a, Evanston, IL 60202, USA', '');
INSERT INTO location VALUES (478, '', '', 'Evanston', 'Cook County', 'Illinois', 'US', '60202', '42.026978', '-87.675194', NULL, 'Eik0MDAgU291dGggQmx2ZCBhLCBFdmFuc3RvbiwgSUwgNjAyMDIsIFVTQQ', '400 South Blvd a, Evanston, IL 60202, USA', '');
INSERT INTO location VALUES (479, '', '', 'Evanston', 'Cook County', 'Illinois', 'US', '60202', '42.026978', '-87.675194', NULL, 'Eik0MDAgU291dGggQmx2ZCBhLCBFdmFuc3RvbiwgSUwgNjAyMDIsIFVTQQ', '400 South Blvd a, Evanston, IL 60202, USA', '');
INSERT INTO location VALUES (480, '', '', 'Evanston', 'Cook County', 'Illinois', 'US', '60202', '42.026978', '-87.675194', NULL, 'Eik0MDAgU291dGggQmx2ZCBhLCBFdmFuc3RvbiwgSUwgNjAyMDIsIFVTQQ', '400 South Blvd a, Evanston, IL 60202, USA', '');
INSERT INTO location VALUES (481, '', '', 'Baltimore', 'Baltimore County', 'Maryland', 'US', '21244', '39.313434', '-76.750379', NULL, 'ChIJEaHwUE8ZyIkRCQtvxlVXOCM', '6968 Security Blvd, Baltimore, MD 21244, USA', '');
INSERT INTO location VALUES (482, '', '', 'Baltimore', 'Baltimore County', 'Maryland', 'US', '21244', '39.313434', '-76.750379', NULL, 'ChIJEaHwUE8ZyIkRCQtvxlVXOCM', '6968 Security Blvd, Baltimore, MD 21244, USA', '');
INSERT INTO location VALUES (483, '', '', 'Baltimore', 'Baltimore County', 'Maryland', 'US', '21244', '39.313434', '-76.750379', NULL, 'ChIJEaHwUE8ZyIkRCQtvxlVXOCM', '6968 Security Blvd, Baltimore, MD 21244, USA', '');
INSERT INTO location VALUES (484, '', '', 'Baltimore', 'Baltimore County', 'Maryland', 'US', '21244', '39.313434', '-76.750379', NULL, 'ChIJEaHwUE8ZyIkRCQtvxlVXOCM', '6968 Security Blvd, Baltimore, MD 21244, USA', '');
INSERT INTO location VALUES (485, '', '', 'Washington', '', 'District of Columbia', 'US', '20500', '38.8976758', '-77.0364827', NULL, 'ChIJcw5BAI63t4kRj5qZY1MSyAo', '1600 Pennsylvania Ave NW, Washington, DC 20500, USA', 'Northwest Washington');
INSERT INTO location VALUES (486, '', '', 'Washington', '', 'District of Columbia', 'US', '20500', '38.8976758', '-77.0364827', NULL, 'ChIJcw5BAI63t4kRj5qZY1MSyAo', '1600 Pennsylvania Ave NW, Washington, DC 20500, USA', 'Northwest Washington');
INSERT INTO location VALUES (487, '', '', 'Happy Valley', 'Clackamas County', 'Oregon', 'US', '97086', '45.4572', '-122.5623907', NULL, 'Ejw5NzAxIFNFIEpvaG5zb24gQ3JlZWsgQmx2ZCBtMjAxLCBIYXBweSBWYWxsZXksIE9SIDk3MDg2LCBVU0E', '9701 SE Johnson Creek Blvd m201, Happy Valley, OR 97086, USA', 'West Mount Scott');
INSERT INTO location VALUES (488, '', '', 'Happy Valley', 'Clackamas County', 'Oregon', 'US', '97086', '45.4572', '-122.5623907', NULL, 'Ejw5NzAxIFNFIEpvaG5zb24gQ3JlZWsgQmx2ZCBtMjAxLCBIYXBweSBWYWxsZXksIE9SIDk3MDg2LCBVU0E', '9701 SE Johnson Creek Blvd m201, Happy Valley, OR 97086, USA', 'West Mount Scott');
INSERT INTO location VALUES (489, '', '', 'San Diego', 'San Diego County', 'California', 'US', '92154', '32.5641645', '-116.9452974', NULL, 'ChIJa6RHnPxG2YAR0NwtWOat2S4', 'CA-11, San Diego, CA 92154, USA', '');
INSERT INTO location VALUES (490, '', '', 'Oklahoma City', 'Oklahoma County', 'Oklahoma', 'US', '73118', '35.517322', '-97.534806', NULL, 'ChIJL0gXvBoasocRF5gVOTH4Qbc', '4509 N Classen Blvd, Oklahoma City, OK 73118, USA', 'Woodland Park');
INSERT INTO location VALUES (491, '', '', 'Happy Valley', 'Clackamas County', 'Oregon', 'US', '97086', '45.4572', '-122.5623907', NULL, 'Ejw5NzAxIFNFIEpvaG5zb24gQ3JlZWsgQmx2ZCBtMjAxLCBIYXBweSBWYWxsZXksIE9SIDk3MDg2LCBVU0E', '9701 SE Johnson Creek Blvd m201, Happy Valley, OR 97086, USA', 'West Mount Scott');
INSERT INTO location VALUES (492, '', '', 'Oklahoma City', 'Oklahoma County', 'Oklahoma', 'US', '73118', '35.517322', '-97.534806', NULL, 'ChIJL0gXvBoasocRF5gVOTH4Qbc', '4509 N Classen Blvd, Oklahoma City, OK 73118, USA', 'Woodland Park');
INSERT INTO location VALUES (493, '', '', 'Happy Valley', 'Clackamas County', 'Oregon', 'US', '97086', '45.4572', '-122.5623907', NULL, 'Ejw5NzAxIFNFIEpvaG5zb24gQ3JlZWsgQmx2ZCBtMjAxLCBIYXBweSBWYWxsZXksIE9SIDk3MDg2LCBVU0E', '9701 SE Johnson Creek Blvd m201, Happy Valley, OR 97086, USA', 'West Mount Scott');
INSERT INTO location VALUES (494, '', '', 'Oklahoma City', 'Oklahoma County', 'Oklahoma', 'US', '73118', '35.517322', '-97.534806', NULL, 'ChIJL0gXvBoasocRF5gVOTH4Qbc', '4509 N Classen Blvd, Oklahoma City, OK 73118, USA', 'Woodland Park');
INSERT INTO location VALUES (495, '', '', 'Happy Valley', 'Clackamas County', 'Oregon', 'US', '97086', '45.4572', '-122.5623907', NULL, 'ChIJB9QhWsKflVQRm4l-CbFU_3Y', '9701 SE Johnson Creek Blvd, Happy Valley, OR 97086, USA', 'West Mount Scott');
INSERT INTO location VALUES (496, '', '', 'Oklahoma City', 'Oklahoma County', 'Oklahoma', 'US', '73118', '35.517322', '-97.534806', NULL, 'ChIJL0gXvBoasocRF5gVOTH4Qbc', '4509 N Classen Blvd, Oklahoma City, OK 73118, USA', 'Woodland Park');
INSERT INTO location VALUES (497, '9701 SE Johnson Creek Blvd', '', 'Happy Valley', '', 'State', 'AA', '', '', '', NULL, '', '', '');
INSERT INTO location VALUES (498, '', '', 'Happy Valley', 'Clackamas County', 'Oregon', 'US', '97086', '45.4572', '-122.5623907', NULL, 'Ejw5NzAxIFNFIEpvaG5zb24gQ3JlZWsgQmx2ZCBtMjAxLCBIYXBweSBWYWxsZXksIE9SIDk3MDg2LCBVU0E', '9701 SE Johnson Creek Blvd m201, Happy Valley, OR 97086, USA', 'West Mount Scott');
INSERT INTO location VALUES (499, '', '', 'State College', 'Centre County', 'Pennsylvania', 'US', '16803', '40.8023682', '-77.8845362', NULL, 'ChIJBUjWZNWnzokRgR85jgPvsfM', 'Johnson Terrace, State College, PA 16803, USA', '');
INSERT INTO location VALUES (500, '400 South Blvd, Unit A', '', 'Evanston', '', 'State', 'US', '', '', '', NULL, '', '', '');
INSERT INTO location VALUES (501, '', '', 'Oklahoma City', 'Oklahoma County', 'Oklahoma', 'US', '73118', '35.517322', '-97.534806', NULL, 'ChIJL0gXvBoasocRF5gVOTH4Qbc', '4509 N Classen Blvd, Oklahoma City, OK 73118, USA', 'Woodland Park');
INSERT INTO location VALUES (502, '', '', 'Oklahoma City', 'Oklahoma County', 'Oklahoma', 'US', '73118', '35.517322', '-97.534806', NULL, 'ChIJL0gXvBoasocRF5gVOTH4Qbc', '4509 N Classen Blvd, Oklahoma City, OK 73118, USA', 'Woodland Park');
INSERT INTO location VALUES (503, '', '', 'Evanston', 'Cook County', 'Illinois', 'US', '60202', '42.026978', '-87.675194', NULL, 'Eik0MDAgU291dGggQmx2ZCBhLCBFdmFuc3RvbiwgSUwgNjAyMDIsIFVTQQ', '400 South Blvd a, Evanston, IL 60202, USA', '');
INSERT INTO location VALUES (504, '', '', 'Washington', '', 'District of Columbia', 'US', '20008', '38.9490396', '-77.0669841', NULL, 'ChIJh1DkacjJt4kRIQEw9tKIoyg', '4530 Connecticut Ave NW, Washington, DC 20008, USA', 'Wakefield');
INSERT INTO location VALUES (505, '', '', 'Evanston', 'Cook County', 'Illinois', 'US', '60202', '42.026978', '-87.675194', NULL, 'Eik0MDAgU291dGggQmx2ZCBhLCBFdmFuc3RvbiwgSUwgNjAyMDIsIFVTQQ', '400 South Blvd a, Evanston, IL 60202, USA', '');
INSERT INTO location VALUES (506, '', '', 'Prospect Park', 'Delaware County', 'Pennsylvania', 'US', '19076', '39.8932273', '-75.3083767', NULL, 'EjExNjAwIFdhc2hpbmd0b24gQXZlLCBQcm9zcGVjdCBQYXJrLCBQQSAxOTA3NiwgVVNB', '1600 Washington Ave, Prospect Park, PA 19076, USA', '');
INSERT INTO location VALUES (507, '', '', 'Evanston', 'Cook County', 'Illinois', 'US', '60201', '42.0466618', '-87.6829625', NULL, 'ChIJZe3kdg7QD4gRsmaJYHkGM2w', '820 Davis St, Evanston, IL 60201, USA', '');
INSERT INTO location VALUES (508, '', '', 'Evanston', 'Cook County', 'Illinois', 'US', '60201', '42.0481872', '-87.6830295', NULL, 'ChIJj22JnA7QD4gRopuz_-n7Xac', '820 Church St, Evanston, IL 60201, USA', '');
INSERT INTO location VALUES (509, '', '', 'Evanston', 'Cook County', 'Illinois', 'US', '60201', '42.0481872', '-87.6830295', NULL, 'ChIJj22JnA7QD4gRopuz_-n7Xac', '820 Church St, Evanston, IL 60201, USA', '');
INSERT INTO location VALUES (510, '', '', 'Evanston', 'Cook County', 'Illinois', 'US', '60201', '42.0481872', '-87.6830295', NULL, 'ChIJj22JnA7QD4gRopuz_-n7Xac', '820 Church St, Evanston, IL 60201, USA', '');
INSERT INTO location VALUES (511, '', '', 'Washington', '', 'District of Columbia', 'US', '20500', '38.8976633', '-77.0365739', NULL, 'ChIJGVtI4by3t4kRr51d_Qm_x58', '1600 Pennsylvania Ave NW, Washington, DC 20500, USA', 'Northwest Washington');


--
-- Name: location_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbri_devnexus
--

SELECT pg_catalog.setval('location_id_seq', 511, true);


--
-- Data for Name: message; Type: TABLE DATA; Schema: public; Owner: northbri_devnexus
--

INSERT INTO message VALUES (84, 176, '[Nexus] Personal Message', 'test', NULL, '2014-09-22 02:18:23.272732+00');
INSERT INTO message VALUES (85, 176, '[Nexus] Personal Message', 'Test', NULL, '2014-09-22 02:18:34.723901+00');
INSERT INTO message VALUES (87, 232, '[Nexus] Personal Message', 'Like, who wants to see your mug anyway??? :)', NULL, '2014-12-05 18:14:23.563131+00');
INSERT INTO message VALUES (88, 233, '[Nexus] Personal Message', 'Hello1.', NULL, '2014-12-20 16:57:55.98915+00');
INSERT INTO message VALUES (89, 233, '[Nexus] Personal Message', 'Hello2', NULL, '2014-12-20 19:22:33.978898+00');
INSERT INTO message VALUES (90, 233, '[Nexus] Personal Message', 'Hello3', NULL, '2014-12-20 19:49:40.885398+00');
INSERT INTO message VALUES (91, 233, '[Nexus] Personal Message', 'Hello3', NULL, '2014-12-20 19:59:01.378765+00');
INSERT INTO message VALUES (92, 233, '[Nexus] Personal Message', 'Hello5', NULL, '2014-12-21 04:20:50.263118+00');
INSERT INTO message VALUES (93, 233, '[Nexus] Personal Message', 'Hello7', NULL, '2014-12-21 04:26:24.172076+00');
INSERT INTO message VALUES (94, 233, '[Nexus] Personal Message', 'asd', NULL, '2014-12-22 03:39:19.123888+00');
INSERT INTO message VALUES (95, 233, '[Nexus] Personal Message', 'asdf', NULL, '2014-12-22 03:42:33.965128+00');
INSERT INTO message VALUES (96, 233, '[Nexus] Personal Message', 'asd', NULL, '2014-12-22 03:43:27.729976+00');
INSERT INTO message VALUES (97, 233, '[Nexus] Personal Message', 'test', NULL, '2014-12-22 03:51:19.253193+00');
INSERT INTO message VALUES (98, 233, '[Nexus] Personal Message', 'asd', NULL, '2014-12-22 03:54:58.924843+00');
INSERT INTO message VALUES (99, 233, '[Nexus] Personal Message', 'Test email', NULL, '2015-01-04 15:03:32.304913+00');
INSERT INTO message VALUES (100, 233, '[Nexus] Personal Message', 'Test - this should puke', NULL, '2015-01-05 22:36:36.415242+00');
INSERT INTO message VALUES (101, 233, '[Nexus] Personal Message', 'Test message - this should not puke.', NULL, '2015-01-05 22:38:53.72531+00');
INSERT INTO message VALUES (102, 233, '[Nexus] Personal Message', 'Test - this should not puke and should also actually work.', NULL, '2015-01-05 22:48:42.670301+00');
INSERT INTO message VALUES (103, 233, '[Nexus] Personal Message', 'Test message from dev', NULL, '2015-01-15 17:25:56.126378+00');
INSERT INTO message VALUES (104, 233, '[Nexus] Personal Message', 'Test message from Directory', NULL, '2015-01-15 17:27:42.278126+00');
INSERT INTO message VALUES (105, 88, '[Nexus] Personal Message', 'test message from nexus in dev', NULL, '2015-09-09 17:07:38.49207+00');


--
-- Name: message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbri_devnexus
--

SELECT pg_catalog.setval('message_id_seq', 105, true);


--
-- Data for Name: message_recipient; Type: TABLE DATA; Schema: public; Owner: northbri_devnexus
--

INSERT INTO message_recipient VALUES (91, 232, '0def30b3-2144-ce59-39ce-dbef25d597e8', 'SENT');
INSERT INTO message_recipient VALUES (91, 233, 'ef946f8e-fcc8-b778-0449-6ac04f762a0e', 'SENT');
INSERT INTO message_recipient VALUES (99, 233, 'e53b5eed-7e35-5bfc-bbea-bcab23347aff', 'SENT');
INSERT INTO message_recipient VALUES (100, 233, 'b5d757e1-d303-076c-4d44-0756f1f295f0', 'SENT');
INSERT INTO message_recipient VALUES (102, 233, 'ec95903f-99c6-54f6-10c7-1c260a81366c', 'SENT');
INSERT INTO message_recipient VALUES (103, 232, '43fd59e2-f305-e8de-6172-2045d2d4ad96', 'SENT');
INSERT INTO message_recipient VALUES (104, 232, 'bf81c418-f67e-5358-ca78-c53c56e55162', 'SENT');
INSERT INTO message_recipient VALUES (88, 232, 'b56bf855-d10c-5958-5f04-1bc4143be16e', 'SENT');
INSERT INTO message_recipient VALUES (89, 232, 'cdfd51af-db2a-7291-4dd2-2737a9835daa', 'SENT');
INSERT INTO message_recipient VALUES (90, 232, '622ae248-2215-5a8b-41ea-27b2758e6faa', 'SENT');
INSERT INTO message_recipient VALUES (90, 233, 'e41bda5e-f87b-ca77-cd96-ee2501e5833e', 'SENT');
INSERT INTO message_recipient VALUES (92, 232, '27f031d2-aa89-6d2f-5317-038035772199', 'SENT');
INSERT INTO message_recipient VALUES (97, 233, '29694734-28e4-80b5-833b-a752339b7814', 'SENT');
INSERT INTO message_recipient VALUES (98, 232, '39d0d988-a145-d81d-2592-3fc3b9db61c0', 'SENT');
INSERT INTO message_recipient VALUES (99, 232, 'd2e34945-4205-a6d5-c090-71d1acd0b724', 'SENT');
INSERT INTO message_recipient VALUES (105, 233, '069a6ff4-be0d-5699-7189-7e62f579c910', 'SENT');
INSERT INTO message_recipient VALUES (105, 248, 'eb257840-babf-9d29-0f3d-9397d8eea69f', 'SENT');
INSERT INTO message_recipient VALUES (105, 88, '93aec0c8-0803-b069-4107-5d41c05a55dd', 'SENT');
INSERT INTO message_recipient VALUES (105, 261, '0570b960-14a4-2fc1-dd5a-80a3c86391d5', 'SENT');
INSERT INTO message_recipient VALUES (105, 252, 'd9a30308-64b2-147d-89d5-a8a30200fe15', 'SENT');
INSERT INTO message_recipient VALUES (105, 253, '9d2cc0ec-9209-dba7-2331-0f060f698425', 'SENT');
INSERT INTO message_recipient VALUES (105, 266, 'a39aeb0f-9879-956e-fa25-d06db3dc45fc', 'SENT');


--
-- Data for Name: organization; Type: TABLE DATA; Schema: public; Owner: northbri_devnexus
--

INSERT INTO organization VALUES (9, 'Oak Lawn Neighborhoods for Peace', NULL, NULL, '2014-05-27 00:36:55.837463+00', NULL, NULL, NULL, NULL, 1, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (12, 'Howard Street Spanish Connections', NULL, NULL, '2014-05-27 00:36:28.32138+00', NULL, NULL, NULL, NULL, 1, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (10, 'Englewood Community Health Services', NULL, NULL, '2014-05-27 00:35:52.322688+00', NULL, NULL, NULL, NULL, 1, 'Health Care Provider', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (45, '30th Ward - St. James Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (46, 'A Just Harvest', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Community Organization', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (47, 'Access Living', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Community Organization', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (48, 'Adalberto Memorial United Methodist Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (52, 'Advocate Parish Nurse Ministry', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (54, 'African Community United Methodist Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (56, 'Agape Family Life Center', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (57, 'Age Options', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Community Organization', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (58, 'Alexian Brothers Parish Services', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Community Organization', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (60, 'Am I My Brothers Keeper', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (61, 'American Cancer Society, Chicago Region', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (62, 'American Heart Association Cultural Health Initiatives', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (63, 'American Kidney Fund', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (64, 'Antioch Telegu Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (65, 'Apostolic Church of God', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (66, 'Apostolic Faith Church Health Professions Ministry', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (68, 'Beacon Light', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (69, 'Bethel Reform Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (70, 'Bikur Cholim (visiting the sick) training', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (71, 'Breast Cancer Network of Strength', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (72, 'Buddhist International Tzu Chi Relief Foundation (Midwest)', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Community Organization', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (73, 'Campaign for Better Health Care', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (74, 'Caring for Health', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (75, 'CARRI (Chicago Area Regional Recovery Initiative)', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Community Organization', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (77, 'Central Spanish Baptist Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (78, 'Chicago Chin Baptist Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (79, 'Chicago Theological Seminary', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (80, 'Chicago Uptown Ministry', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (81, 'Chinmaya Mission Chicago-Badri', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (82, 'Christ Temple Apostolic Faith Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (83, 'Christ the King Lutheran Church ELCA', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (84, 'Christian Churches Caring', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (85, 'Christian Fellowship Flock', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (86, 'Church of Jesus Christ Latter Day Saints', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (87, 'Coalition for Quality and Patient Safety of Chicagoland', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (88, 'Community Health Services and Health Promotion', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (89, 'Community-Outreach Project', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (91, 'Congregational Outreach', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (92, 'Congregational United Church of Christ of Arlington Heights', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (93, 'Consortium to Lower Obesity in Chicago Children (CLOCC)', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (94, 'Cornerstone Community Outreach', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Community Organization', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (95, 'Council of Islamic Organizations of Greater Chicago', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Community Organization', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (97, 'DuPage Department of Public Health', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (98, 'Ebenezer Baptist', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (99, 'Ebenezer Lutheran Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (100, 'Edgewater Presbyterian Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (101, 'Education and Life Coaching', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (102, 'Epworth United Methodist Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (103, 'Evergreen Presbyterian Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (104, 'Exodus Community Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (105, 'Faith Caucus', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (106, 'Faith in Place', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Community Organization', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (107, 'Faith Temple COGIC', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (49, 'Advocate Christ Medical Center', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Health Care Provider', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (96, 'Delegate Church Association of Advocate BroMenn Medical Center', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Collaboration/Network', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (53, 'Advocate United Church of Christ', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (55, 'African-American Alzheimer&apos;s Outreach Initiative', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (59, 'Alzheimer&apos;s Association - Greater Illinois Chapter', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (67, 'B&apos;nai Yehuda Beth Shalom', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (108, 'Faith United Methodist Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (110, 'First Baptist Church, Berwyn', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (111, 'First Baptist Church, LaGrange', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (112, 'First Baptist Church, Park Forest', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (76, 'Center for Faith and Health', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Academic', 'cfcht_logo.png', 'c2007e9b', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (113, 'First Congregational Church of Western Springs', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (114, 'First Evangelical Free Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (115, 'First Grace Missionary Baptist Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (116, 'First New Bethlehem Community Development Corporation', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (117, 'Flossmoor Community Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (118, 'Fourth Presbyterian Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (119, 'Friendly Visits', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (120, 'Friendship Baptist Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (121, 'Gloria Dei Lutheran Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (122, 'God Can Ministries', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (123, 'Grace Calvary United Methodist Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (124, 'Grace Calvary United Methodist Church- Gospel Cafe', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (125, 'Grace Evangelical Lutheran Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (126, 'Grace Lutheran Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (127, 'Greater Galilee MB Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (128, 'Greater Galilee Missionary Baptist Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (129, 'Greater Open Door Baptist Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (130, 'Greater Progressive Missionary Baptist Church Baptist Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (131, 'Greater St. John Bible Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (132, 'Greater St. Paul A M E C', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (133, 'Greater Walters AME Zion Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (134, 'Hamdard Center for Health and Human Services', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Community Organization', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (135, 'Health Initiatives, West Cook Area', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (136, 'Healthcare Consortium of Illinois', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (137, 'Healthy Dining Chicago Healthy Dining Chicago', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Community Organization', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (138, 'Healthy Spirit Healthy Soul', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (139, 'Hispanocare - Chicago', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (140, 'Hyde Park Christian Reformed Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (141, 'Illinois Faith Based Emergency Preparedness Initiative', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Government', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (142, 'Illinois Maternal and Child Health Coalition', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (143, 'Illinois PIRG', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (145, 'Imagine Chicago', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (146, 'Inner City Muslim Action Network', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Community Organization', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (148, 'Islamic Community Center', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (149, 'Islamic Foundation of Villa Park', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (150, 'Ismaili Center in Chicago', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (151, 'Ismaili Center in Glenview', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (152, 'Jesus Name Apostolic Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (153, 'Jewish Child and Family Services', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Community Organization', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (154, 'Jewish Community Emergency Resiliency Team', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Community Organization', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (155, 'Jewish Healing Network of Chicago', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (156, 'Jewish School-Based Wellness Initiative', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (157, 'Joshua Missionary Baptist Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (158, 'Journey Community Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (159, 'Joy To Be Fit Gospel Aerobics Ministry', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (160, 'Kenwood UCC', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (161, 'Kimball Ave. Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (162, 'La Academia', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (163, 'Lakeview Presbyterian Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (164, 'Latino Community Program', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (166, 'Lead Safe Housing Initiatives', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (167, 'lead safe illinois', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (168, 'Leadership and Church Development', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (169, 'Liberty Baptist', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (170, 'Lilydale Baptist Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (171, 'Lincoln United Methodist Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (172, 'Little Brothers - Friends of the Elderly, Chicago Chapter', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (173, 'Lively Stone Missonary Baptist Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (174, 'Living Well Ministries', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (175, 'Lutheran Church of Atonement', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (176, 'Lutheran Church of the Ascension', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (144, 'Illinois Women&apos;s Health Registry', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (147, 'Institute for Women&apos;s Health Research', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (178, 'Lutheran Social Services of Illinois', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Community Organization', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (179, 'M.I.K.E. Minority Intervention and Kidney Education Program', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (180, 'Ministry to New Moms', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (181, 'Montrose Baptist Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (182, 'Monument of Faith Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (183, 'Mosque Foundation', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (185, 'Most Blessed Trinity Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (186, 'Mount Calvary Baptist Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (187, 'Mount Pisgah Ministries', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (188, 'Myanmar Christian Church of Metro Chicago', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (189, 'New Hope Bible Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (190, 'New Life Baptist Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (191, 'New Life Community Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (192, 'New Life Covenant Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (193, 'New Life Worship Center', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (194, 'New Mt.Pilgrim MB Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (195, 'New Pasadena MB Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (196, 'North Park Theological Seminary', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (197, 'North Shore Baptist Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (198, 'North Shore Church of Christ', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (199, 'Northfield Presbyterian Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (200, 'Northside P.O.W.E.R.', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (201, 'Nuestra Senora de Gaudalupe', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (202, 'Older Adult Programs', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (203, 'Our Lady of Fatima Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (204, 'Our Lady of Good Counsel', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (205, 'Park Manor Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (206, 'Park Ridge Community Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (207, 'Peace Lutheran Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (209, 'Peoples Church of Chicago', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (210, 'Pilgrim Faith United Church of Christ', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (211, 'Pillar of Love UCC', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (212, 'Pleasant Ridge Baptist Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (213, 'Polish Community', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (214, 'Primera Iglesia Congregacional', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (215, 'Program of Religion/Spirituality and Mental Health', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (216, 'Progressive Baptist Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (217, 'Pui Tak Center', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Community Organization', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (219, 'Rainbow Hospice and Palliative Care', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Community Organization', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (220, 'Redeeming Life Family Worship Center COGIC', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (221, 'Reformation Lutheran Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (222, 'Revelation International Outreach Ministries', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (223, 'Rush University Medical Center', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (224, 'Salem Baptist', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (225, 'Shiloh Baptist Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (226, 'Shiloh Missionary Baptist Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (227, 'Sinai Urban Health Institute', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (228, 'South Suburban Interfaith Ministerial Association', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Community Organization', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (229, 'Spanish Christian Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (230, 'St Matthews United Methodist Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (231, 'St. Ailbe Catholic Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (232, 'St. Anne Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (234, 'St. Francis of Assisi Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (235, 'St. Genevieve Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (236, 'St. Ita Catholic Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (237, 'St. James Lutheran Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (238, 'St. John MB Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (239, 'St. John United Church of Christ', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (243, 'St. Mark International Christian Ch.', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (244, 'St. Paul UCC', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (208, 'People&apos;s Church of the Harvest', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (246, 'St. Pius V. Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (247, 'St. Sabina Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (248, 'St. Stephen AME Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (249, 'St. Sylvester Catholic Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (250, 'Suburban Chicago Interfaith Mental Health Coalition', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Community Organization', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (251, 'Sunrise Missionary Baptist Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (252, 'Temple of Faith Missionary Baptist Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (253, 'The American Heart Association (AHA)', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (254, 'The Buddhist Temple of Chicago', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (255, 'The Christian Aerobics and Fitness Association (CAFA)', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (256, 'The South Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (258, 'Third Baptist Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (259, 'Triedstone Full Gospel Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (260, 'Trinity AME Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (261, 'Trinity United Church of Christ', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (262, 'True Worship Baptist Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (263, 'Turning Point', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Community Organization', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (264, 'Ubumama - Chicago', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (265, 'United Baptist Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (266, 'United Faith Missionary Baptist Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (267, 'United in Faith Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (268, 'Unity Lutheran Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (269, 'Unity Northwest Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (270, 'Universal House of Refuge Center', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (272, 'Victory Christian Assembly Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (273, 'VOCMA Faith Community Baptist Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (274, 'Wesley United Methodist Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (275, 'Westside Health Authority', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (50, 'Advocate Clinical Pastoral Education', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Health Care Provider', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (51, 'Advocate Health Care', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Health Care Provider', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (90, 'Congregational Health Partnerships', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Health Care Provider', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (109, 'Figure Facts LLC', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Health Care Provider', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (165, 'LaVerne Barnes', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Health Care Provider', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (177, 'Lutheran General Hospital - Mission and Spiritual', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Health Care Provider', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (276, 'Wholistic Medical Clinic', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Health Care Provider', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (218, 'Rahab&apos;s House, Inc.', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (233, 'St. Clement&apos;s Episcopal Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (240, 'St. Kevins&apos;s Church', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (241, 'St. Luke&apos;s Lutheran of Logan Square', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (242, 'St. Luke&apos;s Lutheran Church of Logan Square', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (245, 'St. Paul&apos;s Church by-the-Lake', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (257, 'The Unversity of Illinois Medical Center for Women&apos;s Health Associates', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (271, 'University of Illinois&apos; Division of Community Health', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (277, 'ZAM&apos;s Hope Community Resource Center', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Community Organization', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (311, 'enrollTest1', NULL, NULL, '2014-09-19 20:40:43.631133+00', NULL, NULL, NULL, NULL, 3, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (312, 'NorthBridge', NULL, NULL, '2014-09-21 23:26:27.48849+00', NULL, NULL, NULL, NULL, 3, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (313, 'hello', NULL, NULL, '2014-09-22 02:11:58.01089+00', NULL, NULL, NULL, NULL, 3, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (314, 'Test', NULL, NULL, '2014-09-22 16:21:35.069164+00', NULL, NULL, NULL, NULL, 3, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (315, 'jj', NULL, NULL, '2014-09-23 04:47:00.585879+00', NULL, NULL, NULL, NULL, 3, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (316, 'TEst One', NULL, NULL, '2014-09-26 02:12:48.067588+00', NULL, NULL, NULL, NULL, 3, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (317, 'enrollTest1', NULL, NULL, '2014-09-26 22:44:02.798361+00', NULL, NULL, NULL, NULL, 3, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (318, 'whatever', NULL, NULL, '2014-09-27 16:01:54.182716+00', NULL, NULL, NULL, NULL, 3, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (319, 'alzheimer&apos;s', NULL, NULL, '2014-09-30 23:16:51.637938+00', NULL, NULL, NULL, NULL, 3, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (320, 'hoo ha', NULL, NULL, '2014-09-30 23:25:32.63213+00', NULL, NULL, NULL, NULL, 3, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (321, 'Doges', NULL, NULL, '2014-10-13 02:10:43.651878+00', NULL, NULL, NULL, NULL, 3, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (322, 'Lou&apos;s Org', NULL, NULL, '2014-10-13 02:14:10.905038+00', NULL, NULL, NULL, NULL, 3, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (323, 'The Simpsons', NULL, NULL, '2014-10-24 00:50:42.963782+00', NULL, NULL, NULL, NULL, 3, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (324, 'Jafar Org', NULL, NULL, '2014-10-24 00:57:02.024597+00', NULL, NULL, NULL, NULL, 3, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (325, 'volunteer', NULL, NULL, '2014-10-30 02:36:26.979243+00', NULL, NULL, NULL, NULL, 3, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (327, 'test org', NULL, NULL, '2014-11-16 00:38:33.816072+00', NULL, NULL, NULL, NULL, 3, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (328, 'Org1', NULL, NULL, '2014-12-03 06:06:49.833143+00', NULL, NULL, NULL, NULL, 3, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (329, 'north', NULL, NULL, '2014-12-08 22:15:49.33456+00', NULL, NULL, NULL, NULL, 3, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (332, 'The Sunflower Foundation (Australia) Inc. &reg;', NULL, NULL, '2015-09-11 15:43:17.986956+00', NULL, '2015-09-11 15:43:17.986956+00', NULL, true, 1, NULL, 'sunflower_foundation.jpg', '3000356e', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (184, 'Mosque of Umar Inc.', NULL, NULL, '2014-07-31 21:02:26.883384+00', NULL, '2014-07-31 21:02:26.883384+00', NULL, NULL, 1, 'Faith Community/House of Worship', '', '9e4aec7d', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (330, 'The Demo Organization', NULL, NULL, '2015-07-24 00:28:12.977752+00', NULL, '2015-07-24 00:28:12.977752+00', NULL, true, 1, NULL, 'demo.jpg', '12345678', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (331, 'The Test Organization', NULL, NULL, '2015-09-09 23:12:12.854344+00', NULL, '2015-09-09 23:12:12.854344+00', NULL, true, 1, NULL, 'demo.jpg', '00ba26d5', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (333, 'Nexus Web Meet Demonstration', NULL, NULL, '2015-10-04 00:30:29.25321+00', NULL, '2015-10-04 00:30:29.25321+00', NULL, true, 1, NULL, 'userdemo.png', 'userdemo', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (336, 'Hunger Committee 2', NULL, NULL, '2016-05-10 19:42:05.572207+00', NULL, '2016-05-10 19:42:05.572207+00', NULL, true, 1, NULL, 'edc_logo.png', '82d0833f', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (337, 'Peace and Justice Committee', NULL, NULL, '2016-05-10 20:38:53.038492+00', NULL, '2016-05-10 20:38:53.038492+00', NULL, true, 1, NULL, 'edc_logo.png', '8eb52935', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (346, 'Happy Times Less', NULL, NULL, '2017-03-20 01:27:50.768249+00', NULL, '2017-03-20 01:27:50.768249+00', NULL, NULL, 1, NULL, '', 'bb9a8631', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (339, 'We Love Cats', NULL, NULL, '2017-02-12 21:34:48.303209+00', NULL, '2017-02-12 21:34:48.303209+00', NULL, NULL, 1, NULL, 'lime-cat.jpg', '02f138b9', '16', '15', 10, 22, '17', 138, NULL);
INSERT INTO organization VALUES (1, 'Greater-Chicago Communities Unite!', 'nta', 'nfp', '2014-05-13 21:31:28.774771+00', NULL, '2014-05-16 15:38:22.871587+00', '2014-05-16 15:37:13.939099+00', true, 1, NULL, 'demo.jpg', '87654321', NULL, NULL, NULL, NULL, NULL, 135, NULL);
INSERT INTO organization VALUES (338, 'First New Org in Dev', NULL, NULL, '2017-01-11 22:01:30.149872+00', NULL, '2017-01-11 22:01:30.149872+00', NULL, NULL, 1, NULL, '', '6a9523a5', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (341, 'Kittens and Puppies Can Be Friends', NULL, NULL, '2017-03-12 22:40:46.941773+00', NULL, '2017-03-12 22:40:46.941773+00', NULL, NULL, 1, NULL, '', '6b680047', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (342, 'G''s Peeps', NULL, NULL, '2017-03-20 01:16:45.050524+00', NULL, '2017-03-20 01:16:45.050524+00', NULL, NULL, 1, NULL, '', 'c0345c94', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (18, 'The Demo Network', NULL, NULL, '2014-07-14 22:09:45.885491+00', NULL, '2014-07-14 22:09:45.885491+00', NULL, NULL, 1, NULL, 'demo.jpg', '2518da9e', NULL, NULL, 8, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (343, 'Happy Times', NULL, NULL, '2017-03-20 01:17:10.966397+00', NULL, '2017-03-20 01:17:10.966397+00', NULL, NULL, 1, NULL, '', '9005c074', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (344, 'Disorganization', NULL, NULL, '2017-03-20 01:22:03.132946+00', NULL, '2017-03-20 01:22:03.132946+00', NULL, NULL, 1, NULL, '', '4308bca6', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (13, 'NorthBridge Technology Alliance', NULL, '', '2014-05-27 00:43:41.30068+00', NULL, '2014-05-27 00:43:41.30068+00', NULL, true, 1, NULL, 'demo.jpg', '99999999', '1', '10', NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (340, 'Test NWM Automate Onboard', NULL, NULL, '2017-03-02 23:44:21.42062+00', NULL, '2017-03-02 23:44:21.42062+00', NULL, NULL, 1, NULL, 'demo.jpg', '3f6ab3c2', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (355, 'Testing 123', NULL, NULL, '2017-03-29 23:26:16.2717+00', NULL, '2017-03-29 23:26:16.2717+00', NULL, NULL, 1, NULL, '', '1081a913', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (351, 'Cats in the Cradle', NULL, NULL, '2017-03-29 23:00:17.705463+00', NULL, '2017-03-29 23:00:17.705463+00', NULL, NULL, 1, 'Collaboration/Network', '', 'dafc18ca', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (352, 'Dog''s Who Love Cats', NULL, NULL, '2017-03-29 23:07:59.400349+00', NULL, '2017-03-29 23:07:59.400349+00', NULL, NULL, 1, 'Academic', '', 'b793e1ca', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (353, 'Dogs Are From Mars, Cats Are From Venus', NULL, NULL, '2017-03-29 23:21:48.753451+00', NULL, '2017-03-29 23:21:48.753451+00', NULL, NULL, 1, NULL, '', 'c5115e15', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (356, 'Cats Who Love Dogs', NULL, NULL, '2017-03-29 23:44:45.622079+00', NULL, '2017-03-29 23:44:45.622079+00', NULL, NULL, 1, 'Collaboration/Network', '', '6f4dfa4d', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (349, 'New org to test list refresh', NULL, NULL, '2017-03-29 22:52:44.994895+00', NULL, '2017-03-29 22:52:44.994895+00', NULL, NULL, 1, 'Academic', '', '81aa6326', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (350, 'Cat Has My Tongue', NULL, NULL, '2017-03-29 22:56:24.366384+00', NULL, '2017-03-29 22:56:24.366384+00', NULL, NULL, 1, 'Academic', '', 'b324112c', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (354, 'I Am Getting Frustrated With My Cat', NULL, NULL, '2017-03-29 23:24:31.273605+00', '2017-05-18 00:15:02.670561+00', '2017-03-29 23:24:31.273605+00', '2017-05-18 00:15:02.670561+00', NULL, 1, NULL, '', 'cd8d3a82', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (348, 'Cluttered Living', NULL, NULL, '2017-03-20 01:30:23.668474+00', NULL, '2017-03-20 01:30:23.668474+00', NULL, NULL, 1, 'Academic', '', 'a466da7a', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (345, 'Happy Times More', NULL, NULL, '2017-03-20 01:22:04.256155+00', NULL, '2017-03-20 01:22:04.256155+00', NULL, NULL, 1, 'Academic', '', 'ed9f1850', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (359, 'Meowland', NULL, NULL, '2017-04-10 01:35:41.46369+00', NULL, '2017-04-10 01:35:41.46369+00', NULL, NULL, 1, 'Collaboration/Network', '', '95c9ce87', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (360, 'Kathy&#39;s apostrophe test', NULL, NULL, '2017-04-18 18:35:34.126664+00', NULL, '2017-04-18 18:35:34.126664+00', NULL, NULL, 1, NULL, '', 'ab76125c', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (361, 'Kathy&#38;#39;s apostrophe test', NULL, NULL, '2017-04-18 18:36:44.872273+00', NULL, '2017-04-18 18:36:44.872273+00', NULL, NULL, 1, 'Academic', '', '5e2f3391', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (362, 'Kathy&#39;s apostrophe test #2', NULL, NULL, '2017-04-18 18:53:10.698947+00', NULL, '2017-04-18 18:53:10.698947+00', NULL, NULL, 1, NULL, '', 'c63384f7', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (365, 'XCS2 <script>alert("hello");</script>', NULL, NULL, '2017-04-18 19:02:43.789599+00', NULL, '2017-04-18 19:02:43.789599+00', NULL, NULL, 1, 'Academic', '', 'dcc03a51', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (366, 'another''s', NULL, NULL, '2017-04-18 19:56:14.296339+00', NULL, '2017-04-18 19:56:14.296339+00', NULL, NULL, 1, 'Academic', '', '00b3624f', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (363, 'XCS <script>alert("fixme");</script>', NULL, NULL, '2017-04-18 18:54:17.809795+00', NULL, '2017-04-18 18:54:17.809795+00', NULL, NULL, 1, 'Academic', '', 'eefa87df', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (357, 'Lou"s org', NULL, NULL, '2017-04-10 01:33:47.1239+00', NULL, '2017-04-10 01:33:47.1239+00', NULL, NULL, 1, 'Academic', '', '1fab2d97', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (367, 'Purrfection', NULL, NULL, '2017-05-01 01:07:24.893347+00', NULL, '2017-05-01 01:07:24.893347+00', NULL, NULL, 1, 'Collaboration/Network', '', '36ccef87', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (368, 'Will this work?', NULL, NULL, '2017-05-02 21:25:44.079039+00', NULL, '2017-05-02 21:25:44.079039+00', NULL, NULL, 1, NULL, '', 'b7d13d8f', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (347, 'Cluttered Life', NULL, NULL, '2017-03-20 01:29:11.194251+00', NULL, '2017-03-20 01:29:11.194251+00', NULL, NULL, 1, 'Collaboration/Network', '', 'b2fe0989', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (369, 'Test 5.21.1', NULL, NULL, '2017-05-17 18:33:15.840763+00', NULL, '2017-05-17 18:33:15.840763+00', NULL, NULL, 1, 'Academic', '', '2a533d9c', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (370, 'This is a new one', NULL, NULL, '2017-05-22 02:07:06.600585+00', NULL, '2017-05-22 02:07:06.600585+00', NULL, NULL, 1, 'Academic', '', 'ff41b283', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (358, 'Catariffic', NULL, NULL, '2017-04-10 01:33:57.056679+00', NULL, '2017-04-10 01:33:57.056679+00', NULL, NULL, 1, NULL, '', '13c9f08c', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (371, 'Test Add', NULL, NULL, '2017-06-08 14:57:57.006122+00', NULL, '2017-06-08 14:57:57.006122+00', NULL, NULL, 1, NULL, '', '1b0f5271', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (364, 'Another apostrophe test''s', NULL, NULL, '2017-04-18 19:00:06.270648+00', NULL, '2017-04-18 19:00:06.270648+00', NULL, NULL, 1, 'Collaboration/Network', '', '9b794c12', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (372, 'Test Crm #1', NULL, NULL, '2017-07-20 00:41:28.303774+00', NULL, '2017-07-20 00:41:28.303774+00', NULL, NULL, 1, NULL, 'empty.jpg', 'a4991ce3', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (373, 'Test Crm #1', NULL, NULL, '2017-07-20 00:42:21.928904+00', NULL, '2017-07-20 00:42:21.928904+00', NULL, NULL, 1, NULL, 'empty.jpg', '0d964728', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (374, 'Test Crm #2', NULL, NULL, '2017-07-20 00:52:01.797633+00', NULL, '2017-07-20 00:52:01.797633+00', NULL, NULL, 1, NULL, 'empty.jpg', 'de1cc984', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (375, 'Test Crm #3', NULL, NULL, '2017-07-20 00:55:28.096891+00', NULL, '2017-07-20 00:55:28.096891+00', NULL, NULL, 1, NULL, 'empty.jpg', '18cf8629', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (376, 'Test Crm #4', NULL, NULL, '2017-07-20 01:22:16.797329+00', NULL, '2017-07-20 01:22:16.797329+00', NULL, NULL, 1, NULL, 'empty.jpg', '2f5c094d', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (377, 'Test Crm #5', NULL, NULL, '2017-07-20 02:31:33.90152+00', NULL, '2017-07-20 02:31:33.90152+00', NULL, NULL, 1, NULL, 'empty.jpg', '5b894ba8', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (378, 'Test Crm #6', NULL, NULL, '2017-07-20 02:56:56.444005+00', NULL, '2017-07-20 02:56:56.444005+00', NULL, NULL, 1, NULL, 'empty.jpg', '78d0971a', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (379, 'Test Crm #6', NULL, NULL, '2017-07-26 19:17:58.554296+00', NULL, '2017-07-26 19:17:58.554296+00', NULL, NULL, 1, NULL, 'empty.jpg', '125994d6', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO organization VALUES (380, 'My Committee', NULL, NULL, '2017-07-26 19:28:10.076845+00', NULL, '2017-07-26 19:28:10.076845+00', NULL, NULL, 1, NULL, 'empty.jpg', '03c5779a', NULL, NULL, NULL, NULL, NULL, NULL, NULL);


--
-- Data for Name: organization_account; Type: TABLE DATA; Schema: public; Owner: northbri_devnexus
--

INSERT INTO organization_account VALUES (272, 339, 'ADV');
INSERT INTO organization_account VALUES (8, 1, 'ADV');
INSERT INTO organization_account VALUES (273, 340, 'NWM');
INSERT INTO organization_account VALUES (274, 372, 'NWM');
INSERT INTO organization_account VALUES (276, 374, 'NWM');
INSERT INTO organization_account VALUES (278, 376, 'NWM');
INSERT INTO organization_account VALUES (280, 378, 'NWM');
INSERT INTO organization_account VALUES (281, 379, 'NWM');
INSERT INTO organization_account VALUES (275, 373, 'NWM');
INSERT INTO organization_account VALUES (277, 375, 'NWM');
INSERT INTO organization_account VALUES (279, 377, 'NWM');
INSERT INTO organization_account VALUES (282, 380, 'NWM');
INSERT INTO organization_account VALUES (263, 18, 'ADV');
INSERT INTO organization_account VALUES (264, 13, 'ADV');
INSERT INTO organization_account VALUES (266, 332, 'NWM');
INSERT INTO organization_account VALUES (267, 330, 'NWM');
INSERT INTO organization_account VALUES (268, 331, 'NWM');
INSERT INTO organization_account VALUES (269, 333, 'NWM');
INSERT INTO organization_account VALUES (270, 336, 'NWM');
INSERT INTO organization_account VALUES (271, 337, 'NWM');


--
-- Name: organization_account_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbri_devnexus
--

SELECT pg_catalog.setval('organization_account_id_seq', 282, true);


--
-- Data for Name: organization_affiliation; Type: TABLE DATA; Schema: public; Owner: northbri_devnexus
--



--
-- Name: organization_affiliation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbri_devnexus
--

SELECT pg_catalog.setval('organization_affiliation_id_seq', 119, false);


--
-- Data for Name: organization_contact; Type: TABLE DATA; Schema: public; Owner: northbri_devnexus
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
INSERT INTO organization_contact VALUES (274, 330, 69);
INSERT INTO organization_contact VALUES (275, 338, 277);
INSERT INTO organization_contact VALUES (276, 341, 278);
INSERT INTO organization_contact VALUES (277, 348, 279);
INSERT INTO organization_contact VALUES (278, 349, 280);
INSERT INTO organization_contact VALUES (279, 351, 281);
INSERT INTO organization_contact VALUES (280, 352, 282);
INSERT INTO organization_contact VALUES (281, 355, 283);
INSERT INTO organization_contact VALUES (282, 356, 284);
INSERT INTO organization_contact VALUES (283, 357, 285);
INSERT INTO organization_contact VALUES (284, 359, 286);
INSERT INTO organization_contact VALUES (285, 361, 287);
INSERT INTO organization_contact VALUES (286, 363, 288);
INSERT INTO organization_contact VALUES (287, 364, 289);
INSERT INTO organization_contact VALUES (288, 365, 290);
INSERT INTO organization_contact VALUES (289, 366, 291);
INSERT INTO organization_contact VALUES (290, 357, 292);
INSERT INTO organization_contact VALUES (291, 363, 293);
INSERT INTO organization_contact VALUES (292, 357, 294);
INSERT INTO organization_contact VALUES (293, 349, 295);
INSERT INTO organization_contact VALUES (294, 349, 296);
INSERT INTO organization_contact VALUES (298, 364, 300);
INSERT INTO organization_contact VALUES (299, 364, 301);
INSERT INTO organization_contact VALUES (300, 364, 302);
INSERT INTO organization_contact VALUES (301, 364, 303);
INSERT INTO organization_contact VALUES (302, 364, 304);
INSERT INTO organization_contact VALUES (303, 364, 305);
INSERT INTO organization_contact VALUES (304, 364, 306);
INSERT INTO organization_contact VALUES (305, 364, 307);
INSERT INTO organization_contact VALUES (306, 364, 308);
INSERT INTO organization_contact VALUES (307, 364, 309);
INSERT INTO organization_contact VALUES (308, 364, 310);
INSERT INTO organization_contact VALUES (311, 355, 313);
INSERT INTO organization_contact VALUES (312, 368, 314);
INSERT INTO organization_contact VALUES (313, 368, 315);
INSERT INTO organization_contact VALUES (314, 347, 316);
INSERT INTO organization_contact VALUES (315, 347, 317);
INSERT INTO organization_contact VALUES (316, 369, 318);
INSERT INTO organization_contact VALUES (317, 348, 319);
INSERT INTO organization_contact VALUES (318, 348, 320);
INSERT INTO organization_contact VALUES (319, 369, 321);
INSERT INTO organization_contact VALUES (320, 370, 322);
INSERT INTO organization_contact VALUES (321, 350, 323);
INSERT INTO organization_contact VALUES (322, 358, 324);
INSERT INTO organization_contact VALUES (323, 350, 325);
INSERT INTO organization_contact VALUES (324, 345, 326);
INSERT INTO organization_contact VALUES (325, 371, 327);
INSERT INTO organization_contact VALUES (326, 364, 328);


--
-- Name: organization_contact_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbri_devnexus
--

SELECT pg_catalog.setval('organization_contact_id_seq', 326, true);


--
-- Data for Name: organization_ethnicity; Type: TABLE DATA; Schema: public; Owner: northbri_devnexus
--



--
-- Name: organization_ethnicity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbri_devnexus
--

SELECT pg_catalog.setval('organization_ethnicity_id_seq', 119, false);


--
-- Name: organization_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbri_devnexus
--

SELECT pg_catalog.setval('organization_id_seq', 380, true);


--
-- Data for Name: organization_language; Type: TABLE DATA; Schema: public; Owner: northbri_devnexus
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
-- Name: organization_language_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbri_devnexus
--

SELECT pg_catalog.setval('organization_language_id_seq', 119, true);


--
-- Data for Name: organization_location; Type: TABLE DATA; Schema: public; Owner: northbri_devnexus
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
INSERT INTO organization_location VALUES (466, 338, 466);
INSERT INTO organization_location VALUES (467, 341, 467);
INSERT INTO organization_location VALUES (468, 348, 468);
INSERT INTO organization_location VALUES (470, 351, 470);
INSERT INTO organization_location VALUES (471, 352, 471);
INSERT INTO organization_location VALUES (472, 355, 472);
INSERT INTO organization_location VALUES (473, 356, 473);
INSERT INTO organization_location VALUES (475, 359, 475);
INSERT INTO organization_location VALUES (476, 361, 476);
INSERT INTO organization_location VALUES (479, 365, 479);
INSERT INTO organization_location VALUES (480, 366, 480);
INSERT INTO organization_location VALUES (482, 363, 482);
INSERT INTO organization_location VALUES (483, 357, 483);
INSERT INTO organization_location VALUES (485, 349, 485);
INSERT INTO organization_location VALUES (486, 350, 486);
INSERT INTO organization_location VALUES (499, 364, 499);
INSERT INTO organization_location VALUES (501, 367, 501);
INSERT INTO organization_location VALUES (502, 355, 502);
INSERT INTO organization_location VALUES (503, 368, 503);
INSERT INTO organization_location VALUES (504, 368, 504);
INSERT INTO organization_location VALUES (505, 347, 505);
INSERT INTO organization_location VALUES (506, 347, 506);
INSERT INTO organization_location VALUES (507, 369, 507);
INSERT INTO organization_location VALUES (508, 369, 508);
INSERT INTO organization_location VALUES (509, 370, 509);
INSERT INTO organization_location VALUES (510, 345, 510);
INSERT INTO organization_location VALUES (511, 371, 511);


--
-- Name: organization_location_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbri_devnexus
--

SELECT pg_catalog.setval('organization_location_id_seq', 511, true);


--
-- Data for Name: organization_organization; Type: TABLE DATA; Schema: public; Owner: northbri_devnexus
--

INSERT INTO organization_organization VALUES (1, 1, 10, 'parent', '2014-05-15 20:51:03.396809+00', NULL);
INSERT INTO organization_organization VALUES (3, 1, 12, 'parent', '2014-05-27 01:02:43.508528+00', NULL);
INSERT INTO organization_organization VALUES (4, 1, 9, 'parent', '2014-05-27 01:03:20.140682+00', NULL);
INSERT INTO organization_organization VALUES (38, 18, 45, 'parent', '2014-07-31 21:12:26.905639+00', NULL);
INSERT INTO organization_organization VALUES (39, 18, 46, 'parent', '2014-07-31 21:12:26.929753+00', NULL);
INSERT INTO organization_organization VALUES (40, 18, 47, 'parent', '2014-07-31 21:12:26.951385+00', NULL);
INSERT INTO organization_organization VALUES (41, 18, 48, 'parent', '2014-07-31 21:12:26.971783+00', NULL);
INSERT INTO organization_organization VALUES (42, 18, 49, 'parent', '2014-07-31 21:12:26.992396+00', NULL);
INSERT INTO organization_organization VALUES (43, 18, 50, 'parent', '2014-07-31 21:12:27.017377+00', NULL);
INSERT INTO organization_organization VALUES (44, 18, 51, 'parent', '2014-07-31 21:12:27.038065+00', NULL);
INSERT INTO organization_organization VALUES (45, 18, 52, 'parent', '2014-07-31 21:12:27.059392+00', NULL);
INSERT INTO organization_organization VALUES (46, 18, 53, 'parent', '2014-07-31 21:12:27.08039+00', NULL);
INSERT INTO organization_organization VALUES (47, 18, 54, 'parent', '2014-07-31 21:12:27.109565+00', NULL);
INSERT INTO organization_organization VALUES (48, 18, 55, 'parent', '2014-07-31 21:12:27.138384+00', NULL);
INSERT INTO organization_organization VALUES (49, 18, 56, 'parent', '2014-07-31 21:12:27.164378+00', NULL);
INSERT INTO organization_organization VALUES (50, 18, 57, 'parent', '2014-07-31 21:12:27.187565+00', NULL);
INSERT INTO organization_organization VALUES (51, 18, 58, 'parent', '2014-07-31 21:12:27.209937+00', NULL);
INSERT INTO organization_organization VALUES (52, 18, 59, 'parent', '2014-07-31 21:12:27.234531+00', NULL);
INSERT INTO organization_organization VALUES (53, 18, 60, 'parent', '2014-07-31 21:12:27.26098+00', NULL);
INSERT INTO organization_organization VALUES (54, 18, 61, 'parent', '2014-07-31 21:12:27.290505+00', NULL);
INSERT INTO organization_organization VALUES (55, 18, 62, 'parent', '2014-07-31 21:12:27.3148+00', NULL);
INSERT INTO organization_organization VALUES (56, 18, 63, 'parent', '2014-07-31 21:12:27.339381+00', NULL);
INSERT INTO organization_organization VALUES (57, 18, 64, 'parent', '2014-07-31 21:12:27.364399+00', NULL);
INSERT INTO organization_organization VALUES (58, 18, 65, 'parent', '2014-07-31 21:12:27.390123+00', NULL);
INSERT INTO organization_organization VALUES (59, 18, 66, 'parent', '2014-07-31 21:12:27.413395+00', NULL);
INSERT INTO organization_organization VALUES (60, 18, 67, 'parent', '2014-07-31 21:12:27.435939+00', NULL);
INSERT INTO organization_organization VALUES (61, 18, 68, 'parent', '2014-07-31 21:12:27.457986+00', NULL);
INSERT INTO organization_organization VALUES (62, 18, 69, 'parent', '2014-07-31 21:12:27.481044+00', NULL);
INSERT INTO organization_organization VALUES (63, 18, 70, 'parent', '2014-07-31 21:12:27.502621+00', NULL);
INSERT INTO organization_organization VALUES (64, 18, 71, 'parent', '2014-07-31 21:12:27.526384+00', NULL);
INSERT INTO organization_organization VALUES (65, 18, 72, 'parent', '2014-07-31 21:12:27.551959+00', NULL);
INSERT INTO organization_organization VALUES (66, 18, 73, 'parent', '2014-07-31 21:12:27.623938+00', NULL);
INSERT INTO organization_organization VALUES (67, 18, 74, 'parent', '2014-07-31 21:12:27.650026+00', NULL);
INSERT INTO organization_organization VALUES (68, 18, 75, 'parent', '2014-07-31 21:12:27.672386+00', NULL);
INSERT INTO organization_organization VALUES (69, 18, 76, 'parent', '2014-07-31 21:12:27.706406+00', NULL);
INSERT INTO organization_organization VALUES (70, 18, 77, 'parent', '2014-07-31 21:12:27.77938+00', NULL);
INSERT INTO organization_organization VALUES (71, 18, 78, 'parent', '2014-07-31 21:12:27.800888+00', NULL);
INSERT INTO organization_organization VALUES (72, 18, 79, 'parent', '2014-07-31 21:12:27.822432+00', NULL);
INSERT INTO organization_organization VALUES (73, 18, 80, 'parent', '2014-07-31 21:12:27.852239+00', NULL);
INSERT INTO organization_organization VALUES (74, 18, 81, 'parent', '2014-07-31 21:12:27.873376+00', NULL);
INSERT INTO organization_organization VALUES (75, 18, 82, 'parent', '2014-07-31 21:12:27.906546+00', NULL);
INSERT INTO organization_organization VALUES (76, 18, 83, 'parent', '2014-07-31 21:12:27.930706+00', NULL);
INSERT INTO organization_organization VALUES (77, 18, 84, 'parent', '2014-07-31 21:12:27.951388+00', NULL);
INSERT INTO organization_organization VALUES (78, 18, 85, 'parent', '2014-07-31 21:12:27.971391+00', NULL);
INSERT INTO organization_organization VALUES (79, 18, 86, 'parent', '2014-07-31 21:12:27.991566+00', NULL);
INSERT INTO organization_organization VALUES (80, 18, 87, 'parent', '2014-07-31 21:12:28.023632+00', NULL);
INSERT INTO organization_organization VALUES (81, 18, 88, 'parent', '2014-07-31 21:12:28.065486+00', NULL);
INSERT INTO organization_organization VALUES (82, 18, 89, 'parent', '2014-07-31 21:12:28.08661+00', NULL);
INSERT INTO organization_organization VALUES (83, 18, 90, 'parent', '2014-07-31 21:12:28.108923+00', NULL);
INSERT INTO organization_organization VALUES (84, 18, 91, 'parent', '2014-07-31 21:12:28.129681+00', NULL);
INSERT INTO organization_organization VALUES (85, 18, 92, 'parent', '2014-07-31 21:12:28.153104+00', NULL);
INSERT INTO organization_organization VALUES (86, 18, 93, 'parent', '2014-07-31 21:12:28.182395+00', NULL);
INSERT INTO organization_organization VALUES (87, 18, 94, 'parent', '2014-07-31 21:12:28.204382+00', NULL);
INSERT INTO organization_organization VALUES (88, 18, 95, 'parent', '2014-07-31 21:12:28.227534+00', NULL);
INSERT INTO organization_organization VALUES (89, 18, 96, 'parent', '2014-07-31 21:12:28.250515+00', NULL);
INSERT INTO organization_organization VALUES (90, 18, 97, 'parent', '2014-07-31 21:12:28.271748+00', NULL);
INSERT INTO organization_organization VALUES (91, 18, 98, 'parent', '2014-07-31 21:12:28.29212+00', NULL);
INSERT INTO organization_organization VALUES (92, 18, 99, 'parent', '2014-07-31 21:12:28.312878+00', NULL);
INSERT INTO organization_organization VALUES (93, 18, 100, 'parent', '2014-07-31 21:12:28.334388+00', NULL);
INSERT INTO organization_organization VALUES (329, 18, 18, 'parent', '2017-02-16 16:36:56.374441+00', NULL);
INSERT INTO organization_organization VALUES (331, 13, 340, 'parent', '2017-03-02 23:44:21.452993+00', NULL);
INSERT INTO organization_organization VALUES (2, 13, 1, 'god', '2014-05-27 00:50:47.835112+00', NULL);
INSERT INTO organization_organization VALUES (325, 13, 18, 'god', '2017-02-10 21:55:08.857405+00', NULL);
INSERT INTO organization_organization VALUES (327, 13, 339, 'god', '2017-02-12 21:34:48.322277+00', NULL);
INSERT INTO organization_organization VALUES (333, 339, 341, 'parent', '2017-03-12 22:40:46.967104+00', NULL);
INSERT INTO organization_organization VALUES (334, 339, 342, 'parent', '2017-03-20 01:16:45.08098+00', NULL);
INSERT INTO organization_organization VALUES (336, 339, 344, 'parent', '2017-03-20 01:22:03.154266+00', NULL);
INSERT INTO organization_organization VALUES (338, 339, 346, 'parent', '2017-03-20 01:27:50.803585+00', NULL);
INSERT INTO organization_organization VALUES (340, 339, 348, 'parent', '2017-03-20 01:30:23.686153+00', NULL);
INSERT INTO organization_organization VALUES (341, 339, 349, 'parent', '2017-03-29 22:52:45.018657+00', NULL);
INSERT INTO organization_organization VALUES (343, 339, 351, 'parent', '2017-03-29 23:00:17.738105+00', NULL);
INSERT INTO organization_organization VALUES (345, 339, 353, 'parent', '2017-03-29 23:21:48.81033+00', NULL);
INSERT INTO organization_organization VALUES (347, 1, 355, 'parent', '2017-03-29 23:26:16.293666+00', NULL);
INSERT INTO organization_organization VALUES (349, 339, 357, 'parent', '2017-04-10 01:33:47.139561+00', NULL);
INSERT INTO organization_organization VALUES (351, 339, 359, 'parent', '2017-04-10 01:35:41.467153+00', NULL);
INSERT INTO organization_organization VALUES (352, 339, 360, 'parent', '2017-04-18 18:35:34.142715+00', NULL);
INSERT INTO organization_organization VALUES (354, 339, 362, 'parent', '2017-04-18 18:53:10.73151+00', NULL);
INSERT INTO organization_organization VALUES (356, 339, 364, 'parent', '2017-04-18 19:00:06.300779+00', NULL);
INSERT INTO organization_organization VALUES (358, 339, 366, 'parent', '2017-04-18 19:56:14.315866+00', NULL);
INSERT INTO organization_organization VALUES (359, 339, 367, 'parent', '2017-05-01 01:07:24.909784+00', NULL);
INSERT INTO organization_organization VALUES (360, 1, 368, 'parent', '2017-05-02 21:25:44.098513+00', NULL);
INSERT INTO organization_organization VALUES (361, 339, 369, 'parent', '2017-05-17 18:33:15.86888+00', NULL);
INSERT INTO organization_organization VALUES (362, 339, 370, 'parent', '2017-05-22 02:07:06.624723+00', NULL);
INSERT INTO organization_organization VALUES (363, 339, 371, 'parent', '2017-06-08 14:57:57.051532+00', NULL);
INSERT INTO organization_organization VALUES (364, 13, 372, 'parent', '2017-07-20 00:41:28.493236+00', NULL);
INSERT INTO organization_organization VALUES (366, 13, 373, 'parent', '2017-07-20 00:42:21.956292+00', NULL);
INSERT INTO organization_organization VALUES (368, 13, 374, 'parent', '2017-07-20 00:52:01.835718+00', NULL);
INSERT INTO organization_organization VALUES (370, 13, 375, 'parent', '2017-07-20 00:55:28.124966+00', NULL);
INSERT INTO organization_organization VALUES (372, 13, 376, 'parent', '2017-07-20 01:22:16.816735+00', NULL);
INSERT INTO organization_organization VALUES (374, 13, 377, 'parent', '2017-07-20 02:31:33.920767+00', NULL);
INSERT INTO organization_organization VALUES (376, 13, 378, 'parent', '2017-07-20 02:56:56.471986+00', NULL);
INSERT INTO organization_organization VALUES (378, 13, 379, 'parent', '2017-07-26 19:17:58.563844+00', NULL);
INSERT INTO organization_organization VALUES (380, 13, 380, 'parent', '2017-07-26 19:28:10.121637+00', NULL);
INSERT INTO organization_organization VALUES (326, 13, 13, 'parent', '2017-02-10 22:12:56.665676+00', NULL);
INSERT INTO organization_organization VALUES (328, 339, 339, 'parent', '2017-02-12 22:40:48.16867+00', NULL);
INSERT INTO organization_organization VALUES (330, 1, 1, 'parent', '2017-02-16 16:38:18.105758+00', NULL);
INSERT INTO organization_organization VALUES (332, 340, 340, 'parent', '2017-03-02 23:44:21.462155+00', NULL);
INSERT INTO organization_organization VALUES (335, 339, 343, 'parent', '2017-03-20 01:17:10.982963+00', NULL);
INSERT INTO organization_organization VALUES (337, 339, 345, 'parent', '2017-03-20 01:22:04.260899+00', NULL);
INSERT INTO organization_organization VALUES (339, 339, 347, 'parent', '2017-03-20 01:29:11.210073+00', NULL);
INSERT INTO organization_organization VALUES (342, 339, 350, 'parent', '2017-03-29 22:56:24.377008+00', NULL);
INSERT INTO organization_organization VALUES (344, 339, 352, 'parent', '2017-03-29 23:07:59.429486+00', NULL);
INSERT INTO organization_organization VALUES (346, 339, 354, 'parent', '2017-03-29 23:24:31.361032+00', NULL);
INSERT INTO organization_organization VALUES (348, 339, 356, 'parent', '2017-03-29 23:44:45.653515+00', NULL);
INSERT INTO organization_organization VALUES (350, 339, 358, 'parent', '2017-04-10 01:33:57.076817+00', NULL);
INSERT INTO organization_organization VALUES (353, 339, 361, 'parent', '2017-04-18 18:36:44.886598+00', NULL);
INSERT INTO organization_organization VALUES (355, 339, 363, 'parent', '2017-04-18 18:54:17.838591+00', NULL);
INSERT INTO organization_organization VALUES (357, 339, 365, 'parent', '2017-04-18 19:02:43.817342+00', NULL);
INSERT INTO organization_organization VALUES (365, 372, 372, 'parent', '2017-07-20 00:41:28.521422+00', NULL);
INSERT INTO organization_organization VALUES (367, 373, 373, 'parent', '2017-07-20 00:42:21.983613+00', NULL);
INSERT INTO organization_organization VALUES (369, 374, 374, 'parent', '2017-07-20 00:52:01.845554+00', NULL);
INSERT INTO organization_organization VALUES (371, 375, 375, 'parent', '2017-07-20 00:55:28.133937+00', NULL);
INSERT INTO organization_organization VALUES (373, 376, 376, 'parent', '2017-07-20 01:22:16.825846+00', NULL);
INSERT INTO organization_organization VALUES (375, 377, 377, 'parent', '2017-07-20 02:31:33.929996+00', NULL);
INSERT INTO organization_organization VALUES (377, 378, 378, 'parent', '2017-07-20 02:56:56.479902+00', NULL);
INSERT INTO organization_organization VALUES (379, 379, 379, 'parent', '2017-07-26 19:17:58.573441+00', NULL);
INSERT INTO organization_organization VALUES (381, 380, 380, 'parent', '2017-07-26 19:28:10.184173+00', NULL);
INSERT INTO organization_organization VALUES (318, 13, 330, 'parent', '2015-07-24 00:30:30.179609+00', NULL);
INSERT INTO organization_organization VALUES (319, 13, 331, 'parent', '2015-09-11 15:04:51.191132+00', NULL);
INSERT INTO organization_organization VALUES (320, 13, 332, 'parent', '2015-09-11 15:43:42.219477+00', NULL);
INSERT INTO organization_organization VALUES (321, 13, 333, 'parent', '2015-10-04 00:30:47.398319+00', NULL);
INSERT INTO organization_organization VALUES (322, 13, 336, 'parent', '2016-05-10 19:42:05.601529+00', NULL);
INSERT INTO organization_organization VALUES (323, 13, 337, 'parent', '2016-05-10 20:38:53.057941+00', NULL);


--
-- Name: organization_organization_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbri_devnexus
--

SELECT pg_catalog.setval('organization_organization_id_seq', 381, true);


--
-- Data for Name: organization_program; Type: TABLE DATA; Schema: public; Owner: northbri_devnexus
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
-- Name: organization_program_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbri_devnexus
--

SELECT pg_catalog.setval('organization_program_id_seq', 8, true);


--
-- Data for Name: organization_topic; Type: TABLE DATA; Schema: public; Owner: northbri_devnexus
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
INSERT INTO organization_topic VALUES (948, 349, NULL, 6);
INSERT INTO organization_topic VALUES (949, 351, NULL, 6);
INSERT INTO organization_topic VALUES (950, 356, NULL, 6);
INSERT INTO organization_topic VALUES (951, 363, NULL, 6);
INSERT INTO organization_topic VALUES (953, 365, NULL, 6);
INSERT INTO organization_topic VALUES (954, 366, NULL, 7);
INSERT INTO organization_topic VALUES (955, 349, NULL, 4);
INSERT INTO organization_topic VALUES (967, 367, NULL, 2);
INSERT INTO organization_topic VALUES (970, 347, NULL, 1);
INSERT INTO organization_topic VALUES (971, 347, NULL, 2);
INSERT INTO organization_topic VALUES (974, 348, NULL, 1);
INSERT INTO organization_topic VALUES (975, 369, NULL, 1);
INSERT INTO organization_topic VALUES (976, 370, NULL, 4);
INSERT INTO organization_topic VALUES (978, 350, NULL, 5);
INSERT INTO organization_topic VALUES (979, 345, NULL, 1);
INSERT INTO organization_topic VALUES (980, 364, NULL, 2);


--
-- Name: organization_topic_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbri_devnexus
--

SELECT pg_catalog.setval('organization_topic_id_seq', 980, true);


--
-- Name: person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbri_devnexus
--

SELECT pg_catalog.setval('person_id_seq', 1, false);


--
-- Data for Name: privilege; Type: TABLE DATA; Schema: public; Owner: northbri_devnexus
--

INSERT INTO privilege VALUES (1, 'create_invitation', 'Generate new invitations within own organizational boundaries.');


--
-- Name: privilege_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbri_devnexus
--

SELECT pg_catalog.setval('privilege_id_seq', 1, true);


--
-- Data for Name: program; Type: TABLE DATA; Schema: public; Owner: northbri_devnexus
--

INSERT INTO program VALUES (1, 'Northside P.O.W.E.R. (People Organized to Work, Educate and Restore) is an institution-based people‚Äôs power organization whose members are located in the North Side of the City of Chicago and North Shore Communities. Northside P.O.W.E.R. works on issues that address the causes of hunger and poverty. Currently Northside P.O.W.E.R. is working in the areas of affordable housing and food justice.', 'Northside P.O.W.E.R.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO program VALUES (2, 'Our Community Kitchen is the largest and only self-standing community soup kitchen in the Chicago metro area. We serve hot, nutritious meals 365 days per year to anyone in need. Last year, the Community Kitchen served more than 54,000 meals. The Community Kitchen also distributes several thousand pounds of food each month by hosting the Greater Chicago Food Depository‚Äôs Producemobile which distributes fruit and vegetables to more than 200 families each month.
', 'The Community Kitchen', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO program VALUES (3, 'Supports the Howard Area Community Center‚Äôs Greensleeves After-School Project and the Good News Reading Program;

Hosts the City of Chicago‚Äôs Summer Nutrition Program;

Operates a free hot lunch program for school age children during the school‚Äôs winter and spring breaks.', 'The Childrens‚Äô Anti-Hunger Collaborative', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO program VALUES (4, 'Clinical Pastoral Education (CPE) is an intensive experiential educational program for pastors and religious leaders interested in developing their clinical skills. Students engage in pastoral work and reflect on their experience with a trained supervisor and a peer group. Key areas for learning include integrating theology into pastoral practice, formation as a religious leader, and self-reflection and knowledge. CPE can be an excellent tool for discernment, self-care and renewal.', 'Clinical Pastoral Education', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO program VALUES (5, 'Pastoral Internship is an introduction to supervised clinical pastoral practice with people in crisis. Chaplain interns function as integral members of treatment teams, assisting patients and family members to draw on the meaning and benefits of their faith and spiritual values in the midst of health crises. Skills in pastoral care are developed and approaches to understanding human relationships and spiritual needs are explored. At most sites, intensive 11-12 week programs are offered in the summer. At Advocate Lutheran General Hospital, intensive programs are offered quarterly, year-round.', 'Pastoral Internship', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO program VALUES (6, 'Pastoral Residency is a year-long program. This training provides opportunity for a more in-depth and specialized pastoral education experience. In addition to the basic format, this program includes:

Guided reading and instruction in the historic models of pastoral care


Pastoral theology

Studies in relationships among faith, religions and the behavioral sciences

Clinical/theological case conferences

Management and administration seminars examining principles and practices of pastoral care administration

Specialized opportunities in areas such as obstetrics, oncology, physical, rehabilitation, emergency medicine, pediatrics, gerontology, research methodology and design

Workshops and seminars in clinical ethical issues. ', 'Pastoral Residency', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO program VALUES (7, 'Supervisory CPE is designed for qualified persons with demonstrated pastoral, professional and clinical competence. Students learn the art of supervision through:

Education in supervisory theories by using conceptual models drawn from theology, behavioral science and education

Practicing supervision under an ACPE supervisor

Forming their identity as educators by a focus on integrating theory and practice with their distinct and personal attributes

Peer group seminars where the emerging supervisor''s understanding and practice are tested.', 'Supervisory CPE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO program VALUES (8, 'As part of Advocate Health Care‚Äôs continuum of care, the Parish Nurse Ministry is working in 29 diverse congregations. These faith communities are widely scattered throughout the Chicagoland area from West Garfield Park and Uptown Chicago neighborhoods to the suburban settings of Arlington Heights and Naperville.

Advocate Parish Nurse Ministry continues to seek health ministry partnerships. Both partners, the health care institution and the congregation must espouse the belief that physical, emotional, intellectual, and social well-being are very much dependent on a healthy spiritual core of being.

Advocate Parish Nurse Ministry is designed to build on and strengthen capacities of individuals, families, and congregrations to understand and care for one another in light of their relationship with God, faith traditions, themselves, and the broader society.', 'Advocate Parish Nurse Ministry', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


--
-- Data for Name: program_contact; Type: TABLE DATA; Schema: public; Owner: northbri_devnexus
--



--
-- Name: program_contact_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbri_devnexus
--

SELECT pg_catalog.setval('program_contact_id_seq', 534, false);


--
-- Name: program_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbri_devnexus
--

SELECT pg_catalog.setval('program_id_seq', 9, true);


--
-- Data for Name: program_language; Type: TABLE DATA; Schema: public; Owner: northbri_devnexus
--



--
-- Name: program_language_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbri_devnexus
--

SELECT pg_catalog.setval('program_language_id_seq', 1, false);


--
-- Data for Name: program_location; Type: TABLE DATA; Schema: public; Owner: northbri_devnexus
--



--
-- Name: program_location_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbri_devnexus
--

SELECT pg_catalog.setval('program_location_id_seq', 703, false);


--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: northbri_devnexus
--

INSERT INTO role VALUES (1, 'admin_org', 'Administers organizational data and users.');
INSERT INTO role VALUES (2, 'admin_network', 'Administers network data and users.');
INSERT INTO role VALUES (3, 'admin_system', 'Administers all data and users.');
INSERT INTO role VALUES (4, 'admin_group', 'Administers group data and users.');
INSERT INTO role VALUES (5, 'user', 'Administers nothing.');


--
-- Name: role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbri_devnexus
--

SELECT pg_catalog.setval('role_id_seq', 5, true);


--
-- Data for Name: role_privilege; Type: TABLE DATA; Schema: public; Owner: northbri_devnexus
--

INSERT INTO role_privilege VALUES (1, 1);

--
-- Data for Name: status; Type: TABLE DATA; Schema: public; Owner: northbri_devnexus
--

INSERT INTO status VALUES (1, 'active', '');
INSERT INTO status VALUES (2, 'suspended', '');
INSERT INTO status VALUES (3, 'pending', '');


--
-- Name: status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbri_devnexus
--

SELECT pg_catalog.setval('status_id_seq', 3, true);


--
-- Data for Name: topic; Type: TABLE DATA; Schema: public; Owner: northbri_devnexus
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
INSERT INTO topic VALUES (42, 'Race');
INSERT INTO topic VALUES (43, 'Sex');
INSERT INTO topic VALUES (44, 'National Origin');
INSERT INTO topic VALUES (45, 'Gender');
INSERT INTO topic VALUES (46, 'LGBTQ');
INSERT INTO topic VALUES (47, 'Religion');
INSERT INTO topic VALUES (48, 'School Desegregation');
INSERT INTO topic VALUES (49, 'School Discipline');
INSERT INTO topic VALUES (50, 'Multicultural Education');
INSERT INTO topic VALUES (51, 'Social Justice');
INSERT INTO topic VALUES (52, 'School Finance');
INSERT INTO topic VALUES (53, 'Immigrant Rights in Education');
INSERT INTO topic VALUES (54, 'English Language Learners');
INSERT INTO topic VALUES (55, 'Bilingual Education');
INSERT INTO topic VALUES (56, 'School Turnaround');
INSERT INTO topic VALUES (57, 'Bullying and Harassment');
INSERT INTO topic VALUES (58, 'Family Engagement');
INSERT INTO topic VALUES (59, 'Trauma');


--
-- Name: topic_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbri_devnexus
--

SELECT pg_catalog.setval('topic_id_seq', 59, true);


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: northbri_devnexus
--

INSERT INTO "user" VALUES (176, '174eaaa7-d501-7c2b-5a11-63709d403b0b', 'lou1', '[[ENC]]26eb34a492802596c77a61dca768b4203b44f8bf0d64b860656dc67dc06aa2fc', 'lou', '', 'lou', '2014-09-22 02:11:57.916885+00', NULL, '2014-09-22 02:11:57.916885+00', '2015-08-12 22:29:49.429003+00', 2, '', 'coach.lou@northbridgetech.org', '', true, false, NULL, 'ImplA', 'U&wS@OthOVbszqt(ND0%*Ub%pYdWIqit', '2015-10-15 02:16:01.021512+00', '/openmeetings/swf?invitationHash=83f41a436e497c1e84bf010a9a2137ec', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (232, '67533585-cf2f-41ac-84a3-e10533ad0fb3', 'kcavness', '[[ENC]]eff4aea391c85467591cf1662c0199214afc0b2767ab8cd87fa984d60b9c0b25', 'Kenneth', 'G', 'Cavness', '2014-11-06 00:40:50.170563+00', NULL, '2014-11-06 00:40:50.170563+00', NULL, 1, '', 'kenneth.cavness@gmail.com', '', false, false, NULL, 'ImplA', 'i7$cEXe0lxkYvLxua#c3y!SMYV$6%W$d', '2015-07-31 23:27:24.062813+00', '/openmeetings/swf?invitationHash=', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (225, '2a1cdb8f-5f28-82c9-a334-954d9ee13da4', 'Elizabeth', '[[ENC]]9940453b0785727f6e155e33c3f8ceb0157ef87e0fb475cd0d4df71793e88865', 'Elizabeth', '', 'Eckhardt', '2014-10-26 23:15:24.901361+00', NULL, '2014-10-26 23:15:24.901361+00', '2015-08-10 03:12:42.208189+00', 2, '', 'auntizzie22@yahoo.com', '', true, false, NULL, 'ImplA', '5SDZ$5b*lkW4iRiPyJn3CFjUyDALZ!^^', '2014-10-26 23:15:24.941506+00', '/openmeetings/swf?invitationHash=', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (184, '603c8b8c-1723-9f28-8940-cfb06d926269', 'jafar123', '[[ENC]]09d712bd842051432b8f4533e5786d78602613cff782f33a6297162f1677a6bb', 'jj', '', 'jj', '2014-09-23 05:36:28.496209+00', NULL, '2014-09-23 05:36:28.496209+00', '2015-08-10 03:31:15.804868+00', 2, '', 'jafar.ahmad.71@gmail.com', '', true, false, NULL, 'ImplA', 'Lmw0)UkAX4VinPwAMg09B(Y5RrAj36yO', '2014-09-23 05:36:28.527764+00', '/openmeetings/swf?invitationHash=e3df0f2f82f4ca621aee5479299816dc', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (248, '88aa03ef-f077-4b02-d742-ec5109d904f6', 'kdfTest4', '[[ENC]]fb605342a4bd5cfb01dff73025de9eafb878ab8ffe9f1b18555427575631a63a', 'kdf', '', 'Test4', '2014-11-21 14:09:15.245481+00', NULL, '2014-11-21 14:09:15.245481+00', '2015-08-12 22:29:35.526344+00', 2, '', 'ksflint@comcast.net', '', true, false, NULL, 'ImplA', 'PEfxm$zPrygs^n!cS^jCYMh*3WCZSf8y', '2014-11-21 14:09:15.384306+00', '/openmeetings/swf?invitationHash=', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (226, '51322b68-667b-ae90-9e06-29dcc2c69a9a', 'wja2000', '[[ENC]]3de0a673b699044cd977e0aea49958f2cb181954016b90c89e64591575378fde', 'Will', '', 'Alston', '2014-10-30 02:36:26.897636+00', NULL, '2014-10-30 02:36:26.897636+00', '2015-08-12 22:30:16.532085+00', 2, '', 'wjalston2@yahoo.com', '', true, false, NULL, 'ImplA', '3rcGI)lc1R7qGb*3inv)ueaz3$ithV&k', '2015-03-24 16:48:41.336892+00', '/openmeetings/swf?invitationHash=', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (252, '20b34444-54b2-60cb-2437-029466eaf2c1', 'Testing1', '[[ENC]]04df6446abda312bf569d33172cdffd6c239e54a846b144f67836e0186083698', 'Kathy', '', 'Kathy', '2015-08-10 03:21:26.596337+00', '2015-09-03 00:48:51.132871+00', '2015-08-10 03:21:26.596337+00', '2015-09-03 00:48:51.132871+00', 2, '', 'kathy.d.flint@gmail.com', '', true, false, NULL, 'ImplA', 'S5ed2W7kIEuJxQCp*u9Gs74WsF(WIOLr', '2015-08-10 03:21:26.634127+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (174, 'a3859b3e-1131-f81c-7e15-5b83e72c248d', 'gsaylor', '[[ENC]]664d341a217d457fccaee45fc7a3e67f7783862f91d9fdef354bb73b74b899e5', 'Gretchen', '', 'Saylor', '2014-09-21 23:26:27.396926+00', NULL, '2014-09-21 23:26:27.396926+00', '2015-08-10 03:12:48.538597+00', 2, '', 'gretchen.saylor@gmail.com', '', false, false, NULL, 'ImplA', '%GmoolQs&spyVtBaI3m*NWctRh%XX&XR', '2015-10-26 15:05:12.201391+00', '/openmeetings/swf?invitationHash=81021121b7bf104cb149e255ae0921a4', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (257, 'a1e70a35-f3c6-1260-ec72-223acad73702', 'kennethtestx3', '[[ENC]]e02ee2b1a9164bfbdf3f9f01d1a03b3ff01b028ff783bdf5c3e9f076c294555b', 'Kenneth', '', 'Kenneth', '2015-08-12 23:56:39.866702+00', NULL, '2015-08-12 23:56:39.866702+00', '2015-08-12 23:57:01.607969+00', 2, '', 'kenneth.cavness@gmail.com', '', true, false, NULL, 'ImplA', 'sde0(f@ZxPfq7vqjkt1d4hQkb65ANDv5', '2015-08-12 23:56:39.924696+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (265, 'c30994ea-87c6-9201-59a0-e95b5e93d511', 'kennethemptytest1', '[[ENC]]34a5f3ae204a65939abaf36ec1a0f45d18416f668297c779f27224e60adb767f', 'Kenneth', '', 'Kenneth', '2015-09-01 23:32:31.253336+00', '2015-09-01 23:33:04.276751+00', '2015-09-01 23:32:31.253336+00', '2015-09-01 23:33:04.276751+00', 2, '', 'kenneth.cavness@gmail.com', '', true, false, NULL, 'ImplA', 'Z%fO(XQ3&RjW*wXYLb91WMzGsgPDQ^BF', '2015-09-01 23:32:31.273442+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (258, '4134255c-1dc5-8e99-1e1c-010fe1858fd1', 'kennethtest2', '[[ENC]]ce05aea9e2982776c47978f4114543908c7307bcdb9365717ea50ad35442a6ca', 'KennethTest2', '', 'KennethTest2', '2015-08-13 00:00:00.767669+00', NULL, '2015-08-13 00:00:00.767669+00', '2015-08-13 00:01:47.536335+00', 2, '', 'kenneth.cavness@gmail.com', '', true, false, NULL, 'ImplA', 'ZabqkLn&cKw9qpXgTC)iPqn6(MgaI&Ly', '2015-08-13 00:00:00.780557+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (253, '975b0a36-1d1c-b63f-a578-df90acdd1fa6', 'sammydee', '[[ENC]]372cc82b34c4426b39700cdd6302cd8e6e7d1af8ce5dd683998891e2652f245e', 'Kathy', '', 'Kathy', '2015-08-10 03:34:44.698634+00', NULL, '2015-08-10 03:34:44.698634+00', '2015-08-12 22:29:23.093479+00', 2, '', 'kathy.d.flint@gmail.com', '', true, false, NULL, 'ImplA', '4FUUxQtsYSKuktGyDnsu&#Uwdq1H#sE*', '2015-08-10 03:34:44.714565+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (254, '81b8be3d-435b-b710-7c01-638ccd917aa5', 'kennethtest1', '[[ENC]]c6c9116fbbad9280ef36f845c3d42d4d097f992a64284474b7ade8fd12eb2157', 'Kenneth', '', 'Kenneth', '2015-08-12 23:53:26.917319+00', NULL, '2015-08-12 23:53:26.917319+00', '2015-08-12 23:53:40.13083+00', 2, '', 'kenneth.cavness@gmail.com', '', true, false, NULL, 'ImplA', 'qWhK^j2R2jM)H1BA)4awww$HDDFumwzM', '2015-08-12 23:53:26.937527+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (259, 'f1242b8d-a52a-8c45-4ab3-5c80f0b05cfd', 'kennethtest3', '[[ENC]]f71abaf95d714ce5d05a221d90f76732445d2d4b980441d7f16f698781c0b918', 'KennethTest3', '', 'KennethTest3', '2015-08-13 00:10:51.048249+00', NULL, '2015-08-13 00:10:51.048249+00', '2015-08-17 04:15:09.197525+00', 2, '', 'kenneth.cavness@gmail.com', '', true, false, NULL, 'ImplA', ')*VjxpsYkyD%y(nAGH(AZfzdKKQ6^AO%', '2015-08-13 00:10:51.114406+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (255, '11d359f3-3437-32f5-37e8-a6dae2521322', 'kennethtestx1', '[[ENC]]e37f29b64f23703c910a16e0dd28b64c9146c2f781181af7499eb49e34ceec7a', 'Kenneth', '', 'Kenneth', '2015-08-12 23:55:03.931102+00', NULL, '2015-08-12 23:55:03.931102+00', '2015-08-12 23:55:31.941726+00', 2, '', 'kenneth.cavness@gmail.com', '', true, false, NULL, 'ImplA', 'aOp@D*l3xzBS1lUEvU1BUrNL(F^wr2tB', '2015-08-12 23:55:03.981868+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (256, '72313484-77c7-a5ba-5e9c-8210a305759c', 'kennethtestx2', '[[ENC]]f5a1e13f433c3d2ea98fc35ff4acc2313556e2112395e84d1584393396336b5a', 'Kenneth', '', 'Kenneth', '2015-08-12 23:55:56.813271+00', NULL, '2015-08-12 23:55:56.813271+00', '2015-08-12 23:56:07.845262+00', 2, '', 'kenneth.cavness@gmail.com', '', true, false, NULL, 'ImplA', 'jofS(72k8!Gs@sanBTnv)CVhJn0tc@Iv', '2015-08-12 23:55:56.83629+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (262, '328779fa-97dc-0bd3-a895-271d5ff39a9b', 'gmanthey', '[[ENC]]b6e6762e3eca1b99b7d4ab7f7de502e7165599077975b3818d84ae8d34fda0d7', 'Gretchen', '', 'Gretchen', '2015-09-01 20:20:45.529306+00', '2015-09-01 20:23:57.809229+00', '2015-09-01 20:20:45.529306+00', '2015-09-01 20:23:57.809229+00', 2, '', 'gretchen.anthey@gmail.com', '', true, false, NULL, 'ImplA', '()Fi6BZjYwJoTMRfwRzeP1W*R7hdZgKX', '2015-09-01 20:20:45.54809+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (263, '481eaeb7-9004-09cd-5486-4d96056ffd8e', 'kennethoid1', '[[ENC]]8c3a25cde2d83fe353d072cd1606497945f212f6012d148104644364b4bb73a7', 'Kenneth', '', 'Kenneth', '2015-09-01 23:13:31.415952+00', '2015-09-01 23:13:46.534478+00', '2015-09-01 23:13:31.415952+00', '2015-09-01 23:13:46.534478+00', 2, '', 'kenneth.cavness@gmail.com', '', true, false, NULL, 'ImplA', 'f8(zIMS930Mhd0@wr4q3f8ZKFCHQW%D1', '2015-09-01 23:13:31.430869+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (264, 'f5a09098-f3bb-08d4-861d-612a268baafd', 'kennethtestreturn1', '[[ENC]]4307cdf7ebd95d93ed4644ab0a388d1dbea03400ffb5b3ce415617d6fee02836', 'Kenneth', '', 'Kenneth', '2015-09-01 23:15:16.573157+00', '2015-09-01 23:15:32.089813+00', '2015-09-01 23:15:16.573157+00', '2015-09-01 23:15:32.089813+00', 2, '', 'kenneth.cavness@gmail.com', '', true, false, NULL, 'ImplA', 'Jh2D)%ECGxa2EPjj1w$gogHS7Bj^(WzH', '2015-09-01 23:15:16.585297+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (88, 'e8db0a62-67dd-3d0c-13fd-d2372f4b5d0c', 'admin', 'admin', 'Kathy', '', 'Flint', '2014-08-01 21:09:53.514038+00', '2015-09-09 23:29:35.502472+00', '2014-08-01 21:09:53.514038+00', '2015-09-09 23:29:35.502472+00', 2, '', 'test@test.com', '3129195627', true, true, NULL, 'none', NULL, NULL, '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (85, '8ad02b5a-3ef4-7cfd-aec3-ec528bfa73ac', 'kdflint', 'kdflint', 'Kathy', 'D', 'Flint', '2014-08-01 15:40:24.775305+00', NULL, '2014-08-01 15:40:24.775305+00', NULL, 1, '', 'test@test.com', '3129195627', false, false, NULL, 'none', NULL, NULL, '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (233, 'e59e08b8-e5b6-24b9-b53e-22b105f77887', 'kdfTest2', 'password0', 'kdf', '', 'test2', '2014-11-06 00:42:58.057473+00', NULL, '2014-11-06 00:42:58.057473+00', '2015-08-10 03:12:07.290377+00', 2, '', 'test@test.com', '3129195627', true, true, NULL, 'ImplA', 'dm%prebtFZ(ak^gs##NX2y7IngtZ8#Hl', '2015-01-03 23:23:40.43+00', '/openmeetings/swf?invitationHash=', true, false, 'test description2', '8668489224', true, NULL);
INSERT INTO "user" VALUES (234, '8edc4d8e-856c-4236-95d6-8bd1312bcc80', 'kdfTest3', '[[ENC]]355e33eff45a1ad7b84f7c8657c10768a53b4fc116f9c367608281891609debf', 'Kathy', '', 'Flint', '2014-11-07 19:16:02.784427+00', '2017-08-07 19:49:59.442066+00', '2014-11-07 19:16:02.784427+00', '2017-08-07 19:49:59.442066+00', 2, 'Joe', 'contact@northbridgetech.org', '', false, false, NULL, 'ImplA', 'hoRAH3s(euZJp&XR&!%quWGL*G)lbMbs', '2017-01-30 18:04:32.424075+00', '/openmeetings/swf?invitationHash=', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (272, '2ace8e65-791c-7309-5ccf-718156a8eec5', 'kdfTestTO2', '[[ENC]]56040848ecd954fda87a436b82f02d9bf238218a0392bddedd7c5f458140d354', 'TO', '', 'TO', '2015-09-11 15:24:43.034024+00', NULL, '2015-09-11 15:24:43.034024+00', NULL, 1, '', 'ksflint@comcast.net', '', true, false, NULL, 'ImplA', 'G6c9gfyx#AU&pt0NZTiO5aC13yGh61vN', '2015-09-11 15:24:43.058766+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (273, 'd4c0d217-9d55-14b1-dc9c-355d48af38b9', 'kdfTestSF1', '[[ENC]]af82a34112806340b72c837d587b814772b206ba0a289e7cd6ca375ab9886447', 'SF', '', 'SF', '2015-09-11 15:57:56.854424+00', NULL, '2015-09-11 15:57:56.854424+00', NULL, 1, '', 'angelica.c.flint@gmail.com', '', true, false, NULL, 'ImplA', 'Y90hJu%dexeYL$&KBbik!)kp8PbPFfVu', '2015-09-11 15:57:56.883043+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (280, 'd3af9ec6-f7de-7d92-840f-3203630eaa76', 'kdfTestSF11', '[[ENC]]e5b028ea7162f8053f738ef82838f0b81382233d89595b356af6c0c2e132356d', 'SF11', '', 'Test', '2015-09-11 17:53:59.184533+00', '2015-09-11 18:35:18.445364+00', '2015-09-11 17:53:59.184533+00', '2015-09-11 18:35:18.445364+00', 2, '', 'angelica.c.flint@gmail.com', '', true, false, NULL, 'ImplA', 'acbvFzxibPp4gQn5$BYJv#uYRGQG&cm7', '2015-09-11 17:53:59.196678+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (279, '24f70489-8f3b-b3fd-1856-8d5b30fa5d00', 'kdfTestSF10', '[[ENC]]db68feddd6023aa8bed4653f884f2c4cbf7fe319847acb46696d33622a4d5f92', 'SF10', '', 'Test', '2015-09-11 17:45:40.63402+00', '2015-09-11 18:08:23.055558+00', '2015-09-11 17:45:40.63402+00', '2015-09-11 18:08:23.055558+00', 2, '', 'angelica.c.flint@gmail.com', '', true, false, NULL, 'ImplA', 'IHVeQJxi%vqSQzgNSaMfY!!dPZ7z!wsz', '2015-09-11 17:45:40.650406+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (275, '5d92fc25-cd13-c603-130b-29c19d120cc5', 'kdfTestSF6', '[[ENC]]85e6323cf2e0df3002f5f67d0ac963d03345de494846b7b75e973fbb09136b40', 'SF6', '', 'Test', '2015-09-11 17:31:33.15734+00', '2015-09-11 17:38:20.134159+00', '2015-09-11 17:31:33.15734+00', '2015-09-11 17:38:20.134159+00', 2, '', 'angelica.c.flint@gmail.com', '', true, false, NULL, 'ImplA', '9iAq1(9nOF4XEtu36rH0d!fYkxjF$ye2', '2015-09-11 17:31:33.170219+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (276, 'e96b9404-5bc8-0d3a-670f-3a725a4e26cf', 'kdfTestSF7', '[[ENC]]a2b5701d13f54910d286659ea000e865cc5f8d37d038a76788c743ee07559590', 'SF7', '', 'Test', '2015-09-11 17:36:21.715096+00', '2015-09-11 17:38:23.986336+00', '2015-09-11 17:36:21.715096+00', '2015-09-11 17:38:23.986336+00', 2, '', 'angelica.c.flint@gmail.com', '', true, false, NULL, 'ImplA', 'slbV9jXkMvtwJ(9rt)NFiwLV@K2lhceK', '2015-09-11 17:36:21.736105+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (284, 'edfb234f-5370-9076-2d8d-dd485de62735', 'kdfTestSF16', '[[ENC]]e0441e85cb7e6ecc5b6795b582dd17c14f6cd6a979fba100074c6d7f41664ebb', 'SF16', '', 'Test', '2015-09-11 18:26:17.547456+00', '2015-09-11 18:31:33.830113+00', '2015-09-11 18:26:17.547456+00', '2015-09-11 18:31:33.830113+00', 2, '', 'angelica.c.flint@gmail.com', '', true, false, NULL, 'ImplA', 'BnhgPtB771Mh(nWM(@xnjR8M1773fnoR', '2015-09-11 18:26:17.561243+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (281, '0c84aac4-4547-036c-14dd-da8b84b864be', 'kdfTestSF13', '[[ENC]]f31399960bc3b5c820340a049e245b90fe7be5437b70f9d55cf85c93ef8dc5f9', 'SF13', '', 'Test', '2015-09-11 18:09:45.560837+00', NULL, '2015-09-11 18:09:45.560837+00', NULL, 1, '', 'angelica.c.flint@gmail.com', '', true, false, NULL, 'ImplA', '70Rv1%JeDTO9JGH08ps^!1!uS$KFpIkw', '2015-09-11 18:09:45.583539+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (277, '9cdd42ab-241f-f7bc-87c3-1e7a4fa22062', 'kdfTestSF8', '[[ENC]]d5139b035c67721120be7c26557ce577c837411e2ee7093b3f7ad5017b4a1b50', 'SF8', '', 'Test', '2015-09-11 17:39:19.008786+00', '2015-09-11 18:13:34.903634+00', '2015-09-11 17:39:19.008786+00', '2015-09-11 18:13:34.903634+00', 2, '', 'angelica.c.flint@gmail.com', '', true, false, NULL, 'ImplA', ')E!vSLBQFWK&As3QoBDzWXbYmSeeDABD', '2015-09-11 17:39:19.022669+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (278, '6ec58854-9b32-3359-64c6-bdad8f3b706f', 'kdfTestSF9', '[[ENC]]d2ec1c18bb628067a84f39b35163e1efe8a8932720fb2e99000c5cccc083bb58', 'SF9', '', 'Test', '2015-09-11 17:43:35.41065+00', '2015-09-11 18:13:39.475063+00', '2015-09-11 17:43:35.41065+00', '2015-09-11 18:13:39.475063+00', 2, '', 'angelica.c.flint@gmail.com', '', true, false, NULL, 'ImplA', 'FWTUaHbeDwTZ^63q%VTjPU^Bw8y**%$C', '2015-09-11 17:43:35.422457+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (274, '067d7a6a-f813-bb0f-e627-2c4a6dcb2c04', 'kdfTestSF2', '[[ENC]]4446a3bc64f989f0d769bd6f9e162c7670f220f41e626f733af58da3b27c9064', 'SF2', '', 'Test', '2015-09-11 16:19:13.520528+00', '2015-09-11 18:13:43.092751+00', '2015-09-11 16:19:13.520528+00', '2015-09-11 18:13:43.092751+00', 2, '', 'angelica.c.flint@gmail.com', '', true, false, NULL, 'ImplA', 'tY*AP$xuaYQ%*K&zCAe!FGxZT!@oCoU&', '2015-09-11 16:19:13.533176+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (283, 'bf3d5b90-1076-0c5e-744d-19cfac8200bb', 'kdfTestSF15', '[[ENC]]4c173cde5736736e40078b964e3cba811af3a57ba476e304c96c988c1c71ece1', 'SF15', '', 'Test', '2015-09-11 18:18:44.106402+00', '2015-09-11 18:31:41.383591+00', '2015-09-11 18:18:44.106402+00', '2015-09-11 18:31:41.383591+00', 2, '', 'angelica.c.flint@gmail.com', '', true, false, NULL, 'ImplA', 'lH@nOFFs$acXZNVqPlxcm1hBW5HR%rcf', '2015-09-11 18:18:44.125611+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (282, '500b65d6-1ffa-5ff4-8e0f-4cf574fc3e70', 'kdfTestSF14', '[[ENC]]67d3816c99545ceb3cc9dc2b81e871006825714992f51c20f931f9bce1f594f0', 'SF14', '', 'Test', '2015-09-11 18:14:37.988389+00', '2015-09-11 18:17:33.053778+00', '2015-09-11 18:14:37.988389+00', '2015-09-11 18:17:33.053778+00', 2, '', 'angelica.c.flint@gmail.com', '', true, false, NULL, 'ImplA', 'U@APsFRn@(@xcQ2qwXS9qoFrL*uQJF&u', '2015-09-11 18:14:38.002664+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (285, 'd15d65e7-486a-583c-fe5f-c3d0e3b0271a', 'kdfTest15', '[[ENC]]c9314470e02e26284d572e80af0252a187cad6aee7d36ea1412080f5b6f37de5', 'SF15', '', 'Test', '2015-09-11 18:33:00.571932+00', NULL, '2015-09-11 18:33:00.571932+00', NULL, 1, '', 'angelica.c.flint@gmail.com', '', true, false, NULL, 'ImplA', 'fM6pfA^PG6^8LGpOYxKSFyyy8c6eTe@(', '2015-09-11 18:33:00.584311+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (288, '633c3b2a-21be-fb6b-8683-ace54c280208', 'kdfTestSF20', '[[ENC]]e66669652a09a1adf27404620d21638031770cd43aded05a9ccce83a809b13cc', 'SF20', '', 'Test', '2015-09-11 18:45:40.086014+00', '2015-09-11 18:59:27.983673+00', '2015-09-11 18:45:40.086014+00', '2015-09-11 18:59:27.983673+00', 2, '', 'bryce.m.flint@gmail.com', '', true, false, NULL, 'ImplA', 'PoBaKhQT6v8Cw2vp7bcQ$*&jEMluYXsD', '2015-09-11 18:45:40.099856+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (286, 'e905ad40-cff8-14fa-f81f-7399902d054b', 'kdfTestSF17', '[[ENC]]03c0180dbb8c2e177c89611379da632ddf7ec6e14e9f9a2ee1f60c6688328135', 'SF17', '', 'Test', '2015-09-11 18:36:17.823856+00', '2015-09-11 18:38:25.930597+00', '2015-09-11 18:36:17.823856+00', '2015-09-11 18:38:25.930597+00', 2, '', 'angelica.c.flint@gmail.com', '', true, false, NULL, 'ImplA', 'tnnSkeZg#2QUoWjtJUDNkzHtuMA5%^ro', '2015-09-11 18:36:17.837204+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (287, '2a4a6571-db6e-a82b-3ad9-120a0740a4a5', 'kdfTestSF19', '[[ENC]]591dd73ecb8b65638ff3e3d55edb34cb2766b7ab655bc4237c6f2cf03dcd5504', 'SF19', '', 'Test', '2015-09-11 18:40:41.408525+00', '2015-09-11 18:59:23.538125+00', '2015-09-11 18:40:41.408525+00', '2015-09-11 18:59:23.538125+00', 2, '', 'angelica.c.flint@gmail.com', '', true, false, NULL, 'ImplA', 'Q*eUJAE6Rtkew1QLIIzN$MUPXMBPHEdo', '2015-09-11 18:40:41.421988+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (289, '72d73c73-562d-f901-2edd-11cc021c1164', 'kdfTestSF21', '[[ENC]]254864c7c550347dd202aefdfd479c3e77bf1fcc9cd7823ca468c611b116bdb1', 'SF21', '', 'Test', '2015-09-11 19:01:03.993174+00', NULL, '2015-09-11 19:01:03.993174+00', NULL, 1, '', 'angelica.c.flint@gmail.com', '', true, false, NULL, 'ImplA', 'E*Lr@kp2R0E55jb0L#g3KavEfGXICU57', '2015-09-11 19:01:04.013684+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (290, '0540cc20-dc5a-b400-4e7b-bba20fcd612b', 'kdfTestSF22', '[[ENC]]45ae96548a2d7ec9492bd645e621c43d8ed2678f85979f460c8dba60eb0142e2', 'SF21', '', 'Test', '2015-09-11 19:04:11.458614+00', NULL, '2015-09-11 19:04:11.458614+00', NULL, 1, '', 'angelica.c.flint@gmail.com', '', true, false, NULL, 'ImplA', 'FwkgQxRjuwEB@MAF0sxn#u#2QwWlpjE%', '2015-09-11 19:04:11.472581+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (267, '2fcc85de-00cf-a95d-b242-8fa04091a89f', 'shannon313', '[[ENC]]40d1de3d281597a5abe0f9904bb497cb7f4a201d6ab23f214dd7c71e1e6fdf7b', 'Shannon', '', 'Shannon', '2015-09-09 16:48:43.210129+00', '2015-10-26 01:46:18.543682+00', '2015-09-09 16:48:43.210129+00', '2015-10-26 01:46:18.543682+00', 2, '', 'shannon.cochran@northbridgetech.org', '', true, false, NULL, 'ImplA', 'LMG9rTJ9*vrbFhMn)CVqD@lGWmx&TQqv', '2015-09-09 16:48:43.24397+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (291, '31e01ac8-346e-7601-f34b-ba5992683c06', 'kdfTestSF23', '[[ENC]]6e1b6c724b183c6532d96e4b7d10b671489c9b71733b0f35ea8a725c77161da8', 'SF23', '', 'Test', '2015-09-12 20:06:16.271122+00', NULL, '2015-09-12 20:06:16.271122+00', NULL, 1, '', 'kathy.d.flint@gmail.com', '', true, false, NULL, 'ImplA', '%@3xZEmDi4SA(gWICfm61jlr*9S4wpLr', '2015-09-12 20:06:16.289816+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (311, '63de3a7f-b45b-4185-9270-426858623673', 'pUser-userdemo', '', 'Public', '', 'User', '2015-12-15 23:37:16.566085+00', NULL, '2015-12-15 23:37:16.566085+00', NULL, 1, '', '', '', false, false, NULL, 'None', NULL, NULL, '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (294, '42b5a2cd-9d7e-6b46-622f-0f6e76eabf44', 'flhamer', '[[ENC]]2741fb83711a0be8bff138a4ec613c4671db69196e8658d8db35b3a7a70fec5c', 'F. L.', '', 'Hamer', '2015-10-05 18:34:31.981871+00', NULL, '2015-10-05 18:34:31.981871+00', NULL, 1, '', 'demo_email@northbridgetech.org', '', true, false, NULL, 'ImplA', 'Yil%hzPMid4!iua257Zf4DEAMbKuDTjr', '2015-10-05 18:34:31.999274+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (295, '8830d627-2c31-5851-e683-99ab0aa4e859', 'marlynwescoff', '[[ENC]]f977d167d394f1518f4c807ed3e3b74a37e21b068024ff66b3b17f5116205f17', 'Marlyn', '', 'Wescoff', '2015-10-05 18:40:05.116696+00', NULL, '2015-10-05 18:40:05.116696+00', NULL, 1, '', 'demo_email@northbridgetech.org', '', true, false, NULL, 'ImplA', 'W9#(hHjj5S$^BGUcFSLJZV8cq4VH)HcW', '2015-10-05 18:40:05.138692+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (296, '87e56e08-a4dd-b487-f8a2-971ca3e30be9', 'jeanesammet', '[[ENC]]cd8a2617804c9571718641111af4a125e72d1cd7cb7d6eed3663ba69668591a6', 'Jean E', '', 'Sammet', '2015-10-05 18:42:54.25811+00', NULL, '2015-10-05 18:42:54.25811+00', NULL, 1, '', 'demo_email@northbridgetech.org', '', true, false, NULL, 'ImplA', 'opZjCZQmeUWJI1ZwpK3FHi6%C*KsVdYa', '2015-10-05 18:42:54.364357+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (297, 'fe831089-a368-6355-6b71-8adfd482b769', 'ernaschneider', '[[ENC]]bb828924b2bab165e0d3e2f2b0ea778b8bd174c2130aa32717400b1c29a0d3a0', 'Erna', '', 'Schneider', '2015-10-05 18:44:27.907793+00', NULL, '2015-10-05 18:44:27.907793+00', NULL, 1, '', 'demo_email@northbridgetech.org', '', true, false, NULL, 'ImplA', '*TbB2EVXJMQesA5k8&epmdJfi2R3&5t$', '2015-10-05 18:44:27.921868+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (304, '7f84503d-0bde-d7d9-aeb5-448b593f854c', 'Grrrretchen', '[[ENC]]d9efbd16558d5d2935fe20fb4564bff6d848841b18168789693fcb44bcd86a20', 'ZeeGretchenIsAwesome', '', '', '2015-10-26 01:15:06.415871+00', '2015-10-26 01:15:27.338016+00', '2015-10-26 01:15:06.415871+00', '2015-10-26 01:15:27.338016+00', 2, '', 'gretchen.saylor@gmail.com', '', true, false, NULL, 'ImplA', 'g8TRF4i9@!NStK#7HC^IiiGSDQ99cLdt', '2015-10-26 01:15:06.427785+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (312, '186d9a3b-7d98-4c52-89a5-8955d91d7157', 'pUser-c2007e9b', '', 'Public', '', 'User', '2015-12-16 01:13:46.504767+00', NULL, '2015-12-16 01:13:46.504767+00', NULL, 1, '', '', '', false, false, NULL, 'None', NULL, NULL, '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (302, 'c4b17ab9-fd3e-4ac6-db08-045ddb22015e', 'kennethlong2', '[[ENC]]680bdd8ea16d07c871eaed067a8c37d53eedc122c1f5020e3e97f01feebbeaa3', 'SixteenCharacter', '', 'Cavness', '2015-10-25 17:45:11.159494+00', '2015-10-26 01:39:02.488+00', '2015-10-25 17:45:11.159494+00', '2015-10-26 01:39:02.488+00', 2, '', 'kenneth.cavness@gmail.com', '', true, false, NULL, 'ImplA', 'Y7r7t%uj0$aGL1O^EIV*8zHWA4fpSS4H', '2015-10-25 17:45:11.173316+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (298, 'b1d4eaa1-b9be-602b-edfb-af7f140b4440', 'testuser1', '[[ENC]]d20e1d3a7304cdc8b5bde0dd9d02ad82ec0cf0c60483ca8ce334c647b52f5982', 'Test U', '', 'One', '2015-10-05 19:35:50.393077+00', '2015-10-05 19:37:17.166242+00', '2015-10-05 19:35:50.393077+00', '2015-10-05 19:37:17.166242+00', 2, '', 'demo_usr@test.com', '', true, false, NULL, 'ImplA', '2FyPQ56s&z%lQkEkLhvgcUheynhiH0DJ', '2015-10-05 19:35:50.444401+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (300, 'fdcef291-1229-4622-8c8b-d87003070132', 'fifteencharacte', '[[ENC]]a0de34a66a535fe66d15c736c62d041cabfcb912b4936cdf3dffb7a80d0b57ec', 'Kenneth', '', 'Cavness', '2015-10-25 17:41:18.621996+00', '2015-10-25 17:41:40.788776+00', '2015-10-25 17:41:18.621996+00', '2015-10-25 17:41:40.788776+00', 2, '', 'kenneth.cavness@gmail.com', '', true, false, NULL, 'ImplA', ')I6u8#jC6$#iqfAiJggYqvwkKA8hNRDM', '2015-10-25 17:41:18.662249+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (299, '0296e7e4-d212-22ec-1a86-fa0857dcdcad', 'demoUser39', '[[ENC]]93a3595ab2ba0d488e7e4b07503e111c3c59d96518e6ad10b6c69f481879e32b', 'Kathy', '', 'Flint', '2015-10-06 20:55:19.929175+00', '2016-01-17 23:13:59.369607+00', '2015-10-06 20:55:19.929175+00', '2016-01-17 23:13:59.369607+00', 2, '', 'kathy.d.flint@gmail.com', '', true, false, NULL, 'ImplA', 'xmO3V33edGKUqbAt##ez7AeIj#VV1#Py', '2015-10-06 20:55:20.118611+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (301, '27cb8ca2-2f50-4c51-67d9-f0047708dd2a', 'kennethlong1', '[[ENC]]3515fdd0e08a2f0b3edd2ce295dc4c1504be88326ccad2f1d7aa6f31d0d3b471', 'FifteenCharacte', '', 'Cavness', '2015-10-25 17:42:24.311564+00', '2015-10-25 17:43:48.392557+00', '2015-10-25 17:42:24.311564+00', '2015-10-25 17:43:48.392557+00', 2, '', 'kenneth.cavness@gmail.com', '', true, false, NULL, 'ImplA', 'hfUTJ)XCmlLZr@#%zcVX8EwZL6vJ%ejc', '2015-10-25 17:42:24.326996+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (313, '4c33b434-1f9d-4a8c-991f-918b375d5ed3', 'pUser-87654321', '', 'Public', '', 'User', '2016-01-18 19:17:55.189398+00', NULL, '2016-01-18 19:17:55.189398+00', NULL, 1, '', '', '', false, false, NULL, 'None', NULL, NULL, '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (306, '0e99b243-73f4-40cd-961f-12b603c9627e', 'gretchie', '[[ENC]]7c0af35f70006d2d773141029dff43a3022c1ac18f02e260cedce9b582e7978e', 'SaylorGrr', '', '', '2015-10-26 01:48:22.197524+00', '2015-10-26 01:49:54.695679+00', '2015-10-26 01:48:22.197524+00', '2015-10-26 01:49:54.695679+00', 2, '', 'gretchen.saylor@gmail.com', '', true, false, NULL, 'ImplA', '9UC26u^1LrLtC@PF&kjmSLnQzi1AP3yY', '2015-10-26 01:48:22.209011+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (303, 'f433483e-848a-fb0d-a0aa-f49da3daef49', 'Grrrrrretchen', '[[ENC]]435541e7c0ee6fdb4bc43e1b32ba614f64294cfd2290659af4221b54889455b6', 'GretchenIsAwesome', '', '', '2015-10-26 01:12:36.403548+00', '2015-10-26 01:13:20.767046+00', '2015-10-26 01:12:36.403548+00', '2015-10-26 01:13:20.767046+00', 2, '', 'gretchen.saylor@gmail.com', '', true, false, NULL, 'ImplA', '#XlU9pGK34jP%XSt(V$wI7krmI4BVYoN', '2015-10-26 01:12:36.420138+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (307, '209774a1-739a-4b60-bfee-9cb00c7ee6e0', 'pUser-12345678', '', 'Public', '', 'User', '2015-11-10 13:04:38.154575+00', NULL, '2015-11-10 13:04:38.154575+00', NULL, 1, '', '', '', false, false, NULL, 'None', NULL, NULL, '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (305, 'a7557a84-87b9-4a32-101d-46d38458ff1f', 'Grrretchen', '[[ENC]]f897c75038f847b1c435605bdffd86f4a198bf7ec6cf16d8272554120d743344', 'GretchenIsAwesome', '', 'Saylor', '2015-10-26 01:19:55.668371+00', '2016-01-30 02:38:34.877657+00', '2015-10-26 01:19:55.668371+00', '2016-01-30 02:38:34.877657+00', 2, '', 'gretchen.saylor@gmail.com', '', true, false, NULL, 'ImplA', '^&APwNfSq#1^ybcYX(vmJ3EI5xQ3^BP!', '2015-10-26 01:19:55.68466+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (309, 'f5e2ab58-7281-95da-dd66-2c1b60c99353', 'KennethTestLast1', '[[ENC]]24dde62a533483f40b581e133e47a1caabcd90b015f7001b1c266c3d1492609f', 'KennethTestLast1', '', 'Cavness', '2015-11-19 01:12:28.60475+00', '2015-11-22 14:53:05.803079+00', '2015-11-19 01:12:28.60475+00', '2015-11-22 14:53:05.803079+00', 2, '', 'kenneth.cavness@gmail.com', '', true, false, NULL, 'ImplA', 'OD*mlt#^tLJL8sF&#1Dg%UlZePP1yKBd', '2015-11-19 01:12:28.619764+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (320, 'a2b6c351-b3b0-f86a-5a2a-bf9785ce2529', 'kdfTest88', '[[ENC]]67e7c578c06e4fddb61701f371ea50d8756b2b6cc93bb00e87034e4a10c197eb', 'Test', '', 'Test', '2016-05-25 01:53:01.382817+00', '2016-06-15 01:08:27.772637+00', '2016-05-25 01:53:01.382817+00', '2016-06-15 01:08:27.772637+00', 2, '', 'northbridge.test@yahoo.com', '', true, false, NULL, 'ImplA', 'gjTz61UMKmbw(4@Ajis(Bcm^sZ6NqSdG', '2016-05-25 01:53:01.396967+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (314, 'd3e9b4ba-5b95-1120-2ff2-0295d13f463c', 'kdfTest19', '[[ENC]]0ef66df083673d1ff95cd072d9738466d4ed5736aceb7b00724801b9a2cd1194', 'Regression ', '', 'Tester', '2016-05-10 18:46:20.535653+00', '2016-05-10 18:47:13.985627+00', '2016-05-10 18:46:20.535653+00', '2016-05-10 18:47:13.985627+00', 2, '', 'kathy.d.flint@gmail.com', '', true, false, NULL, 'ImplA', 'iA8papXcKJ0DdCdGI($(w5QYYKh93*Kl', '2016-05-10 18:46:20.548158+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (315, '0de6e8ae-ecb7-22c2-d425-e6f768effcec', 'pUser-82d0833f', '', 'Public', '', 'User', '2016-05-10 19:42:05.620236+00', NULL, '2016-05-10 19:42:05.620236+00', NULL, 1, '', '', '', false, false, NULL, 'None', NULL, NULL, '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (316, '1ee77a30-6e88-5b82-0f4b-51dcb0932592', 'kdfTest49', '[[ENC]]f7cf9f19b27a82b7b4cd9dd6bd008be6b08c7a1949f885da7499ecb5459a7b9f', 'Testy', '', 'Tester', '2016-05-10 19:43:13.204303+00', NULL, '2016-05-10 19:43:13.204303+00', NULL, 1, '', 'kathy.flint@yahoo.com', '', true, false, NULL, 'ImplA', '%4Ie@fkAbffOzJzkti)wCIm9B*mSlFug', '2016-05-10 19:43:13.22595+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (317, 'b6f42532-0416-f3a3-8b42-460088b70971', 'pUser-8eb52935', '', 'Public', '', 'User', '2016-05-10 20:38:53.078311+00', NULL, '2016-05-10 20:38:53.078311+00', NULL, 1, '', '', '', false, false, NULL, 'None', NULL, NULL, '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (293, '5ef92865-0168-b61d-7388-c0d09f3a9c0b', 'userdemo', '[[ENC]]437f88d03fbae108f1ae6266c597139be2620e74f81dabbdbb695bfef895ea7b', 'aaNot', '', 'Used', '2015-10-05 18:25:48.960946+00', NULL, '2015-10-05 18:25:48.960946+00', NULL, 1, '', 'test@test.com', '', false, false, NULL, 'ImplA', 'UX%i0fxYanlmy5axeoZ)M&t^gujcJ84t', '2015-10-05 19:11:30.089863+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (319, 'c5cc2323-2af2-dac9-6207-3095bf6d5525', 'kdfTest77', '[[ENC]]6a27168d0f4e37ccbf1c9dd2c7145bb2dad2e82b3a9d438b9baed8bd1ffbdfcd', 'Kathy', '', 'Flint', '2016-05-25 01:40:42.60277+00', '2016-05-25 01:51:51.498991+00', '2016-05-25 01:40:42.60277+00', '2016-05-25 01:51:51.498991+00', 2, '', 'northbridge.test@yahoo.com', '', true, false, NULL, 'ImplA', 'Dq*kPz2oMC9f3NN)K8ve@%^LWTn(FUZ8', '2016-05-25 01:40:42.610254+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (310, 'd7c0135d-9873-768e-0dbe-94f50a995b44', 'sdfghjk', '[[ENC]]1a292b88431771b31d258a27a503af4b7cd8c38a68c8be52f7e1525e67f8098d', 'Kathy', '', 'Flint', '2015-12-09 23:37:18.267728+00', '2017-01-31 14:33:03.158638+00', '2015-12-09 23:37:18.267728+00', '2017-01-31 14:33:03.158638+00', 2, '', 'kathy.flint@yahoo.com', '', true, false, NULL, 'ImplA', 'abjy0j8NHO5f3XqM)JrNcbhZ$4(guU&E', '2015-12-09 23:37:18.296469+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (260, '2a05bcdf-52a5-6ad1-e021-a97a08b989f3', 'gretchensaylor', '[[ENC]]f920a9d03aa7a8556f8f78daa9dcdda5b3741dddc870006854754396bcff14e4', 'Gretchen', '', 'Saylor', '2015-08-17 00:57:17.764236+00', '2017-03-06 02:17:29.802952+00', '2015-08-17 00:57:17.764236+00', '2017-03-06 02:17:29.802952+00', 2, '', 'gretchen.saylor@gmail.com', '', false, false, NULL, 'ImplA', 'ga#xCZ(29&3Aip3cmvabgfKNLaEici8t', '2016-11-10 20:04:26.515221+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (325, '89fb6765-885c-3e2d-da7a-1f479d24a165', 'kdfTest79', '[[ENC]]f97e73370fce1e717be8750d418490aff04039e151172d96abbfa07162c1fd51', 'Kathy-79', '', 'Tester', '2017-01-31 01:31:40.736683+00', NULL, '2017-01-31 01:31:40.736683+00', NULL, 1, '', 'test@test.com', '', true, false, NULL, 'ImplA', '61#I%l&cf88iQ*EGq%ypTM2Hr3GbNJ7U', '2017-01-31 01:31:40.740993+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (318, 'e42179bd-0a75-0f73-083a-15699bc3fdde', 'kdfTest42', '[[ENC]]3d92608ba0feea27bebf85e8cde0ef2bde051ff341452cb3e453392ca850f373', 'Kathy', '', 'Flint2', '2016-05-10 20:39:46.323571+00', NULL, '2016-05-10 20:39:46.323571+00', NULL, 1, '', 'test@test.com', '', false, false, NULL, 'ImplA', 'e!09Jv1dqqvg^T(HSUP7Xr%sorjiYZh2', '2017-01-20 20:08:39.93073+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (308, 'be72d650-9db6-45a1-9cc1-9dca6f5b024f', 'kdfTestAdv', 'password0', 'Kathy', '', 'Flint', '2015-11-15 23:54:35.963683+00', NULL, '2015-11-15 23:54:35.963683+00', NULL, 1, '', 'test@test.com', '3129195627', false, false, NULL, 'None', NULL, NULL, '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (329, '97920ba4-97c6-a6fc-2a8a-856fd164f28f', 'kdfNwmTest', '[[ENC]]7ad73d6fd4a678c3a69696774be72e23423b740fe7429aebec2681250b1b0696', 'Kathy-nwm', '', 'Tester', '2017-01-31 14:35:01.960553+00', '2017-10-03 17:30:22.29+00', '2017-01-31 14:35:01.960553+00', '2017-10-03 17:30:22.29+00', 2, '', 'kathy.d.flint@gmail.com', '', true, false, NULL, 'ImplA', 'ZGJLTTfBO(VBRMP#UxHkOUGKLTjKcnk2', '2017-01-31 14:35:01.990146+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (321, 'c8a88d59-3199-a826-1509-f9e4424cfb0d', 'kdfTest99', '[[ENC]]3d608429333cc4587fe6e99998c6e8372b5335657c48d9db0fa45bc5313e2eb6', 'Test', '', 'Test', '2016-05-25 01:57:14.036349+00', '2017-01-31 14:32:56.827795+00', '2016-05-25 01:57:14.036349+00', '2017-01-31 14:32:56.827795+00', 2, '', 'northbridge.test@yahoo.com', '', true, false, NULL, 'ImplA', '5Zy!qcZ8TpKe$GGD9lj4*sl#NqqcO(HU', '2016-05-25 01:57:14.041139+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (323, '9316feb6-c6fc-965f-31bb-245e727a57cd', 'forumTest', '[[ENC]]6fe0c9af1c91a591cbb7ed8ed603bb1421d84100c35cad42d6ee64dd8763b488', 'Forum', '', 'Tester', '2016-12-13 21:14:20.367746+00', NULL, '2016-12-13 21:14:20.367746+00', NULL, 1, '', 'kathy.d.flint@gmail.com', '', true, false, NULL, 'ImplA', 'q)e6GJbDC8p63(lCR2)LXzQ4pf%RtX1U', '2017-01-30 18:05:18.242531+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (353, 'bee50a7d-caad-f95f-37d4-d29a87ce9b61', 'kdfTest293', '[[ENC]]301be36715f6890e218b061dad9f37081b4748684836b3b048bc265da6e388a3', 'Kathy2', '', 'Flint2', '2017-03-02 23:46:10.077234+00', NULL, '2017-03-02 23:46:10.077234+00', NULL, 1, '', 'test@test.com', '', true, false, NULL, 'ImplA', 'L7$(tur&e99D%hWn6Y5RQITtwMF1scW3', '2017-03-02 23:46:10.105347+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (359, '744ad535-d188-da0f-1050-31091dcc952d', 'kdfCats11', '[[ENC]]f753fc74c36e79102e27ebbb82b9ea7a037d7c21cbf9030f75dec2c742cb9b25', 'Kathy', '', 'Flint 3', '2017-05-08 00:08:01.827142+00', NULL, '2017-05-08 00:08:01.827142+00', NULL, 1, '', 'test@test.com', '', true, false, NULL, 'ImplA', '$(V#ObNwH&3bqICTdIJfNHht25f6qJ!k', '2017-05-08 00:08:01.848225+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (341, '5f5c2e8a-4520-b83c-eb7b-59e0a95e12e4', 'kdfCats2', '[[ENC]]3b27193c12818ba2722b83d5ece05e4c4d1ae92f6444584c0c4265f9c0f44107', 'Cats2', '', 'Flint', '2017-02-12 23:23:27.959662+00', '2017-08-09 00:39:04.256788+00', '2017-02-12 23:23:27.959662+00', NULL, 1, '', 'kathy.flint@northbridgetech.org', '', false, false, NULL, 'ImplA', 'A*vGd*^RYeTLPfPAQqchS%xzbE3CEyE5', '2017-02-12 23:23:28.002423+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (343, 'df99c475-00d3-6971-55c7-5a65d0828f55', 'thordog', '[[ENC]]0fd0e0abd52bec3a6755629a13e2beedfc07a2300e40d5b2650cc8328ecd9326', 'Thor', '', 'Saylor', '2017-02-13 02:08:39.642313+00', NULL, '2017-02-13 02:08:39.642313+00', NULL, 1, '', 'gretchen.saylor@gmail.com', '2246286371', true, true, NULL, 'ImplA', 'vJb@AmAwG66XVlnnRx3yi#NNAztkw(D#', '2017-02-13 02:08:39.770966+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (356, '66578a87-ccce-0fb2-baec-a95eb21fb8c5', 'gsaylor123', '[[ENC]]c343da14562338edca7fc7a840fc3688c8611033e9ea2d3692cd4a32135e62b4', 'Gretchen', '', 'Saylor', '2017-03-06 02:18:02.420336+00', '2017-08-07 01:38:30.146063+00', '2017-03-06 02:18:02.420336+00', '2017-08-07 01:38:30.146063+00', 2, '', 'gretchen.saylor@gmail.com', '', false, false, NULL, 'ImplA', '3nsgv*4k*iSTYVw25ag8K4CINZ1EPckS', '2017-07-10 01:24:01.612442+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (342, '003fd0f1-11f5-2662-c1ef-dd6fd1de080e', 'kgccattest1', '[[ENC]]8e94df267cc6f89249ad1b176562182fdb11356e4858c085b8974d67882a547e', 'Kenneth', '', 'Cavness', '2017-02-13 02:07:13.192753+00', NULL, '2017-02-13 02:07:13.192753+00', NULL, 1, '', 'kenneth.cavness@gmail.com', '7734120657', true, true, NULL, 'ImplA', 'DctB9N0YFaWY)2^ki*fUXY52Zy&Pna)!', '2017-02-13 02:07:13.210333+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (336, '1a077937-7e6a-81e5-ae4d-52b31f367580', 'kgctest1', '[[ENC]]852d03e6e3d89ae094f0717faf5e134816a58365b51963c7f093530f6819a9d8', 'Kenneth', '', 'Cavness', '2017-02-01 02:13:50.637015+00', NULL, '2017-02-01 02:13:50.637015+00', NULL, 1, '', 'kenneth.cavness@gmail.com', '', true, false, NULL, 'ImplA', '#Fl9lfWUBUNjszVpI%*&kqOR7Hsj#B1U', '2017-02-01 02:13:50.647927+00', '', false, false, '', '7734120657', true, NULL);
INSERT INTO "user" VALUES (337, '4521a5fa-c55e-bdd2-d27d-b10fd8a1f7e3', 'lou1234', '[[ENC]]618aab41635bc8ee7f8f25b94639ea4639b2408b83923fe4ea2dbaf35c4e5b56', 'Lou', '', 'Patel', '2017-02-01 02:17:37.492581+00', NULL, '2017-02-01 02:17:37.492581+00', NULL, 1, '', 'coach.lou@northbridgetech.org', '', true, false, NULL, 'ImplA', 'WalTdyWQjf0TyoyyjeKF&Ij*4vC%xSnj', '2017-02-01 02:17:37.515947+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (350, '2d07a501-44da-66da-56f0-032ec91ee3f8', 'gesaylo', '[[ENC]]6f09b036cee07341fe9ffea9773c89938bc8951ae31c110173ac9c95baeb52b2', 'Gretchen', '', 'Saylor', '2017-02-27 02:04:18.920086+00', '2017-09-11 00:09:31.618621+00', '2017-02-27 02:04:18.920086+00', NULL, 1, '', 'gretchen.saylor@gmail.com', '2246286371', false, false, NULL, 'ImplA', '0(IdqXs#5SJanz!H#BpxexsNZ#KiuEPu', '2017-09-11 00:09:31.642143+00', '', false, true, '', '', false, NULL);
INSERT INTO "user" VALUES (338, '7c6017a4-fccd-bd3d-818b-9078f927f071', 'pUser-02f138b9', '', 'Public', '', 'User', '2017-02-12 21:34:48.337269+00', NULL, '2017-02-12 21:34:48.337269+00', NULL, 1, '', '', '', false, false, NULL, 'None', NULL, NULL, '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (330, 'e35711ed-1ae6-b737-7020-76d018160836', 'kdfTestEnroll2', '[[ENC]]c5127d07d3b1915de89d670b47394fe1fddce635b1e2ef1a4c6ed1ab487a373f', 'Kathy-enroll2', '', 'Test', '2017-01-31 15:10:54.517515+00', NULL, '2017-01-31 15:10:54.517515+00', NULL, 1, '', 'test@test.com', '', true, false, NULL, 'ImplA', 'TA9EK68^qM^cKenOtEw!$Pt*w88OCNAm', '2017-01-31 15:10:54.557801+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (355, '4cb40b67-7532-32b9-b8f7-70896c0bcce2', 'kdfCats5', '[[ENC]]5f8c18a6cbc5336419f01749a6b5c585feb3f3f8c128f3c2bf658476c44a667d', 'Floating', '', 'Tester', '2017-03-03 19:07:47.903426+00', '2017-09-18 01:15:54.786075+00', '2017-03-03 19:07:47.903426+00', NULL, 1, '', 'tim.saylor@gmail.com', '', false, false, NULL, 'ImplA', '$%LSsPooDL3x(33CHVQ$p%wyV4ZmR@dL', '2017-03-03 19:07:47.93241+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (345, 'd9ffb171-58fa-55c1-2dab-86d0e265079b', 'lou20170212', '[[ENC]]001417d37458163f855602e06ec2769dfc49f326c92f1cad159ad808370e21b2', 'Lou', '', 'Patel', '2017-02-13 02:11:38.364702+00', NULL, '2017-02-13 02:11:38.364702+00', NULL, 1, '', 'coach.lou@northbridgetech.org', '', false, false, NULL, 'ImplA', 'Jnn%zcSfL6QBb9I8t1(DfWv*JT0s0qrK', '2017-02-27 02:18:57.353658+00', '', true, false, '', '', false, NULL);
INSERT INTO "user" VALUES (339, 'e18d3fca-5c27-bc4a-7cc1-c4bf53b21772', 'kdfCatsAdmin', '[[ENC]]9c62f9b0a48d1b14d21844fd645235d9e5313c6fd87ad333746e748cfb0716bf', 'Cats', '', 'Flint', '2017-02-12 21:55:15.188463+00', '2017-07-24 16:20:32.890148+00', '2017-02-12 21:55:15.188463+00', NULL, 1, '', 'kathy.d.flint@gmail.com', '', false, false, NULL, 'ImplA', 'gf39Py9Pdu*q!$z@O!WTjptjHcyi!en6', '2017-07-24 16:20:32.90573+00', '', true, false, '', '3129195627', false, '{"occupation":"Teacher","network":"339"}');
INSERT INTO "user" VALUES (344, '355c2831-26a2-dc98-1d80-144f61ee8623', 'kdfCats3', '[[ENC]]00452deaef54823d48fe4ae3daea399541df500410146ec06f144a2ee39a94e2', 'Cats2', '', 'Flint', '2017-02-13 02:09:00.343087+00', NULL, '2017-02-13 02:09:00.343087+00', NULL, 1, '', 'kathy.d.flint@gmail.com', '', true, false, NULL, 'ImplA', '(4LT!qU77b(*0o69IH%DmbFH0y#ICCLA', '2017-02-13 02:09:00.34746+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (346, '8ae641bf-3e20-2502-4214-5431bacd9130', 'kgccattest2', '[[ENC]]26c99c024bcc06aabb2ff63f71722b0762a4ebfe27dc6cc9cc9f15638ffbcafe', 'Kenneth', '', 'Cavness', '2017-02-13 02:57:41.754965+00', NULL, '2017-02-13 02:57:41.754965+00', NULL, 1, '', 'kenneth.cavness@gmail.com', '', true, false, NULL, 'ImplA', 'mOxIHSjz2$Umef9Y*TPMAFhyBj($5^Yr', '2017-02-13 02:57:41.788845+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (347, '35a62ca5-cccc-4997-bfa9-9571c7c4acb0', 'nUser-02f138b9', '', 'Network', '', 'User', '2017-02-26 15:30:36.55428+00', NULL, '2017-02-26 15:30:36.55428+00', NULL, 1, '', '', '', false, false, NULL, 'None', NULL, NULL, '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (348, '501971d9-685f-c4ee-cdc0-e726e6f8aaa9', 'kdfProdValidate1', '[[ENC]]7cb90f72dfb412461d1aa83c60394b81adae36314a0249138c24c7269d82a6ac', 'KathyV', '', 'Flint', '2017-02-26 20:03:28.098351+00', '2017-02-26 20:33:02.140691+00', '2017-02-26 20:03:28.098351+00', '2017-02-26 20:33:02.140691+00', 2, '', 'kathy.d.flint@gmail.com', '', true, false, NULL, 'ImplA', 'GII%CqVOnLIBh3b&zKO)Mg5QUBQz79)N', '2017-02-26 20:03:28.12865+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (349, '4e6223b0-14be-777e-096e-e8757ca41d1b', 'kdfValid1', '[[ENC]]2317bb83301990c66cf6557d7103cc39d1aa9fe7fd5cb1204e849f32adf4caae', 'KathyJoJo', '', 'Flint', '2017-02-26 20:19:19.380437+00', '2017-02-26 20:33:06.042383+00', '2017-02-26 20:19:19.380437+00', '2017-02-26 20:33:06.042383+00', 2, '', 'kathy.d.flint@gmail.com', '', false, false, NULL, 'ImplA', '0dC^U1k1ZV23@XRHvy#ghvAi8DuokPRk', '2017-02-26 20:31:27.503915+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (335, '3f875dd3-987c-ebd9-4884-d8982f09e23a', 'gesaylor', '[[ENC]]c114f6e2337fcfd4b5f2a52129cb6956938118601df5739747dac9b9739a4b66', 'Gretchen', '', 'Saylor', '2017-02-01 02:11:39.101396+00', '2017-07-10 01:14:53.429035+00', '2017-02-01 02:11:39.101396+00', NULL, 1, '', 'gretchen.saylor@gmail.com', '2246286371', false, false, NULL, 'ImplA', 'FpUoUYwqJk*)4xoO9t&yfWwrk&6lZNVv', '2017-07-10 01:14:08.447754+00', '', false, false, '', '2246286371', true, NULL);
INSERT INTO "user" VALUES (352, '882991e8-59e5-8553-36a4-ffc75441c76c', 'kdfTest793', '[[ENC]]0bf4df6ec73dc188ed395206b1606bcdd925d65019deec6e58ebb1a8c94b0dfe', 'Kathy ', '', 'Flint', '2017-03-02 23:44:55.970292+00', NULL, '2017-03-02 23:44:55.970292+00', NULL, 1, '', 'kathy.d.flint@gmail.com', '', true, false, NULL, 'ImplA', 'vEAwcJ0lFzPTQhCNd$wx59!g^rHeC#(*', '2017-03-02 23:44:55.999779+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (357, 'd45a1a65-f7b5-e992-7ac7-46803c6d9a4b', 'LouWebMeet', '[[ENC]]c23d024a6f4eb9db6c8a1f8b8bfb6fe2d7c34343a08b42e08054c1854280ddab', 'Lou', '', 'WebMeet', '2017-03-06 02:20:55.91818+00', NULL, '2017-03-06 02:20:55.91818+00', NULL, 1, '', 'coach.lou@northbridgetech.org', '', true, false, NULL, 'ImplA', '*lDRl3(!JFCHl$jBPQ&NyLe4@PmGMiAJ', '2017-03-06 02:20:55.94395+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (354, '68a2e2c6-89b3-38a8-4a9a-c383976b9d44', 'kdfCats4', '[[ENC]]eb78f8186b1b2a4462ae6d174334e2bda11ff6c9950a11bb7d5e2358467b12b3', 'Kathy4', '', 'Flint', '2017-03-03 19:00:29.214367+00', '2017-07-24 16:18:19.244328+00', '2017-03-03 19:00:29.214367+00', NULL, 1, '', 'kathy.d.flint@gmail.com', '', false, false, NULL, 'ImplA', '8Ix!7WmcftUAllWT9t1Vn5^q@@8RRwa!', '2017-07-24 16:18:19.281685+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (351, 'ecb9d297-08b4-5aeb-9049-0f1219674c7e', 'kenneth1-02262017', '[[ENC]]27dafc0eb75c5ade9e2868eab4ae09533d556ca6549958d81da5530a866e9ba8', 'Kenneth 02262017', '', 'Cavness', '2017-02-27 02:06:09.349771+00', NULL, '2017-02-27 02:06:09.349771+00', NULL, 1, '', 'kenneth.cavness@gmail.com', '7734120657', false, false, NULL, 'ImplA', 'cbCqOWa1vmsLmfmx)WXyzhryGtJgNz1Z', '2017-02-27 02:06:09.361688+00', '', true, true, '', '7731112222', true, NULL);
INSERT INTO "user" VALUES (326, '72340275-a358-980f-49eb-bfef1477ce52', 'groupEnrollTest', '[[ENC]]393be73e4fec2737606432115ca8911e304b4f1e8074c3e1889b68f1fb73e4ab', 'Kathy-Enroll', '', 'Test', '2017-01-31 02:28:55.954122+00', NULL, '2017-01-31 02:28:55.954122+00', NULL, 1, '', 'test@test.com', '', true, false, NULL, 'ImplA', 'vbk6$%Fs97VyzA0SzZh%0NJ5sctYp9mU', '2017-01-31 02:28:55.971867+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (324, 'dc8d6bdc-1b1e-2396-53e3-e6b9b7e3097b', 'kdfTest78', '[[ENC]]59036e57b4f214b11c6f4a2e92b1413461cf73361194f50c06ee97af475d2187', 'Kathy-78', '', 'Tester', '2017-01-31 01:17:19.078558+00', NULL, '2017-01-31 01:17:19.078558+00', NULL, 1, '', 'test@test.com', '', true, false, NULL, 'ImplA', 'oL5t6g0SzUoa2ZN43oJatWe&6GKaa64y', '2017-01-31 01:17:19.102099+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (327, '668ad253-ff14-cd85-1f30-88b8d9dfd2f4', 'kdfTesEnroll', '[[ENC]]dadcfcd8f2911b3f0de8056d4d2704348df6f12291a50f5a7165bb231d455105', 'Kathy-Enroll', '', 'Test', '2017-01-31 02:49:18.967903+00', NULL, '2017-01-31 02:49:18.967903+00', NULL, 1, '', 'test@test.com', '', true, false, NULL, 'ImplA', 'bi#nD^qXXuk$vMWeN$Fj5F^Wa79!!x11', '2017-01-31 02:49:18.98763+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (328, 'e7b28391-0e67-a483-dfa2-d797c939ce09', 'kdfTestEnroll', '[[ENC]]546e5b86ad7c16e1ccf75550692f15667ec5a5e5eeb4ae5cadf222090136e552', 'Kathy-enroll', '', 'Test', '2017-01-31 03:01:20.587427+00', NULL, '2017-01-31 03:01:20.587427+00', NULL, 1, '', 'test@test.com', '', true, false, NULL, 'ImplA', 'ddT!B9OW#V2n7oiYoUDYmK@r6bytH4OU', '2017-01-31 03:01:20.603374+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (340, '92a10941-c4ca-f39c-d3a4-7dd7b87a78ef', 'kdfCats1', '[[ENC]]0d2abc69f4fc06c8e72b14954c0a30c5f5ac2073b1d92cc52af6bbc377c32e1e', 'Cats1', '', 'Flint', '2017-02-12 22:10:27.259611+00', '2017-08-09 00:39:41.264972+00', '2017-02-12 22:10:27.259611+00', NULL, 1, '', 'contact@northbridgetech.org', '', false, false, NULL, 'ImplA', 'Ua88Z02o2NU)$JxoQzMzE@Gde*80WYjG', '2017-02-12 22:10:27.2832+00', '', true, false, '', '8473025289', false, '{"occupation":"School district level administrator","parent":"yes","subscribe":"no","network":"339"}');
INSERT INTO "user" VALUES (331, '6d2b9cc0-e7a0-63e7-2a3c-c1243d086672', 'kdfTestEnroll3', '[[ENC]]7dfff3fafdeedddc0326099dbc38476e40c4ca3ec0e029d040cdb8739a1f7fb4', 'Kathy-e3', '', 'Tester', '2017-01-31 15:15:23.733491+00', NULL, '2017-01-31 15:15:23.733491+00', NULL, 1, '', 'test@test.com', '', true, false, NULL, 'ImplA', 'pFm)kO72U@*(y8QcAd9BWJ7EX6m1Tvp9', '2017-01-31 15:15:23.75524+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (332, '04d54a61-b57c-7c77-31b4-4aaf9c43e536', 'kdfTestE4', '[[ENC]]704e8696f8d5a1415b4d7784962b9baf0cdb5126265b888c6e0d371dbbbab8ee', 'Kathy-e4', '', 'Tester', '2017-01-31 15:18:33.249088+00', NULL, '2017-01-31 15:18:33.249088+00', NULL, 1, '', 'test@test.com', '', true, false, NULL, 'ImplA', 'sr1)mLo$IINJpLYHnSB0gF1F!d$WA1m$', '2017-01-31 15:18:33.256798+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (333, 'd7cade3d-87ea-9d8f-b93a-f9cb13408a2a', 'kdfTestE5', '[[ENC]]8498294dba98362f9f2e67d7e9ff337eff277cffca75877e321e23707e7b00db', 'Kathy-e5', '', 'Tester', '2017-01-31 15:20:34.453965+00', NULL, '2017-01-31 15:20:34.453965+00', NULL, 1, '', 'test@test.com', '', true, false, NULL, 'ImplA', 'wlD%meXsmF77)pLe##Et*J&Zj()MEYK0', '2017-01-31 15:20:34.46555+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (334, '150ba8ef-a5f7-9664-5f7d-3f60092e042e', 'kdfTestE6', '[[ENC]]a5ed9162c06cdde6d9924aae484c9b28e6c6b4fbb4db49e3553b7a4e1e36dd05', 'Kathy-e6', '', 'Tester', '2017-01-31 15:22:05.98453+00', NULL, '2017-01-31 15:22:05.98453+00', NULL, 1, '', 'test@test.com', '3129195627', true, false, NULL, 'ImplA', '#P(XnHrP6QEQOrAm)suXvyAb8PcXo@Mg', '2017-01-31 15:31:29.738626+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (361, 'b17fbb49-b07f-ce39-a08a-fb2c687763ea', 'Hemalatha', '[[ENC]]04273e79699bcbfb4c1586fec31c0084c09ff992c166211ee709694c802b7f31', 'Hemalatha', '', 'Nambiradje', '2017-07-10 00:57:49.274744+00', '2017-07-18 16:25:42.089503+00', '2017-07-10 00:57:49.274744+00', NULL, 1, '', 'hemalatha.nambiradje@gmail.com', '', false, false, NULL, 'ImplA', 'g)2R4J)ugRIaBHrrfLBc1rs4KOe@cQ9t', '2017-07-18 16:25:42.112408+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (369, 'e2155d5b-928f-64f4-16d3-5afbd4a068d2', 'hansen_t_d', '[[ENC]]71ac3b926724a862451180c507364fa5eac175ce2ac40f54d2733a4270c8d2c3', 'Hansen', '', 'Dharmawan', '2017-07-24 01:20:27.639691+00', '2017-08-07 19:48:15.75387+00', '2017-07-24 01:20:27.639691+00', '2017-08-07 19:48:15.75387+00', 2, '', 'hansentamaradharmawan@gmail.com', '', true, false, NULL, 'ImplA', 'OIQAelk9IH8NL(OskLFMlfWeKYc*@GKG', '2017-07-24 01:20:27.65889+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (368, '3bafccff-89f8-55ab-afd6-f16741119e70', 'kdfCrm9', '[[ENC]]9c1844caeba3c76476aaf29e1a4f95606ceb0b63f6b16485dd8c7aa8079684ce', 'KAthy', '', 'Flint', '2017-07-20 02:57:42.256581+00', NULL, '2017-07-20 02:57:42.256581+00', NULL, 1, '', 'kathy.d.flint@gmail.com', '', true, false, NULL, 'ImplA', 'U7PZcO4h@wZ@s0OVPcJ1q@G4TP)$yCqj', '2017-07-20 02:57:42.273522+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (358, 'abff5a81-00dd-aab4-723d-faf4caf66351', 'kdfCats6', '[[ENC]]aa9af03c73b0553cb1f5b5187c3c60c04a2208a3284cd36ae8bb291a2d4cdd71', 'Kathy 6', '', 'Flint', '2017-03-12 22:39:25.619666+00', '2017-07-24 15:59:37.859159+00', '2017-03-12 22:39:25.619666+00', '2017-07-24 15:59:37.859159+00', 2, '', 'test@test.com', '', true, false, NULL, 'ImplA', 'nhN8YxReQJE2R5$D)vlXnNEYH0u5C7B!', '2017-03-12 22:39:25.624634+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (261, '085458bc-0aa0-c583-3362-a6f7735dccd9', 'demoUser3', '[[ENC]]47898a718a29b6bc651dff479aa0b20ee569c72d0e2312ba43ba6cd71495a22d', 'Kathy', '', 'Kathy', '2015-08-31 20:49:51.627269+00', '2015-09-03 00:21:35.835224+00', '2015-08-31 20:49:51.627269+00', '2015-09-03 00:21:35.835224+00', 2, '', 'test@test.com', '', true, false, NULL, 'ImplA', '*CyzPGXPh$th4s*3qYNw6x3YVn$8dYEa', '2015-08-31 20:49:51.668053+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (266, '59b8a075-fd35-cf66-5d10-2709c4926502', 'asdfo;inqef', '[[ENC]]e709b3393d754b3ecc6774ca656740bcbb26fe964f6e2f73f1c4f339b18d7b92', 'Kathy', '', 'Kathy', '2015-09-03 00:22:21.881494+00', '2015-09-09 23:29:46.483764+00', '2015-09-03 00:22:21.881494+00', '2015-09-09 23:29:46.483764+00', 2, '', 'test@test.com', '', true, false, NULL, 'ImplA', '(pw7D50bc)$8dvB!yOvcENSztOmuPvEN', '2015-09-03 00:22:21.925283+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (268, '8b90123a-240f-84ae-1410-207182306a4d', 'joeTest1', '[[ENC]]42eea73c9d2cee11f1bab736111992e6b0f407520d78b68939b0f7f179a9be0d', 'Joe', '', 'Joe', '2015-09-09 23:32:15.520583+00', NULL, '2015-09-09 23:32:15.520583+00', NULL, 1, '', 'test@test.com', '', true, false, NULL, 'ImplA', 'ZKoUnNOddl$V2fsOibfJQvVEYiZBa4g0', '2015-09-09 23:32:15.535873+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (269, '2557ae9f-af5d-bbfb-a4be-4f19190c515d', 'joeFlint', '[[ENC]]8bf94847ebf6087ad15b9ee8c0088e3810646a65b8a74e2dff19444d601e327c', 'Joe', '', 'Joe', '2015-09-09 23:41:19.10834+00', NULL, '2015-09-09 23:41:19.10834+00', NULL, 1, '', 'test@test.com', '', true, false, NULL, 'ImplA', 'BbWXY0Mug@Iba9gFh2yEujmBt(3s1jSD', '2015-09-09 23:41:19.121571+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (270, '53364e54-4424-27ae-aa95-067885c224d2', 'kdfTestTO', '[[ENC]]c8c2f1dde489f2c2012166760a6e5751b5f8b0487ac493940030d0a09ea89ac4', 'Dev', '', 'Dev', '2015-09-11 14:55:00.132472+00', NULL, '2015-09-11 14:55:00.132472+00', NULL, 1, '', 'test@test.com', '', true, false, NULL, 'ImplA', '3th5MOL&*PbxSm^I3Fri&)RLbjog7Tha', '2015-09-11 14:55:00.155898+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (271, '9def0922-1d87-026f-5685-e46ffff75043', 'kdfTestTO1', '[[ENC]]680272f90abb7168fa9bae3bc24805f4cd9331b4b98f5c1ed0942c9ce366193a', 'Dev', '', 'Dev', '2015-09-11 15:07:06.254874+00', '2015-09-11 21:36:02.832665+00', '2015-09-11 15:07:06.254874+00', '2015-09-11 21:36:02.832665+00', 2, '', 'test@test.com', '', true, false, NULL, 'ImplA', 'Fv8fG7rmJ8)7OjEzwI)g2YDM2!DfpUO^', '2015-09-11 15:07:06.277969+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (362, '12aa2568-a772-d448-9948-5220540c6b9c', 'kdfCrm3', '[[ENC]]766a0a1420fde0424120bcbf05b1e6ad2a6ceb823ba9d48a2037982f791d9f28', 'Kathy', '', 'Flint', '2017-07-20 01:00:41.400525+00', NULL, '2017-07-20 01:00:41.400525+00', NULL, 1, '', 'test@test.com', '', true, false, NULL, 'ImplA', 'iWPlhl*DIA#iQ$DXvnUZNjQVoUkr!Jp9', '2017-07-20 01:00:41.480916+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (363, '8a6c2fe7-df5f-e351-af3d-fc349f5f8230', 'kdfCrm4', '[[ENC]]65e68323e84ec3033ed6270e39aeef820d3629710d7a978f5e031055454310fe', 'Kathy', '', 'Flint', '2017-07-20 01:23:44.032316+00', NULL, '2017-07-20 01:23:44.032316+00', NULL, 1, '', 'test@test.com', '', true, false, NULL, 'ImplA', '2%6*#jh8UTsaUuftxDURK$Iwz*$y8owa', '2017-07-20 01:23:44.058821+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (364, '1a5ddd21-5701-975c-0495-5b1d12cd4c9e', 'kdfCrm5', '[[ENC]]acfeed05fa5b29da17c8c55e734cd87bb536a9e6c1c5c77aee93cec475a0d93b', 'Kathy', '', 'Flint', '2017-07-20 01:32:17.51863+00', NULL, '2017-07-20 01:32:17.51863+00', NULL, 1, '', 'test@test.com', '', true, false, NULL, 'ImplA', '6jQhyAgghB6ozk4^d%9Z3EbtWNs7NN&U', '2017-07-20 01:32:17.543136+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (365, '5076ceb3-bc33-13c2-fc74-d1df4ce21262', 'kdfCrm6', '[[ENC]]fe0e0a0eb6d7ea1c47b4a0fc3025299f27bbf28a0b4a7bf51b723b93a4c344f7', 'Kathy', '', 'Flint', '2017-07-20 01:37:33.467369+00', NULL, '2017-07-20 01:37:33.467369+00', NULL, 1, '', 'test@test.com', '', true, false, NULL, 'ImplA', '%kJ1fYmM@fnnmsX)c9IxZ1vPi4(RVXEP', '2017-07-20 01:37:33.491781+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (366, '9b1d8c30-74b0-53a1-5f00-87743150e37d', 'kdfCrm7', '[[ENC]]31a41fab6fe5bab6eb81fe2cf92ea1611e31efd9210536e350a06e124551034f', 'Kathy', '', 'Flint', '2017-07-20 01:38:49.919279+00', NULL, '2017-07-20 01:38:49.919279+00', NULL, 1, '', 'test@test.com', '', true, false, NULL, 'ImplA', '7ptZ*qVk&@ZVDA)hpE1kp@W^vy^UTam@', '2017-07-20 01:38:49.958151+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (367, 'edd1a043-52b4-3838-e3bb-52eeaddbea59', 'kdfCrm8', '[[ENC]]12d2d251312f16d91d5dbb429e5cbd7ff3b808e3d637fefcc8061800baff4f2c', 'Kathy', '', 'Flint', '2017-07-20 02:32:46.703453+00', NULL, '2017-07-20 02:32:46.703453+00', NULL, 1, '', 'test@test.com', '', true, false, NULL, 'ImplA', '0Ei^(J2^tv2UMuRt7925YSTpdtyl%&z^', '2017-07-20 02:32:46.713449+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (360, '52c97e30-c5d2-dd54-2f0d-282f90cad23c', 'kdfCats12', '[[ENC]]48d754acca1461432c29f3ae787b45a322b1c3382338417f43bfdadbe799f370', 'Kathy', '', 'Flint 12', '2017-05-08 00:10:19.276576+00', '2017-07-24 16:19:11.903301+00', '2017-05-08 00:10:19.276576+00', '2017-07-24 16:19:11.903301+00', 2, '', 'kathy.flint@northbridgetech.org', '', true, false, NULL, 'ImplA', 'qvdT6oLXbCjU1aRaEKoVWu#8d%et%E&l', '2017-05-08 00:10:19.306969+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (370, 'cf7c323e-ad74-0e4d-9eb6-11764231afbb', 'HemaTestUser', '[[ENC]]b399815871fbc9e8bfafcfce09a9835fe893f5e8d789bc7068019db630794987', 'Hema', '', 'Nambi ', '2017-08-15 19:50:31.649236+00', '2017-09-21 02:56:15.395329+00', '2017-08-15 19:50:31.649236+00', '2017-09-21 02:56:15.395329+00', 2, '', 'hemnam24@gmail.com', '', true, false, NULL, 'ImplA', '4(9mUlJ!wo7)*o6NO1oow)P)tqGrzr8D', '2017-08-15 19:50:31.656119+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (371, 'f72244af-34db-d195-d6a8-a9091d5d8e96', 'Tester1', '[[ENC]]e77b3e34025a6a8d571488aaadf8700adacdbb2fa5a972e4dddcded5b6e3df79', 'Tester1', '', '', '2017-08-29 02:32:01.2624+00', '2018-03-27 00:06:35.630004+00', '2017-08-29 02:32:01.2624+00', NULL, 1, '', 'testuser1411988@gmail.com', '', true, false, NULL, 'ImplA', 'PzsxBEKvKja9Cgc@gFyxgLBovIOSk)W0', '2017-08-29 02:32:01.298537+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (375, 'e2470938-6daa-cd44-28e9-68641b1f52d6', 'kdfNwmNonAdmin', '[[ENC]]6ae5e11e7eacc16978efc6b5dbc5b5679af629b3485e3a1ec465c66a614668f6', 'Kathy', '', 'Non-Admin', '2017-10-03 17:20:40.212365+00', NULL, '2017-10-03 17:20:40.212365+00', NULL, 1, '', 'kathy.d.flint@gmail.com', '', true, false, NULL, 'ImplA', 'M)DFMb0Y33u@VJ)PZhk*ninYM3HOGSii', '2017-10-03 17:20:40.234683+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (372, 'c4ad3a66-9bf5-152e-dfbd-645a787aaa38', 'Tester2', '[[ENC]]84dcc862a8eb1ae0728d17e3f0498e395884fcf50f8b7cde2b2bed80b9ff914c', 'Tester2', '', '', '2017-08-29 02:34:01.382913+00', '2018-03-27 01:16:58.298184+00', '2017-08-29 02:34:01.382913+00', NULL, 1, '', 'testuser1411988@gmail.com', '', true, false, NULL, 'ImplA', 'kcyXwog3Qq#pYFzeiE6iDg4pKcVtoFfJ', '2017-08-29 02:34:01.389603+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (380, '75151af4-38b1-fb8f-129c-52a0c55296c1', 'a0s8ehnr', '[[ENC]]4f4394b452491a502e881085cf8c8bacc32d70d79b1015071f2e3adf2371359c', 'Kathy Test', '', 'Flint', '2018-03-27 21:28:38.642+00', '2018-03-27 21:36:47.76016+00', '2018-03-27 21:28:38.642+00', '2018-03-27 21:36:47.76016+00', 2, '', 'kathy.flint@northbridgetech.org', '', true, false, NULL, 'ImplA', 'MRLO@n0ymojMIKiALslGhCYwe66pTlnw', '2018-03-27 21:28:38.647438+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (373, 'c5c364b7-641d-ca89-f245-cb5b3ef11343', 'HemaNambi', '[[ENC]]f243f2b0a28d9ba6860a67ca63e8de95bc3d5d1773b94715a762f0c2169ab745', 'Hema ', '', 'Nambi', '2017-09-25 15:52:36.082301+00', '2017-10-11 18:04:14.214886+00', '2017-09-25 15:52:36.082301+00', NULL, 1, '', 'hemnam24@gmail.com', '', false, false, NULL, 'ImplA', 'le@YPLqI@TrBN#OwDPK$p7*PWIaRHPq$', '2017-10-11 17:59:41.660758+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (376, '415a17c2-2b34-d915-e9b8-15d52c3704a7', 'RudyJimenez', '[[ENC]]f8c56f72019e3865699e05b7265aeb5e3adee7b5b14b6d637d3c640fde45e1a8', 'Rodolfo', '', '', '2018-02-13 04:31:24.038216+00', NULL, '2018-02-13 04:31:24.038216+00', NULL, 1, '', 'rodolfoj@hotmail.com', '', true, false, NULL, 'ImplA', 'kAzjFa*K9BI$zT8C3Q9qtdyC6h9VYR68', '2018-02-13 04:31:24.046796+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (374, 'c30d18c2-cab0-bc89-1465-c8f7ab5e6ea6', 'kdfNwmAdmin', '[[ENC]]8b5184b348024fb336776dc2a8e86c6e3ddc46433d9013695fe97a2f3fc21c22', 'Kathy', '', 'Admin', '2017-10-03 17:20:11.032066+00', '2018-03-27 00:54:16.05244+00', '2017-10-03 17:20:11.032066+00', NULL, 1, '', 'kathy.d.flint@gmail.com', '', false, false, NULL, 'ImplA', 'hfUjnU!$(sGzl$0jp0#ylJe!FiiHpEgH', '2017-10-03 17:20:11.067548+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (377, 'eef1362a-7071-e41d-5974-8934fadada52', 'K-Rashmi', '[[ENC]]753cd1c212b153c9524514ec5cc438a2f4b4293ab807ad05f117bde0bea5566e', 'Rashmi', '', 'Kulkarni', '2018-03-27 01:28:43.399959+00', NULL, '2018-03-27 01:28:43.399959+00', NULL, 1, '', 'rashmjk@gmail.com', '', true, false, NULL, 'ImplA', '8Wbkf5sDgR89(m03cF6GXuKYXHwCXL!&', '2018-03-27 01:28:43.423088+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (378, '3be6fe88-2eaa-ba97-ca2b-50e8b31456a4', 'Renukabhat', '[[ENC]]63314339bc22d2b9f76269a6647869e961d75f4e0b2ef872cd2dd43c21d3ebee', 'Renuka', '', 'Bhatnagar', '2018-03-27 01:44:54.540356+00', NULL, '2018-03-27 01:44:54.540356+00', NULL, 1, '', 'renu.safernet@gmail.com', '', true, false, NULL, 'ImplA', 'BVxk(s&0KFrMpU)Uy@8mnpl2I0Y%Sbyj', '2018-03-27 01:44:54.545495+00', '', false, false, '', '', false, NULL);
INSERT INTO "user" VALUES (379, '022a634d-a768-a3d5-80ba-d78cbd9119a2', 'hdanursa', '[[ENC]]86e1f6c3f1d6b04c401dbe76bdfb4ee7d10b1e1623004617ae946932984a33cc', 'Hanim', '', 'Danur', '2018-03-27 02:10:00.754652+00', NULL, '2018-03-27 02:10:00.754652+00', NULL, 1, '', 'htd5cf@virginia.edu', '', true, false, NULL, 'ImplA', 'bO899pwi%1Y9vC9D7i!BoB5@nNE8*g&9', '2018-03-27 02:10:00.804194+00', '', false, false, '', '', false, NULL);


--
-- Data for Name: user_group; Type: TABLE DATA; Schema: public; Owner: northbri_devnexus
--

INSERT INTO user_group VALUES (1, 88, '2014-09-13 20:19:15.825895+00', NULL, 1, NULL);
INSERT INTO user_group VALUES (122, 248, '2014-11-21 14:09:15.558243+00', NULL, 1, NULL);
INSERT INTO user_group VALUES (125, 233, '2014-12-17 01:52:45.121247+00', NULL, 1, NULL);
INSERT INTO user_group VALUES (48, 174, '2014-09-21 23:26:27.565222+00', NULL, 1, NULL);
INSERT INTO user_group VALUES (50, 176, '2014-09-22 02:11:58.19277+00', NULL, 1, NULL);
INSERT INTO user_group VALUES (57, 184, '2014-09-23 05:36:28.816368+00', NULL, 1, NULL);
INSERT INTO user_group VALUES (98, 225, '2014-10-26 23:15:25.062895+00', NULL, 1, NULL);
INSERT INTO user_group VALUES (99, 226, '2014-10-30 02:36:27.083872+00', NULL, 1, NULL);
INSERT INTO user_group VALUES (105, 232, '2014-11-06 00:40:50.377192+00', NULL, 1, NULL);
INSERT INTO user_group VALUES (106, 233, '2014-11-06 00:42:58.197125+00', NULL, 2, NULL);
INSERT INTO user_group VALUES (107, 234, '2014-11-07 19:16:02.988712+00', NULL, 1, NULL);
INSERT INTO user_group VALUES (127, 252, '2015-08-10 03:21:26.658946+00', NULL, 1, 5);
INSERT INTO user_group VALUES (128, 253, '2015-08-10 03:34:44.73566+00', NULL, 1, 5);
INSERT INTO user_group VALUES (129, 254, '2015-08-12 23:53:26.971378+00', NULL, 1, 5);
INSERT INTO user_group VALUES (130, 255, '2015-08-12 23:55:04.118595+00', NULL, 1, 5);
INSERT INTO user_group VALUES (131, 256, '2015-08-12 23:55:56.859299+00', NULL, 1, 5);
INSERT INTO user_group VALUES (132, 257, '2015-08-12 23:56:39.990434+00', NULL, 1, 5);
INSERT INTO user_group VALUES (133, 258, '2015-08-13 00:00:00.808117+00', NULL, 1, 4);
INSERT INTO user_group VALUES (134, 259, '2015-08-13 00:10:51.140864+00', NULL, 1, 5);
INSERT INTO user_group VALUES (135, 260, '2015-08-17 00:57:17.801629+00', NULL, 1, 4);
INSERT INTO user_group VALUES (136, 261, '2015-08-31 20:49:51.693017+00', NULL, 1, 4);
INSERT INTO user_group VALUES (137, 262, '2015-09-01 20:20:45.599767+00', NULL, 1, 5);
INSERT INTO user_group VALUES (138, 263, '2015-09-01 23:13:31.483618+00', NULL, 1, 5);
INSERT INTO user_group VALUES (139, 264, '2015-09-01 23:15:16.606205+00', NULL, 1, 5);
INSERT INTO user_group VALUES (140, 265, '2015-09-01 23:32:31.309715+00', NULL, 1, 5);
INSERT INTO user_group VALUES (141, 266, '2015-09-03 00:22:21.962973+00', NULL, 1, 5);
INSERT INTO user_group VALUES (142, 267, '2015-09-09 16:48:43.267606+00', NULL, 1, 4);
INSERT INTO user_group VALUES (145, 270, '2015-09-11 14:55:00.210854+00', NULL, 6, 5);
INSERT INTO user_group VALUES (146, 271, '2015-09-11 15:07:06.319707+00', NULL, 1, 5);
INSERT INTO user_group VALUES (147, 272, '2015-09-11 15:24:43.088281+00', NULL, 6, 5);
INSERT INTO user_group VALUES (148, 273, '2015-09-11 15:57:56.915519+00', NULL, 10, 4);
INSERT INTO user_group VALUES (149, 274, '2015-09-11 16:19:13.554509+00', NULL, 10, 5);
INSERT INTO user_group VALUES (150, 275, '2015-09-11 17:31:33.193207+00', NULL, 10, 5);
INSERT INTO user_group VALUES (151, 276, '2015-09-11 17:36:21.760934+00', NULL, 10, 5);
INSERT INTO user_group VALUES (152, 277, '2015-09-11 17:39:19.046884+00', NULL, 10, 5);
INSERT INTO user_group VALUES (153, 278, '2015-09-11 17:43:35.450337+00', NULL, 10, 5);
INSERT INTO user_group VALUES (154, 279, '2015-09-11 17:45:40.671648+00', NULL, 10, 5);
INSERT INTO user_group VALUES (155, 280, '2015-09-11 17:53:59.227785+00', NULL, 10, 4);
INSERT INTO user_group VALUES (156, 281, '2015-09-11 18:09:45.631682+00', NULL, 10, 5);
INSERT INTO user_group VALUES (157, 282, '2015-09-11 18:14:38.026569+00', NULL, 10, 5);
INSERT INTO user_group VALUES (158, 283, '2015-09-11 18:18:44.156662+00', NULL, 10, 5);
INSERT INTO user_group VALUES (159, 284, '2015-09-11 18:26:17.582138+00', NULL, 10, 5);
INSERT INTO user_group VALUES (160, 285, '2015-09-11 18:33:00.605315+00', NULL, 10, 5);
INSERT INTO user_group VALUES (161, 286, '2015-09-11 18:36:17.867197+00', NULL, 10, 5);
INSERT INTO user_group VALUES (162, 287, '2015-09-11 18:40:41.44027+00', NULL, 10, 5);
INSERT INTO user_group VALUES (163, 288, '2015-09-11 18:45:40.120575+00', NULL, 10, 5);
INSERT INTO user_group VALUES (164, 289, '2015-09-11 19:01:04.048101+00', NULL, 10, 5);
INSERT INTO user_group VALUES (165, 290, '2015-09-11 19:04:11.49221+00', NULL, 10, 5);
INSERT INTO user_group VALUES (166, 291, '2015-09-12 20:06:16.313575+00', NULL, 10, 5);
INSERT INTO user_group VALUES (169, 294, '2015-10-05 18:34:32.029339+00', NULL, 12, 4);
INSERT INTO user_group VALUES (170, 295, '2015-10-05 18:40:05.174848+00', NULL, 12, 4);
INSERT INTO user_group VALUES (171, 296, '2015-10-05 18:42:54.424809+00', NULL, 12, 5);
INSERT INTO user_group VALUES (172, 297, '2015-10-05 18:44:27.953855+00', NULL, 12, 5);
INSERT INTO user_group VALUES (168, 293, '2015-10-05 18:25:49.087139+00', NULL, 12, 5);
INSERT INTO user_group VALUES (173, 298, '2015-10-05 19:35:50.474138+00', NULL, 12, 5);
INSERT INTO user_group VALUES (174, 299, '2015-10-06 20:55:20.153505+00', NULL, 1, 5);
INSERT INTO user_group VALUES (175, 300, '2015-10-25 17:41:18.732333+00', NULL, 1, 5);
INSERT INTO user_group VALUES (176, 301, '2015-10-25 17:42:24.351376+00', NULL, 1, 5);
INSERT INTO user_group VALUES (177, 302, '2015-10-25 17:45:11.192911+00', NULL, 1, 5);
INSERT INTO user_group VALUES (178, 303, '2015-10-26 01:12:36.438963+00', NULL, 1, 5);
INSERT INTO user_group VALUES (179, 304, '2015-10-26 01:15:06.447558+00', NULL, 1, 5);
INSERT INTO user_group VALUES (180, 305, '2015-10-26 01:19:55.703658+00', NULL, 1, 5);
INSERT INTO user_group VALUES (181, 306, '2015-10-26 01:48:22.22818+00', NULL, 1, 5);
INSERT INTO user_group VALUES (182, 307, '2015-11-10 13:08:16.110826+00', NULL, 13, 5);
INSERT INTO user_group VALUES (183, 308, '2015-11-16 00:01:04.530821+00', NULL, 5, 4);
INSERT INTO user_group VALUES (184, 309, '2015-11-19 01:12:28.641143+00', NULL, 1, 4);
INSERT INTO user_group VALUES (185, 310, '2015-12-09 23:37:18.318411+00', NULL, 1, 5);
INSERT INTO user_group VALUES (187, 311, '2015-12-15 23:38:35.620299+00', NULL, 15, 5);
INSERT INTO user_group VALUES (188, 312, '2015-12-16 01:41:20.454428+00', NULL, 16, 5);
INSERT INTO user_group VALUES (189, 313, '2016-01-18 19:22:12.057705+00', NULL, 17, 4);
INSERT INTO user_group VALUES (190, 314, '2016-05-10 18:46:20.556484+00', NULL, 1, 5);
INSERT INTO user_group VALUES (192, 316, '2016-05-10 19:43:13.259331+00', NULL, 18, 4);
INSERT INTO user_group VALUES (191, 315, '2016-05-10 19:42:05.624257+00', NULL, 13, 5);
INSERT INTO user_group VALUES (193, 317, '2016-05-10 20:38:53.082718+00', NULL, 13, 4);
INSERT INTO user_group VALUES (194, 318, '2016-05-10 20:39:46.351031+00', NULL, 19, 4);
INSERT INTO user_group VALUES (195, 319, '2016-05-25 01:40:42.621367+00', NULL, 1, 5);
INSERT INTO user_group VALUES (196, 320, '2016-05-25 01:53:01.408025+00', NULL, 1, 5);
INSERT INTO user_group VALUES (197, 321, '2016-05-25 01:57:14.050148+00', NULL, 1, 5);
INSERT INTO user_group VALUES (199, 323, '2016-12-13 21:14:20.395929+00', NULL, 5, 5);
INSERT INTO user_group VALUES (200, 324, '2017-01-31 01:17:19.111447+00', NULL, 20, 5);
INSERT INTO user_group VALUES (201, 325, '2017-01-31 01:31:40.748795+00', NULL, 20, 5);
INSERT INTO user_group VALUES (202, 326, '2017-01-31 02:28:55.982563+00', NULL, 20, 5);
INSERT INTO user_group VALUES (203, 327, '2017-01-31 02:49:18.999383+00', NULL, 20, 5);
INSERT INTO user_group VALUES (204, 328, '2017-01-31 03:01:20.611973+00', NULL, 20, 5);
INSERT INTO user_group VALUES (206, 330, '2017-01-31 15:10:54.59729+00', NULL, 20, 5);
INSERT INTO user_group VALUES (207, 331, '2017-01-31 15:15:23.773607+00', NULL, 20, 5);
INSERT INTO user_group VALUES (208, 332, '2017-01-31 15:18:33.270237+00', NULL, 20, 5);
INSERT INTO user_group VALUES (209, 333, '2017-01-31 15:20:34.475039+00', NULL, 20, 5);
INSERT INTO user_group VALUES (210, 334, '2017-01-31 15:22:06.02373+00', NULL, 20, 5);
INSERT INTO user_group VALUES (211, 335, '2017-02-01 02:11:39.137857+00', NULL, 20, 5);
INSERT INTO user_group VALUES (212, 336, '2017-02-01 02:13:50.656762+00', NULL, 20, 5);
INSERT INTO user_group VALUES (213, 337, '2017-02-01 02:17:37.525024+00', NULL, 20, 5);
INSERT INTO user_group VALUES (214, 338, '2017-02-12 21:34:48.341736+00', NULL, 21, 5);
INSERT INTO user_group VALUES (215, 347, '2017-02-26 15:32:08.721055+00', NULL, 23, 5);
INSERT INTO user_group VALUES (216, 348, '2017-02-26 20:03:28.139845+00', NULL, 1, 4);
INSERT INTO user_group VALUES (217, 349, '2017-02-26 20:19:19.455263+00', NULL, 1, 4);
INSERT INTO user_group VALUES (218, 352, '2017-03-02 23:44:56.021552+00', NULL, 24, 4);
INSERT INTO user_group VALUES (219, 353, '2017-03-02 23:46:10.114376+00', NULL, 24, 5);
INSERT INTO user_group VALUES (220, 356, '2017-03-06 02:18:02.49602+00', NULL, 1, 5);
INSERT INTO user_group VALUES (221, 357, '2017-03-06 02:20:55.956898+00', NULL, 1, 4);
INSERT INTO user_group VALUES (222, 339, '2017-03-12 21:43:37.762718+00', NULL, 22, 1);
INSERT INTO user_group VALUES (223, 354, '2017-03-12 22:08:18.852829+00', NULL, 22, 5);
INSERT INTO user_group VALUES (225, 351, '2017-03-12 22:08:19.278208+00', NULL, 22, 5);
INSERT INTO user_group VALUES (226, 338, '2017-03-12 22:29:01.504382+00', NULL, 22, 5);
INSERT INTO user_group VALUES (227, 342, '2017-04-10 01:43:24.996484+00', NULL, 22, 5);
INSERT INTO user_group VALUES (228, 342, '2017-04-10 01:43:25.030917+00', NULL, 22, 5);
INSERT INTO user_group VALUES (229, 359, '2017-05-08 00:08:01.864051+00', NULL, 22, 5);
INSERT INTO user_group VALUES (230, 360, '2017-05-08 00:10:19.328147+00', NULL, 22, 5);
INSERT INTO user_group VALUES (231, 361, '2017-07-10 00:57:49.426249+00', NULL, 1, 4);
INSERT INTO user_group VALUES (232, 362, '2017-07-20 01:00:41.583859+00', NULL, 28, 4);
INSERT INTO user_group VALUES (233, 363, '2017-07-20 01:23:44.077062+00', NULL, 29, 4);
INSERT INTO user_group VALUES (234, 364, '2017-07-20 01:32:17.568524+00', NULL, 29, 4);
INSERT INTO user_group VALUES (235, 365, '2017-07-20 01:37:33.509098+00', NULL, 29, 4);
INSERT INTO user_group VALUES (236, 366, '2017-07-20 01:38:50.018367+00', NULL, 29, 4);
INSERT INTO user_group VALUES (237, 367, '2017-07-20 02:32:46.730861+00', NULL, 30, 4);
INSERT INTO user_group VALUES (238, 368, '2017-07-20 02:57:42.287581+00', NULL, 31, 4);
INSERT INTO user_group VALUES (239, 369, '2017-07-24 01:20:27.676829+00', NULL, 1, 4);
INSERT INTO user_group VALUES (240, 370, '2017-08-15 19:50:31.670539+00', NULL, 1, 4);
INSERT INTO user_group VALUES (241, 371, '2017-08-29 02:32:01.315525+00', NULL, 1, 5);
INSERT INTO user_group VALUES (242, 372, '2017-08-29 02:34:01.415113+00', NULL, 1, 5);
INSERT INTO user_group VALUES (243, 373, '2017-09-25 15:52:36.143745+00', NULL, 1, 5);
INSERT INTO user_group VALUES (205, 329, '2017-01-31 14:35:02.048744+00', NULL, 1, 5);
INSERT INTO user_group VALUES (244, 374, '2017-10-03 17:20:11.109309+00', NULL, 1, 4);
INSERT INTO user_group VALUES (245, 375, '2017-10-03 17:20:40.249253+00', NULL, 1, 5);
INSERT INTO user_group VALUES (246, 376, '2018-02-13 04:31:24.066044+00', NULL, 1, 4);
INSERT INTO user_group VALUES (247, 377, '2018-03-27 01:28:43.441667+00', NULL, 1, 4);
INSERT INTO user_group VALUES (248, 378, '2018-03-27 01:44:54.563161+00', NULL, 1, 4);
INSERT INTO user_group VALUES (249, 379, '2018-03-27 02:10:00.867069+00', NULL, 1, 4);
INSERT INTO user_group VALUES (250, 380, '2018-03-27 21:28:38.661981+00', NULL, 1, 4);


--
-- Name: user_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbri_devnexus
--

SELECT pg_catalog.setval('user_group_id_seq', 250, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbri_devnexus
--

SELECT pg_catalog.setval('user_id_seq', 380, true);


--
-- Data for Name: user_organization; Type: TABLE DATA; Schema: public; Owner: northbri_devnexus
--

INSERT INTO user_organization VALUES (89, 88, 330, 85, '2014-08-01 21:09:53.544925+00', NULL, 1);
INSERT INTO user_organization VALUES (155, 176, 330, 85, '2014-09-22 02:11:58.09187+00', NULL, 1);
INSERT INTO user_organization VALUES (86, 85, 330, 85, '2014-08-01 15:43:43.165403+00', NULL, 1);
INSERT INTO user_organization VALUES (162, 184, 330, 85, '2014-09-23 05:36:28.588378+00', NULL, 1);
INSERT INTO user_organization VALUES (203, 225, 330, 85, '2014-10-26 23:15:25.016865+00', NULL, 1);
INSERT INTO user_organization VALUES (204, 226, 330, 85, '2014-10-30 02:36:27.042547+00', NULL, 1);
INSERT INTO user_organization VALUES (153, 174, 330, 85, '2014-09-21 23:26:27.53641+00', NULL, 1);
INSERT INTO user_organization VALUES (210, 232, 330, 88, '2014-11-06 00:40:50.337557+00', NULL, 1);
INSERT INTO user_organization VALUES (212, 234, 330, 85, '2014-11-07 19:16:02.949057+00', NULL, 1);
INSERT INTO user_organization VALUES (226, 248, 330, 88, '2014-11-21 14:09:15.49534+00', NULL, 1);
INSERT INTO user_organization VALUES (230, 252, 330, 234, '2015-08-10 03:21:26.64388+00', NULL, 5);
INSERT INTO user_organization VALUES (231, 253, 330, 234, '2015-08-10 03:34:44.723681+00', NULL, 5);
INSERT INTO user_organization VALUES (232, 254, 330, 232, '2015-08-12 23:53:26.951815+00', NULL, 5);
INSERT INTO user_organization VALUES (233, 255, 330, 232, '2015-08-12 23:55:04.017107+00', NULL, 5);
INSERT INTO user_organization VALUES (234, 256, 330, 232, '2015-08-12 23:55:56.84643+00', NULL, 5);
INSERT INTO user_organization VALUES (235, 257, 330, 232, '2015-08-12 23:56:39.961652+00', NULL, 5);
INSERT INTO user_organization VALUES (236, 258, 330, 232, '2015-08-13 00:00:00.792632+00', NULL, 4);
INSERT INTO user_organization VALUES (237, 259, 330, 232, '2015-08-13 00:10:51.12765+00', NULL, 5);
INSERT INTO user_organization VALUES (238, 260, 330, 232, '2015-08-17 00:57:17.78897+00', NULL, 4);
INSERT INTO user_organization VALUES (239, 261, 330, 234, '2015-08-31 20:49:51.677356+00', NULL, 4);
INSERT INTO user_organization VALUES (240, 262, 330, 260, '2015-09-01 20:20:45.586423+00', NULL, 5);
INSERT INTO user_organization VALUES (241, 263, 330, 232, '2015-09-01 23:13:31.468872+00', NULL, 5);
INSERT INTO user_organization VALUES (242, 264, 330, 232, '2015-09-01 23:15:16.59413+00', NULL, 5);
INSERT INTO user_organization VALUES (243, 265, 330, 232, '2015-09-01 23:32:31.291232+00', NULL, 5);
INSERT INTO user_organization VALUES (244, 266, 330, 234, '2015-09-03 00:22:21.945079+00', NULL, 5);
INSERT INTO user_organization VALUES (245, 267, 330, 234, '2015-09-09 16:48:43.253564+00', NULL, 4);
INSERT INTO user_organization VALUES (246, 268, 331, 234, '2015-09-09 23:32:15.545638+00', NULL, 5);
INSERT INTO user_organization VALUES (247, 269, 331, 234, '2015-09-09 23:41:19.130051+00', NULL, 5);
INSERT INTO user_organization VALUES (248, 270, 331, 234, '2015-09-11 14:55:00.165988+00', NULL, 5);
INSERT INTO user_organization VALUES (249, 271, 330, 234, '2015-09-11 15:07:06.29328+00', NULL, 5);
INSERT INTO user_organization VALUES (250, 272, 331, 234, '2015-09-11 15:24:43.074515+00', NULL, 5);
INSERT INTO user_organization VALUES (251, 273, 332, 85, '2015-09-11 15:57:56.89847+00', NULL, 4);
INSERT INTO user_organization VALUES (252, 274, 332, 273, '2015-09-11 16:19:13.542236+00', NULL, 5);
INSERT INTO user_organization VALUES (253, 275, 332, 273, '2015-09-11 17:31:33.1811+00', NULL, 5);
INSERT INTO user_organization VALUES (254, 276, 332, 273, '2015-09-11 17:36:21.747819+00', NULL, 5);
INSERT INTO user_organization VALUES (255, 277, 332, 273, '2015-09-11 17:39:19.031259+00', NULL, 5);
INSERT INTO user_organization VALUES (256, 278, 332, 273, '2015-09-11 17:43:35.432518+00', NULL, 5);
INSERT INTO user_organization VALUES (257, 279, 332, 273, '2015-09-11 17:45:40.659863+00', NULL, 5);
INSERT INTO user_organization VALUES (258, 280, 332, 273, '2015-09-11 17:53:59.211168+00', NULL, 4);
INSERT INTO user_organization VALUES (259, 281, 332, 273, '2015-09-11 18:09:45.594809+00', NULL, 5);
INSERT INTO user_organization VALUES (260, 282, 332, 273, '2015-09-11 18:14:38.012041+00', NULL, 5);
INSERT INTO user_organization VALUES (261, 283, 332, 273, '2015-09-11 18:18:44.136612+00', NULL, 5);
INSERT INTO user_organization VALUES (262, 284, 332, 273, '2015-09-11 18:26:17.57055+00', NULL, 5);
INSERT INTO user_organization VALUES (263, 285, 332, 273, '2015-09-11 18:33:00.59339+00', NULL, 5);
INSERT INTO user_organization VALUES (264, 286, 332, 273, '2015-09-11 18:36:17.846232+00', NULL, 5);
INSERT INTO user_organization VALUES (265, 287, 332, 273, '2015-09-11 18:40:41.430128+00', NULL, 5);
INSERT INTO user_organization VALUES (266, 288, 332, 273, '2015-09-11 18:45:40.109214+00', NULL, 5);
INSERT INTO user_organization VALUES (267, 289, 332, 273, '2015-09-11 19:01:04.034083+00', NULL, 5);
INSERT INTO user_organization VALUES (268, 290, 332, 273, '2015-09-11 19:04:11.481317+00', NULL, 5);
INSERT INTO user_organization VALUES (269, 291, 332, 273, '2015-09-12 20:06:16.300215+00', NULL, 5);
INSERT INTO user_organization VALUES (271, 293, 333, 88, '2015-10-05 18:25:49.050827+00', NULL, 4);
INSERT INTO user_organization VALUES (272, 294, 333, 88, '2015-10-05 18:34:32.013552+00', NULL, 4);
INSERT INTO user_organization VALUES (273, 295, 333, 88, '2015-10-05 18:40:05.153836+00', NULL, 4);
INSERT INTO user_organization VALUES (274, 296, 333, 88, '2015-10-05 18:42:54.389074+00', NULL, 5);
INSERT INTO user_organization VALUES (275, 297, 333, 88, '2015-10-05 18:44:27.93643+00', NULL, 5);
INSERT INTO user_organization VALUES (276, 298, 333, 88, '2015-10-05 19:35:50.457639+00', NULL, 5);
INSERT INTO user_organization VALUES (277, 299, 330, 234, '2015-10-06 20:55:20.130213+00', NULL, 5);
INSERT INTO user_organization VALUES (278, 300, 330, 232, '2015-10-25 17:41:18.681628+00', NULL, 5);
INSERT INTO user_organization VALUES (279, 301, 330, 232, '2015-10-25 17:42:24.335667+00', NULL, 5);
INSERT INTO user_organization VALUES (280, 302, 330, 232, '2015-10-25 17:45:11.181953+00', NULL, 5);
INSERT INTO user_organization VALUES (281, 303, 330, 260, '2015-10-26 01:12:36.428359+00', NULL, 5);
INSERT INTO user_organization VALUES (282, 304, 330, 260, '2015-10-26 01:15:06.436455+00', NULL, 5);
INSERT INTO user_organization VALUES (283, 305, 330, 260, '2015-10-26 01:19:55.692797+00', NULL, 5);
INSERT INTO user_organization VALUES (284, 306, 330, 260, '2015-10-26 01:48:22.217635+00', NULL, 5);
INSERT INTO user_organization VALUES (285, 307, 330, 88, '2015-11-10 13:09:37.191871+00', NULL, 5);
INSERT INTO user_organization VALUES (286, 308, 1, 88, '2015-11-15 23:54:54.05024+00', NULL, 4);
INSERT INTO user_organization VALUES (287, 309, 330, 232, '2015-11-19 01:12:28.628805+00', NULL, 4);
INSERT INTO user_organization VALUES (288, 310, 330, 234, '2015-12-09 23:37:18.305109+00', NULL, 5);
INSERT INTO user_organization VALUES (290, 311, 333, 88, '2015-12-15 23:39:31.645906+00', NULL, 5);
INSERT INTO user_organization VALUES (291, 312, 76, 88, '2015-12-16 01:42:02.109773+00', NULL, 5);
INSERT INTO user_organization VALUES (292, 313, 1, 88, '2016-01-18 19:22:37.20658+00', NULL, 4);
INSERT INTO user_organization VALUES (293, 314, 330, 234, '2016-05-10 18:46:20.55164+00', NULL, 5);
INSERT INTO user_organization VALUES (295, 316, 336, 88, '2016-05-10 19:43:13.230762+00', NULL, 4);
INSERT INTO user_organization VALUES (294, 315, 336, 88, '2016-05-10 19:42:05.628374+00', NULL, 5);
INSERT INTO user_organization VALUES (296, 317, 337, 88, '2016-05-10 20:38:53.088006+00', NULL, 4);
INSERT INTO user_organization VALUES (297, 318, 337, 88, '2016-05-10 20:39:46.345402+00', NULL, 4);
INSERT INTO user_organization VALUES (298, 319, 330, 234, '2016-05-25 01:40:42.614959+00', NULL, 5);
INSERT INTO user_organization VALUES (299, 320, 330, 234, '2016-05-25 01:53:01.401661+00', NULL, 5);
INSERT INTO user_organization VALUES (300, 321, 330, 234, '2016-05-25 01:57:14.044979+00', NULL, 5);
INSERT INTO user_organization VALUES (302, 323, 1, 88, '2016-12-13 21:14:20.390638+00', NULL, 4);
INSERT INTO user_organization VALUES (303, 324, 1, 88, '2017-01-31 01:17:19.105957+00', NULL, 5);
INSERT INTO user_organization VALUES (304, 325, 1, 88, '2017-01-31 01:31:40.744304+00', NULL, 5);
INSERT INTO user_organization VALUES (305, 326, 1, 88, '2017-01-31 02:28:55.976544+00', NULL, 5);
INSERT INTO user_organization VALUES (306, 327, 1, 88, '2017-01-31 02:49:18.991737+00', NULL, 5);
INSERT INTO user_organization VALUES (307, 328, 1, 88, '2017-01-31 03:01:20.607108+00', NULL, 5);
INSERT INTO user_organization VALUES (309, 330, 1, 88, '2017-01-31 15:10:54.58994+00', NULL, 5);
INSERT INTO user_organization VALUES (310, 331, 1, 88, '2017-01-31 15:15:23.76247+00', NULL, 5);
INSERT INTO user_organization VALUES (311, 332, 1, 88, '2017-01-31 15:18:33.262902+00', NULL, 5);
INSERT INTO user_organization VALUES (312, 333, 1, 88, '2017-01-31 15:20:34.469603+00', NULL, 5);
INSERT INTO user_organization VALUES (313, 334, 1, 88, '2017-01-31 15:22:06.015648+00', NULL, 5);
INSERT INTO user_organization VALUES (314, 335, 1, 88, '2017-02-01 02:11:39.130492+00', NULL, 5);
INSERT INTO user_organization VALUES (315, 336, 1, 88, '2017-02-01 02:13:50.651855+00', NULL, 5);
INSERT INTO user_organization VALUES (316, 337, 1, 88, '2017-02-01 02:17:37.519882+00', NULL, 5);
INSERT INTO user_organization VALUES (317, 338, 339, 88, '2017-02-12 21:34:48.346186+00', NULL, 5);
INSERT INTO user_organization VALUES (318, 339, 339, 88, '2017-02-12 21:55:15.203214+00', NULL, 1);
INSERT INTO user_organization VALUES (319, 340, 339, 88, '2017-02-12 22:10:27.28621+00', NULL, 5);
INSERT INTO user_organization VALUES (320, 341, 339, 88, '2017-02-12 23:23:28.029914+00', NULL, 5);
INSERT INTO user_organization VALUES (321, 342, 339, 88, '2017-02-13 02:07:13.231597+00', NULL, 5);
INSERT INTO user_organization VALUES (322, 343, 339, 88, '2017-02-13 02:08:39.805418+00', NULL, 5);
INSERT INTO user_organization VALUES (323, 344, 339, 88, '2017-02-13 02:09:00.351548+00', NULL, 5);
INSERT INTO user_organization VALUES (324, 345, 339, 88, '2017-02-13 02:11:38.389633+00', NULL, 5);
INSERT INTO user_organization VALUES (325, 346, 339, 88, '2017-02-13 02:57:41.792059+00', NULL, 5);
INSERT INTO user_organization VALUES (326, 347, 339, 88, '2017-02-26 15:33:40.920166+00', NULL, 5);
INSERT INTO user_organization VALUES (327, 348, 330, 234, '2017-02-26 20:03:28.133494+00', NULL, 4);
INSERT INTO user_organization VALUES (328, 349, 330, 234, '2017-02-26 20:19:19.430551+00', NULL, 4);
INSERT INTO user_organization VALUES (329, 350, 339, 88, '2017-02-27 02:04:18.946139+00', NULL, 5);
INSERT INTO user_organization VALUES (330, 351, 339, 88, '2017-02-27 02:06:09.366173+00', NULL, 5);
INSERT INTO user_organization VALUES (331, 352, 340, 88, '2017-03-02 23:44:56.014361+00', NULL, 4);
INSERT INTO user_organization VALUES (332, 353, 340, 352, '2017-03-02 23:46:10.109301+00', NULL, 5);
INSERT INTO user_organization VALUES (333, 354, 339, 88, '2017-03-03 19:00:29.328836+00', NULL, 5);
INSERT INTO user_organization VALUES (334, 355, 339, 88, '2017-03-03 19:07:47.935819+00', NULL, 5);
INSERT INTO user_organization VALUES (335, 356, 330, 234, '2017-03-06 02:18:02.473482+00', NULL, 5);
INSERT INTO user_organization VALUES (336, 357, 330, 234, '2017-03-06 02:20:55.948084+00', NULL, 4);
INSERT INTO user_organization VALUES (337, 358, 339, 88, '2017-03-12 22:39:25.631298+00', NULL, 5);
INSERT INTO user_organization VALUES (338, 358, 341, 88, '2017-03-12 22:40:46.975432+00', NULL, 5);
INSERT INTO user_organization VALUES (339, 350, 342, 88, '2017-03-20 01:16:45.094595+00', NULL, 5);
INSERT INTO user_organization VALUES (347, 351, 348, 88, '2017-03-20 01:30:23.699221+00', NULL, 5);
INSERT INTO user_organization VALUES (354, 341, 354, 88, '2017-03-29 23:24:31.500109+00', NULL, 5);
INSERT INTO user_organization VALUES (355, 308, 355, 88, '2017-03-29 23:26:16.300369+00', NULL, 5);
INSERT INTO user_organization VALUES (356, 339, 356, 88, '2017-03-29 23:44:45.663007+00', NULL, 5);
INSERT INTO user_organization VALUES (360, 345, 350, 88, '2017-04-10 01:32:24.592141+00', NULL, 5);
INSERT INTO user_organization VALUES (361, 339, 353, 88, '2017-04-10 01:32:28.440521+00', NULL, 5);
INSERT INTO user_organization VALUES (362, 345, 357, 88, '2017-04-10 01:33:47.14697+00', NULL, 5);
INSERT INTO user_organization VALUES (364, 342, 359, 88, '2017-04-10 01:35:41.4743+00', NULL, 5);
INSERT INTO user_organization VALUES (367, 340, 362, 88, '2017-04-18 18:53:10.738834+00', NULL, 5);
INSERT INTO user_organization VALUES (370, 340, 365, 88, '2017-04-18 19:02:43.847143+00', NULL, 5);
INSERT INTO user_organization VALUES (371, 339, 366, 88, '2017-04-18 19:56:14.333297+00', NULL, 5);
INSERT INTO user_organization VALUES (308, 329, 330, 234, '2017-01-31 14:35:02.031971+00', NULL, 4);
INSERT INTO user_organization VALUES (373, 359, 339, 88, '2017-05-08 00:08:01.855492+00', NULL, 5);
INSERT INTO user_organization VALUES (374, 360, 339, 88, '2017-05-08 00:10:19.316276+00', NULL, 5);
INSERT INTO user_organization VALUES (375, 340, 349, 88, '2017-05-22 02:06:18.20324+00', NULL, 5);
INSERT INTO user_organization VALUES (376, 340, 370, 88, '2017-05-22 02:07:06.634993+00', NULL, 5);
INSERT INTO user_organization VALUES (377, 339, 360, 88, '2017-06-13 17:20:16.307714+00', NULL, 5);
INSERT INTO user_organization VALUES (378, 361, 330, 234, '2017-07-10 00:57:49.398314+00', NULL, 4);
INSERT INTO user_organization VALUES (379, 362, 375, 88, '2017-07-20 01:00:41.524646+00', NULL, 4);
INSERT INTO user_organization VALUES (380, 363, 376, 88, '2017-07-20 01:23:44.068324+00', NULL, 4);
INSERT INTO user_organization VALUES (381, 364, 376, 88, '2017-07-20 01:32:17.558015+00', NULL, 4);
INSERT INTO user_organization VALUES (382, 365, 376, 88, '2017-07-20 01:37:33.499252+00', NULL, 4);
INSERT INTO user_organization VALUES (383, 366, 376, 88, '2017-07-20 01:38:49.988975+00', NULL, 4);
INSERT INTO user_organization VALUES (384, 367, 377, 88, '2017-07-20 02:32:46.720601+00', NULL, 4);
INSERT INTO user_organization VALUES (385, 368, 378, 88, '2017-07-20 02:57:42.279961+00', NULL, 4);
INSERT INTO user_organization VALUES (386, 369, 330, 234, '2017-07-24 01:20:27.666549+00', NULL, 4);
INSERT INTO user_organization VALUES (387, 370, 330, 361, '2017-08-15 19:50:31.663315+00', NULL, 4);
INSERT INTO user_organization VALUES (388, 371, 330, 370, '2017-08-29 02:32:01.306716+00', NULL, 5);
INSERT INTO user_organization VALUES (389, 372, 330, 370, '2017-08-29 02:34:01.40113+00', NULL, 5);
INSERT INTO user_organization VALUES (390, 373, 330, 361, '2017-09-25 15:52:36.128199+00', NULL, 5);
INSERT INTO user_organization VALUES (391, 374, 330, 329, '2017-10-03 17:20:11.082327+00', NULL, 4);
INSERT INTO user_organization VALUES (392, 375, 330, 329, '2017-10-03 17:20:40.241813+00', NULL, 5);
INSERT INTO user_organization VALUES (393, 376, 330, 374, '2018-02-13 04:31:24.055559+00', NULL, 4);
INSERT INTO user_organization VALUES (394, 377, 330, 374, '2018-03-27 01:28:43.431447+00', NULL, 4);
INSERT INTO user_organization VALUES (395, 378, 330, 374, '2018-03-27 01:44:54.553788+00', NULL, 4);
INSERT INTO user_organization VALUES (396, 379, 330, 374, '2018-03-27 02:10:00.812071+00', NULL, 4);
INSERT INTO user_organization VALUES (397, 380, 330, 374, '2018-03-27 21:28:38.654118+00', NULL, 4);


--
-- Name: user_organization_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbri_devnexus
--

SELECT pg_catalog.setval('user_organization_id_seq', 397, true);


--
-- Data for Name: user_password; Type: TABLE DATA; Schema: public; Owner: northbri_devnexus
--

INSERT INTO user_password VALUES (36, 88, 'RESET', '2014-11-15 23:45:33.058772+00', NULL, 'cf489230-b558-239e-9131-dce6c2c97cab');
INSERT INTO user_password VALUES (8, 85, 'RESET', '2014-10-21 01:43:41.445595+00', '2014-10-21 01:43:52.517372+00', 'c432e47b-ad93-0330-6e2d-5d81a4dd6ca4');
INSERT INTO user_password VALUES (43, 233, 'RESET', '2015-01-03 23:22:23.584058+00', '2015-01-03 23:23:25.123453+00', '70fa12c2-f8ee-554f-ca20-d7dd24bb27bd');
INSERT INTO user_password VALUES (48, 226, 'RESET', '2015-03-18 02:09:37.661101+00', '2015-03-24 16:36:05.003231+00', 'c8bcf3c2-a6f8-3c0e-04ba-925e4d9a35ff');
INSERT INTO user_password VALUES (49, 226, 'RESET', '2015-03-24 16:36:05.221276+00', '2015-03-24 16:47:47.045302+00', '4b1f0280-88cd-eed7-1136-47a116130ffe');
INSERT INTO user_password VALUES (71, 293, 'RESET', '2015-10-05 19:10:28.62333+00', '2015-10-05 19:10:52.143955+00', '0efa7f40-8d05-af5c-f8f7-4f85c1ac6ada');
INSERT INTO user_password VALUES (10, 176, 'RESET', '2014-10-22 02:17:39.416557+00', '2015-10-15 02:15:29.883546+00', '6cd2014f-f14e-0a0f-bb2b-19bf571857f3');
INSERT INTO user_password VALUES (72, 176, 'RESET', '2015-10-15 02:15:29.894649+00', '2015-10-15 02:15:46.231016+00', '01e27daa-1615-4b04-e921-c044502621f7');
INSERT INTO user_password VALUES (41, 232, 'RESET', '2014-12-18 21:59:48.786851+00', '2015-07-31 23:27:01.086445+00', 'f7c3e813-b27d-a5d0-696a-ff5c23c4d2b8');
INSERT INTO user_password VALUES (64, 232, 'RESET', '2015-07-31 23:27:01.097196+00', '2015-07-31 23:27:11.70383+00', 'aae62a2d-1a36-45d7-0baa-362d2a2dadff');
INSERT INTO user_password VALUES (65, 174, 'RESET', '2015-08-05 00:15:45.347396+00', '2015-10-26 15:04:16.701657+00', '048a73b8-eb4e-a19e-bbf3-32f7d14f7cf9');
INSERT INTO user_password VALUES (50, 174, 'RESET', '2015-03-26 01:55:04.496383+00', '2015-10-26 15:04:16.701657+00', '87dc3374-0265-ca46-c2d6-062376958cc4');
INSERT INTO user_password VALUES (9, 174, 'RESET', '2014-10-22 01:42:11.952254+00', '2015-10-26 15:04:16.701657+00', '425e348f-e240-b949-e4d4-1d4c651b8c57');
INSERT INTO user_password VALUES (28, 174, 'RESET', '2014-10-29 01:57:00.751987+00', '2015-10-26 15:04:16.701657+00', 'c44afcb2-14b1-2721-d4ae-450c57ba3669');
INSERT INTO user_password VALUES (29, 174, 'RESET', '2014-10-29 01:57:09.2567+00', '2015-10-26 15:04:16.701657+00', 'e5759f73-07ff-5f45-c368-45c5d2d5eb9d');
INSERT INTO user_password VALUES (30, 174, 'RESET', '2014-10-29 01:57:16.521371+00', '2015-10-26 15:04:16.701657+00', '0eee568f-fbf8-5395-977e-637b376cea55');
INSERT INTO user_password VALUES (31, 174, 'RESET', '2014-10-29 02:07:54.857135+00', '2015-10-26 15:04:16.701657+00', 'e5ecd1bb-1f04-c370-ef8d-c3e831928a44');
INSERT INTO user_password VALUES (32, 174, 'RESET', '2014-10-29 02:07:57.247113+00', '2015-10-26 15:04:16.701657+00', '9bd6a52b-0407-bc7f-2223-bc04e76d18e2');
INSERT INTO user_password VALUES (38, 174, 'RESET', '2014-12-10 23:17:33.552457+00', '2015-10-26 15:04:16.701657+00', '22053ed6-0ab2-bcfc-f9f1-97db9b382f7f');
INSERT INTO user_password VALUES (39, 174, 'RESET', '2014-12-10 23:17:35.9149+00', '2015-10-26 15:04:16.701657+00', 'c1b4524a-0086-2982-65f4-aec7b13ddbfc');
INSERT INTO user_password VALUES (40, 174, 'RESET', '2014-12-15 03:00:19.644542+00', '2015-10-26 15:04:16.701657+00', '4b77aa5b-04ad-17cc-04a8-529252612484');
INSERT INTO user_password VALUES (46, 174, 'RESET', '2015-02-03 03:02:50.459449+00', '2015-10-26 15:04:16.701657+00', '9b992044-2bf1-e4aa-a83d-68ae3ba8f365');
INSERT INTO user_password VALUES (47, 174, 'RESET', '2015-02-03 03:02:52.809845+00', '2015-10-26 15:04:16.701657+00', '7061b067-401a-ea01-5c69-618da0397be7');
INSERT INTO user_password VALUES (51, 174, 'RESET', '2015-04-12 17:39:33.760435+00', '2015-10-26 15:04:16.701657+00', 'ddf7b915-3e76-80a9-b622-7d8d24424f18');
INSERT INTO user_password VALUES (52, 174, 'RESET', '2015-04-12 17:39:36.098297+00', '2015-10-26 15:04:16.701657+00', '24697697-f80c-1875-1941-73a9bee2684c');
INSERT INTO user_password VALUES (63, 174, 'RESET', '2015-07-30 20:24:28.963922+00', '2015-10-26 15:04:16.701657+00', 'ef1af73f-730b-184f-08f0-4f68d7f0ee3e');
INSERT INTO user_password VALUES (73, 174, 'RESET', '2015-10-15 02:19:00.758613+00', '2015-10-26 15:04:16.701657+00', 'dda4957b-4d6a-25c5-2862-b91e13e97f5d');
INSERT INTO user_password VALUES (74, 174, 'RESET', '2015-10-15 02:19:03.036364+00', '2015-10-26 15:04:16.701657+00', '5f74920a-3f4c-7970-78ae-ed4633903451');
INSERT INTO user_password VALUES (75, 174, 'RESET', '2015-10-15 02:19:47.30283+00', '2015-10-26 15:04:16.701657+00', 'fe0c3085-4845-7046-e76c-dcfad105fbf4');
INSERT INTO user_password VALUES (76, 174, 'RESET', '2015-10-26 15:04:16.7159+00', '2015-10-26 15:04:53.284235+00', 'd8f9f281-5408-9d95-8cc4-b7819a961f0d');
INSERT INTO user_password VALUES (80, 260, 'RESET', '2016-04-17 23:47:58.834216+00', '2016-11-10 20:02:28.025241+00', '6c60023e-8988-2cba-9f61-f95d1dc587f7');
INSERT INTO user_password VALUES (81, 260, 'RESET', '2016-09-26 00:24:08.624972+00', '2016-11-10 20:02:28.025241+00', 'a5f6a65e-30c2-5ee4-35df-e40d698453b2');
INSERT INTO user_password VALUES (82, 260, 'RESET', '2016-11-10 20:02:28.046633+00', '2016-11-10 20:04:14.53931+00', '3c48bfd2-3fb9-28c6-db6c-39be53546574');
INSERT INTO user_password VALUES (83, 318, 'RESET', '2017-01-20 20:07:15.760664+00', '2017-01-20 20:08:17.99473+00', '21c43ae8-45d1-1714-98fa-2bdc4f1ef776');
INSERT INTO user_password VALUES (84, 323, 'RESET', '2017-01-20 21:22:53.872346+00', '2017-01-30 17:58:51.734971+00', '12bd9704-43dc-f170-9fee-e77cac10953e');
INSERT INTO user_password VALUES (85, 323, 'RESET', '2017-01-20 21:45:57.258253+00', '2017-01-30 17:58:51.734971+00', '68104c2d-8604-59fc-aff4-03f865ace3e5');
INSERT INTO user_password VALUES (86, 323, 'RESET', '2017-01-20 21:47:40.570884+00', '2017-01-30 17:58:51.734971+00', '684cd37f-df1a-c7db-7b97-4571358dc140');
INSERT INTO user_password VALUES (87, 323, 'RESET', '2017-01-30 17:58:51.761572+00', '2017-01-30 17:59:09.701111+00', '28cd42c1-56fa-10da-1e33-f80d75bb5fdf');
INSERT INTO user_password VALUES (69, 234, 'RESET', '2015-09-14 17:36:46.153966+00', '2017-01-30 18:03:25.577967+00', '464a8169-696b-4b5b-9057-6f43ae0adc91');
INSERT INTO user_password VALUES (42, 234, 'RESET', '2015-01-03 01:52:35.978674+00', '2017-01-30 18:03:25.577967+00', '60e2df73-61cb-59fc-951d-fcf0a96125f6');
INSERT INTO user_password VALUES (44, 234, 'RESET', '2015-01-09 18:08:50.875144+00', '2017-01-30 18:03:25.577967+00', '04a133a9-6e42-b11c-7ab0-e5ea7d2b7663');
INSERT INTO user_password VALUES (45, 234, 'RESET', '2015-01-09 18:14:30.879352+00', '2017-01-30 18:03:25.577967+00', '1f1fbe4c-dc03-3751-96e3-11752956e541');
INSERT INTO user_password VALUES (53, 234, 'RESET', '2015-06-09 20:44:33.077286+00', '2017-01-30 18:03:25.577967+00', 'c0a988c9-0711-0171-8c86-69159d4ba15a');
INSERT INTO user_password VALUES (54, 234, 'RESET', '2015-06-09 20:57:44.107673+00', '2017-01-30 18:03:25.577967+00', '07439c2e-dab8-834a-44cc-30fe67f9d782');
INSERT INTO user_password VALUES (55, 234, 'RESET', '2015-06-09 20:58:31.515604+00', '2017-01-30 18:03:25.577967+00', '9c8ba8d7-dc9e-ce37-e427-d801d2b8ed37');
INSERT INTO user_password VALUES (56, 234, 'RESET', '2015-07-26 21:55:07.537028+00', '2017-01-30 18:03:25.577967+00', '7abdd490-f123-1490-cc41-d60b837c6b62');
INSERT INTO user_password VALUES (57, 234, 'RESET', '2015-07-28 00:57:03.314306+00', '2017-01-30 18:03:25.577967+00', 'c669509e-9308-6329-c04b-297387e8ba5c');
INSERT INTO user_password VALUES (58, 234, 'RESET', '2015-07-28 00:59:21.505803+00', '2017-01-30 18:03:25.577967+00', 'e805d44a-d62e-cd7c-fbaa-cc4c8dbaaaf3');
INSERT INTO user_password VALUES (59, 234, 'RESET', '2015-07-28 01:02:08.539614+00', '2017-01-30 18:03:25.577967+00', '62d2ec2f-fc23-be4a-3220-03c465bb3a43');
INSERT INTO user_password VALUES (60, 234, 'RESET', '2015-07-28 18:28:57.733504+00', '2017-01-30 18:03:25.577967+00', '1c17bebb-bdef-f674-dfb6-e20cb3710e54');
INSERT INTO user_password VALUES (61, 234, 'RESET', '2015-07-28 18:29:11.303083+00', '2017-01-30 18:03:25.577967+00', 'd6691805-965b-027a-6697-2b25371ff913');
INSERT INTO user_password VALUES (62, 234, 'RESET', '2015-07-28 18:29:21.453747+00', '2017-01-30 18:03:25.577967+00', '912bcf60-9d3a-b350-77ad-ac8ff7e84c3c');
INSERT INTO user_password VALUES (66, 234, 'RESET', '2015-09-14 17:00:00.514092+00', '2017-01-30 18:03:25.577967+00', 'afb897e8-9add-a4e0-3db6-07692e707228');
INSERT INTO user_password VALUES (67, 234, 'RESET', '2015-09-14 17:16:02.618578+00', '2017-01-30 18:03:25.577967+00', '43b6466d-69a9-c6a6-e6db-34425e8ecda2');
INSERT INTO user_password VALUES (68, 234, 'RESET', '2015-09-14 17:18:59.568738+00', '2017-01-30 18:03:25.577967+00', '01d97527-441c-d493-ff26-87c766e0f64a');
INSERT INTO user_password VALUES (70, 234, 'RESET', '2015-09-14 17:54:07.417023+00', '2017-01-30 18:03:25.577967+00', 'a3b92d7f-94d9-1df0-3224-3f891d1480a0');
INSERT INTO user_password VALUES (77, 234, 'RESET', '2015-12-09 23:19:20.366184+00', '2017-01-30 18:03:25.577967+00', 'cac7f046-ecc5-934f-cafe-03c2cd5cc8e3');
INSERT INTO user_password VALUES (78, 234, 'RESET', '2015-12-09 23:39:09.783088+00', '2017-01-30 18:03:25.577967+00', '7107ed1d-f18b-ef9b-29c3-82d7ab92357f');
INSERT INTO user_password VALUES (79, 234, 'RESET', '2016-04-04 19:21:44.708561+00', '2017-01-30 18:03:25.577967+00', '32bec53c-d585-32f1-cfe6-5b41f3737367');
INSERT INTO user_password VALUES (88, 234, 'RESET', '2017-01-30 18:03:25.602823+00', '2017-01-30 18:03:50.855089+00', 'a5c26369-4c89-9539-c4fd-419d69aa2470');
INSERT INTO user_password VALUES (89, 349, 'RESET', '2017-02-26 20:25:09.799163+00', '2017-02-26 20:25:19.221629+00', 'e3ddcdb5-add4-2d62-e090-2a4218747baa');
INSERT INTO user_password VALUES (90, 345, 'RESET', '2017-02-27 02:18:15.357802+00', '2017-02-27 02:18:29.843085+00', '07b87f84-9c6d-3a14-ce5e-bcc9b0c47e58');
INSERT INTO user_password VALUES (91, 337, 'RESET', '2017-03-06 02:17:31.401175+00', '2017-03-06 02:17:48.264913+00', '102d5678-8d87-608a-02b2-f91321197a58');
INSERT INTO user_password VALUES (92, 335, 'RESET', '2017-07-10 01:12:54.650812+00', '2017-07-10 01:13:53.850938+00', '61b477dd-2c17-cf94-00b0-15ab61e032b8');
INSERT INTO user_password VALUES (94, 343, 'RESET', '2017-07-10 01:21:29.260113+00', '2017-07-10 01:21:43.485336+00', '4f167659-4c29-da3c-7237-2b31a4f83259');
INSERT INTO user_password VALUES (95, 356, 'RESET', '2017-07-10 01:22:43.566478+00', '2017-07-10 01:23:01.026803+00', '0930d245-850b-7895-5aee-7aff7dbe8582');
INSERT INTO user_password VALUES (96, 361, 'RESET', '2017-07-18 16:24:25.785111+00', '2017-07-18 16:24:51.476229+00', '04e5fb31-b4c5-259f-24ca-6fbf1ca049b1');
INSERT INTO user_password VALUES (97, 344, 'RESET', '2017-07-24 15:56:51.939806+00', '2017-07-24 15:57:42.759013+00', '25ba8435-0822-7518-df9d-0e5892c06fda');
INSERT INTO user_password VALUES (98, 340, 'RESET', '2017-07-24 16:00:28.222821+00', NULL, '268db702-a6af-6d71-d47a-cb468c9769f7');
INSERT INTO user_password VALUES (99, 359, 'RESET', '2017-07-24 16:08:49.806664+00', NULL, 'cf48048e-80dc-1ff5-2409-14d3ef8682b1');
INSERT INTO user_password VALUES (100, 354, 'RESET', '2017-07-24 16:11:21.428505+00', '2017-07-24 16:13:26.960035+00', 'cb290afe-d872-f542-6b0f-fbc7eb4a83df');
INSERT INTO user_password VALUES (93, 350, 'RESET', '2017-07-10 01:20:36.413506+00', '2017-09-11 00:08:56.595028+00', 'c19d41a8-0268-c461-cc73-ac0da086ff22');
INSERT INTO user_password VALUES (101, 350, 'RESET', '2017-09-11 00:08:56.599459+00', '2017-09-11 00:09:06.749765+00', '74c46836-a771-f6b2-5c7e-0d82cd9077fb');


--
-- Name: user_password_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbri_devnexus
--

SELECT pg_catalog.setval('user_password_id_seq', 101, true);


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: northbri_devnexus
--


--
-- Name: user_session_id_seq; Type: SEQUENCE SET; Schema: public; Owner: northbri_devnexus
--

SELECT pg_catalog.setval('user_session_id_seq', 2817, true);


--
-- Name: affiliation_pkey; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY affiliation
    ADD CONSTRAINT affiliation_pkey PRIMARY KEY (id);


--
-- Name: category_pkey; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


--
-- Name: category_topic_pkey; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY category_topic
    ADD CONSTRAINT category_topic_pkey PRIMARY KEY (id);


--
-- Name: contact_pkey; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY contact
    ADD CONSTRAINT contact_pkey PRIMARY KEY (id);


--
-- Name: ethnicity_pkey; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY ethnicity
    ADD CONSTRAINT ethnicity_pkey PRIMARY KEY (id);


--
-- Name: event_group_pkey; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY event_group
    ADD CONSTRAINT event_group_pkey PRIMARY KEY (id);


--
-- Name: event_pkey; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY event
    ADD CONSTRAINT event_pkey PRIMARY KEY (id);


--
-- Name: event_recur_pkey; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY event_recur
    ADD CONSTRAINT event_recur_pkey PRIMARY KEY (id);


--
-- Name: forum_user_pkey; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY forum_user
    ADD CONSTRAINT forum_user_pkey PRIMARY KEY (id);


--
-- Name: group_new_pkey; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY "group"
    ADD CONSTRAINT group_new_pkey PRIMARY KEY (id);


--
-- Name: invitation_pkey; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY invitation
    ADD CONSTRAINT invitation_pkey PRIMARY KEY (id);


--
-- Name: invitation_uuid_key; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY invitation
    ADD CONSTRAINT invitation_uuid_key UNIQUE (uuid);


--
-- Name: language_pkey; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY language
    ADD CONSTRAINT language_pkey PRIMARY KEY (id);


--
-- Name: location_pkey; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY location
    ADD CONSTRAINT location_pkey PRIMARY KEY (id);


--
-- Name: message_pkey; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY message
    ADD CONSTRAINT message_pkey PRIMARY KEY (id);


--
-- Name: message_recipient_pkey; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY message_recipient
    ADD CONSTRAINT message_recipient_pkey PRIMARY KEY (message_fk, recipient_fk);


--
-- Name: organization_account_pkey; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY organization_account
    ADD CONSTRAINT organization_account_pkey PRIMARY KEY (id);


--
-- Name: organization_affiliation_pkey; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY organization_affiliation
    ADD CONSTRAINT organization_affiliation_pkey PRIMARY KEY (id);


--
-- Name: organization_contact_pkey; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY organization_contact
    ADD CONSTRAINT organization_contact_pkey PRIMARY KEY (id);


--
-- Name: organization_ethnicity_pkey; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY organization_ethnicity
    ADD CONSTRAINT organization_ethnicity_pkey PRIMARY KEY (id);


--
-- Name: organization_language_pkey; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY organization_language
    ADD CONSTRAINT organization_language_pkey PRIMARY KEY (id);


--
-- Name: organization_location_pkey; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY organization_location
    ADD CONSTRAINT organization_location_pkey PRIMARY KEY (id);


--
-- Name: organization_organization_pkey; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY organization_organization
    ADD CONSTRAINT organization_organization_pkey PRIMARY KEY (id);


--
-- Name: organization_pkey; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY organization
    ADD CONSTRAINT organization_pkey PRIMARY KEY (id);


--
-- Name: organization_program_pkey; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY organization_program
    ADD CONSTRAINT organization_program_pkey PRIMARY KEY (id);


--
-- Name: organization_topic_pkey; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY organization_topic
    ADD CONSTRAINT organization_topic_pkey PRIMARY KEY (id);


--
-- Name: organization_uid_key; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY organization
    ADD CONSTRAINT organization_uid_key UNIQUE (uid);


--
-- Name: privilege_pkey; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY privilege
    ADD CONSTRAINT privilege_pkey PRIMARY KEY (id);


--
-- Name: program_contact_pkey; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY program_contact
    ADD CONSTRAINT program_contact_pkey PRIMARY KEY (id);


--
-- Name: program_language_pkey; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY program_language
    ADD CONSTRAINT program_language_pkey PRIMARY KEY (id);


--
-- Name: program_location_pkey; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY program_location
    ADD CONSTRAINT program_location_pkey PRIMARY KEY (id);


--
-- Name: program_pkey; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY program
    ADD CONSTRAINT program_pkey PRIMARY KEY (id);


--
-- Name: role_name_key; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY role
    ADD CONSTRAINT role_name_key UNIQUE (name);


--
-- Name: role_pkey; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- Name: role_privilege_pkey; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY role_privilege
    ADD CONSTRAINT role_privilege_pkey PRIMARY KEY (role_id_fk, privilege_id_fk);


--
-- Name: spatial_ref_sys_pkey; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY spatial_ref_sys
    ADD CONSTRAINT spatial_ref_sys_pkey PRIMARY KEY (srid);


--
-- Name: status_name_key; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY status
    ADD CONSTRAINT status_name_key UNIQUE (name);


--
-- Name: status_pkey; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY status
    ADD CONSTRAINT status_pkey PRIMARY KEY (id);


--
-- Name: topic_pkey; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY topic
    ADD CONSTRAINT topic_pkey PRIMARY KEY (id);


--
-- Name: user_group_pkey; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY user_group
    ADD CONSTRAINT user_group_pkey PRIMARY KEY (id);


--
-- Name: user_organization_pkey; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY user_organization
    ADD CONSTRAINT user_organization_pkey PRIMARY KEY (id);


--
-- Name: user_organization_user_fk_key; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY user_organization
    ADD CONSTRAINT user_organization_user_fk_key UNIQUE (user_fk, organization_fk);


--
-- Name: user_password_pkey; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY user_password
    ADD CONSTRAINT user_password_pkey PRIMARY KEY (id);


--
-- Name: user_pkey; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: user_session_pkey; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY user_session
    ADD CONSTRAINT user_session_pkey PRIMARY KEY (id);


--
-- Name: user_username_key; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_username_key UNIQUE (username);


--
-- Name: user_uuid_key; Type: CONSTRAINT; Schema: public; Owner: northbri_devnexus; Tablespace: 
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_uuid_key UNIQUE (uuid);


--
-- Name: geometry_columns_delete; Type: RULE; Schema: public; Owner: northbri_devnexus
--

CREATE RULE geometry_columns_delete AS
    ON DELETE TO geometry_columns DO INSTEAD NOTHING;


--
-- Name: geometry_columns_insert; Type: RULE; Schema: public; Owner: northbri_devnexus
--

CREATE RULE geometry_columns_insert AS
    ON INSERT TO geometry_columns DO INSTEAD NOTHING;


--
-- Name: geometry_columns_update; Type: RULE; Schema: public; Owner: northbri_devnexus
--

CREATE RULE geometry_columns_update AS
    ON UPDATE TO geometry_columns DO INSTEAD NOTHING;


--
-- Name: category_topic_category_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY category_topic
    ADD CONSTRAINT category_topic_category_fk_fkey FOREIGN KEY (category_fk) REFERENCES category(id);


--
-- Name: category_topic_topic_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY category_topic
    ADD CONSTRAINT category_topic_topic_fk_fkey FOREIGN KEY (topic_fk) REFERENCES topic(id);


--
-- Name: event_admin_user_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY event
    ADD CONSTRAINT event_admin_user_fk_fkey FOREIGN KEY (admin_user_fk) REFERENCES "user"(id);


--
-- Name: event_group_event_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY event_group
    ADD CONSTRAINT event_group_event_fk_fkey FOREIGN KEY (event_fk) REFERENCES event(id);


--
-- Name: event_group_group_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY event_group
    ADD CONSTRAINT event_group_group_fk_fkey FOREIGN KEY (group_fk) REFERENCES "group"(id);


--
-- Name: event_group_status_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY event_group
    ADD CONSTRAINT event_group_status_fk_fkey FOREIGN KEY (status_fk) REFERENCES status(id);


--
-- Name: event_recur_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY event
    ADD CONSTRAINT event_recur_fk_fkey FOREIGN KEY (recur_fk) REFERENCES event_recur(id);


--
-- Name: event_reserved_user_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY event
    ADD CONSTRAINT event_reserved_user_fk_fkey FOREIGN KEY (reserved_user_fk) REFERENCES "user"(id);


--
-- Name: forum_user_user_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY forum_user
    ADD CONSTRAINT forum_user_user_fk_fkey FOREIGN KEY (user_fk) REFERENCES "user"(id);


--
-- Name: grantor_fk; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY user_organization
    ADD CONSTRAINT grantor_fk FOREIGN KEY (grantor_fk) REFERENCES "user"(id);


--
-- Name: invitation_group_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY invitation
    ADD CONSTRAINT invitation_group_fk_fkey FOREIGN KEY (group_fk) REFERENCES "group"(id);


--
-- Name: invitation_issuer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY invitation
    ADD CONSTRAINT invitation_issuer_fkey FOREIGN KEY (issuer_fk) REFERENCES "user"(id);


--
-- Name: invitation_network_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY invitation
    ADD CONSTRAINT invitation_network_fk_fkey FOREIGN KEY (network_fk) REFERENCES organization(id);


--
-- Name: invitation_organization_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY invitation
    ADD CONSTRAINT invitation_organization_fk_fkey FOREIGN KEY (organization_fk) REFERENCES organization(id);


--
-- Name: message_recipient_message_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY message_recipient
    ADD CONSTRAINT message_recipient_message_fk_fkey FOREIGN KEY (message_fk) REFERENCES message(id);


--
-- Name: message_recipient_recipient_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY message_recipient
    ADD CONSTRAINT message_recipient_recipient_fk_fkey FOREIGN KEY (recipient_fk) REFERENCES "user"(id);


--
-- Name: message_reply_to_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY message
    ADD CONSTRAINT message_reply_to_fk_fkey FOREIGN KEY (reply_to_fk) REFERENCES message(id);


--
-- Name: message_sender_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY message
    ADD CONSTRAINT message_sender_fk_fkey FOREIGN KEY (sender_fk) REFERENCES "user"(id);


--
-- Name: organization_account_organization_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY organization_account
    ADD CONSTRAINT organization_account_organization_fk_fkey FOREIGN KEY (organization_fk) REFERENCES organization(id);


--
-- Name: organization_affiliation_affiliation_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY organization_affiliation
    ADD CONSTRAINT organization_affiliation_affiliation_fk_fkey FOREIGN KEY (affiliation_fk) REFERENCES affiliation(id);


--
-- Name: organization_affiliation_organization_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY organization_affiliation
    ADD CONSTRAINT organization_affiliation_organization_fk_fkey FOREIGN KEY (organization_fk) REFERENCES organization(id);


--
-- Name: organization_community_group_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY organization
    ADD CONSTRAINT organization_community_group_fk_fkey FOREIGN KEY (community_group_fk) REFERENCES "group"(id);


--
-- Name: organization_contact_contact_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY organization_contact
    ADD CONSTRAINT organization_contact_contact_fk_fkey FOREIGN KEY (contact_fk) REFERENCES contact(id);


--
-- Name: organization_contact_organization_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY organization_contact
    ADD CONSTRAINT organization_contact_organization_fk_fkey FOREIGN KEY (organization_fk) REFERENCES organization(id);


--
-- Name: organization_ethnicity_ethnicity_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY organization_ethnicity
    ADD CONSTRAINT organization_ethnicity_ethnicity_fk_fkey FOREIGN KEY (ethnicity_fk) REFERENCES ethnicity(id);


--
-- Name: organization_ethnicity_organization_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY organization_ethnicity
    ADD CONSTRAINT organization_ethnicity_organization_fk_fkey FOREIGN KEY (organization_fk) REFERENCES organization(id);


--
-- Name: organization_fk; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY user_organization
    ADD CONSTRAINT organization_fk FOREIGN KEY (organization_fk) REFERENCES organization(id);


--
-- Name: organization_language_language_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY organization_language
    ADD CONSTRAINT organization_language_language_fk_fkey FOREIGN KEY (language_fk) REFERENCES language(id);


--
-- Name: organization_language_organization_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY organization_language
    ADD CONSTRAINT organization_language_organization_fk_fkey FOREIGN KEY (organization_fk) REFERENCES organization(id);


--
-- Name: organization_organization_organization_from_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY organization_organization
    ADD CONSTRAINT organization_organization_organization_from_fk_fkey FOREIGN KEY (organization_from_fk) REFERENCES organization(id);


--
-- Name: organization_organization_organization_to_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY organization_organization
    ADD CONSTRAINT organization_organization_organization_to_fk_fkey FOREIGN KEY (organization_to_fk) REFERENCES organization(id);


--
-- Name: organization_program_organization_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY organization_program
    ADD CONSTRAINT organization_program_organization_fk_fkey FOREIGN KEY (organization_fk) REFERENCES organization(id);


--
-- Name: organization_program_program_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY organization_program
    ADD CONSTRAINT organization_program_program_fk_fkey FOREIGN KEY (program_fk) REFERENCES program(id);


--
-- Name: organization_topic_organization_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY organization_topic
    ADD CONSTRAINT organization_topic_organization_fk_fkey FOREIGN KEY (organization_fk) REFERENCES organization(id);


--
-- Name: organization_topic_program_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY organization_topic
    ADD CONSTRAINT organization_topic_program_fk_fkey FOREIGN KEY (program_fk) REFERENCES organization_program(id);


--
-- Name: organization_topic_topic_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY organization_topic
    ADD CONSTRAINT organization_topic_topic_fkey FOREIGN KEY (topic_fk) REFERENCES topic(id);


--
-- Name: program_contact_contact_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY program_contact
    ADD CONSTRAINT program_contact_contact_fk_fkey FOREIGN KEY (contact_fk) REFERENCES contact(id);


--
-- Name: program_contact_program_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY program_contact
    ADD CONSTRAINT program_contact_program_fk_fkey FOREIGN KEY (program_fk) REFERENCES program(id);


--
-- Name: public_global_invite_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY organization
    ADD CONSTRAINT public_global_invite_fk_fkey FOREIGN KEY (public_global_invite_fk) REFERENCES invitation(id);


--
-- Name: role_fk; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY user_organization
    ADD CONSTRAINT role_fk FOREIGN KEY (role_fk) REFERENCES role(id);


--
-- Name: role_fk; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY invitation
    ADD CONSTRAINT role_fk FOREIGN KEY (role_fk) REFERENCES role(id);


--
-- Name: role_privilege_privilege_id_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY role_privilege
    ADD CONSTRAINT role_privilege_privilege_id_fk_fkey FOREIGN KEY (privilege_id_fk) REFERENCES privilege(id);


--
-- Name: role_privilege_role_id_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY role_privilege
    ADD CONSTRAINT role_privilege_role_id_fk_fkey FOREIGN KEY (role_id_fk) REFERENCES role(id);


--
-- Name: user_contact_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_contact_fk_fkey FOREIGN KEY (contact_fk) REFERENCES contact(id);


--
-- Name: user_fk; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY user_organization
    ADD CONSTRAINT user_fk FOREIGN KEY (user_fk) REFERENCES "user"(id);


--
-- Name: user_group_group_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY user_group
    ADD CONSTRAINT user_group_group_fk_fkey FOREIGN KEY (group_fk) REFERENCES "group"(id);


--
-- Name: user_group_role_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY user_group
    ADD CONSTRAINT user_group_role_fk_fkey FOREIGN KEY (role_fk) REFERENCES role(id);


--
-- Name: user_group_user_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY user_group
    ADD CONSTRAINT user_group_user_fk_fkey FOREIGN KEY (user_fk) REFERENCES "user"(id);


--
-- Name: user_password_user_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY user_password
    ADD CONSTRAINT user_password_user_fk_fkey FOREIGN KEY (user_fk) REFERENCES "user"(id);


--
-- Name: user_session_user_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
--

ALTER TABLE ONLY user_session
    ADD CONSTRAINT user_session_user_fk_fkey FOREIGN KEY (user_fk) REFERENCES "user"(id);


--
-- Name: user_status_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: northbri_devnexus
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
-- Name: affiliation; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON TABLE affiliation FROM PUBLIC;
REVOKE ALL ON TABLE affiliation FROM northbri_devnexus;
GRANT ALL ON TABLE affiliation TO northbri_devnexus;
GRANT SELECT,INSERT,REFERENCES,UPDATE ON TABLE affiliation TO northbri_web WITH GRANT OPTION;
GRANT ALL ON TABLE affiliation TO northbri_nbnexus;


--
-- Name: category; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON TABLE category FROM PUBLIC;
REVOKE ALL ON TABLE category FROM northbri_devnexus;
GRANT ALL ON TABLE category TO northbri_devnexus;


--
-- Name: category_topic; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON TABLE category_topic FROM PUBLIC;
REVOKE ALL ON TABLE category_topic FROM northbri_devnexus;
GRANT ALL ON TABLE category_topic TO northbri_devnexus;


--
-- Name: contact_id_seq; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON SEQUENCE contact_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE contact_id_seq FROM northbri_devnexus;
GRANT ALL ON SEQUENCE contact_id_seq TO northbri_devnexus;
GRANT SELECT,UPDATE ON SEQUENCE contact_id_seq TO northbri_web;


--
-- Name: contact; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON TABLE contact FROM PUBLIC;
REVOKE ALL ON TABLE contact FROM northbri_devnexus;
GRANT ALL ON TABLE contact TO northbri_devnexus;
GRANT SELECT,INSERT,REFERENCES,UPDATE ON TABLE contact TO northbri_web WITH GRANT OPTION;


--
-- Name: ethnicity; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON TABLE ethnicity FROM PUBLIC;
REVOKE ALL ON TABLE ethnicity FROM northbri_devnexus;
GRANT ALL ON TABLE ethnicity TO northbri_devnexus;
GRANT SELECT,INSERT,REFERENCES,UPDATE ON TABLE ethnicity TO northbri_web WITH GRANT OPTION;
GRANT ALL ON TABLE ethnicity TO northbri_nbnexus;


--
-- Name: event; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON TABLE event FROM PUBLIC;
REVOKE ALL ON TABLE event FROM northbri_devnexus;
GRANT ALL ON TABLE event TO northbri_devnexus;
GRANT SELECT,INSERT,UPDATE ON TABLE event TO northbri_web;


--
-- Name: event_group_id_seq; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON SEQUENCE event_group_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE event_group_id_seq FROM northbri_devnexus;
GRANT ALL ON SEQUENCE event_group_id_seq TO northbri_devnexus;
GRANT SELECT,UPDATE ON SEQUENCE event_group_id_seq TO northbri_web;


--
-- Name: event_group; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON TABLE event_group FROM PUBLIC;
REVOKE ALL ON TABLE event_group FROM northbri_devnexus;
GRANT ALL ON TABLE event_group TO northbri_devnexus;
GRANT SELECT,INSERT,UPDATE ON TABLE event_group TO northbri_web;


--
-- Name: event_id_seq; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON SEQUENCE event_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE event_id_seq FROM northbri_devnexus;
GRANT ALL ON SEQUENCE event_id_seq TO northbri_devnexus;
GRANT SELECT,UPDATE ON SEQUENCE event_id_seq TO northbri_web;


--
-- Name: event_recur_id_seq; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON SEQUENCE event_recur_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE event_recur_id_seq FROM northbri_devnexus;
GRANT ALL ON SEQUENCE event_recur_id_seq TO northbri_devnexus;
GRANT SELECT,UPDATE ON SEQUENCE event_recur_id_seq TO northbri_web;


--
-- Name: event_recur; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON TABLE event_recur FROM PUBLIC;
REVOKE ALL ON TABLE event_recur FROM northbri_devnexus;
GRANT ALL ON TABLE event_recur TO northbri_devnexus;
GRANT SELECT,INSERT,UPDATE ON TABLE event_recur TO northbri_web;


--
-- Name: forum_poll; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON TABLE forum_poll FROM PUBLIC;
REVOKE ALL ON TABLE forum_poll FROM northbri_devnexus;
GRANT ALL ON TABLE forum_poll TO northbri_devnexus;
GRANT ALL ON TABLE forum_poll TO northbri_nbnexus;
GRANT SELECT,INSERT,REFERENCES,UPDATE ON TABLE forum_poll TO northbri_web WITH GRANT OPTION;


--
-- Name: forum_user_id_seq; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON SEQUENCE forum_user_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE forum_user_id_seq FROM northbri_devnexus;
GRANT USAGE ON SEQUENCE forum_user_id_seq TO northbri_devnexus;
GRANT SELECT,UPDATE ON SEQUENCE forum_user_id_seq TO northbri_devnexus WITH GRANT OPTION;
GRANT SELECT,UPDATE ON SEQUENCE forum_user_id_seq TO northbri_web WITH GRANT OPTION;


--
-- Name: forum_user; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON TABLE forum_user FROM PUBLIC;
REVOKE ALL ON TABLE forum_user FROM northbri_devnexus;
GRANT ALL ON TABLE forum_user TO northbri_devnexus;
GRANT SELECT,INSERT,REFERENCES,UPDATE ON TABLE forum_user TO northbri_web WITH GRANT OPTION;


--
-- Name: group_id_seq; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON SEQUENCE group_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE group_id_seq FROM northbri_devnexus;
GRANT ALL ON SEQUENCE group_id_seq TO northbri_devnexus;
GRANT SELECT,UPDATE ON SEQUENCE group_id_seq TO northbri_web;


--
-- Name: group; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON TABLE "group" FROM PUBLIC;
REVOKE ALL ON TABLE "group" FROM northbri_devnexus;
GRANT ALL ON TABLE "group" TO northbri_devnexus;
GRANT SELECT,INSERT,UPDATE ON TABLE "group" TO northbri_web;


--
-- Name: invitation; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON TABLE invitation FROM PUBLIC;
REVOKE ALL ON TABLE invitation FROM northbri_devnexus;
GRANT ALL ON TABLE invitation TO northbri_devnexus;
GRANT SELECT,INSERT,REFERENCES,UPDATE ON TABLE invitation TO northbri_web;


--
-- Name: invitation_id_seq; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON SEQUENCE invitation_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE invitation_id_seq FROM northbri_devnexus;
GRANT ALL ON SEQUENCE invitation_id_seq TO northbri_devnexus;
GRANT SELECT,UPDATE ON SEQUENCE invitation_id_seq TO northbri_web;


--
-- Name: invitation_organization; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON TABLE invitation_organization FROM PUBLIC;
REVOKE ALL ON TABLE invitation_organization FROM northbri_devnexus;
GRANT ALL ON TABLE invitation_organization TO northbri_devnexus;
GRANT SELECT,INSERT,REFERENCES,UPDATE ON TABLE invitation_organization TO northbri_web;


--
-- Name: invitation_organization_id_seq; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON SEQUENCE invitation_organization_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE invitation_organization_id_seq FROM northbri_devnexus;
GRANT ALL ON SEQUENCE invitation_organization_id_seq TO northbri_devnexus;
GRANT SELECT,UPDATE ON SEQUENCE invitation_organization_id_seq TO northbri_web;


--
-- Name: language; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON TABLE language FROM PUBLIC;
REVOKE ALL ON TABLE language FROM northbri_devnexus;
GRANT ALL ON TABLE language TO northbri_devnexus;
GRANT SELECT,INSERT,REFERENCES,UPDATE ON TABLE language TO northbri_web WITH GRANT OPTION;


--
-- Name: location_id_seq; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON SEQUENCE location_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE location_id_seq FROM northbri_devnexus;
GRANT ALL ON SEQUENCE location_id_seq TO northbri_devnexus;
GRANT SELECT,UPDATE ON SEQUENCE location_id_seq TO northbri_web;


--
-- Name: location; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON TABLE location FROM PUBLIC;
REVOKE ALL ON TABLE location FROM northbri_devnexus;
GRANT ALL ON TABLE location TO northbri_devnexus;
GRANT SELECT,INSERT,REFERENCES,UPDATE ON TABLE location TO northbri_web WITH GRANT OPTION;


--
-- Name: message_id_seq; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON SEQUENCE message_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE message_id_seq FROM northbri_devnexus;
GRANT ALL ON SEQUENCE message_id_seq TO northbri_devnexus;
GRANT SELECT,UPDATE ON SEQUENCE message_id_seq TO northbri_web;


--
-- Name: message; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON TABLE message FROM PUBLIC;
REVOKE ALL ON TABLE message FROM northbri_devnexus;
GRANT ALL ON TABLE message TO northbri_devnexus;
GRANT SELECT,INSERT,UPDATE ON TABLE message TO northbri_web;


--
-- Name: message_recipient; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON TABLE message_recipient FROM PUBLIC;
REVOKE ALL ON TABLE message_recipient FROM northbri_devnexus;
GRANT ALL ON TABLE message_recipient TO northbri_devnexus;
GRANT SELECT,INSERT ON TABLE message_recipient TO northbri_web;


--
-- Name: organization; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON TABLE organization FROM PUBLIC;
REVOKE ALL ON TABLE organization FROM northbri_devnexus;
GRANT ALL ON TABLE organization TO northbri_devnexus;
GRANT SELECT,INSERT,REFERENCES,UPDATE ON TABLE organization TO northbri_web WITH GRANT OPTION;


--
-- Name: organization_account_id_seq; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON SEQUENCE organization_account_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE organization_account_id_seq FROM northbri_devnexus;
GRANT ALL ON SEQUENCE organization_account_id_seq TO northbri_devnexus;
GRANT SELECT,UPDATE ON SEQUENCE organization_account_id_seq TO northbri_web;


--
-- Name: organization_account; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON TABLE organization_account FROM PUBLIC;
REVOKE ALL ON TABLE organization_account FROM northbri_devnexus;
GRANT ALL ON TABLE organization_account TO northbri_devnexus;
GRANT SELECT,INSERT,REFERENCES,UPDATE ON TABLE organization_account TO northbri_web WITH GRANT OPTION;


--
-- Name: organization_affiliation_id_seq; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON SEQUENCE organization_affiliation_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE organization_affiliation_id_seq FROM northbri_devnexus;
GRANT ALL ON SEQUENCE organization_affiliation_id_seq TO northbri_devnexus;
GRANT SELECT,UPDATE ON SEQUENCE organization_affiliation_id_seq TO northbri_web;


--
-- Name: organization_affiliation; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON TABLE organization_affiliation FROM PUBLIC;
REVOKE ALL ON TABLE organization_affiliation FROM northbri_devnexus;
GRANT ALL ON TABLE organization_affiliation TO northbri_devnexus;
GRANT SELECT,INSERT,REFERENCES,DELETE,UPDATE ON TABLE organization_affiliation TO northbri_web WITH GRANT OPTION;
GRANT ALL ON TABLE organization_affiliation TO northbri_nbnexus;


--
-- Name: organization_contact_id_seq; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON SEQUENCE organization_contact_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE organization_contact_id_seq FROM northbri_devnexus;
GRANT ALL ON SEQUENCE organization_contact_id_seq TO northbri_devnexus;
GRANT SELECT,UPDATE ON SEQUENCE organization_contact_id_seq TO northbri_web;


--
-- Name: organization_contact; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON TABLE organization_contact FROM PUBLIC;
REVOKE ALL ON TABLE organization_contact FROM northbri_devnexus;
GRANT ALL ON TABLE organization_contact TO northbri_devnexus;
GRANT SELECT,INSERT,REFERENCES,DELETE,UPDATE ON TABLE organization_contact TO northbri_web WITH GRANT OPTION;


--
-- Name: organization_ethnicity_id_seq; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON SEQUENCE organization_ethnicity_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE organization_ethnicity_id_seq FROM northbri_devnexus;
GRANT ALL ON SEQUENCE organization_ethnicity_id_seq TO northbri_devnexus;
GRANT SELECT,UPDATE ON SEQUENCE organization_ethnicity_id_seq TO northbri_web;


--
-- Name: organization_ethnicity; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON TABLE organization_ethnicity FROM PUBLIC;
REVOKE ALL ON TABLE organization_ethnicity FROM northbri_devnexus;
GRANT ALL ON TABLE organization_ethnicity TO northbri_devnexus;
GRANT SELECT,INSERT,REFERENCES,DELETE,UPDATE ON TABLE organization_ethnicity TO northbri_web WITH GRANT OPTION;
GRANT ALL ON TABLE organization_ethnicity TO northbri_nbnexus;


--
-- Name: organization_id_seq; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON SEQUENCE organization_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE organization_id_seq FROM northbri_devnexus;
GRANT ALL ON SEQUENCE organization_id_seq TO northbri_devnexus;
GRANT SELECT,UPDATE ON SEQUENCE organization_id_seq TO northbri_web;


--
-- Name: organization_language_id_seq; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON SEQUENCE organization_language_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE organization_language_id_seq FROM northbri_devnexus;
GRANT ALL ON SEQUENCE organization_language_id_seq TO northbri_devnexus;
GRANT SELECT,UPDATE ON SEQUENCE organization_language_id_seq TO northbri_web;


--
-- Name: organization_language; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON TABLE organization_language FROM PUBLIC;
REVOKE ALL ON TABLE organization_language FROM northbri_devnexus;
GRANT ALL ON TABLE organization_language TO northbri_devnexus;
GRANT SELECT,INSERT,REFERENCES,DELETE,UPDATE ON TABLE organization_language TO northbri_web WITH GRANT OPTION;


--
-- Name: organization_location_id_seq; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON SEQUENCE organization_location_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE organization_location_id_seq FROM northbri_devnexus;
GRANT ALL ON SEQUENCE organization_location_id_seq TO northbri_devnexus;
GRANT SELECT,UPDATE ON SEQUENCE organization_location_id_seq TO northbri_web;


--
-- Name: organization_location; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON TABLE organization_location FROM PUBLIC;
REVOKE ALL ON TABLE organization_location FROM northbri_devnexus;
GRANT ALL ON TABLE organization_location TO northbri_devnexus;
GRANT SELECT,INSERT,REFERENCES,DELETE,UPDATE ON TABLE organization_location TO northbri_web WITH GRANT OPTION;


--
-- Name: organization_organization; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON TABLE organization_organization FROM PUBLIC;
REVOKE ALL ON TABLE organization_organization FROM northbri_devnexus;
GRANT ALL ON TABLE organization_organization TO northbri_devnexus;
GRANT SELECT,INSERT ON TABLE organization_organization TO northbri_web;


--
-- Name: organization_organization_id_seq; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON SEQUENCE organization_organization_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE organization_organization_id_seq FROM northbri_devnexus;
GRANT ALL ON SEQUENCE organization_organization_id_seq TO northbri_devnexus;
GRANT SELECT,UPDATE ON SEQUENCE organization_organization_id_seq TO northbri_web;


--
-- Name: organization_program_id_seq; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON SEQUENCE organization_program_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE organization_program_id_seq FROM northbri_devnexus;
GRANT ALL ON SEQUENCE organization_program_id_seq TO northbri_devnexus;
GRANT SELECT,UPDATE ON SEQUENCE organization_program_id_seq TO northbri_web;


--
-- Name: organization_program; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON TABLE organization_program FROM PUBLIC;
REVOKE ALL ON TABLE organization_program FROM northbri_devnexus;
GRANT ALL ON TABLE organization_program TO northbri_devnexus;
GRANT SELECT,INSERT,REFERENCES,UPDATE ON TABLE organization_program TO northbri_web WITH GRANT OPTION;


--
-- Name: organization_topic_id_seq; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON SEQUENCE organization_topic_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE organization_topic_id_seq FROM northbri_devnexus;
GRANT ALL ON SEQUENCE organization_topic_id_seq TO northbri_devnexus;
GRANT SELECT,UPDATE ON SEQUENCE organization_topic_id_seq TO northbri_web;


--
-- Name: organization_topic; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON TABLE organization_topic FROM PUBLIC;
REVOKE ALL ON TABLE organization_topic FROM northbri_devnexus;
GRANT ALL ON TABLE organization_topic TO northbri_devnexus;
GRANT SELECT,INSERT,REFERENCES,DELETE,UPDATE ON TABLE organization_topic TO northbri_web WITH GRANT OPTION;


--
-- Name: privilege; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON TABLE privilege FROM PUBLIC;
REVOKE ALL ON TABLE privilege FROM northbri_devnexus;
GRANT ALL ON TABLE privilege TO northbri_devnexus;
GRANT SELECT,INSERT ON TABLE privilege TO northbri_web;


--
-- Name: program_id_seq; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON SEQUENCE program_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE program_id_seq FROM northbri_devnexus;
GRANT ALL ON SEQUENCE program_id_seq TO northbri_devnexus;
GRANT SELECT,UPDATE ON SEQUENCE program_id_seq TO northbri_web;


--
-- Name: program; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON TABLE program FROM PUBLIC;
REVOKE ALL ON TABLE program FROM northbri_devnexus;
GRANT ALL ON TABLE program TO northbri_devnexus;
GRANT SELECT,INSERT,REFERENCES,UPDATE ON TABLE program TO northbri_web WITH GRANT OPTION;


--
-- Name: program_contact_id_seq; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON SEQUENCE program_contact_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE program_contact_id_seq FROM northbri_devnexus;
GRANT ALL ON SEQUENCE program_contact_id_seq TO northbri_devnexus;
GRANT SELECT,UPDATE ON SEQUENCE program_contact_id_seq TO northbri_web;


--
-- Name: program_contact; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON TABLE program_contact FROM PUBLIC;
REVOKE ALL ON TABLE program_contact FROM northbri_devnexus;
GRANT ALL ON TABLE program_contact TO northbri_devnexus;
GRANT ALL ON TABLE program_contact TO northbri_nbnexus;
GRANT SELECT,INSERT,REFERENCES,DELETE,UPDATE ON TABLE program_contact TO northbri_web WITH GRANT OPTION;


--
-- Name: program_language; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON TABLE program_language FROM PUBLIC;
REVOKE ALL ON TABLE program_language FROM northbri_devnexus;
GRANT ALL ON TABLE program_language TO northbri_devnexus;


--
-- Name: program_location_id_seq; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON SEQUENCE program_location_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE program_location_id_seq FROM northbri_devnexus;
GRANT ALL ON SEQUENCE program_location_id_seq TO northbri_devnexus;
GRANT SELECT,UPDATE ON SEQUENCE program_location_id_seq TO northbri_web;


--
-- Name: program_location; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON TABLE program_location FROM PUBLIC;
REVOKE ALL ON TABLE program_location FROM northbri_devnexus;
GRANT ALL ON TABLE program_location TO northbri_devnexus;
GRANT ALL ON TABLE program_location TO northbri_nbnexus;
GRANT SELECT,INSERT,REFERENCES,DELETE,UPDATE ON TABLE program_location TO northbri_web WITH GRANT OPTION;


--
-- Name: raster_columns; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON TABLE raster_columns FROM PUBLIC;
REVOKE ALL ON TABLE raster_columns FROM northbri_devnexus;
GRANT ALL ON TABLE raster_columns TO northbri_devnexus;
GRANT SELECT ON TABLE raster_columns TO PUBLIC;


--
-- Name: raster_overviews; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON TABLE raster_overviews FROM PUBLIC;
REVOKE ALL ON TABLE raster_overviews FROM northbri_devnexus;
GRANT ALL ON TABLE raster_overviews TO northbri_devnexus;
GRANT SELECT ON TABLE raster_overviews TO PUBLIC;


--
-- Name: role; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON TABLE role FROM PUBLIC;
REVOKE ALL ON TABLE role FROM northbri_devnexus;
GRANT ALL ON TABLE role TO northbri_devnexus;
GRANT SELECT ON TABLE role TO northbri_web;


--
-- Name: role_privilege; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON TABLE role_privilege FROM PUBLIC;
REVOKE ALL ON TABLE role_privilege FROM northbri_devnexus;
GRANT ALL ON TABLE role_privilege TO northbri_devnexus;
GRANT SELECT ON TABLE role_privilege TO northbri_web;


--
-- Name: spatial_ref_sys; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON TABLE spatial_ref_sys FROM PUBLIC;
REVOKE ALL ON TABLE spatial_ref_sys FROM northbri_devnexus;
GRANT ALL ON TABLE spatial_ref_sys TO northbri_devnexus;


--
-- Name: status; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON TABLE status FROM PUBLIC;
REVOKE ALL ON TABLE status FROM northbri_devnexus;
GRANT ALL ON TABLE status TO northbri_devnexus;
GRANT SELECT,INSERT,UPDATE ON TABLE status TO northbri_web;


--
-- Name: topic; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON TABLE topic FROM PUBLIC;
REVOKE ALL ON TABLE topic FROM northbri_devnexus;
GRANT ALL ON TABLE topic TO northbri_devnexus;
GRANT SELECT,INSERT,REFERENCES,UPDATE ON TABLE topic TO northbri_web WITH GRANT OPTION;


--
-- Name: user; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON TABLE "user" FROM PUBLIC;
REVOKE ALL ON TABLE "user" FROM northbri_devnexus;
GRANT ALL ON TABLE "user" TO northbri_devnexus;
GRANT SELECT,INSERT,UPDATE ON TABLE "user" TO northbri_web;


--
-- Name: user_group_id_seq; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON SEQUENCE user_group_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE user_group_id_seq FROM northbri_devnexus;
GRANT ALL ON SEQUENCE user_group_id_seq TO northbri_devnexus;
GRANT SELECT,UPDATE ON SEQUENCE user_group_id_seq TO northbri_web;


--
-- Name: user_group; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON TABLE user_group FROM PUBLIC;
REVOKE ALL ON TABLE user_group FROM northbri_devnexus;
GRANT ALL ON TABLE user_group TO northbri_devnexus;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE user_group TO northbri_web;


--
-- Name: user_id_seq; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON SEQUENCE user_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE user_id_seq FROM northbri_devnexus;
GRANT ALL ON SEQUENCE user_id_seq TO northbri_devnexus;
GRANT SELECT,UPDATE ON SEQUENCE user_id_seq TO northbri_web;


--
-- Name: user_organization; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON TABLE user_organization FROM PUBLIC;
REVOKE ALL ON TABLE user_organization FROM northbri_devnexus;
GRANT ALL ON TABLE user_organization TO northbri_devnexus;
GRANT SELECT,INSERT,DELETE ON TABLE user_organization TO northbri_web;


--
-- Name: user_organization_id_seq; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON SEQUENCE user_organization_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE user_organization_id_seq FROM northbri_devnexus;
GRANT ALL ON SEQUENCE user_organization_id_seq TO northbri_devnexus;
GRANT SELECT,UPDATE ON SEQUENCE user_organization_id_seq TO northbri_web;


--
-- Name: user_password_id_seq; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON SEQUENCE user_password_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE user_password_id_seq FROM northbri_devnexus;
GRANT ALL ON SEQUENCE user_password_id_seq TO northbri_devnexus;
GRANT SELECT,UPDATE ON SEQUENCE user_password_id_seq TO northbri_web;


--
-- Name: user_password; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON TABLE user_password FROM PUBLIC;
REVOKE ALL ON TABLE user_password FROM northbri_devnexus;
GRANT ALL ON TABLE user_password TO northbri_devnexus;
GRANT SELECT,INSERT,UPDATE ON TABLE user_password TO northbri_web;


--
-- Name: user_session_id_seq; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON SEQUENCE user_session_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE user_session_id_seq FROM northbri_devnexus;
GRANT ALL ON SEQUENCE user_session_id_seq TO northbri_devnexus;
GRANT SELECT,UPDATE ON SEQUENCE user_session_id_seq TO northbri_web;


--
-- Name: user_session; Type: ACL; Schema: public; Owner: northbri_devnexus
--

REVOKE ALL ON TABLE user_session FROM PUBLIC;
REVOKE ALL ON TABLE user_session FROM northbri_devnexus;
GRANT ALL ON TABLE user_session TO northbri_devnexus;
GRANT SELECT,INSERT ON TABLE user_session TO northbri_web;


--
-- PostgreSQL database dump complete
--

