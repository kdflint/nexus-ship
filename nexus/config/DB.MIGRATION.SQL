
group = 9
public forums = 15
community forums = 14

--- above is for IDRA onboarding

--- below for pm messaging

ALTER TABLE forum_poll
   ADD COLUMN pm_last_poll_dttm timestamp with time zone;
