-- Database: localnexus

-- DROP DATABASE localnexus;

CREATE DATABASE localnexus
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'English_United States.1252'
       LC_CTYPE = 'English_United States.1252'
       CONNECTION LIMIT = -1;
       
-- Role: northbri_devnexus

-- DROP ROLE northbri_devnexus;

CREATE ROLE northbri_devnexus LOGIN
  ENCRYPTED PASSWORD 'password'
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
  
 -- Role: northbri_web

-- DROP ROLE northbri_web;

CREATE ROLE northbri_web LOGIN
  ENCRYPTED PASSWORD 'password'
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
  
-- Database: localphbb

-- DROP DATABASE localphpbb;

CREATE DATABASE localphpbb
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'English_United States.1252'
       LC_CTYPE = 'English_United States.1252'
       CONNECTION LIMIT = -1;
GRANT CONNECT, TEMPORARY ON DATABASE localphpbb TO public;
GRANT ALL ON DATABASE localphpbb TO postgres;
GRANT ALL ON DATABASE localphpbb TO northbr6_web;
