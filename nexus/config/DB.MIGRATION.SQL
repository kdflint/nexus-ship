
GRANT SELECT, UPDATE ON TABLE contact_id_seq TO northbri_web;
GRANT SELECT, UPDATE ON TABLE organization_contact_id_seq TO northbri_web;
GRANT SELECT, UPDATE ON TABLE location_id_seq TO northbri_web;
GRANT SELECT, UPDATE ON TABLE organization_location_id_seq TO northbri_web;

alter table public.location add column g_placeid varchar(300);
alter table public.location add column g_formatted_address varchar(200);
alter table public.location add column neighborhood varchar(100);

--config file changes
-- define("GOOGLE_API_KEY", "AIzaSyD-tLX5TYQhwxQQNx5-UF0VajixUwGGkJQ");

-- move states.js over to config folder

-- copy over directory/views/include from last deploy - this is a defect
	
	
