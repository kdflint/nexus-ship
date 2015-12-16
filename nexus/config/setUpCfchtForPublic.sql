update organization set uid = 'ed787a92' where id = 18
update organization set logo = 'cfcht_logo.png' where id = 18

-- We need a public user for CFCHT
insert into public.user (uuid, username, fname, lname, email, status_fk, create_dttm, activate_dttm) values (
'51b921d8-f805-440a-8db8-3352904bfa73', 
'pUser-ed787a92',
'Public',
'User',
'',
'1',
now(),
now()) returning id;

--(Got 246)

-- We need a CFCHT public group
insert into public.group (name, descr, create_dttm, activate_dttm, uid) values (
'Public Group',
'This group is a placeholder for public ed787a92',
now(),
now(),
'503ebc8d') returning id;

-- (Got 18)

-- Tie new public user to public group
insert into user_group (user_fk, create_dttm, group_fk, role_fk) values
(246,
now(),
18,
5);

-- Tie new public user to CFCHT
insert into user_organization (user_fk, organization_fk, grantor_fk, create_dttm, role_fk) values (
246,
18,
88,
now(),
5)


-- Add events
-- Events are tied to public group. Public site access logs in under pUser-c2007e9b which is tied to public group and to c2007e9b (that is, CFCHT)
-- So CFCHT public events are pulled by association with pUser

insert into event (uuid, start_dttm, duration, name, descr, reserved_user_fk, tz_name, tz_abbrev, type, location, isBbbMeet) values (
'8ceada6c-d4b3-4c39-9595-64f562253ded',
'2016-12-15 17:25:00-07',
'00:30:00',
'Test Event',
'',
'88',
'America/Chicago',
'CST',
'collaboration',
'740 Monroe Street',
false)
returning id

insert into event_group (event_fk, group_fk) values (47, 18)
