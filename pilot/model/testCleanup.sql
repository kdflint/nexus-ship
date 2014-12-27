delete from user_session where user_fk = 235
delete from user_group where user_fk = 235
delete from user_organization where user_fk = 235
delete from forum_user where user_fk = 235
delete from message_recipient where recipient_fk = 235
delete from message where sender_fk = 235
delete from user_password where user_fk = 235
delete from public.user where id = 235

delete from organization_organization where organization_to_fk = 286
delete from organization where id = 286

also, clean up from forums

also, clean up from calendar: /module/calendar/delete.php