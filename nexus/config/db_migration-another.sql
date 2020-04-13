CREATE SEQUENCE public.event_children_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.event_children_id_seq
    OWNER TO northbri_nbnexus;

GRANT ALL ON SEQUENCE public.event_children_id_seq TO northbri_nbnexus;

GRANT SELECT, UPDATE ON SEQUENCE public.event_children_id_seq TO northbri_web;

CREATE TABLE public.event_children
(
    id integer NOT NULL DEFAULT nextval('event_children_id_seq'::regclass),
    event_fk integer NOT NULL,
    start_dttm timestamp with time zone NOT NULL,
    CONSTRAINT event_children_pkey PRIMARY KEY (id),
    CONSTRAINT event_children_event_fk_fkey FOREIGN KEY (event_fk)
        REFERENCES public.event (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
);

ALTER TABLE public.event_children
    OWNER to northbri_nbnexus;
	
GRANT INSERT, SELECT, UPDATE ON TABLE public.event TO northbri_web;

GRANT ALL ON TABLE public.event TO northbri_nbnexus;

CREATE OR REPLACE FUNCTION create_event_recurrences() RETURNS trigger AS 
--DO 
$$ 
DECLARE
	next_dttm TIMESTAMP;
	num_of_occurrences NUMERIC := 0;
	recur_pattern CHARACTER VARYING(12) := '';
	counter NUMERIC := 0;
	this_event_id INTEGER := NEW.id;
	this_recur_id INTEGER := NEW.recur_fk;
BEGIN 
  IF this_recur_id IS NOT NULL THEN
    IF EXISTS (SELECT num_occur FROM event_recur WHERE id = this_recur_id) THEN
        SELECT num_occur, pattern INTO STRICT num_of_occurrences, recur_pattern FROM event_recur WHERE id = this_recur_id;
    END IF;
    SELECT start_dttm INTO STRICT next_dttm FROM event where recur_fk = this_recur_id;
    RAISE NOTICE 'The pattern is %', recur_pattern;
    RAISE NOTICE 'The parent event starts at %', next_dttm;
    RAISE NOTICE 'We want % occurrences', num_of_occurrences;
    RAISE NOTICE 'Inserting recurrence at % ', next_dttm;
    INSERT INTO event_children(event_fk,start_dttm) VALUES(this_event_id,next_dttm);
    WHILE counter < num_of_occurrences-1 LOOP
        IF recur_pattern = 'weekly' THEN
          next_dttm := next_dttm + (INTERVAL '1 WEEK');
        END IF;	
      IF recur_pattern IN ('daily','weekdays') THEN
        next_dttm := next_dttm + (INTERVAL '1 DAY');
        IF recur_pattern =  'weekdays' THEN
          IF EXTRACT(DOW FROM next_dttm) = 6 THEN 
            next_dttm := next_dttm + (INTERVAL '2 DAYS');
            RAISE NOTICE 'We found a Saturday. Skipping 2 days'; 
            END IF;
          IF EXTRACT(DOW FROM next_dttm) = 0 THEN 
            next_dttm := next_dttm + (INTERVAL '1 DAY');
            RAISE NOTICE 'We found a Sunday. Skipping 1 day'; 
          END IF;
        END IF;
      END IF;
    RAISE NOTICE 'Inserting recurrence at % ', next_dttm;
    INSERT INTO event_children(event_fk,start_dttm) VALUES(this_event_id,next_dttm);
    counter := counter + 1;
    END LOOP;	
  END IF;
  RETURN NEW;
END
$$
LANGUAGE plpgsql;


CREATE TRIGGER create_event
  AFTER INSERT
  ON event
  FOR EACH ROW
  EXECUTE PROCEDURE create_event_recurrences();