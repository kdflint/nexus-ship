insert into organization (name, create_dttm, activate_dttm, tax_exempt, status_fk, logo, uid) values ('North Stars', now(), now(), true, 1, '', '1c5b1ce5') returning id;

insert into organization_organization (organization_from_fk, organization_to_fk, relationship, create_dttm) values (13, 337, 'parent', now());

insert into public.group (name, create_dttm, activate_dttm, logo, uid) values ('North Stars', now(), now(), '', '06fdd481') returning id;

insert into invitation (uuid, email, create_dttm, accept_dttm, network_fk, invitation_dttm, role_fk, expire_dt, issuer_fk, type, organization_fk, group_fk) values ('330f7b16-b43f-4326-9993-08972f37b8f1', 'kathy.d.flint@northbridgetech.org', now(), NULL, NULL, now(), '4', (CURRENT_DATE + interval '31 days'), '88', 'single', 337, 6) returning uuid;

--http://nexus.northbridgetech.org/web/enroll?invitation=330f7b16-b43f-4326-9993-08972f37b8f1

insert into organization (name, create_dttm, activate_dttm, tax_exempt, status_fk, logo, uid) values ('PyselTongues', now(), now(), true, 1, '', '7c83535d') returning id;

insert into organization_organization (organization_from_fk, organization_to_fk, relationship, create_dttm) values (13, 338, 'parent', now());

insert into public.group (name, create_dttm, activate_dttm, logo, uid) values ('PyselTongues', now(), now(), '', '879d98c4') returning id;

insert into invitation (uuid, email, create_dttm, accept_dttm, network_fk, invitation_dttm, role_fk, expire_dt, issuer_fk, type, organization_fk, group_fk) values ('8a051780-89d9-45d7-8b3f-94644b8be65c', 'kathy.d.flint@northbridgetech.org', now(), NULL, NULL, now(), '4', (CURRENT_DATE + interval '31 days'), '88', 'single', 338, 7) returning uuid;

--http://nexus.northbridgetech.org/web/enroll?invitation=8a051780-89d9-45d7-8b3f-94644b8be65c

insert into organization (name, create_dttm, activate_dttm, tax_exempt, status_fk, logo, uid) values ('The Sunflower Foundation (Australia) Inc. &reg;', now(), now(), true, 1, 'src="image/partners/sunflower_foundation.jpg" height="126" width="120"', 'b02c54c9') returning id;

insert into organization_organization (organization_from_fk, organization_to_fk, relationship, create_dttm) values (13, 339, 'parent', now());

insert into public.group (name, create_dttm, activate_dttm, logo, uid) values ('The Sunflower Foundation (Australia) Inc. &reg;', now(), now(), '', 'ee7d37ee') returning id;

insert into invitation (uuid, email, create_dttm, accept_dttm, network_fk, invitation_dttm, role_fk, expire_dt, issuer_fk, type, organization_fk, group_fk) values ('39be9c2d-1a34-47c1-ad67-b2c2f368ca77', 'kpower@internode.on.net', now(), NULL, NULL, now(), '4', (CURRENT_DATE + interval '31 days'), '88', 'single', 339, 8) returning uuid;

--http://nexus.northbridgetech.org/web/enroll.php?invitation=39be9c2d-1a34-47c1-ad67-b2c2f368ca77

insert into organization (name, create_dttm, activate_dttm, tax_exempt, status_fk, logo, uid) values ('CALA (Community Activism Law Alliance)', now(), now(), true, 1, 'src="image/partners/cala_banner_resized.jpg" height="70" width="120"', 'c56aac3e') returning id;

insert into organization_organization (organization_from_fk, organization_to_fk, relationship, create_dttm) values (13, 340, 'parent', now());

insert into public.group (name, create_dttm, activate_dttm, logo, uid) values ('CALA (Community Activism Law Alliance)', now(), now(), '', '91f8b760') returning id;

insert into invitation (uuid, email, create_dttm, accept_dttm, network_fk, invitation_dttm, role_fk, expire_dt, issuer_fk, type, organization_fk, group_fk) values ('992f9523-e2ca-4955-b1a1-fb027456dba5', 'chad@calachicago.org', now(), NULL, NULL, now(), '4', (CURRENT_DATE + interval '31 days'), '88', 'single', 340, 9) returning uuid;

--http://nexus.northbridgetech.org/web/enroll.php?invitation=992f9523-e2ca-4955-b1a1-fb027456dba5

insert into organization (name, create_dttm, activate_dttm, tax_exempt, status_fk, logo, uid) values ('Ayuda', now(), now(), true, 1, 'src="image/partners/ayuda.png" height="97" width="120"', '29666a8b') returning id;

insert into organization_organization (organization_from_fk, organization_to_fk, relationship, create_dttm) values (13, 341, 'parent', now());

insert into public.group (name, create_dttm, activate_dttm, logo, uid) values ('Ayuda', now(), now(), '', '992e69b3') returning id;

insert into invitation (uuid, email, create_dttm, accept_dttm, network_fk, invitation_dttm, role_fk, expire_dt, issuer_fk, type, organization_fk, group_fk) values ('d3c978f3-0f21-4196-a1b1-e197d563798b', 'fatima@ayuda.com', now(), NULL, NULL, now(), '4', (CURRENT_DATE + interval '31 days'), '88', 'single', 341, 10) returning uuid;

--http://nexus.northbridgetech.org/web/enroll.php?invitation=d3c978f3-0f21-4196-a1b1-e197d563798b

insert into invitation (uuid, email, create_dttm, accept_dttm, network_fk, invitation_dttm, role_fk, expire_dt, issuer_fk, type, organization_fk, group_fk) values ('a5665e21-5c7a-4a1f-b13e-d4f44d61a208', 'ryan@ayuda.com', now(), NULL, NULL, now(), '4', (CURRENT_DATE + interval '31 days'), '88', 'single', 341, 10) returning uuid;

--http://nexus.northbridgetech.org/web/enroll.php?invitation=a5665e21-5c7a-4a1f-b13e-d4f44d61a208

insert into organization (name, create_dttm, activate_dttm, tax_exempt, status_fk, logo, uid) values ('World Trust', now(), now(), true, 1, 'src="image/partners/worldtrust.png" height="38" width="120"', '371d5aca') returning id;

insert into organization_organization (organization_from_fk, organization_to_fk, relationship, create_dttm) values (13, 342, 'parent', now());

insert into public.group (name, create_dttm, activate_dttm, logo, uid) values ('World Trust', now(), now(), '', '79588deb') returning id;

insert into invitation (uuid, email, create_dttm, accept_dttm, network_fk, invitation_dttm, role_fk, expire_dt, issuer_fk, type, organization_fk, group_fk) values ('85dc378a-75be-4690-9dae-92032309d8ff', 'dia.penning@gmail.com', now(), NULL, NULL, now(), '4', (CURRENT_DATE + interval '31 days'), '88', 'single', 342, 11) returning uuid;

--http://nexus.northbridgetech.org/web/enroll.php?invitation=85dc378a-75be-4690-9dae-92032309d8ff

insert into invitation (uuid, email, create_dttm, accept_dttm, network_fk, invitation_dttm, role_fk, expire_dt, issuer_fk, type, organization_fk, group_fk) values ('a504d04a-bfc0-4b83-9c72-a0154969650b', 'aimee@world-trust.org', now(), NULL, NULL, now(), '4', (CURRENT_DATE + interval '31 days'), '88', 'single', 342, 11) returning uuid;

--http://nexus.northbridgetech.org/web/enroll.php?invitation=a504d04a-bfc0-4b83-9c72-a0154969650b

insert into organization (name, create_dttm, activate_dttm, tax_exempt, status_fk, logo, uid) values ('People\'s Resource Center', now(), now(), true, 1, 'src="image/partners/prc_resized.jpg" height="83" width="120"', 'e4212fb4') returning id;

insert into organization_organization (organization_from_fk, organization_to_fk, relationship, create_dttm) values (13, 343, 'parent', now());

insert into public.group (name, create_dttm, activate_dttm, logo, uid) values ('People\'s Resource Center', now(), now(), '', '0f566250') returning id;

insert into invitation (uuid, email, create_dttm, accept_dttm, network_fk, invitation_dttm, role_fk, expire_dt, issuer_fk, type, organization_fk, group_fk) values ('d78ea568-974f-402a-a124-1fefd41111b9', 'slichtenwalter@peoplesrc.org', now(), NULL, NULL, now(), '4', (CURRENT_DATE + interval '31 days'), '88', 'single', 343, 12) returning uuid;

--http://nexus.northbridgetech.org/web/enroll.php?invitation=d78ea568-974f-402a-a124-1fefd41111b9

insert into invitation (uuid, email, create_dttm, accept_dttm, network_fk, invitation_dttm, role_fk, expire_dt, issuer_fk, type, organization_fk, group_fk) values ('31e5bbd1-784e-413b-991f-fc7e18fc2ddb', 'jvictor@peoplesrc.org', now(), NULL, NULL, now(), '4', (CURRENT_DATE + interval '31 days'), '88', 'single', 343, 12) returning uuid;

--http://nexus.northbridgetech.org/web/enroll.php?invitation=31e5bbd1-784e-413b-991f-fc7e18fc2ddb

insert into organization (name, create_dttm, activate_dttm, tax_exempt, status_fk, logo, uid) values ('Courage Campaign: CTA', now(), now(), true, 1, 'src="image/partners/courage_campaign.jpg" height="120" width="120"', '21c2c24d') returning id;

insert into organization_organization (organization_from_fk, organization_to_fk, relationship, create_dttm) values (13, 344, 'parent', now());

insert into public.group (name, create_dttm, activate_dttm, logo, uid) values ('Courage Campaign: CTA', now(), now(), '', 'e75c8938') returning id;

insert into invitation (uuid, email, create_dttm, accept_dttm, network_fk, invitation_dttm, role_fk, expire_dt, issuer_fk, type, organization_fk, group_fk) values ('e372feb8-65d7-4e24-b08f-02f705fbe796', 'lnolive2@Gmail.com', now(), NULL, NULL, now(), '4', (CURRENT_DATE + interval '31 days'), '88', 'single', 344, 13) returning uuid;

--http://nexus.northbridgetech.org/web/enroll.php?invitation=e372feb8-65d7-4e24-b08f-02f705fbe796

insert into invitation (uuid, email, create_dttm, accept_dttm, network_fk, invitation_dttm, role_fk, expire_dt, issuer_fk, type, organization_fk, group_fk) values ('13dcf104-6297-43d3-85b1-7e5127548c96', 'madelaine.obvi@gmail.com', now(), NULL, NULL, now(), '4', (CURRENT_DATE + interval '31 days'), '88', 'single', 344, 13) returning uuid;

--http://nexus.northbridgetech.org/web/enroll.php?invitation=13dcf104-6297-43d3-85b1-7e5127548c96

insert into organization (name, create_dttm, activate_dttm, tax_exempt, status_fk, logo, uid) values ('Mansfield Institute for Social Justice and Transformation', now(), now(), true, 1, 'src="image/partners/roosevelt_univ.png" height="40" width="120"', '1db72823') returning id;

insert into organization_organization (organization_from_fk, organization_to_fk, relationship, create_dttm) values (13, 346, 'parent', now());

insert into public.group (name, create_dttm, activate_dttm, logo, uid) values ('Mansfield Institute for Social Justice and Transformation', now(), now(), '', '5204e034') returning id;

insert into invitation (uuid, email, create_dttm, accept_dttm, network_fk, invitation_dttm, role_fk, expire_dt, issuer_fk, type, organization_fk, group_fk) values ('15694699-729a-4cc3-abc1-1d9a19771308', 'lharrington01@roosevelt.edu', now(), NULL, NULL, now(), '4', (CURRENT_DATE + interval '31 days'), '88', 'single', 346, 15) returning uuid;

--http://nexus.northbridgetech.org/web/enroll?invitation=15694699-729a-4cc3-abc1-1d9a19771308


insert into organization (name, create_dttm, activate_dttm, tax_exempt, status_fk, logo, uid) values ('Illinois Balanced and Restorative Justice Project', now(), now(), true, 1, 'ibarj.png', '0d3eb152') returning id;

insert into organization_organization (organization_from_fk, organization_to_fk, relationship, create_dttm) values (13, 349, 'parent', now());

insert into organization_account (organization_fk, account_type) values (349, 'NWM');

insert into public.group (name, create_dttm, activate_dttm, logo, uid) values ('Illinois Balanced and Restorative Justice Project', now(), now(), '', 'c80b25e5') returning id;

insert into invitation (uuid, email, create_dttm, accept_dttm, network_fk, invitation_dttm, role_fk, expire_dt, issuer_fk, type, organization_fk, group_fk) values ('7befdea3-56ed-4f6a-899d-f72448821527', 'sarab@ibarj.org', now(), NULL, NULL, now(), '4', (CURRENT_DATE + interval '31 days'), '88', 'single', 349, 17) returning uuid;

insert into public.user (uuid, username, fname, lname, email, status_fk, create_dttm, activate_dttm) values ('e3f1f53e-9bc5-4c1b-90c7-7c14dda0d34a', 'pUser-0d3eb152', 'Public', 'User', '', '1', now(), now()) returning id;

insert into user_group (user_fk, create_dttm, group_fk, role_fk) values (256, now(), 16, 4);

insert into user_organization (user_fk, organization_fk, grantor_fk, create_dttm, role_fk) values (256, 349, 88, now(), 4);

--http://nexus.northbridgetech.org/web/enroll?invitation=7befdea3-56ed-4f6a-899d-f72448821527


insert into organization (name, create_dttm, activate_dttm, tax_exempt, status_fk, logo, uid) values ('Northbridge Technology Alliance Board Room', now(), now(), true, 1, 'NB_sidewheel_square_120_rgb.jpg', 'b2c2c38c') returning id;

insert into organization_organization (organization_from_fk, organization_to_fk, relationship, create_dttm) values (13, 350, 'parent', now());

insert into organization_account (organization_fk, account_type) values (350, 'NWM');

insert into public.group (name, create_dttm, activate_dttm, logo, uid) values ('Northbridge Technology Alliance Board Room', now(), now(), '', '27b9f4a2') returning id;

insert into invitation (uuid, email, create_dttm, accept_dttm, network_fk, invitation_dttm, role_fk, expire_dt, issuer_fk, type, organization_fk, group_fk) values ('a45853cd-5dc6-4954-a4a4-dee5dbf05f5a', 'kathy.flint@northbridgetech.org', now(), NULL, NULL, now(), '4', (CURRENT_DATE + interval '31 days'), '88', 'single', 350, 19) returning uuid;

insert into public.user (uuid, username, fname, lname, email, status_fk, create_dttm, activate_dttm) values ('e89c7d13-3509-4bc0-a546-59c67e937fe0', 'pUser-b2c2c38c', 'Public', 'User', '', '1', now(), now()) returning id;

insert into user_group (user_fk, create_dttm, group_fk, role_fk) values (255, now(), 16, 4);

insert into user_organization (user_fk, organization_fk, grantor_fk, create_dttm, role_fk) values (255, 350, 88, now(), 4);

--http://nexus.northbridgetech.org/web/enroll?invitation=a45853cd-5dc6-4954-a4a4-dee5dbf05f5a


insert into organization (name, create_dttm, activate_dttm, tax_exempt, status_fk, logo, uid) values ('Crossroads Antiracism Organizing and Training', now(), now(), true, 1, 'crossroads.jpg', '0879ae0f') returning id;

insert into organization_organization (organization_from_fk, organization_to_fk, relationship, create_dttm) values (13, 351, 'parent', now());

insert into organization_account (organization_fk, account_type) values (351, 'NWM');

insert into public.group (name, create_dttm, activate_dttm, logo, uid) values ('Crossroads Antiracism Organizing and Training', now(), now(), '', '04c59c1d') returning id;

insert into invitation (uuid, email, create_dttm, accept_dttm, network_fk, invitation_dttm, role_fk, expire_dt, issuer_fk, type, organization_fk, group_fk) values ('c3fbda92-d3ed-41f8-bb40-0b3e7d2e07d1', 'karen.ziech@croar.org', now(), NULL, NULL, now(), '4', (CURRENT_DATE + interval '31 days'), '88', 'single', 351, 20) returning uuid;

insert into public.user (uuid, username, fname, lname, email, status_fk, create_dttm, activate_dttm) values ('b8869216-3cdc-429f-8fa7-138a5c1391ad', 'pUser-0879ae0f', 'Public', 'User', '', '1', now(), now()) returning id;

insert into user_group (user_fk, create_dttm, group_fk, role_fk) values (257, now(), 16, 4);

insert into user_organization (user_fk, organization_fk, grantor_fk, create_dttm, role_fk) values (257, 351, 88, now(), 4);

--http://nexus.northbridgetech.org/web/enroll?invitation=c3fbda92-d3ed-41f8-bb40-0b3e7d2e07d1


insert into organization (name, create_dttm, activate_dttm, tax_exempt, status_fk, logo, uid) values ('Episcopal Diocese of Chicago Hunger Committee', now(), now(), true, 1, 'edc_logo.png', '51fd21a1') returning id;

insert into organization_organization (organization_from_fk, organization_to_fk, relationship, create_dttm) values (13, 352, 'parent', now());

insert into organization_account (organization_fk, account_type) values (352, 'NWM');

insert into public.group (name, create_dttm, activate_dttm, logo, uid) values ('Episcopal Diocese of Chicago Hunger Committee', now(), now(), '', '754e159a') returning id;

insert into invitation (uuid, email, create_dttm, accept_dttm, network_fk, invitation_dttm, role_fk, expire_dt, issuer_fk, type, organization_fk, group_fk) values ('45241c03-2315-4e76-987b-9f2e4831d910', 'ndavis@episcopalchicago.org', now(), NULL, NULL, now(), '4', (CURRENT_DATE + interval '31 days'), '88', 'single', 352, 21) returning uuid;

insert into public.user (uuid, username, fname, lname, email, status_fk, create_dttm, activate_dttm) values ('ba55d95b-fb8b-48a2-8e20-61ca658411d7', 'pUser-51fd21a1', 'Public', 'User', '', '1', now(), now()) returning id;

insert into user_group (user_fk, create_dttm, group_fk, role_fk) values (258, now(), 16, 4);

insert into user_organization (user_fk, organization_fk, grantor_fk, create_dttm, role_fk) values (258, 352, 88, now(), 4);

--http://nexus.northbridgetech.org/web/enroll?invitation=45241c03-2315-4e76-987b-9f2e4831d910

-- CONVERT EDC ANTI-RACISM COMMISSION

change name of org id 19 and add uid = f4470d42

update organization_organization set organization_from_fk = 13 where id = 277

update organization_account set account_type = 'NWM' where id = 301

change name of group where id = 5

insert into public.user (uuid, username, fname, lname, email, status_fk, create_dttm, activate_dttm) values ('836bb228-b718-4172-9108-10380f44ddd1', 'pUser-f4470d42', 'Public', 'User', '', '1', now(), now()) returning id;

insert into user_group (user_fk, create_dttm, group_fk, role_fk) values (259, now(), 16, 4);

insert into user_organization (user_fk, organization_fk, grantor_fk, create_dttm, role_fk) values (259, 19, 88, now(), 4);
