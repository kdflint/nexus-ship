ALTER TABLE organization ADD COLUMN forum_user_group numeric;

-- populate above columns

update organization set forum_user_group = 8 where id = 18

-- populate GROUP.forum_group_id

-- remove CFCHT_FORUM_USER_GROUP

-- in PROD, tie groups 1, 25 to pUser