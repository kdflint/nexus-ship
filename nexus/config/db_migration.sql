insert into organization (name, create_dttm, activate_dttm, tax_exempt, status_fk, logo, uid) values ('Nexus Web Meet Demonstration', now(), now(), true, 1, 'src="image/partners/userdemo.png"', 'userdemo') returning id;

insert into organization_organization (organization_from_fk, organization_to_fk, relationship, create_dttm) values (13, 333, 'parent', now());

insert into public.group (name, create_dttm, activate_dttm, logo, uid) values ('Nexus Web Meet Demonstration', now(), now(), '', '0c442176') returning id;

insert into invitation (uuid, email, create_dttm, accept_dttm, network_fk, invitation_dttm, role_fk, expire_dt, issuer_fk, type, organization_fk, group_fk) values ('fa116fa0-5b8a-4356-bd36-1934963330e3', '', now(), NULL, NULL, now(), '5', (CURRENT_DATE + interval '31 days'), '88', 'single', 333, 12) returning uuid;

--http://northbridgetech.org/dev/new_nexus/web/enroll.php?invitation=fa116fa0-5b8a-4356-bd36-1934963330e3

-- enroll demo user using above link: userdemo/fakepassword295

-- add DEMO_UIDPK	to config

insert into invitation (uuid, email, create_dttm, accept_dttm, network_fk, invitation_dttm, role_fk, expire_dt, issuer_fk, type, organization_fk, group_fk) values ('835c2ced-76e8-44df-aa41-366f07acfb5c', '', now(), NULL, NULL, now(), '4', (CURRENT_DATE + interval '31 days'), '88', 'single', 333, 12);

insert into invitation (uuid, email, create_dttm, accept_dttm, network_fk, invitation_dttm, role_fk, expire_dt, issuer_fk, type, organization_fk, group_fk) values ('4ea91884-6367-4f6c-9b70-208a6300063e', '', now(), NULL, NULL, now(), '4', (CURRENT_DATE + interval '31 days'), '88', 'single', 333, 12);

insert into invitation (uuid, email, create_dttm, accept_dttm, network_fk, invitation_dttm, role_fk, expire_dt, issuer_fk, type, organization_fk, group_fk) values ('bf5901d3-06e5-4c04-9eb2-4053d8448fdf', '', now(), NULL, NULL, now(), '5', (CURRENT_DATE + interval '31 days'), '88', 'single', 333, 12);

insert into invitation (uuid, email, create_dttm, accept_dttm, network_fk, invitation_dttm, role_fk, expire_dt, issuer_fk, type, organization_fk, group_fk) values ('abb827b5-9c2e-4bf5-bbf1-20daf18290d6', '', now(), NULL, NULL, now(), '5', (CURRENT_DATE + interval '31 days'), '88', 'single', 333, 12);


-- invite and enroll more users - demo_email@northbridgetech.org

-- F. L. Hamer - admin
-- Marlyn Wescoff - admin
-- Jean E. Sammet
-- Erna Schneider

-- login as an admin and add meetings

-- add soft link to Util.php batch folder

-- set cron jobs