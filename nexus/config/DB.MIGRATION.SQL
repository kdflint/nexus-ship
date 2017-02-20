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

-- purge forum cache