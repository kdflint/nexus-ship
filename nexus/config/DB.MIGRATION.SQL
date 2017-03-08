ALTER TABLE organization
   ADD COLUMN public_global_invite_fk integer;
   
 ALTER TABLE organization
  ADD CONSTRAINT public_global_invite_fk_fkey FOREIGN KEY (public_global_invite_fk) REFERENCES invitation (id)
   ON UPDATE NO ACTION ON DELETE NO ACTION;
   
 update organization set public_global_invite_fk = 118 where id = 376


-- remove definition of EVENT_APPROVE_LIST

-- shut down Guest group search permission (Action on all forums that Guest can see) - DONE ALL

-- turn off announcement permission for Network groups - DONE ALL

