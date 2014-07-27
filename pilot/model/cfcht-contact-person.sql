-- clean funny characters
-- spot check
-- move titles down
-- strip "Primary Contact"
-- add insert into set contact_fk = (select max(id) from contact)) person where name = ''

-- &acirc;&euro;&trade; => '
-- &acirc;&euro;" => -
-- &amp; => and

-- 30th Ward - St. James Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = '30th Ward - St. James Church'), (select max(id) from contact));
-- A Just Harvest
insert into contact (name) values ('Primary Contact Person: Rev. Marilyn Pagan Banks');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'A Just Harvest'), (select max(id) from contact));
-- Access Living
insert into contact (name) values ('Primary Contact: Ms. Rahnee Patrick');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'http://www.accessliving.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Access Living'), (select max(id) from contact));
-- Adalberto Memorial United Methodist Church
insert into contact (name) values ('');
update contact set phone = '773-782-8464', email = 'null', fax = 'null', url = 'http://www.familialatinaunida.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Adalberto Memorial United Methodist Church'), (select max(id) from contact));
-- Advocate Christ Medical Center
insert into contact (name) values ('Primary Contact Person: Corky DeBoer, Manager of Spiritual Services');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Advocate Christ Medical Center'), (select max(id) from contact));
-- Advocate Clinical Pastoral Education
insert into contact (name) values ('Primary Contact Person: Darlene Zec');
update contact set phone = 'null', email = 'darlene.zec@advocatehealth.com', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Advocate Clinical Pastoral Education'), (select max(id) from contact));
-- Advocate Health Care
insert into contact (name) values ('Primary Contact Person: Rev. Bonnie Condon');
update contact set phone = '630-572-9393', email = 'null', fax = 'null', url = 'http://www.advocatehealth.com/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Advocate Health Care'), (select max(id) from contact));
-- Advocate Parish Nurse Ministry
insert into contact (name) values ('Primary Contact Person: Nancy Durbin Director, Parish Nurse Ministry');
update contact set phone = '847-384-3749', email = 'nancy.durbin@advocatehealth.com', fax = '847-696-0239', url = 'http://www.advocatehealth.com/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Advocate Parish Nurse Ministry'), (select max(id) from contact));
-- Advocate United Church of Christ
insert into contact (name) values ('Primary Contact Person: Minister Chris Church');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Advocate United Church of Christ'), (select max(id) from contact));
-- African Community United Methodist Church
insert into contact (name) values ('Primary Contact Person: Rev. Amos Olidapo');
update contact set phone = '773-262-7881', email = 'pastor@africancommunityumc.org', fax = 'null', url = 'http://www.africancommunityumc.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'African Community United Methodist Church'), (select max(id) from contact));
-- African-American Alzheimer&acirc;&euro;&trade;s Outreach Initiative
insert into contact (name) values ('Primary Contact Person: Beverly Kimmons');
update contact set phone = '847-933-2413', email = 'beverly.kimmons@alz.org', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'African-American Alzheimer&acirc;&euro;&trade;s Outreach Initiative'), (select max(id) from contact));
-- Agape Family Life Center
insert into contact (name) values ('');
update contact set phone = '773-416-7328', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Agape Family Life Center'), (select max(id) from contact));
-- Age Options
insert into contact (name) values ('Primary Contact Person: Ms. Lisa Blechschmidt');
update contact set phone = '708-383-0258', email = 'kim.blechschmidt@ageoptions.org', fax = 'null', url = 'http://www.ageoptions.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Age Options'), (select max(id) from contact));
-- Alexian Brothers Parish Services
insert into contact (name) values ('Primary Contact Person: Rita Tippentrop, Assistant Director');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'http://www.alexianbrothershealth.org/parishservices' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Alexian Brothers Parish Services'), (select max(id) from contact));
-- Alzheimer's Association &acirc;&euro;" Greater Illinois Chapter
insert into contact (name) values ('');
update contact set phone = '847-933-2413', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Alzheimer's Association &acirc;&euro;" Greater Illinois Chapter'), (select max(id) from contact));
-- Am I My Brothers Keeper
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Am I My Brothers Keeper'), (select max(id) from contact));
-- American Cancer Society, Chicago Region
insert into contact (name) values ('');
update contact set phone = '800-227-2345', email = 'null', fax = 'null', url = 'http://www.cancer.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'American Cancer Society, Chicago Region'), (select max(id) from contact));
-- American Heart Association Cultural Health Initiatives
insert into contact (name) values ('Primary Contact Person: Debra Davis, Director of Cultural Health Initiatives');
update contact set phone = '312-476-6619', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'American Heart Association Cultural Health Initiatives'), (select max(id) from contact));
-- American Kidney Fund
insert into contact (name) values ('');
update contact set phone = '312-224-8172', email = 'null', fax = '312-238-9464', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'American Kidney Fund'), (select max(id) from contact));
-- Antioch Telegu Church
insert into contact (name) values ('Primary Contact Person: Rev. David Sagar');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'http://www.antiochteleguchurch.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Antioch Telegu Church'), (select max(id) from contact));
-- Apostolic Church of God
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Apostolic Church of God'), (select max(id) from contact));
-- Apostolic Faith Church Health Professions Ministry
insert into contact (name) values ('Primary Contact Person: Geraldine Peacock, Health Ministry Coordinator');
update contact set phone = '773-373-8500', email = 'sistuhgsp@yahoo.com', fax = '312-864-9007', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Apostolic Faith Church Health Professions Ministry'), (select max(id) from contact));
-- B&acirc;&euro;&trade;nai Yehuda Beth Shalom
insert into contact (name) values ('Primary Contact Person: Rabbi Ellen Dreyfus');
update contact set phone = '708-799-4110', email = 'rabbi@bybs.org', fax = 'null', url = 'http://www.bybs.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'B&acirc;&euro;&trade;nai Yehuda Beth Shalom'), (select max(id) from contact));
-- Beacon Light
insert into contact (name) values ('Primary Contact Person: Cynthia Johnson, Pastor');
update contact set phone = '773-522-4812', email = 'revcwj2000@sbcglobal.net', fax = '773-522-4812', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Beacon Light'), (select max(id) from contact));
-- Bethel Reform Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Bethel Reform Church'), (select max(id) from contact));
-- Bikur Cholim (visiting the sick) training
insert into contact (name) values ('Primary Contact Person: Tracey Kite Director, Jewish Healing Network of Chicago');
update contact set phone = '847-568-5216', email = 'TraceyKite@jcfs.org', fax = '547-568-5100', url = 'http://www.jcfs.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Bikur Cholim (visiting the sick) training'), (select max(id) from contact));
-- Breast Cancer Network of Strength
insert into contact (name) values ('');
update contact set phone = '312-364-9071', email = 'null', fax = '312-364-9066', url = 'http://www.networkofstrength.org/illinois' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Breast Cancer Network of Strength'), (select max(id) from contact));
-- Buddhist International Tzu Chi Relief Foundation (Midwest)
insert into contact (name) values ('Primary Contact Person: Ms. Yahmei Hsieh');
update contact set phone = '630-963-6601', email = 'yahmeihsieh@gmail.com', fax = 'null', url = 'http://www.us.tzuchi.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Buddhist International Tzu Chi Relief Foundation (Midwest)'), (select max(id) from contact));
-- Campaign for Better Health Care
insert into contact (name) values ('Primary Contact Person: Laura Leon, Director of Faith Initiatives');
update contact set phone = '312-913-9449', email = 'faithcaucus@cbhconline.org', fax = '312-913-9559', url = 'http://www.cbhconline.org/faith' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Campaign for Better Health Care'), (select max(id) from contact));
-- Caring for Health
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Caring for Health'), (select max(id) from contact));
-- CARRI (Chicago Area Regional Recovery Initiative)
insert into contact (name) values ('Primary Contact Person: Rev. Dave Roth');
update contact set phone = '708-488-5581', email = 'dave_roth@lcfs.org', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'CARRI (Chicago Area Regional Recovery Initiative)'), (select max(id) from contact));
-- Center for Faith and Health
insert into contact (name) values ('Primary Contact: Mary Chase-Ziolek, PhD, RN Director, Professor of Health Ministries');
update contact set phone = '773-244-6201', email = 'null', fax = '773-244-6244', url = 'http://www.northpark.edu/sem/academics/faculty/mchasez.html' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Center for Faith and Health'), (select max(id) from contact));
-- Central Spanish Baptist Church
insert into contact (name) values ('Primary Contact Person: Rev. Shakespeare Osorio');
update contact set phone = '773-342-0836', email = 'pastor@iglesiabautistacentral.org', fax = 'null', url = 'http://www.iglesiabautistacentral.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Central Spanish Baptist Church'), (select max(id) from contact));
-- Chicago Chin Baptist Church
insert into contact (name) values ('Primary Contact Person: Pastor Danny Bawi Thianhlun');
update contact set phone = '773-603-3263', email = 'chicagochinbaptistchurch@gmail.com', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Chicago Chin Baptist Church'), (select max(id) from contact));
-- Chicago Theological Seminary
insert into contact (name) values ('');
update contact set phone = 'null', email = 'dderylak@ctschicago.edu', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Chicago Theological Seminary'), (select max(id) from contact));
-- Chicago Uptown Ministry
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Chicago Uptown Ministry'), (select max(id) from contact));
-- Chinmaya Mission Chicago-Badri
insert into contact (name) values ('Primary Contact Person: Mr. Shanker Pillai');
update contact set phone = '630-653-3370', email = 'pillaishanker@gmail.com', fax = 'null', url = 'http://www.mychinmaya.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Chinmaya Mission Chicago-Badri'), (select max(id) from contact));
-- Christ Temple Apostolic Faith Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Christ Temple Apostolic Faith Church'), (select max(id) from contact));
-- Christ the King Lutheran Church ELCA
insert into contact (name) values ('Primary Contact Person: Sandra Guy, Leadership team member');
update contact set phone = '312-939-3720', email = 'sguy178525@aol.com', fax = '312-321-3027', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Christ the King Lutheran Church ELCA'), (select max(id) from contact));
-- Christian Churches Caring
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Christian Churches Caring'), (select max(id) from contact));
-- Christian Fellowship Flock
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Christian Fellowship Flock'), (select max(id) from contact));
-- Church of Jesus Christ Latter Day Saints
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Church of Jesus Christ Latter Day Saints'), (select max(id) from contact));
-- Coalition for Quality and Patient Safety of Chicagoland
insert into contact (name) values ('Primary Contact Person: Marty Hatlie, CEO');
update contact set phone = '312-906-6196', email = 'null', fax = '312-906-6123', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Coalition for Quality and Patient Safety of Chicagoland'), (select max(id) from contact));
-- Community Health Services and Health Promotion
insert into contact (name) values ('Primary Contact Person: Bette Lawrence Water, Program Manager');
update contact set phone = '630-682-7979', email = 'blwater@dupagehealth.org', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Community Health Services and Health Promotion'), (select max(id) from contact));
-- Community-Outreach Project
insert into contact (name) values ('Primary Contact Person: Michele Ariyo');
update contact set phone = '773-473-4100', email = 'MAriyo@cityforce.org', fax = '773-473-4200', url = 'http://www.ilfba.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Community-Outreach Project'), (select max(id) from contact));
-- Congregational Health Partnerships
insert into contact (name) values ('Primary Contact Person: Rev. Kirsten Peachey');
update contact set phone = '847-384-3552', email = 'kirsten.peachey@advocatehealth.com', fax = '847-696-0239', url = 'http://www.advocatehealth.com/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Congregational Health Partnerships'), (select max(id) from contact));
-- Congregational Outreach
insert into contact (name) values ('');
update contact set phone = '312-733-4640', email = 'veronica@faithinplace.org', fax = '312-733-4610', url = 'http://faithinplace.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Congregational Outreach'), (select max(id) from contact));
-- Congregational United Church of Christ of Arlington Heights
insert into contact (name) values ('Primary Contact Person: Pastor Rex Piercy');
update contact set phone = 'null', email = 'pastorcucc@sbcglobal.net', fax = 'null', url = 'http://www.congucc.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Congregational United Church of Christ of Arlington Heights'), (select max(id) from contact));
-- Consortium to Lower Obesity in Chicago Children (CLOCC)
insert into contact (name) values ('Primary Contact Person: Rev. James Kenady, Lead Community Liaison');
update contact set phone = '312-573-7749', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Consortium to Lower Obesity in Chicago Children (CLOCC)'), (select max(id) from contact));
-- Cornerstone Community Outreach
insert into contact (name) values ('Primary Contact Person: Ms. Sandy Ramsey');
update contact set phone = '773-506-6396', email = 'sramsey@jpusa.org', fax = 'null', url = 'http://www.ccolife.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Cornerstone Community Outreach'), (select max(id) from contact));
-- Council of Islamic Organizations of Greater Chicago
insert into contact (name) values ('Primary Contact Person: Ms. Ahlam Jbara');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'http://www.ciogc.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Council of Islamic Organizations of Greater Chicago'), (select max(id) from contact));
-- Delegate Church Association of Advocate BroMenn Medical Center
insert into contact (name) values ('Primary Contact Person: The Rev. Cheree' Johnson');
update contact set phone = '309-268-5499', email = 'BROM-ChurchRelations@advocatehealth.com', fax = 'null', url = 'http://www.advocatehealth.com/bromenn/churchrelations' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Delegate Church Association of Advocate BroMenn Medical Center'), (select max(id) from contact));
-- DuPage Department of Public Health
insert into contact (name) values ('');
update contact set phone = '630-682-7979', email = 'null', fax = '630-462-9085', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'DuPage Department of Public Health'), (select max(id) from contact));
-- Ebenezer Baptist
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Ebenezer Baptist'), (select max(id) from contact));
-- Ebenezer Lutheran Church
insert into contact (name) values ('');
update contact set phone = '773-561-8496', email = 'null', fax = '773-561-8001', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Ebenezer Lutheran Church'), (select max(id) from contact));
-- Edgewater Presbyterian Church
insert into contact (name) values ('Primary Contact Person: Rev. Dr. Barb Cathey');
update contact set phone = '773-561-4748', email = 'macphie@sbcglobal.net', fax = 'null', url = 'http://www.edgewaterpres.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Edgewater Presbyterian Church'), (select max(id) from contact));
-- Education and Life Coaching
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Education and Life Coaching'), (select max(id) from contact));
-- Epworth United Methodist Church
insert into contact (name) values ('Primary Contact Person: Rev. Amos Olidapo');
update contact set phone = 'null', email = 'epworthchicago@gmail.com', fax = 'null', url = 'http://www.epworthchicago.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Epworth United Methodist Church'), (select max(id) from contact));
-- Evergreen Presbyterian Church
insert into contact (name) values ('Primary Contact Person: Rev. Yun Chun Han');
update contact set phone = '847-537-4449', email = 'hesed333@yahoo.com', fax = 'null', url = 'http://www.egreenpc.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Evergreen Presbyterian Church'), (select max(id) from contact));
-- Exodus Community Church
insert into contact (name) values ('Primary Contact Person: Rev. Dr. Jeremiah Yi');
update contact set phone = '847-208-9544', email = 'null', fax = 'null', url = 'http://www.exoduschurch.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Exodus Community Church'), (select max(id) from contact));
-- Faith Caucus
insert into contact (name) values ('');
update contact set phone = '312-913-9449', email = 'lleon@cbhconline.org', fax = '312-913-9559', url = 'http://www.cbhconline.org/issues/hcjc/faith.html' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Faith Caucus'), (select max(id) from contact));
-- Faith in Place
insert into contact (name) values ('');
update contact set phone = '312-726-4948', email = 'null', fax = '312-726-6108', url = 'http://www.faithinplace.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Faith in Place'), (select max(id) from contact));
-- Faith Temple COGIC
insert into contact (name) values ('');
update contact set phone = '773-846-1056', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Faith Temple COGIC'), (select max(id) from contact));
-- Faith United Methodist Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Faith United Methodist Church'), (select max(id) from contact));
-- Figure Facts LLC
insert into contact (name) values ('');
update contact set phone = '312-988-4850', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Figure Facts LLC'), (select max(id) from contact));
-- First Baptist Church, Berwyn
insert into contact (name) values ('Primary Contact Person: Rev. Dr. Damon Jones');
update contact set phone = '708-749-8800', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'First Baptist Church, Berwyn'), (select max(id) from contact));
-- First Baptist Church, LaGrange
insert into contact (name) values ('Primary Contact Person: Rev. Michael Strickland');
update contact set phone = 'null', email = 'fbclagrange@sbcglobal.net', fax = 'null', url = 'http://www.fbclagrange.com/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'First Baptist Church, LaGrange'), (select max(id) from contact));
-- First Baptist Church, Park Forest
insert into contact (name) values ('Primary Contact Person: Rev. Carol Jamieson Brown');
update contact set phone = '708-748-2566', email = 'pastorfbc@yahoo.com', fax = 'null', url = 'http://www.fbcparkforest.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'First Baptist Church, Park Forest'), (select max(id) from contact));
-- First Congregational Church of Western Springs
insert into contact (name) values ('Primary Contact Person: Deborah Stankiewicz, AHC Parish Nurse');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'http://www.wscongo.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'First Congregational Church of Western Springs'), (select max(id) from contact));
-- First Evangelical Free Church
insert into contact (name) values ('Primary Contact Person: Rev. Bill Shereos');
update contact set phone = 'null', email = 'bshereos@firstfree.com', fax = 'null', url = 'http://www.firstfree.com/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'First Evangelical Free Church'), (select max(id) from contact));
-- First Grace Missionary Baptist Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'First Grace Missionary Baptist Church'), (select max(id) from contact));
-- First New Bethlehem Community Development Corporation
insert into contact (name) values ('Primary Contact Person: The Rev. Rickey Kendrick, Executive Director');
update contact set phone = '773-488-6053', email = 'newbethlehem@gmail.com', fax = '773-602-1559', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'First New Bethlehem Community Development Corporation'), (select max(id) from contact));
-- Flossmoor Community Church
insert into contact (name) values ('');
update contact set phone = '708-798-2800', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Flossmoor Community Church'), (select max(id) from contact));
-- Fourth Presbyterian Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Fourth Presbyterian Church'), (select max(id) from contact));
-- Friendly Visits
insert into contact (name) values ('Primary Contact Person: Heather Dudzinski, Community Outreach Coordinator');
update contact set phone = '312-455-1000', email = 'null', fax = '312-455-9674', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Friendly Visits'), (select max(id) from contact));
-- Friendship Baptist Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Friendship Baptist Church'), (select max(id) from contact));
-- Gloria Dei Lutheran Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Gloria Dei Lutheran Church'), (select max(id) from contact));
-- God Can Ministries
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'God Can Ministries'), (select max(id) from contact));
-- Grace Calvary United Methodist Church
insert into contact (name) values ('Primary Contact Person: Rev. Rodney C. Walker');
update contact set phone = '773-783-5145', email = 'rodneycwalker@yahoo.com', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Grace Calvary United Methodist Church'), (select max(id) from contact));
-- Grace Calvary United Methodist Church- Gospel Cafe
insert into contact (name) values ('Primary Contact Person: Rev. Rodney C. Walker');
update contact set phone = '773-783-5145', email = 'rodneycwalker@yahoo.com', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Grace Calvary United Methodist Church- Gospel Cafe'), (select max(id) from contact));
-- Grace Evangelical Lutheran Church
insert into contact (name) values ('Primary Contact Person: Pastor Jade Yi');
update contact set phone = 'null', email = 'gracevillapark@yahoo.com', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Grace Evangelical Lutheran Church'), (select max(id) from contact));
-- Grace Lutheran Church
insert into contact (name) values ('Primary Contact Person: Dr. MaryBeth Buschmann');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'http://www.graceriverforest.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Grace Lutheran Church'), (select max(id) from contact));
-- Greater Galilee MB Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Greater Galilee MB Church'), (select max(id) from contact));
-- Greater Galilee Missionary Baptist Church
insert into contact (name) values ('Primary Contact Person: Charlayne Guy Moore');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Greater Galilee Missionary Baptist Church'), (select max(id) from contact));
-- Greater Open Door Baptist Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Greater Open Door Baptist Church'), (select max(id) from contact));
-- Greater Progressive Missionary Baptist Church Baptist Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Greater Progressive Missionary Baptist Church Baptist Church'), (select max(id) from contact));
-- Greater St. John Bible Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Greater St. John Bible Church'), (select max(id) from contact));
-- Greater St. Paul A M E C
insert into contact (name) values ('');
update contact set phone = '773-522-4812', email = 'null', fax = '773-522-4812', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Greater St. Paul A M E C'), (select max(id) from contact));
-- Greater Walters AME Zion Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Greater Walters AME Zion Church'), (select max(id) from contact));
-- Hamdard Center for Health and Human Services
insert into contact (name) values ('Primary Contact Person: Ms. Kiran Siddiqui');
update contact set phone = '773-465-4600', email = 'ksidd@hamdardcenter.org', fax = 'null', url = 'http://www.hamdardcenter.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Hamdard Center for Health and Human Services'), (select max(id) from contact));
-- Health Initiatives, West Cook Area
insert into contact (name) values ('Primary Contact Person: Carmen Carrizales, Health Initiatives Representative');
update contact set phone = '708-484-8541', email = 'null', fax = '708-484-3179', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Health Initiatives, West Cook Area'), (select max(id) from contact));
-- Healthcare Consortium of Illinois
insert into contact (name) values ('Primary Contact Person: Mayme Buckley, Associate Director, Interfaith and Development');
update contact set phone = '708-841-9515', email = 'mbcukley@hcionline.org', fax = '708-841-9713', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Healthcare Consortium of Illinois'), (select max(id) from contact));
-- Healthy Dining Chicago Healthy Dining Chicago
insert into contact (name) values ('');
update contact set phone = '312-666-9979', email = 'Laura@HealthyDinning.org', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Healthy Dining Chicago Healthy Dining Chicago'), (select max(id) from contact));
-- Healthy Spirit Healthy Soul
insert into contact (name) values ('Primary Contact Person: Desmond Konadu, Senior Health Initiatives Representative');
update contact set phone = '312-279-7278', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Healthy Spirit Healthy Soul'), (select max(id) from contact));
-- Hispanocare - Chicago
insert into contact (name) values ('Primary Contact Person: Maria Oquendo, Coordinator');
update contact set phone = '773-296-7157', email = 'maria.oquendo@advocatehealth.com', fax = '773-327-8208', url = 'http://www.hispanocare.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Hispanocare - Chicago'), (select max(id) from contact));
-- Hyde Park Christian Reformed Church
insert into contact (name) values ('Primary Contact Person: Mr. Eric Chua');
update contact set phone = '773-288-2677', email = 'eric.chua@juno.com', fax = 'null', url = 'http://www.hydeparkcrc.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Hyde Park Christian Reformed Church'), (select max(id) from contact));
-- Illinois Faith Based Emergency Preparedness Initiative
insert into contact (name) values ('Primary Contact Person: Dr. Leon Dingle');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'http://www.idph.state.il.us/planready/index.htm' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Illinois Faith Based Emergency Preparedness Initiative'), (select max(id) from contact));
-- Illinois Maternal and Child Health Coalition
insert into contact (name) values ('');
update contact set phone = '312-491-8161', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Illinois Maternal and Child Health Coalition'), (select max(id) from contact));
-- Illinois PIRG
insert into contact (name) values ('');
update contact set phone = '312-291-0441', email = 'alozanoff@illinoispirg.org', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Illinois PIRG'), (select max(id) from contact));
-- Illinois Women's Health Registry
insert into contact (name) values ('Primary Contact: Sarah Bristol-Gould Director, Research Programs; IL Women's Heallth Registry');
update contact set phone = '312-503-1764', email = 'null', fax = '312-506-1764', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Illinois Women's Health Registry'), (select max(id) from contact));
-- Imagine Chicago
insert into contact (name) values ('');
update contact set phone = '773-275-2520', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Imagine Chicago'), (select max(id) from contact));
-- Inner City Muslim Action Network
insert into contact (name) values ('Primary Contact Person: Mr. Shamar Hemphill');
update contact set phone = '773-434-4626', email = 'shamar@imancentral.org', fax = 'null', url = 'http://www.imancentral.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Inner City Muslim Action Network'), (select max(id) from contact));
-- Institute for Women's Health Research
insert into contact (name) values ('');
update contact set phone = '312-503-1308', email = 'null', fax = '312-503-1764', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Institute for Women's Health Research'), (select max(id) from contact));
-- Islamic Community Center
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Islamic Community Center'), (select max(id) from contact));
-- Islamic Foundation of Villa Park
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Islamic Foundation of Villa Park'), (select max(id) from contact));
-- Ismaili Center in Chicago
insert into contact (name) values ('Primary Contact Person: Mr. Nizar Jawani');
update contact set phone = '773-262-1616', email = 'nizar.jiwani@gmail.com', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Ismaili Center in Chicago'), (select max(id) from contact));
-- Ismaili Center in Glenview
insert into contact (name) values ('Primary Contact Person: Mr. Nizar Jiwani, Communications Director');
update contact set phone = '312-399-5713', email = 'nizar.jiwani@gmail.com', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Ismaili Center in Glenview'), (select max(id) from contact));
-- Jesus Name Apostolic Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Jesus Name Apostolic Church'), (select max(id) from contact));
-- Jewish Child and Family Services
insert into contact (name) values ('Primary Contact Person: Ms. Robin Levine');
update contact set phone = '773-467-3700', email = 'null', fax = 'null', url = 'http://www.jcfs.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Jewish Child and Family Services'), (select max(id) from contact));
-- Jewish Community Emergency Resiliency Team
insert into contact (name) values ('Primary Contact Person: Ms. Charlotte Mallon');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'http://www.juf.org/guide/category.aspx?id=31892' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Jewish Community Emergency Resiliency Team'), (select max(id) from contact));
-- Jewish Healing Network of Chicago
insert into contact (name) values ('');
update contact set phone = '847-568-5216', email = 'null', fax = '847-568-5125', url = 'http://www.jcfs.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Jewish Healing Network of Chicago'), (select max(id) from contact));
-- Jewish School-Based Wellness Initiative
insert into contact (name) values ('Primary Contact Person: Maureen Benjamins Senior Epidemiologist');
update contact set phone = '773-257-2324', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Jewish School-Based Wellness Initiative'), (select max(id) from contact));
-- Joshua Missionary Baptist Church
insert into contact (name) values ('');
update contact set phone = '773-533-0034', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Joshua Missionary Baptist Church'), (select max(id) from contact));
-- Journey Community Church
insert into contact (name) values ('Primary Contact Person: Rev. Daniel Park');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'http://www.journeytogether.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Journey Community Church'), (select max(id) from contact));
-- Joy To Be Fit Gospel Aerobics Ministry
insert into contact (name) values ('Primary Contact Person: Stephanie Jackson-Rowe, Founder &amp; President');
update contact set phone = '708-366-2633', email = 'joytobefitboom@sbcaol.com', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Joy To Be Fit Gospel Aerobics Ministry'), (select max(id) from contact));
-- Kenwood UCC
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Kenwood UCC'), (select max(id) from contact));
-- Kimball Ave. Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Kimball Ave. Church'), (select max(id) from contact));
-- La Academia
insert into contact (name) values ('');
update contact set phone = '708-344-4470', email = 'null', fax = '708-344-4564', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'La Academia'), (select max(id) from contact));
-- Lakeview Presbyterian Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Lakeview Presbyterian Church'), (select max(id) from contact));
-- Latino Community Program
insert into contact (name) values ('Primary Contact Person: Judy Guitelman, Program Coordinator');
update contact set phone = '312-364-9071', email = 'null', fax = '312-364-9066', url = 'http://www.networkofstrength.org/illinois' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Latino Community Program'), (select max(id) from contact));
-- LaVerne Barnes
insert into contact (name) values ('');
update contact set phone = '708-396-9777', email = 'null', fax = '708-396-9732', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'LaVerne Barnes'), (select max(id) from contact));
-- Lead Safe Housing Initiatives
insert into contact (name) values ('Primary Contact Person: Mary Burns, Community Projects Director');
update contact set phone = '312-915-6811', email = 'null', fax = '312-915-6485', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Lead Safe Housing Initiatives'), (select max(id) from contact));
-- lead safe illinois
insert into contact (name) values ('');
update contact set phone = '312-915-6811', email = 'null', fax = '312-915-6485', url = 'http://www.leadsafeillinois.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'lead safe illinois'), (select max(id) from contact));
-- Leadership and Church Development
insert into contact (name) values ('Primary Contact Person: Jorge Montes, Reverend');
update contact set phone = '708-344-4470', email = 'illconfmontes@aol.com', fax = '708-344-4564', url = 'http://www.uccillconf.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Leadership and Church Development'), (select max(id) from contact));
-- Liberty Baptist
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Liberty Baptist'), (select max(id) from contact));
-- Lilydale Baptist Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Lilydale Baptist Church'), (select max(id) from contact));
-- Lincoln United Methodist Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Lincoln United Methodist Church'), (select max(id) from contact));
-- Little Brothers &acirc;&euro;" Friends of the Elderly, Chicago Chapter
insert into contact (name) values ('');
update contact set phone = '312-455-1000', email = 'null', fax = '312-455-9674', url = 'http://www.littlebrotherschicago.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Little Brothers &acirc;&euro;" Friends of the Elderly, Chicago Chapter'), (select max(id) from contact));
-- Lively Stone Missonary Baptist Church
insert into contact (name) values ('');
update contact set phone = '773-379-1750', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Lively Stone Missonary Baptist Church'), (select max(id) from contact));
-- Living Well Ministries
insert into contact (name) values ('');
update contact set phone = '773-655-4357', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Living Well Ministries'), (select max(id) from contact));
-- Lutheran Church of Atonement
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Lutheran Church of Atonement'), (select max(id) from contact));
-- Lutheran Church of the Ascension
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Lutheran Church of the Ascension'), (select max(id) from contact));
-- Lutheran General Hospital &acirc;&euro;" Mission and Spiritual
insert into contact (name) values ('Primary Contact Person: Rev. Kathi Bender Schwich');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'http://www.advocatehealth.com/lgch/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Lutheran General Hospital &acirc;&euro;" Mission and Spiritual'), (select max(id) from contact));
-- Lutheran Social Services of Illinois
insert into contact (name) values ('Primary Contact Person: Daniel Schwick, V.P Church &amp; Community');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'http://www.lssi.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Lutheran Social Services of Illinois'), (select max(id) from contact));
-- M.I.K.E. Minority Intervention and Kidney Education Program
insert into contact (name) values ('Primary Contact Person: Courtney Nicholas, Associate Director');
update contact set phone = '312-224-8172', email = 'cnicholas@kidneyfund.org', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'M.I.K.E. Minority Intervention and Kidney Education Program'), (select max(id) from contact));
-- Ministry to New Moms
insert into contact (name) values ('Primary Contact Person: Vicki Burke, Founder of the Ministry to New Moms');
update contact set phone = '708-647-7658', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Ministry to New Moms'), (select max(id) from contact));
-- Montrose Baptist Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Montrose Baptist Church'), (select max(id) from contact));
-- Monument of Faith Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Monument of Faith Church'), (select max(id) from contact));
-- Mosque Foundation
insert into contact (name) values ('Primary Contact Person: Imam Kifah Mustapha');
update contact set phone = 'null', email = 'info@mosquefoundation.org', fax = 'null', url = 'http://www.mosquefoundation.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Mosque Foundation'), (select max(id) from contact));
-- Mosque of Umar Inc.
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Mosque of Umar Inc.'), (select max(id) from contact));
-- Most Blessed Trinity Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Most Blessed Trinity Church'), (select max(id) from contact));
-- Mount Calvary Baptist Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Mount Calvary Baptist Church'), (select max(id) from contact));
-- Mount Pisgah Ministries
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Mount Pisgah Ministries'), (select max(id) from contact));
-- Myanmar Christian Church of Metro Chicago
insert into contact (name) values ('Primary Contact Person: Rev. Dr. Biak Mang');
update contact set phone = '773-493-1847', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Myanmar Christian Church of Metro Chicago'), (select max(id) from contact));
-- New Hope Bible Church
insert into contact (name) values ('');
update contact set phone = '312-394-2860', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'New Hope Bible Church'), (select max(id) from contact));
-- New Life Baptist Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'New Life Baptist Church'), (select max(id) from contact));
-- New Life Community Church
insert into contact (name) values ('');
update contact set phone = '773-838-9470', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'New Life Community Church'), (select max(id) from contact));
-- New Life Covenant Church
insert into contact (name) values ('');
update contact set phone = '773-384-7113', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'New Life Covenant Church'), (select max(id) from contact));
-- New Life Worship Center
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'New Life Worship Center'), (select max(id) from contact));
-- New Mt.Pilgrim MB Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'New Mt.Pilgrim MB Church'), (select max(id) from contact));
-- New Pasadena MB Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'New Pasadena MB Church'), (select max(id) from contact));
-- North Park Theological Seminary
insert into contact (name) values ('');
update contact set phone = '773-244-6201', email = 'null', fax = '773-244-6244', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'North Park Theological Seminary'), (select max(id) from contact));
-- North Shore Baptist Church
insert into contact (name) values ('Primary Contact Person: Ms. Dawn Noldan/Mrs. Emy Kosmas');
update contact set phone = '773-728-4200', email = 'cmvetty@northshorebaptist.org', fax = 'null', url = 'http://www.northshorebaptist.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'North Shore Baptist Church'), (select max(id) from contact));
-- North Shore Church of Christ
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'North Shore Church of Christ'), (select max(id) from contact));
-- Northfield Presbyterian Church
insert into contact (name) values ('Primary Contact Person: Rev. Bumhoon (John) Lee');
update contact set phone = '847-808-5700', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Northfield Presbyterian Church'), (select max(id) from contact));
-- Northside P.O.W.E.R.
insert into contact (name) values ('Primary Contact Person: Marilyn Pagan-Banks, Executive Director');
update contact set phone = '773-262-2297', email = 'goodnewskitchen@sbcglobal.net', fax = '773-262-7872', url = 'http://www.gnck.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Northside P.O.W.E.R.'), (select max(id) from contact));
-- Nuestra Senora de Gaudalupe
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Nuestra Senora de Gaudalupe'), (select max(id) from contact));
-- Older Adult Programs
insert into contact (name) values ('Primary Contact Person: Dana Bright Community Health Coordinator');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Older Adult Programs'), (select max(id) from contact));
-- Our Lady of Fatima Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Our Lady of Fatima Church'), (select max(id) from contact));
-- Our Lady of Good Counsel
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Our Lady of Good Counsel'), (select max(id) from contact));
-- Park Manor Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Park Manor Church'), (select max(id) from contact));
-- Park Ridge Community Church
insert into contact (name) values ('Primary Contact Person: Brett McCleneghan, Senior Minister');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Park Ridge Community Church'), (select max(id) from contact));
-- Peace Lutheran Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Peace Lutheran Church'), (select max(id) from contact));
-- People&acirc;&euro;&trade;s Church of the Harvest
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'People&acirc;&euro;&trade;s Church of the Harvest'), (select max(id) from contact));
-- Peoples Church of Chicago
insert into contact (name) values ('Primary Contact Person: Rev. Jean Darling');
update contact set phone = '773-784-6633', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Peoples Church of Chicago'), (select max(id) from contact));
-- Pilgrim Faith United Church of Christ
insert into contact (name) values ('');
update contact set phone = 'null', email = 'office@pilgrimfaith.org', fax = 'null', url = 'http://www.pilgrimfaith.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Pilgrim Faith United Church of Christ'), (select max(id) from contact));
-- Pillar of Love UCC
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Pillar of Love UCC'), (select max(id) from contact));
-- Pleasant Ridge Baptist Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Pleasant Ridge Baptist Church'), (select max(id) from contact));
-- Polish Community
insert into contact (name) values ('Primary Contact Person: Gabriela Kowalczyk, Program Coordinator');
update contact set phone = '312-364-9071', email = 'null', fax = '312-364-9066', url = 'http://www.networkofstrength.org/illinois' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Polish Community'), (select max(id) from contact));
-- Primera Iglesia Congregacional
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Primera Iglesia Congregacional'), (select max(id) from contact));
-- Program of Religion/Spirituality and Mental Health
insert into contact (name) values ('');
update contact set phone = '312-413-4609', email = 'null', fax = '312-413-4503', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Program of Religion/Spirituality and Mental Health'), (select max(id) from contact));
-- Progressive Baptist Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Progressive Baptist Church'), (select max(id) from contact));
-- Pui Tak Center
insert into contact (name) values ('Primary Contact Person: Mr. David Wu');
update contact set phone = '312-328-1188', email = 'davidwu@puitak.org', fax = 'null', url = 'http://www.puitak.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Pui Tak Center'), (select max(id) from contact));
-- Rahab's House, Inc.
insert into contact (name) values ('Primary Contact Person: Denise Henley, Rev./President');
update contact set phone = '773-593-5896', email = 'admin@rahabshouse.net', fax = 'null', url = 'http://www.rahabshouse.net/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Rahab's House, Inc.'), (select max(id) from contact));
-- Rainbow Hospice and Palliative Care
insert into contact (name) values ('Primary Contact Person: Dave Samson');
update contact set phone = '847-685-9900', email = 'Info@RainbowHospice.org', fax = '847-294-9613', url = 'http://www.rainbowhospice.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Rainbow Hospice and Palliative Care'), (select max(id) from contact));
-- Redeeming Life Family Worship Center COGIC
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Redeeming Life Family Worship Center COGIC'), (select max(id) from contact));
-- Reformation Lutheran Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Reformation Lutheran Church'), (select max(id) from contact));
-- Revelation International Outreach Ministries
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Revelation International Outreach Ministries'), (select max(id) from contact));
-- Rush University Medical Center
insert into contact (name) values ('');
update contact set phone = '800-757-0202', email = 'null', fax = '312-942-6116', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Rush University Medical Center'), (select max(id) from contact));
-- Salem Baptist
insert into contact (name) values ('');
update contact set phone = '773-371-2300', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Salem Baptist'), (select max(id) from contact));
-- Shiloh Baptist Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Shiloh Baptist Church'), (select max(id) from contact));
-- Shiloh Missionary Baptist Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Shiloh Missionary Baptist Church'), (select max(id) from contact));
-- Sinai Urban Health Institute
insert into contact (name) values ('');
update contact set phone = '773-257-2324', email = 'null', fax = '773-257-5680', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Sinai Urban Health Institute'), (select max(id) from contact));
-- South Suburban Interfaith Ministerial Association
insert into contact (name) values ('Primary Contact Person: Re. Kris Orr');
update contact set phone = '708-798-4150', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'South Suburban Interfaith Ministerial Association'), (select max(id) from contact));
-- Spanish Christian Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Spanish Christian Church'), (select max(id) from contact));
-- St Matthews United Methodist Church
insert into contact (name) values ('');
update contact set phone = '312-337-7111', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'St Matthews United Methodist Church'), (select max(id) from contact));
-- St. Ailbe Catholic Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'St. Ailbe Catholic Church'), (select max(id) from contact));
-- St. Anne Church
insert into contact (name) values ('Primary Contact Person: Rev. Thomas Bishop');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'St. Anne Church'), (select max(id) from contact));
-- St. Clement&acirc;&euro;&trade;s Episcopal Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'St. Clement&acirc;&euro;&trade;s Episcopal Church'), (select max(id) from contact));
-- St. Francis of Assisi Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'St. Francis of Assisi Church'), (select max(id) from contact));
-- St. Genevieve Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'St. Genevieve Church'), (select max(id) from contact));
-- St. Ita Catholic Church
insert into contact (name) values ('Primary Contact Person: Sr. Mary Jeanne Hayes');
update contact set phone = '773-561-5343', email = 'mjh816@sbcglobal.net', fax = 'null', url = 'http://www.saintita.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'St. Ita Catholic Church'), (select max(id) from contact));
-- St. James Lutheran Church
insert into contact (name) values ('Primary Contact Person: Pastor Erin Clausen');
update contact set phone = 'null', email = 'stjames.pastor@gmail.com', fax = 'null', url = 'http://www.stjamesws.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'St. James Lutheran Church'), (select max(id) from contact));
-- St. John MB Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'St. John MB Church'), (select max(id) from contact));
-- St. John United Church of Christ
insert into contact (name) values ('');
update contact set phone = '847-255-6687', email = 'office@churchonthepark.com', fax = '847-255-6388', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'St. John United Church of Christ'), (select max(id) from contact));
-- St. Kevins&acirc;&euro;&trade;s Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'St. Kevins&acirc;&euro;&trade;s Church'), (select max(id) from contact));
-- St. Luke's Lutheran of Logan Square
insert into contact (name) values ('');
update contact set phone = '773-235-5420', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'St. Luke's Lutheran of Logan Square'), (select max(id) from contact));
-- St. Luke&acirc;&euro;&trade;s Lutheran Church of Logan Square
insert into contact (name) values ('Primary Contact Person: Erik Christensen, Rev.');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'St. Luke&acirc;&euro;&trade;s Lutheran Church of Logan Square'), (select max(id) from contact));
-- St. Mark International Christian Ch.
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'St. Mark International Christian Ch.'), (select max(id) from contact));
-- St. Paul UCC
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'St. Paul UCC'), (select max(id) from contact));
-- St. Paul&acirc;&euro;&trade;s Church by-the-Lake
insert into contact (name) values ('Primary Contact Person: Ms. Judith Gramer');
update contact set phone = 'null', email = 'jvg001@sbcglobal.net', fax = 'null', url = 'http://www.stpaulsbylake.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'St. Paul&acirc;&euro;&trade;s Church by-the-Lake'), (select max(id) from contact));
-- St. Pius V. Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'St. Pius V. Church'), (select max(id) from contact));
-- St. Sabina Church
insert into contact (name) values ('');
update contact set phone = '773-483-4300', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'St. Sabina Church'), (select max(id) from contact));
-- St. Stephen AME Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'St. Stephen AME Church'), (select max(id) from contact));
-- St. Sylvester Catholic Church
insert into contact (name) values ('Primary Contact Person: Dora Albert');
update contact set phone = '773-235-3646', email = 'stsylvester@archchicago.org', fax = 'null', url = 'http://stsylvesterparish.com/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'St. Sylvester Catholic Church'), (select max(id) from contact));
-- Suburban Chicago Interfaith Mental Health Coalition
insert into contact (name) values ('Primary Contact Person: Mr. Bob Skrocki');
update contact set phone = '630-682-7979', email = 'null', fax = 'null', url = 'http://www.scimc.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Suburban Chicago Interfaith Mental Health Coalition'), (select max(id) from contact));
-- Sunrise Missionary Baptist Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Sunrise Missionary Baptist Church'), (select max(id) from contact));
-- Temple of Faith Missionary Baptist Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Temple of Faith Missionary Baptist Church'), (select max(id) from contact));
-- The American Heart Association (AHA)
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'The American Heart Association (AHA)'), (select max(id) from contact));
-- The Buddhist Temple of Chicago
insert into contact (name) values ('Primary Contact Person: Rev. Patti Nakai');
update contact set phone = '773-334-4661', email = 'rev.eshin.patti23@gmail.com', fax = 'null', url = 'http://www.budtempchi.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'The Buddhist Temple of Chicago'), (select max(id) from contact));
-- The Christian Aerobics &amp; Fitness Association (CAFA)
insert into contact (name) values ('');
update contact set phone = '708-366-2633', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'The Christian Aerobics &amp; Fitness Association (CAFA)'), (select max(id) from contact));
-- The South Church
insert into contact (name) values ('Primary Contact Person: Rev. Rick Kessler');
update contact set phone = '847-253-0501', email = 'null', fax = 'null', url = 'http://www.thesouthchurch.com/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'The South Church'), (select max(id) from contact));
-- The Unversity of Illinois Medical Center for Women's Health Associates
insert into contact (name) values ('Contact: Sharon Greene-Hughes, Antenatal Testing Specialist, Maternal Fetal Medicine High Risk Nurse');
update contact set phone = '312-413-7500', email = 'sghughes@uic.edu', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'The Unversity of Illinois Medical Center for Women's Health Associates'), (select max(id) from contact));
-- Third Baptist Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Third Baptist Church'), (select max(id) from contact));
-- Triedstone Full Gospel Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Triedstone Full Gospel Church'), (select max(id) from contact));
-- Trinity AME Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Trinity AME Church'), (select max(id) from contact));
-- Trinity United Church of Christ
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Trinity United Church of Christ'), (select max(id) from contact));
-- True Worship Baptist Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'True Worship Baptist Church'), (select max(id) from contact));
-- Turning Point
insert into contact (name) values ('Primary Contact Person: Ms. Ann Fisher Raney');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'http://www.tpoint.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Turning Point'), (select max(id) from contact));
-- Ubumama - Chicago
insert into contact (name) values ('Primary Contact Person: Bliss Browne, President');
update contact set phone = 'null', email = 'bliss@imaginechicago.org', fax = 'null', url = 'http://www.ubumama.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Ubumama - Chicago'), (select max(id) from contact));
-- United Baptist Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'United Baptist Church'), (select max(id) from contact));
-- United Faith Missionary Baptist Church
insert into contact (name) values ('');
update contact set phone = '708-338-1150', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'United Faith Missionary Baptist Church'), (select max(id) from contact));
-- United in Faith Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'United in Faith Church'), (select max(id) from contact));
-- Unity Lutheran Church
insert into contact (name) values ('Primary Contact Person: Rev. Fred Kinsey');
update contact set phone = '773-878-4747', email = 'unitylutheran@ameritech.net', fax = 'null', url = 'http://www.unitylutheranchicago.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Unity Lutheran Church'), (select max(id) from contact));
-- Unity Northwest Church
insert into contact (name) values ('Primary Contact Person: Rev. Greg Barrette');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'http://www.unitynorthwest.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Unity Northwest Church'), (select max(id) from contact));
-- Universal House of Refuge Center
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Universal House of Refuge Center'), (select max(id) from contact));
-- University of Illinois&acirc;&euro;&trade; Division of Community Health
insert into contact (name) values ('Primary Contact Person: Bertha Paul, School and Community Health Educator');
update contact set phone = '312-996-4656', email = 'null', fax = '312-996-3848', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'University of Illinois&acirc;&euro;&trade; Division of Community Health'), (select max(id) from contact));
-- Victory Christian Assembly Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Victory Christian Assembly Church'), (select max(id) from contact));
-- VOCMA Faith Community Baptist Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'VOCMA Faith Community Baptist Church'), (select max(id) from contact));
-- Wesley United Methodist Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Wesley United Methodist Church'), (select max(id) from contact));
-- Westside Health Authority
insert into contact (name) values ('Primary Contact Person: Janine Lewis, Director of Health Promotions');
update contact set phone = '773-786-0249', email = 'jlewis6@gmail.com', fax = '773-786-0256', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Westside Health Authority'), (select max(id) from contact));
-- Wholistic Medical Clinic
insert into contact (name) values ('');
update contact set phone = '708-396-9777', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Wholistic Medical Clinic'), (select max(id) from contact));
-- ZAM&acirc;&euro;&trade;s Hope Community Resource Center
insert into contact (name) values ('');
update contact set phone = 'null', email = 'zehra_zamshope@yahoo.com', fax = 'null', url = 'http://www.zamshope.net/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'ZAM&acirc;&euro;&trade;s Hope Community Resource Center'), (select max(id) from contact));