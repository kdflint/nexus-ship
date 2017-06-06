GRANT ALL ON TABLE program_id_seq TO northbri_devnexus;
GRANT SELECT, UPDATE ON TABLE program_id_seq TO northbri_web;

GRANT ALL ON TABLE organization_program_id_seq TO northbri_devnexus;
GRANT SELECT, UPDATE ON TABLE organization_program_id_seq TO northbri_web;

ALTER TABLE program ALTER COLUMN description DROP NOT NULL;
ALTER TABLE program ALTER COLUMN name DROP NOT NULL;