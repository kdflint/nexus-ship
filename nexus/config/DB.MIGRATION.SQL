ALTER TABLE organization ADD COLUMN forum_user_group numeric;

-- populate above columns --- run below in DEV - what else??

-- remove CFCHT_FORUM_USER_GROUP, then

-- define("UAT_NETWORKS", "");

update organization set forum_user_group = 8 where id = 18

-- populate GROUP.forum_group_id

-- in PROD, tie groups 1, 25 to pUser???


-- Add a default community group for each network:
insert into public.group (name, create_dttm, activate_dttm, logo, uid) values ($1, now(), now(), '', $2) returning id

ALTER TABLE organization
   ADD COLUMN community_group_fk integer;
   
ALTER TABLE organization ADD CONSTRAINT organization_community_group_fk_fkey FOREIGN KEY (community_group_fk)
      REFERENCES public.group (id) MATCH SIMPLE

update organization set community_group_fk = --27 
where id = --376 

-- deactivate all custom profile fields except ours

-- set first, last to visible on memberlist (in db)
update phpbb_profile_fields set field_show_on_ml = 1 where field_id in (19,18)

-- forum - make sure ucp is enabled, and inside, profile and avatar
-- avatar file size

-- purge forum cache

-- make new directory, sibling of config nexus/include/directory/group-tables
-- define("INCL_ROOT"

-- retroact default network group

returned 29
insert into public.group (name, create_dttm, activate_dttm, logo, uid) values ('Network Group', now(), now(), '', 'a08808ad') returning id

returned 334
insert into public.user (uuid, username, fname, lname, email, status_fk, create_dttm, activate_dttm) values ('35a62ca5-341d-4997-bfa9-9571c7c4acb0', 'nUser-cfa975fd', 'Network', 'User', '', '1', now(), now()) returning id

insert into user_group (user_fk, group_fk, role_fk, create_dttm) values (334, 29, 5, now())

insert into user_organization (user_fk, organization_fk, grantor_fk, role_fk, create_dttm) values (334, 376, 296, 5, now()) returning id