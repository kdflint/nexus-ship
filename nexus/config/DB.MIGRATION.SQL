-- copy over orgtype, orgfocus files

-- double check ids, then:

insert into topic (id, name) values (42,'Race');
insert into topic (id, name) values (43,'Sex'); 
insert into topic (id, name) values (44,'National Origin');
insert into topic (id, name) values (45,'Gender');
insert into topic (id, name) values (46,'LGBTQ');
insert into topic (id, name) values (47,'Religion');
insert into topic (id, name) values (48,'School Desegregation');
insert into topic (id, name) values (49,'School Discipline');
insert into topic (id, name) values (50,'Multicultural Education');
insert into topic (id, name) values (51,'Social Justice');
insert into topic (id, name) values (52,'School Finance');
insert into topic (id, name) values (53,'Immigrant Rights in Education');
insert into topic (id, name) values (54,'English Language Learners');
insert into topic (id, name) values (55,'Bilingual Education');
insert into topic (id, name) values (56,'School Turnaround');
insert into topic (id, name) values (57,'Bullying and Harassment');
insert into topic (id, name) values (58,'Family Engagement');

GRANT ALL ON TABLE organization_topic_id_seq TO northbri_devnexus;
GRANT SELECT, UPDATE ON TABLE organization_topic_id_seq TO northbri_web;