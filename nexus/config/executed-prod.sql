ALTER TABLE organization ADD COLUMN forum_user_group numeric;

-- remove CFCHT_FORUM_USER_GROUP, then
update organization set forum_user_group = 8 where id = 18

update organization set uid = '99999999' where id = 13

insert into organization_organization (organization_to_fk, organization_from_fk, relationship) values (13,13,'parent');
insert into organization_organization (organization_to_fk, organization_from_fk, relationship) values (1,1,'parent');

delete from organization_account where account_type = 'ADV' and organization_fk not in (1,18,13)

insert into organization_organization (organization_from_fk, organization_to_fk, relationship) values (13,18,'parent');
insert into organization_organization (organization_from_fk, organization_to_fk, relationship) values (13,1,'parent');

-- in PROD, tie groups 1, 25 to pUser


-- make new directory, sibling of config nexus/include/directory/group-tables
-- define("INCL_ROOT"

-- forum - make sure ucp profile is enabled, and inside, profile and avatar
-- avatar file size = 0
-- deactivate all custom profile fields except ours
-- set first, last to visible on memberlist (in db)
update phpbb_profile_fields set field_show_on_ml = 1 where field_id in (18,17)

-- Add a default community group for each network:
ALTER TABLE organization
   ADD COLUMN community_group_fk integer;
   
ALTER TABLE organization ADD CONSTRAINT organization_community_group_fk_fkey FOREIGN KEY (community_group_fk)
      REFERENCES public.group (id) MATCH SIMPLE

insert into public.group (name, create_dttm, activate_dttm, logo, uid) values ('The Center for Faith and Community Health Transformation', now(), now(), '', '22f3b8e3') returning id

update organization set community_group_fk = 26 where id = 18

-- Create network group (similar to public group)
returned 27
insert into public.group (name, create_dttm, activate_dttm, logo, uid) values ('Network Group', now(), now(), '', 'a09909ad') returning id

returned 288
insert into public.user (uuid, username, fname, lname, email, status_fk, create_dttm, activate_dttm) values ('bb8858eb-0512-49f8-acaa-7ef7f43971d4', 'nUser-ed787a92', 'Network', 'User', '', '1', now(), now()) returning id

insert into user_group (user_fk, group_fk, role_fk, create_dttm) values (288, 27, 5, now())

insert into user_organization (user_fk, organization_fk, grantor_fk, role_fk, create_dttm) values (288, 18, 88, 5, now()) returning id


