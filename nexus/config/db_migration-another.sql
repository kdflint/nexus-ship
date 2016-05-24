UPDATE pg_attribute SET atttypmod = 604
WHERE attrelid = 'public.event'::regclass
AND attname = 'url';

UPDATE pg_attribute SET atttypmod = 604
WHERE attrelid = 'public.event'::regclass
AND attname = 'registration_url';

-- No permission to do above at A2
-- So, use phpPgAdmin
