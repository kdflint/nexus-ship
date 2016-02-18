-- Table: public.member_prospects

DROP TABLE public.prospects;

CREATE TABLE public.prospects
(
  id numeric NOT NULL,
  name character varying(500),
  ein character varying(20),
  keywords character varying(500),
  cname character varying(200),
  ctitle character varying(200),
  cemail character varying(200),
  url character varying(200),
  CONSTRAINT prospects_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.prospects
  OWNER TO postgres;
GRANT ALL ON TABLE public.prospects TO postgres;

-- Table: public.member_prospects_code

DROP TABLE public.prospects_code;

CREATE TABLE public.prospects_code
(
  prospect_fk numeric NOT NULL,
  ntee_code character varying(2000) NOT NULL,
  CONSTRAINT prospects_code_pkey PRIMARY KEY (prospect_fk, ntee_code)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.prospects_code
  OWNER TO postgres;
GRANT ALL ON TABLE public.prospects_code TO postgres;