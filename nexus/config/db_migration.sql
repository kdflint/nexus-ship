insert into organization (name, create_dttm, activate_dttm, tax_exempt, status_fk, logo, uid) values ('Nexus Web Meet Demonstration', now(), now(), true, 1, 'src="image/partners/userdemo.png"', 'userdemo') returning id;

insert into organization_organization (organization_from_fk, organization_to_fk, relationship, create_dttm) values (13, 345, 'parent', now());

insert into public.group (name, create_dttm, activate_dttm, logo, uid) values ('Nexus Web Meet Demonstration', now(), now(), '', '29892965') returning id;

insert into invitation (uuid, email, create_dttm, accept_dttm, network_fk, invitation_dttm, role_fk, expire_dt, issuer_fk, type, organization_fk, group_fk) values ('caf7c611-3d93-4814-b441-780ab2f1f5ab', '', now(), NULL, NULL, now(), '5', (CURRENT_DATE + interval '31 days'), '88', 'single', 345, 14) returning uuid;

--http://northbridgetech.org/dev/new_nexus/web/enroll.php?invitation=caf7c611-3d93-4814-b441-780ab2f1f5ab

-- enroll demo user using above link: userdemo/fakepassword295

-- add DEMO_UIDPK	to config

insert into invitation (uuid, email, create_dttm, accept_dttm, network_fk, invitation_dttm, role_fk, expire_dt, issuer_fk, type, organization_fk, group_fk) values ('d44da407-26d4-4788-bd0a-1e7eebc859e7', '', now(), NULL, NULL, now(), '4', (CURRENT_DATE + interval '31 days'), '88', 'single', 345, 14);

insert into invitation (uuid, email, create_dttm, accept_dttm, network_fk, invitation_dttm, role_fk, expire_dt, issuer_fk, type, organization_fk, group_fk) values ('aa8fb27b-8bfa-408d-a122-a5cc96c09248', '', now(), NULL, NULL, now(), '4', (CURRENT_DATE + interval '31 days'), '88', 'single', 345, 14);

insert into invitation (uuid, email, create_dttm, accept_dttm, network_fk, invitation_dttm, role_fk, expire_dt, issuer_fk, type, organization_fk, group_fk) values ('df0f6eef-0e3c-47f7-b4f9-a372ada4eb25', '', now(), NULL, NULL, now(), '5', (CURRENT_DATE + interval '31 days'), '88', 'single', 345, 14);

insert into invitation (uuid, email, create_dttm, accept_dttm, network_fk, invitation_dttm, role_fk, expire_dt, issuer_fk, type, organization_fk, group_fk) values ('dfd1fdb4-23ff-4934-a0ef-e6a38672f76d', '', now(), NULL, NULL, now(), '5', (CURRENT_DATE + interval '31 days'), '88', 'single', 345, 14);


-- invite and enroll more users - demo_email@northbridgetech.org

-- F. L. Hamer - admin
-- Marlyn Wescoff - admin
-- Jean E. Sammet
-- Erna Schneider

-- login as an admin and add meetings

-- add soft link to Util.php batch folder

-- set cron jobs

-- move redirect