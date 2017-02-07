== PHPBB

--Add custom profile fields

insert into phpbb_profile_fields 
  (field_name,
  field_type,
  field_ident,
  field_length,
  field_minlen,
  field_maxlen,
  field_validation,
  field_active,  
  field_order,
  field_show_on_vt,
  field_show_on_pm,
  field_is_contact)
values
  ('nexus_email','profilefields.type.string','nexus_email','100','0','100','.*',1,16,0,0,1);
  
 insert into phpbb_profile_fields 
  (field_name,
  field_type,
  field_ident,
  field_length,
  field_minlen,
  field_maxlen,
  field_validation,
  field_active,  
  field_order,
  field_show_on_vt,
  field_show_on_pm,
  field_is_contact)
values
  ('nexus_sms','profilefields.type.string','nexus_sms','20','0','20','.*',1,17,0,0,1);
  
 insert into phpbb_profile_fields 
  (field_name,
  field_type,
  field_ident,
  field_length,
  field_minlen,
  field_maxlen,
  field_validation,
  field_active,  
  field_order,
  field_show_on_vt,
  field_show_on_pm,
  field_is_contact)
values
  ('nexus_phone','profilefields.type.string','nexus_phone','20','0','20','.*',1,18,0,0,1);
  
 insert into phpbb_profile_fields 
  (field_name,
  field_type,
  field_ident,
  field_length,
  field_minlen,
  field_maxlen,
  field_validation,
  field_active,  
  field_order,
  field_show_on_vt,
  field_show_on_pm,
  field_is_contact)
values
  ('nexus_fname','profilefields.type.string','nexus_fname','20','0','20','.*',1,14,1,1,0);
  
 insert into phpbb_profile_fields 
  (field_name,
  field_type,
  field_ident,
  field_length,
  field_minlen,
  field_maxlen,
  field_validation,
  field_active,  
  field_order,
  field_show_on_vt,
  field_show_on_pm,
  field_is_contact)
values
  ('nexus_lname','profilefields.type.string','nexus_lname','20','0','20','.*',1,15,1,1,0);
  
 ALTER TABLE phpbb_profile_fields_data
   ADD COLUMN pf_nexus_fname character varying(255) DEFAULT '';
 ALTER TABLE phpbb_profile_fields_data
   ADD COLUMN pf_nexus_lname character varying(255) DEFAULT '';
 ALTER TABLE phpbb_profile_fields_data
   ADD COLUMN pf_nexus_email character varying(255) DEFAULT '';
 ALTER TABLE phpbb_profile_fields_data
   ADD COLUMN pf_nexus_phone character varying(255) DEFAULT '';
 ALTER TABLE phpbb_profile_fields_data
   ADD COLUMN pf_nexus_sms character varying(255) DEFAULT '';

insert into phpbb_profile_lang
	(field_id,
  lang_id,
  lang_name)
 values (18,1,'First');

insert into phpbb_profile_lang
	(field_id,
  lang_id,
  lang_name)
 values (19,1,'Last');
 
insert into phpbb_profile_lang
	(field_id,
  lang_id,
  lang_name)
 values (24,1,'Email');
 
insert into phpbb_profile_lang
	(field_id,
  lang_id,
  lang_name)
 values (25,1,'Cell/Text Number');

insert into phpbb_profile_lang
	(field_id,
  lang_id,
  lang_name)
 values (26,1,'Other Phone');


--import existing profile values

--deploy build

--purge forum cache


select 'update phpbb_profile_fields_data set pf_nexus_fname = ''' || fname || ''' where user_id = (select user_id from phpbb_users where username = ''' || username || ''');'
from public.user
where username not like 'pUser%'

select 'update phpbb_profile_fields_data set pf_nexus_lname = ''' || lname || ''' where user_id = (select user_id from phpbb_users where username = ''' || username || ''');'
from public.user
where username not like 'pUser%'

select 'update phpbb_profile_fields_data set pf_nexus_email = ''' || email || ''' where user_id = (select user_id from phpbb_users where username = ''' || username || ''');'
from public.user
where publish_email = 'TRUE'

select 'update phpbb_profile_fields_data set pf_nexus_sms = ''' || sms || ''' where user_id = (select user_id from phpbb_users where username = ''' || username || ''');'
from public.user
where publish_sms = 'TRUE'

select 'update phpbb_profile_fields_data set pf_nexus_phone = ''' || phone || ''' where user_id = (select user_id from phpbb_users where username = ''' || username || ''');'
from public.user
where publish_phone = 'TRUE'

select 'insert into phpbb_profile_fields_data (user_id) values (' || user_id || ')' from phpbb_users where user_id > 47

===============

insert into phpbb_profile_fields_data (user_id) values (48)
insert into phpbb_profile_fields_data (user_id) values (49)
insert into phpbb_profile_fields_data (user_id) values (51)
insert into phpbb_profile_fields_data (user_id) values (52)
insert into phpbb_profile_fields_data (user_id) values (53)
insert into phpbb_profile_fields_data (user_id) values (54)
insert into phpbb_profile_fields_data (user_id) values (55)
insert into phpbb_profile_fields_data (user_id) values (56)
insert into phpbb_profile_fields_data (user_id) values (57)
insert into phpbb_profile_fields_data (user_id) values (58)
insert into phpbb_profile_fields_data (user_id) values (59)
insert into phpbb_profile_fields_data (user_id) values (60)


update phpbb_profile_fields_data set pf_nexus_phone = 8668489224 where user_id = (select user_id from phpbb_users where username = 'kdfTest2');
update phpbb_profile_fields_data set pf_nexus_phone = 7734120657 where user_id = (select user_id from phpbb_users where username = 'kgctest1');
update phpbb_profile_fields_data set pf_nexus_phone = 2246286371 where user_id = (select user_id from phpbb_users where username = 'gesaylor');

update phpbb_profile_fields_data set pf_nexus_fname = 'Kathy' where user_id = (select user_id from phpbb_users where username = 'kdflint');
update phpbb_profile_fields_data set pf_nexus_fname = 'Kathy' where user_id = (select user_id from phpbb_users where username = 'admin');
update phpbb_profile_fields_data set pf_nexus_fname = 'lou' where user_id = (select user_id from phpbb_users where username = 'lou1');
update phpbb_profile_fields_data set pf_nexus_fname = 'kdf' where user_id = (select user_id from phpbb_users where username = 'kdfTest2');
update phpbb_profile_fields_data set pf_nexus_fname = 'Kenneth' where user_id = (select user_id from phpbb_users where username = 'kcavness');
update phpbb_profile_fields_data set pf_nexus_fname = 'Elizabeth' where user_id = (select user_id from phpbb_users where username = 'Elizabeth');
update phpbb_profile_fields_data set pf_nexus_fname = 'jj' where user_id = (select user_id from phpbb_users where username = 'jafar123');
update phpbb_profile_fields_data set pf_nexus_fname = 'kdf' where user_id = (select user_id from phpbb_users where username = 'kdfTest4');
update phpbb_profile_fields_data set pf_nexus_fname = 'Will' where user_id = (select user_id from phpbb_users where username = 'wja2000');
update phpbb_profile_fields_data set pf_nexus_fname = 'Kathy' where user_id = (select user_id from phpbb_users where username = 'demoUser3');
update phpbb_profile_fields_data set pf_nexus_fname = 'Kathy' where user_id = (select user_id from phpbb_users where username = 'Testing1');
update phpbb_profile_fields_data set pf_nexus_fname = 'Gretchen' where user_id = (select user_id from phpbb_users where username = 'gsaylor');
update phpbb_profile_fields_data set pf_nexus_fname = 'Kenneth' where user_id = (select user_id from phpbb_users where username = 'kennethtestx3');
update phpbb_profile_fields_data set pf_nexus_fname = 'Kenneth' where user_id = (select user_id from phpbb_users where username = 'kennethemptytest1');
update phpbb_profile_fields_data set pf_nexus_fname = 'KennethTest2' where user_id = (select user_id from phpbb_users where username = 'kennethtest2');
update phpbb_profile_fields_data set pf_nexus_fname = 'Kathy' where user_id = (select user_id from phpbb_users where username = 'sammydee');
update phpbb_profile_fields_data set pf_nexus_fname = 'Kenneth' where user_id = (select user_id from phpbb_users where username = 'kennethtest1');
update phpbb_profile_fields_data set pf_nexus_fname = 'KennethTest3' where user_id = (select user_id from phpbb_users where username = 'kennethtest3');
update phpbb_profile_fields_data set pf_nexus_fname = 'Kenneth' where user_id = (select user_id from phpbb_users where username = 'kennethtestx1');
update phpbb_profile_fields_data set pf_nexus_fname = 'Kenneth' where user_id = (select user_id from phpbb_users where username = 'kennethtestx2');
update phpbb_profile_fields_data set pf_nexus_fname = 'Gretchen' where user_id = (select user_id from phpbb_users where username = 'gmanthey');
update phpbb_profile_fields_data set pf_nexus_fname = 'Kenneth' where user_id = (select user_id from phpbb_users where username = 'kennethoid1');
update phpbb_profile_fields_data set pf_nexus_fname = 'Kenneth' where user_id = (select user_id from phpbb_users where username = 'kennethtestreturn1');
update phpbb_profile_fields_data set pf_nexus_fname = 'Kathy' where user_id = (select user_id from phpbb_users where username = 'asdfo;inqef');
update phpbb_profile_fields_data set pf_nexus_fname = 'Joe' where user_id = (select user_id from phpbb_users where username = 'joeTest1');
update phpbb_profile_fields_data set pf_nexus_fname = 'Joe' where user_id = (select user_id from phpbb_users where username = 'joeFlint');
update phpbb_profile_fields_data set pf_nexus_fname = 'Kathy' where user_id = (select user_id from phpbb_users where username = 'kdfTest3');
update phpbb_profile_fields_data set pf_nexus_fname = 'Dev' where user_id = (select user_id from phpbb_users where username = 'kdfTestTO');
update phpbb_profile_fields_data set pf_nexus_fname = 'TO' where user_id = (select user_id from phpbb_users where username = 'kdfTestTO2');
update phpbb_profile_fields_data set pf_nexus_fname = 'SF' where user_id = (select user_id from phpbb_users where username = 'kdfTestSF1');
update phpbb_profile_fields_data set pf_nexus_fname = 'SF11' where user_id = (select user_id from phpbb_users where username = 'kdfTestSF11');
update phpbb_profile_fields_data set pf_nexus_fname = 'SF10' where user_id = (select user_id from phpbb_users where username = 'kdfTestSF10');
update phpbb_profile_fields_data set pf_nexus_fname = 'SF6' where user_id = (select user_id from phpbb_users where username = 'kdfTestSF6');
update phpbb_profile_fields_data set pf_nexus_fname = 'SF7' where user_id = (select user_id from phpbb_users where username = 'kdfTestSF7');
update phpbb_profile_fields_data set pf_nexus_fname = 'SF16' where user_id = (select user_id from phpbb_users where username = 'kdfTestSF16');
update phpbb_profile_fields_data set pf_nexus_fname = 'SF13' where user_id = (select user_id from phpbb_users where username = 'kdfTestSF13');
update phpbb_profile_fields_data set pf_nexus_fname = 'SF8' where user_id = (select user_id from phpbb_users where username = 'kdfTestSF8');
update phpbb_profile_fields_data set pf_nexus_fname = 'SF9' where user_id = (select user_id from phpbb_users where username = 'kdfTestSF9');
update phpbb_profile_fields_data set pf_nexus_fname = 'SF2' where user_id = (select user_id from phpbb_users where username = 'kdfTestSF2');
update phpbb_profile_fields_data set pf_nexus_fname = 'SF15' where user_id = (select user_id from phpbb_users where username = 'kdfTestSF15');
update phpbb_profile_fields_data set pf_nexus_fname = 'SF14' where user_id = (select user_id from phpbb_users where username = 'kdfTestSF14');
update phpbb_profile_fields_data set pf_nexus_fname = 'SF15' where user_id = (select user_id from phpbb_users where username = 'kdfTest15');
update phpbb_profile_fields_data set pf_nexus_fname = 'SF20' where user_id = (select user_id from phpbb_users where username = 'kdfTestSF20');
update phpbb_profile_fields_data set pf_nexus_fname = 'SF17' where user_id = (select user_id from phpbb_users where username = 'kdfTestSF17');
update phpbb_profile_fields_data set pf_nexus_fname = 'SF19' where user_id = (select user_id from phpbb_users where username = 'kdfTestSF19');
update phpbb_profile_fields_data set pf_nexus_fname = 'SF21' where user_id = (select user_id from phpbb_users where username = 'kdfTestSF21');
update phpbb_profile_fields_data set pf_nexus_fname = 'SF21' where user_id = (select user_id from phpbb_users where username = 'kdfTestSF22');
update phpbb_profile_fields_data set pf_nexus_fname = 'Dev' where user_id = (select user_id from phpbb_users where username = 'kdfTestTO1');
update phpbb_profile_fields_data set pf_nexus_fname = 'Shannon' where user_id = (select user_id from phpbb_users where username = 'shannon313');
update phpbb_profile_fields_data set pf_nexus_fname = 'SF23' where user_id = (select user_id from phpbb_users where username = 'kdfTestSF23');
update phpbb_profile_fields_data set pf_nexus_fname = 'F. L.' where user_id = (select user_id from phpbb_users where username = 'flhamer');
update phpbb_profile_fields_data set pf_nexus_fname = 'Marlyn' where user_id = (select user_id from phpbb_users where username = 'marlynwescoff');
update phpbb_profile_fields_data set pf_nexus_fname = 'Jean E' where user_id = (select user_id from phpbb_users where username = 'jeanesammet');
update phpbb_profile_fields_data set pf_nexus_fname = 'Erna' where user_id = (select user_id from phpbb_users where username = 'ernaschneider');
update phpbb_profile_fields_data set pf_nexus_fname = 'ZeeGretchenIsAwesome' where user_id = (select user_id from phpbb_users where username = 'Grrrretchen');
update phpbb_profile_fields_data set pf_nexus_fname = 'SixteenCharacter' where user_id = (select user_id from phpbb_users where username = 'kennethlong2');
update phpbb_profile_fields_data set pf_nexus_fname = 'Test U' where user_id = (select user_id from phpbb_users where username = 'testuser1');
update phpbb_profile_fields_data set pf_nexus_fname = 'Kenneth' where user_id = (select user_id from phpbb_users where username = 'fifteencharacte');
update phpbb_profile_fields_data set pf_nexus_fname = 'Kathy' where user_id = (select user_id from phpbb_users where username = 'demoUser39');
update phpbb_profile_fields_data set pf_nexus_fname = 'FifteenCharacte' where user_id = (select user_id from phpbb_users where username = 'kennethlong1');
update phpbb_profile_fields_data set pf_nexus_fname = 'SaylorGrr' where user_id = (select user_id from phpbb_users where username = 'gretchie');
update phpbb_profile_fields_data set pf_nexus_fname = 'GretchenIsAwesome' where user_id = (select user_id from phpbb_users where username = 'Grrrrrretchen');
update phpbb_profile_fields_data set pf_nexus_fname = 'aaNot' where user_id = (select user_id from phpbb_users where username = 'userdemo');
update phpbb_profile_fields_data set pf_nexus_fname = 'GretchenIsAwesome' where user_id = (select user_id from phpbb_users where username = 'Grrretchen');
update phpbb_profile_fields_data set pf_nexus_fname = 'KennethTestLast1' where user_id = (select user_id from phpbb_users where username = 'KennethTestLast1');
update phpbb_profile_fields_data set pf_nexus_fname = 'Test' where user_id = (select user_id from phpbb_users where username = 'kdfTest88');
update phpbb_profile_fields_data set pf_nexus_fname = 'Regression ' where user_id = (select user_id from phpbb_users where username = 'kdfTest19');
update phpbb_profile_fields_data set pf_nexus_fname = 'Testy' where user_id = (select user_id from phpbb_users where username = 'kdfTest49');
update phpbb_profile_fields_data set pf_nexus_fname = 'Kathy-79' where user_id = (select user_id from phpbb_users where username = 'kdfTest79');
update phpbb_profile_fields_data set pf_nexus_fname = 'Kathy' where user_id = (select user_id from phpbb_users where username = 'kdfTest77');
update phpbb_profile_fields_data set pf_nexus_fname = 'Kathy' where user_id = (select user_id from phpbb_users where username = 'sdfghjk');
update phpbb_profile_fields_data set pf_nexus_fname = 'Kathy' where user_id = (select user_id from phpbb_users where username = 'kdfTest42');
update phpbb_profile_fields_data set pf_nexus_fname = 'Forum' where user_id = (select user_id from phpbb_users where username = 'forumTest');
update phpbb_profile_fields_data set pf_nexus_fname = 'Gretchen' where user_id = (select user_id from phpbb_users where username = 'gretchensaylor');
update phpbb_profile_fields_data set pf_nexus_fname = 'Kathy-Enroll' where user_id = (select user_id from phpbb_users where username = 'groupEnrollTest');
update phpbb_profile_fields_data set pf_nexus_fname = 'Kathy-78' where user_id = (select user_id from phpbb_users where username = 'kdfTest78');
update phpbb_profile_fields_data set pf_nexus_fname = 'Kathy-Enroll' where user_id = (select user_id from phpbb_users where username = 'kdfTesEnroll');
update phpbb_profile_fields_data set pf_nexus_fname = 'Kathy-enroll' where user_id = (select user_id from phpbb_users where username = 'kdfTestEnroll');
update phpbb_profile_fields_data set pf_nexus_fname = 'Test' where user_id = (select user_id from phpbb_users where username = 'kdfTest99');
update phpbb_profile_fields_data set pf_nexus_fname = 'Kathy-nwm' where user_id = (select user_id from phpbb_users where username = 'kdfNwmTest');
update phpbb_profile_fields_data set pf_nexus_fname = 'Kathy' where user_id = (select user_id from phpbb_users where username = 'kdfTestAdv');
update phpbb_profile_fields_data set pf_nexus_fname = 'Kathy-enroll2' where user_id = (select user_id from phpbb_users where username = 'kdfTestEnroll2');
update phpbb_profile_fields_data set pf_nexus_fname = 'Kathy-e3' where user_id = (select user_id from phpbb_users where username = 'kdfTestEnroll3');
update phpbb_profile_fields_data set pf_nexus_fname = 'Kathy-e4' where user_id = (select user_id from phpbb_users where username = 'kdfTestE4');
update phpbb_profile_fields_data set pf_nexus_fname = 'Kathy-e5' where user_id = (select user_id from phpbb_users where username = 'kdfTestE5');
update phpbb_profile_fields_data set pf_nexus_fname = 'Kathy-e6' where user_id = (select user_id from phpbb_users where username = 'kdfTestE6');
update phpbb_profile_fields_data set pf_nexus_fname = 'Kenneth' where user_id = (select user_id from phpbb_users where username = 'kgctest1');
update phpbb_profile_fields_data set pf_nexus_fname = 'Lou' where user_id = (select user_id from phpbb_users where username = 'lou1234');
update phpbb_profile_fields_data set pf_nexus_fname = 'Gretchen' where user_id = (select user_id from phpbb_users where username = 'gesaylor');
