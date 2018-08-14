-- DEV

insert into public.group 
(name, create_dttm, activate_dttm, logo, uid) 
values ('Trauma Informed Congregations Network', now(), now(), '', 'bf3ddd1c') returning id

insert into invitation 
(uuid, email, create_dttm, accept_dttm, network_fk, invitation_dttm, role_fk, expire_dt, issuer_fk, type, organization_fk, group_fk) 
values ('15962d1f-24c3-4c89-b974-3afaa2494eb4', '', now(), NULL, NULL, now(), 5, (CURRENT_DATE + interval '31 days'), 88, 'global', 1, 20) 
returning uuid

--http://northbridgetech.org/dev/nexus/web/enroll?invitation=15962d1f-24c3-4c89-b974-3afaa2494eb4

-- PROD

insert into public.group 
(name, create_dttm, activate_dttm, logo, uid) 
values ('Trauma Informed Congregations Network', now(), now(), '', 'bf3eee1c') returning id

insert into invitation 
(uuid, email, create_dttm, accept_dttm, network_fk, invitation_dttm, role_fk, expire_dt, issuer_fk, type, organization_fk, group_fk) 
values ('66662d1f-24c3-4c89-b974-3afaa2494eb4', '', now(), NULL, NULL, now(), 5, (CURRENT_DATE + interval '62 days'), 138, 'global', 18, 25) 
returning uuid

--http://nexus.northbridgetech.org/web/enroll?invitation=66662d1f-24c3-4c89-b974-3afaa2494eb4

-- LATER UPDATES


-- MAKE SURE NETWORK ORG has a uid

--select * from invitation where uuid = '15962d1f-24c3-4c89-b974-3afaa2494eb4'

--update invitation set network_fk = organization_fk where id = 135

--update invitation set group_fk = NULL where id = 135

--update invitation set expire_dt = NULL where id = 135

--update invitation set email = NULL where id = 135

