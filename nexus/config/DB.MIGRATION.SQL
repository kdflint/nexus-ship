alter table public.user add column email_confirmed boolean not null default false;

update public.user set email_confirmed = true;