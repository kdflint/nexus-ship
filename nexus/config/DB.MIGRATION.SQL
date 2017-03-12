ALTER TABLE organization
   ADD COLUMN public_global_invite_fk integer;
   
 ALTER TABLE organization
  ADD CONSTRAINT public_global_invite_fk_fkey FOREIGN KEY (public_global_invite_fk) REFERENCES invitation (id)
   ON UPDATE NO ACTION ON DELETE NO ACTION;
   
 update organization set public_global_invite_fk = 118 where id = 376


-- remove definition of EVENT_APPROVE_LIST

-- shut down Guest group search permission (Action on all forums that Guest can see) - DONE ALL

-- turn off announcement permission for Network groups - DONE ALL

GRANT SELECT, INSERT, DELETE ON TABLE user_organization TO northbri_web;
GRANT SELECT, INSERT, DELETE ON TABLE user_group TO northbri_web;


make new directory partner/custom

copy over orgtype-18.html
move 18.html to partner/custom/orgfocus-18.html 

-- change the below relationship == 'god'
-- (local, this was organization_organization ids 2,355,357,362,365,367)
-- (dev: 1,18,339)

select id, organization_from_fk, organization_to_fk, relationship from organization_organization 
where organization_to_fk in (select organization_fk from organization_account where account_type = 'ADV')
and organization_from_fk = 13
and organization_to_fk != 13

update organization_organization set relationship = 'god' where id = 2;
update organization_organization set relationship = 'god' where id = 325;
update organization_organization set relationship = 'god' where id = 327;

--add network admins to all groups, like this:

select * from user_organization where organization_fk = 379
insert into user_group (user_fk, group_fk, role_fk) values (300,28,1)


