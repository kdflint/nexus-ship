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
  ("nexus_email","profilefields.type.string","nexus_email","100","0","100",".*",1,16,0,0,1);
  
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
  ("nexus_sms","profilefields.type.string","nexus_text","20","0","20","","",".*",1,17,0,0,1);
  
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
  ("nexus_phone","profilefields.type.string","nexus_phone","20","0","20","","",".*",1,18,0,0,1);
  
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
  ("nexus_fname","profilefields.type.string","nexus_fname","20","0","20","","",".*",1,14,1,1,0);
  
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
  ("nexus_lname","profilefields.type.string","nexus_lname","20","0","20","","",".*",1,15,1,1,0);
  
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
  option_id)
 values (18,1,"First");

insert into phpbb_profile_lang
	(field_id,
  lang_id,
  option_id)
 values (19,1,"Last");
 
insert into phpbb_profile_lang
	(field_id,
  lang_id,
  option_id)
 values (24,1,"Email");
 
insert into phpbb_profile_lang
	(field_id,
  lang_id,
  option_id)
 values (25,1,"Cell/Text Number");

insert into phpbb_profile_lang
	(field_id,
  lang_id,
  option_id)
 values (26,1,"Other Phone");


--PM settings
--import existing profile values