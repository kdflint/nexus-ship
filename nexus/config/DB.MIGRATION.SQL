alter table public.user add column email_confirmed boolean not null default false;

update public.user set email_confirmed = true;

update public.user set username = username || '__' || id where status_fk = 2 and suspend_dttm is not NULL;