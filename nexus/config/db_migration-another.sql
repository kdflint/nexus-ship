UPDATE pg_attribute SET atttypmod = 604
WHERE attrelid = 'public.event'::regclass
AND attname = 'url';

UPDATE pg_attribute SET atttypmod = 604
WHERE attrelid = 'public.event'::regclass
AND attname = 'registration_url';

-- No permission to do above at A2
-- So, use phpPgAdmin

select count(*) from event where url is not null and url != '' and url not like 'http%'
update event set url = 'http://' || url where url is not null and url != '' and url not like 'http%'

select count(*) from event where registration_url is not null and registration_url != '' and registration_url not like 'http%'
update event set registration_url = 'http://' || registration_url where registration_url is not null and registration_url != '' and registration_url not like 'http%'
