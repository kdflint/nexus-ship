copy image and determine dimensions: web/image

insert into organization (name, create_dttm, activate_dttm, tax_exempt, status_fk, logo, uid) values ('The Demo Organization', now(), now(), true, 1, 'src="image/demo.jpg" height="120" width="120"', '12345678') returning id;

insert into organization_organization (organization_from_fk, organization_to_fk, relationship, create_dttm) values (13, 331, 'parent', now());

--https://www.uuidgenerator.net

insert into public.group (name, create_dttm, activate_dttm, logo, uid) values ('The Sunflower Foundation (Australia) Inc.', now(), now(), '', '54fc6c40') returning id;

insert into invitation (uuid, email, create_dttm, accept_dttm, network_fk, invitation_dttm, role_fk, expire_dt, issuer_fk, type, organization_fk, group_fk) values ('43afb3cd-31b5-477e-b636-945d88a8a9d9', 'angelica.c.flint@gmail.com', now(), NULL, NULL, now(), '4', (CURRENT_DATE + interval '31 days'), '85', 'single', 332, 10) returning uuid;

-- Send them to url
-- http://northbridgetech.org/dev/new_nexus/web/enroll.php?invitation=a42f29df-4205-41a6-b591-c03bf57e3592

