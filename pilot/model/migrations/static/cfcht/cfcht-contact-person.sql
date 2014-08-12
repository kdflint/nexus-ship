-- executed. Error on dashes in phone numbers. Error on url > col length. Fixed.


-- 30th Ward - St. James Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = '30th Ward - St. James Church'), (select max(id) from contact));
-- A Just Harvest
insert into contact (name) values ('Rev. Marilyn Pagan Banks');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'A Just Harvest'), (select max(id) from contact));
-- Access Living
insert into contact (name) values ('Ms. Rahnee Patrick');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'http://www.accessliving.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Access Living'), (select max(id) from contact));
-- Adalberto Memorial United Methodist Church
insert into contact (name) values ('');
update contact set phone = '7737828464', email = 'null', fax = 'null', url = 'http://www.familialatinaunida.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Adalberto Memorial United Methodist Church'), (select max(id) from contact));
-- Advocate Christ Medical Center
insert into contact (name) values ('Corky DeBoer, Manager of Spiritual Services');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Advocate Christ Medical Center'), (select max(id) from contact));
-- Advocate Clinical Pastoral Education
insert into contact (name) values ('Darlene Zec');
update contact set phone = 'null', email = 'darlene.zec@advocatehealth.com', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Advocate Clinical Pastoral Education'), (select max(id) from contact));
-- Advocate Health Care
insert into contact (name) values ('Rev. Bonnie Condon');
update contact set phone = '6305729393', email = 'null', fax = 'null', url = 'http://www.advocatehealth.com/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Advocate Health Care'), (select max(id) from contact));
-- Advocate Parish Nurse Ministry
insert into contact (name) values ('Nancy Durbin Director, Parish Nurse Ministry');
update contact set phone = '8473843749', email = 'nancy.durbin@advocatehealth.com', fax = '8476960239', url = 'http://www.advocatehealth.com/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Advocate Parish Nurse Ministry'), (select max(id) from contact));
-- Advocate United Church of Christ
insert into contact (name) values ('Minister Chris Church');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Advocate United Church of Christ'), (select max(id) from contact));
-- African Community United Methodist Church
insert into contact (name) values ('Rev. Amos Olidapo');
update contact set phone = '7732627881', email = 'pastor@africancommunityumc.org', fax = 'null', url = 'http://www.africancommunityumc.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'African Community United Methodist Church'), (select max(id) from contact));
-- African-American Alzheimer\'s Outreach Initiative
insert into contact (name) values ('Beverly Kimmons');
update contact set phone = '8479332413', email = 'beverly.kimmons@alz.org', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'African-American Alzheimer\'s Outreach Initiative'), (select max(id) from contact));
-- Agape Family Life Center
insert into contact (name) values ('');
update contact set phone = '7734167328', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Agape Family Life Center'), (select max(id) from contact));
-- Age Options
insert into contact (name) values ('Ms. Lisa Blechschmidt');
update contact set phone = '7083830258', email = 'kim.blechschmidt@ageoptions.org', fax = 'null', url = 'http://www.ageoptions.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Age Options'), (select max(id) from contact));
-- Alexian Brothers Parish Services
insert into contact (name) values ('Rita Tippentrop, Assistant Director');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'http://www.alexianbrothershealth.org/parishservices' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Alexian Brothers Parish Services'), (select max(id) from contact));
-- Alzheimer\'s Association - Greater Illinois Chapter
insert into contact (name) values ('');
update contact set phone = '8479332413', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Alzheimer\'s Association - Greater Illinois Chapter'), (select max(id) from contact));
-- Am I My Brothers Keeper
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Am I My Brothers Keeper'), (select max(id) from contact));
-- American Cancer Society, Chicago Region
insert into contact (name) values ('');
update contact set phone = '8002272345', email = 'null', fax = 'null', url = 'http://www.cancer.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'American Cancer Society, Chicago Region'), (select max(id) from contact));
-- American Heart Association Cultural Health Initiatives
insert into contact (name) values ('Debra Davis, Director of Cultural Health Initiatives');
update contact set phone = '3124766619', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'American Heart Association Cultural Health Initiatives'), (select max(id) from contact));
-- American Kidney Fund
insert into contact (name) values ('');
update contact set phone = '3122248172', email = 'null', fax = '3122389464', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'American Kidney Fund'), (select max(id) from contact));
-- Antioch Telegu Church
insert into contact (name) values ('Rev. David Sagar');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'http://www.antiochteleguchurch.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Antioch Telegu Church'), (select max(id) from contact));
-- Apostolic Church of God
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Apostolic Church of God'), (select max(id) from contact));
-- Apostolic Faith Church Health Professions Ministry
insert into contact (name) values ('Geraldine Peacock, Health Ministry Coordinator');
update contact set phone = '7733738500', email = 'sistuhgsp@yahoo.com', fax = '3128649007', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Apostolic Faith Church Health Professions Ministry'), (select max(id) from contact));
-- B\'nai Yehuda Beth Shalom
insert into contact (name) values ('Rabbi Ellen Dreyfus');
update contact set phone = '7087994110', email = 'rabbi@bybs.org', fax = 'null', url = 'http://www.bybs.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'B\'nai Yehuda Beth Shalom'), (select max(id) from contact));
-- Beacon Light
insert into contact (name) values ('Cynthia Johnson, Pastor');
update contact set phone = '7735224812', email = 'revcwj2000@sbcglobal.net', fax = '7735224812', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Beacon Light'), (select max(id) from contact));
-- Bethel Reform Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Bethel Reform Church'), (select max(id) from contact));
-- Bikur Cholim (visiting the sick) training
insert into contact (name) values ('Tracey Kite Director, Jewish Healing Network of Chicago');
update contact set phone = '8475685216', email = 'TraceyKite@jcfs.org', fax = '5475685100', url = 'http://www.jcfs.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Bikur Cholim (visiting the sick) training'), (select max(id) from contact));
-- Breast Cancer Network of Strength
insert into contact (name) values ('');
update contact set phone = '3123649071', email = 'null', fax = '3123649066', url = 'http://www.networkofstrength.org/illinois' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Breast Cancer Network of Strength'), (select max(id) from contact));
-- Buddhist International Tzu Chi Relief Foundation (Midwest)
insert into contact (name) values ('Ms. Yahmei Hsieh');
update contact set phone = '6309636601', email = 'yahmeihsieh@gmail.com', fax = 'null', url = 'http://www.us.tzuchi.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Buddhist International Tzu Chi Relief Foundation (Midwest)'), (select max(id) from contact));
-- Campaign for Better Health Care
insert into contact (name) values ('Laura Leon, Director of Faith Initiatives');
update contact set phone = '3129139449', email = 'faithcaucus@cbhconline.org', fax = '3129139559', url = 'http://www.cbhconline.org/faith' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Campaign for Better Health Care'), (select max(id) from contact));
-- Caring for Health
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Caring for Health'), (select max(id) from contact));
-- CARRI (Chicago Area Regional Recovery Initiative)
insert into contact (name) values ('Rev. Dave Roth');
update contact set phone = '7084885581', email = 'dave_roth@lcfs.org', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'CARRI (Chicago Area Regional Recovery Initiative)'), (select max(id) from contact));
-- Center for Faith and Health
insert into contact (name) values ('Mary Chase-Ziolek, PhD, RN Director, Professor of Health Ministries');
update contact set phone = '7732446201', email = 'null', fax = '7732446244', url = 'http://www.northpark.edu/sem/academics/faculty/mchasez.html' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Center for Faith and Health'), (select max(id) from contact));
-- Central Spanish Baptist Church
insert into contact (name) values ('Rev. Shakespeare Osorio');
update contact set phone = '7733420836', email = 'pastor@iglesiabautistacentral.org', fax = 'null', url = 'http://www.iglesiabautistacentral.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Central Spanish Baptist Church'), (select max(id) from contact));
-- Chicago Chin Baptist Church
insert into contact (name) values ('Pastor Danny Bawi Thianhlun');
update contact set phone = '7736033263', email = 'chicagochinbaptistchurch@gmail.com', fax = 'null', url = 'null' where id = (select max(id) from contact);
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
insert into contact (name) values ('Mr. Shanker Pillai');
update contact set phone = '6306533370', email = 'pillaishanker@gmail.com', fax = 'null', url = 'http://www.mychinmaya.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Chinmaya Mission Chicago-Badri'), (select max(id) from contact));
-- Christ Temple Apostolic Faith Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Christ Temple Apostolic Faith Church'), (select max(id) from contact));
-- Christ the King Lutheran Church ELCA
insert into contact (name) values ('Sandra Guy, Leadership team member');
update contact set phone = '3129393720', email = 'sguy178525@aol.com', fax = '3123213027', url = 'null' where id = (select max(id) from contact);
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
insert into contact (name) values ('Marty Hatlie, CEO');
update contact set phone = '3129066196', email = 'null', fax = '3129066123', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Coalition for Quality and Patient Safety of Chicagoland'), (select max(id) from contact));
-- Community Health Services and Health Promotion
insert into contact (name) values ('Bette Lawrence Water, Program Manager');
update contact set phone = '6306827979', email = 'blwater@dupagehealth.org', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Community Health Services and Health Promotion'), (select max(id) from contact));
-- Community-Outreach Project
insert into contact (name) values ('Michele Ariyo');
update contact set phone = '7734734100', email = 'MAriyo@cityforce.org', fax = '7734734200', url = 'http://www.ilfba.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Community-Outreach Project'), (select max(id) from contact));
-- Congregational Health Partnerships
insert into contact (name) values ('Rev. Kirsten Peachey');
update contact set phone = '8473843552', email = 'kirsten.peachey@advocatehealth.com', fax = '8476960239', url = 'http://www.advocatehealth.com/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Congregational Health Partnerships'), (select max(id) from contact));
-- Congregational Outreach
insert into contact (name) values ('');
update contact set phone = '3127334640', email = 'veronica@faithinplace.org', fax = '3127334610', url = 'http://faithinplace.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Congregational Outreach'), (select max(id) from contact));
-- Congregational United Church of Christ of Arlington Heights
insert into contact (name) values ('Pastor Rex Piercy');
update contact set phone = 'null', email = 'pastorcucc@sbcglobal.net', fax = 'null', url = 'http://www.congucc.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Congregational United Church of Christ of Arlington Heights'), (select max(id) from contact));
-- Consortium to Lower Obesity in Chicago Children (CLOCC)
insert into contact (name) values ('Rev. James Kenady, Lead Community Liaison');
update contact set phone = '3125737749', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Consortium to Lower Obesity in Chicago Children (CLOCC)'), (select max(id) from contact));
-- Cornerstone Community Outreach
insert into contact (name) values ('Ms. Sandy Ramsey');
update contact set phone = '7735066396', email = 'sramsey@jpusa.org', fax = 'null', url = 'http://www.ccolife.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Cornerstone Community Outreach'), (select max(id) from contact));
-- Council of Islamic Organizations of Greater Chicago
insert into contact (name) values ('Ms. Ahlam Jbara');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'http://www.ciogc.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Council of Islamic Organizations of Greater Chicago'), (select max(id) from contact));
-- Delegate Church Association of Advocate BroMenn Medical Center
insert into contact (name) values ('The Rev. Cheree\' Johnson');
update contact set phone = '3092685499', email = 'BROM-ChurchRelations@advocatehealth.com', fax = 'null', url = 'http://www.advocatehealth.com/bromenn/churchrelations' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Delegate Church Association of Advocate BroMenn Medical Center'), (select max(id) from contact));
-- DuPage Department of Public Health
insert into contact (name) values ('');
update contact set phone = '6306827979', email = 'null', fax = '6304629085', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'DuPage Department of Public Health'), (select max(id) from contact));
-- Ebenezer Baptist
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Ebenezer Baptist'), (select max(id) from contact));
-- Ebenezer Lutheran Church
insert into contact (name) values ('');
update contact set phone = '7735618496', email = 'null', fax = '7735618001', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Ebenezer Lutheran Church'), (select max(id) from contact));
-- Edgewater Presbyterian Church
insert into contact (name) values ('Rev. Dr. Barb Cathey');
update contact set phone = '7735614748', email = 'macphie@sbcglobal.net', fax = 'null', url = 'http://www.edgewaterpres.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Edgewater Presbyterian Church'), (select max(id) from contact));
-- Education and Life Coaching
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Education and Life Coaching'), (select max(id) from contact));
-- Epworth United Methodist Church
insert into contact (name) values ('Rev. Amos Olidapo');
update contact set phone = 'null', email = 'epworthchicago@gmail.com', fax = 'null', url = 'http://www.epworthchicago.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Epworth United Methodist Church'), (select max(id) from contact));
-- Evergreen Presbyterian Church
insert into contact (name) values ('Rev. Yun Chun Han');
update contact set phone = '8475374449', email = 'hesed333@yahoo.com', fax = 'null', url = 'http://www.egreenpc.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Evergreen Presbyterian Church'), (select max(id) from contact));
-- Exodus Community Church
insert into contact (name) values ('Rev. Dr. Jeremiah Yi');
update contact set phone = '8472089544', email = 'null', fax = 'null', url = 'http://www.exoduschurch.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Exodus Community Church'), (select max(id) from contact));
-- Faith Caucus
insert into contact (name) values ('');
update contact set phone = '3129139449', email = 'lleon@cbhconline.org', fax = '3129139559', url = 'http://www.cbhconline.org/issues/hcjc/faith.html' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Faith Caucus'), (select max(id) from contact));
-- Faith in Place
insert into contact (name) values ('');
update contact set phone = '3127264948', email = 'null', fax = '3127266108', url = 'http://www.faithinplace.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Faith in Place'), (select max(id) from contact));
-- Faith Temple COGIC
insert into contact (name) values ('');
update contact set phone = '7738461056', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Faith Temple COGIC'), (select max(id) from contact));
-- Faith United Methodist Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Faith United Methodist Church'), (select max(id) from contact));
-- Figure Facts LLC
insert into contact (name) values ('');
update contact set phone = '3129884850', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Figure Facts LLC'), (select max(id) from contact));
-- First Baptist Church, Berwyn
insert into contact (name) values ('Rev. Dr. Damon Jones');
update contact set phone = '7087498800', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'First Baptist Church, Berwyn'), (select max(id) from contact));
-- First Baptist Church, LaGrange
insert into contact (name) values ('Rev. Michael Strickland');
update contact set phone = 'null', email = 'fbclagrange@sbcglobal.net', fax = 'null', url = 'http://www.fbclagrange.com/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'First Baptist Church, LaGrange'), (select max(id) from contact));
-- First Baptist Church, Park Forest
insert into contact (name) values ('Rev. Carol Jamieson Brown');
update contact set phone = '7087482566', email = 'pastorfbc@yahoo.com', fax = 'null', url = 'http://www.fbcparkforest.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'First Baptist Church, Park Forest'), (select max(id) from contact));
-- First Congregational Church of Western Springs
insert into contact (name) values ('Deborah Stankiewicz, AHC Parish Nurse');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'http://www.wscongo.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'First Congregational Church of Western Springs'), (select max(id) from contact));
-- First Evangelical Free Church
insert into contact (name) values ('Rev. Bill Shereos');
update contact set phone = 'null', email = 'bshereos@firstfree.com', fax = 'null', url = 'http://www.firstfree.com/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'First Evangelical Free Church'), (select max(id) from contact));
-- First Grace Missionary Baptist Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'First Grace Missionary Baptist Church'), (select max(id) from contact));
-- First New Bethlehem Community Development Corporation
insert into contact (name) values ('The Rev. Rickey Kendrick, Executive Director');
update contact set phone = '7734886053', email = 'newbethlehem@gmail.com', fax = '7736021559', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'First New Bethlehem Community Development Corporation'), (select max(id) from contact));
-- Flossmoor Community Church
insert into contact (name) values ('');
update contact set phone = '7087982800', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Flossmoor Community Church'), (select max(id) from contact));
-- Fourth Presbyterian Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Fourth Presbyterian Church'), (select max(id) from contact));
-- Friendly Visits
insert into contact (name) values ('Heather Dudzinski, Community Outreach Coordinator');
update contact set phone = '3124551000', email = 'null', fax = '3124559674', url = 'null' where id = (select max(id) from contact);
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
insert into contact (name) values ('Rev. Rodney C. Walker');
update contact set phone = '7737835145', email = 'rodneycwalker@yahoo.com', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Grace Calvary United Methodist Church'), (select max(id) from contact));
-- Grace Calvary United Methodist Church- Gospel Cafe
insert into contact (name) values ('Rev. Rodney C. Walker');
update contact set phone = '7737835145', email = 'rodneycwalker@yahoo.com', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Grace Calvary United Methodist Church- Gospel Cafe'), (select max(id) from contact));
-- Grace Evangelical Lutheran Church
insert into contact (name) values ('Pastor Jade Yi');
update contact set phone = 'null', email = 'gracevillapark@yahoo.com', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Grace Evangelical Lutheran Church'), (select max(id) from contact));
-- Grace Lutheran Church
insert into contact (name) values ('Dr. MaryBeth Buschmann');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'http://www.graceriverforest.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Grace Lutheran Church'), (select max(id) from contact));
-- Greater Galilee MB Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Greater Galilee MB Church'), (select max(id) from contact));
-- Greater Galilee Missionary Baptist Church
insert into contact (name) values ('Charlayne Guy Moore');
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
update contact set phone = '7735224812', email = 'null', fax = '7735224812', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Greater St. Paul A M E C'), (select max(id) from contact));
-- Greater Walters AME Zion Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Greater Walters AME Zion Church'), (select max(id) from contact));
-- Hamdard Center for Health and Human Services
insert into contact (name) values ('Ms. Kiran Siddiqui');
update contact set phone = '7734654600', email = 'ksidd@hamdardcenter.org', fax = 'null', url = 'http://www.hamdardcenter.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Hamdard Center for Health and Human Services'), (select max(id) from contact));
-- Health Initiatives, West Cook Area
insert into contact (name) values ('Carmen Carrizales, Health Initiatives Representative');
update contact set phone = '7084848541', email = 'null', fax = '7084843179', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Health Initiatives, West Cook Area'), (select max(id) from contact));
-- Healthcare Consortium of Illinois
insert into contact (name) values ('Mayme Buckley, Associate Director, Interfaith and Development');
update contact set phone = '7088419515', email = 'mbcukley@hcionline.org', fax = '7088419713', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Healthcare Consortium of Illinois'), (select max(id) from contact));
-- Healthy Dining Chicago Healthy Dining Chicago
insert into contact (name) values ('');
update contact set phone = '3126669979', email = 'Laura@HealthyDinning.org', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Healthy Dining Chicago Healthy Dining Chicago'), (select max(id) from contact));
-- Healthy Spirit Healthy Soul
insert into contact (name) values ('Desmond Konadu, Senior Health Initiatives Representative');
update contact set phone = '3122797278', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Healthy Spirit Healthy Soul'), (select max(id) from contact));
-- Hispanocare - Chicago
insert into contact (name) values ('Maria Oquendo, Coordinator');
update contact set phone = '7732967157', email = 'maria.oquendo@advocatehealth.com', fax = '7733278208', url = 'http://www.hispanocare.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Hispanocare - Chicago'), (select max(id) from contact));
-- Hyde Park Christian Reformed Church
insert into contact (name) values ('Mr. Eric Chua');
update contact set phone = '7732882677', email = 'eric.chua@juno.com', fax = 'null', url = 'http://www.hydeparkcrc.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Hyde Park Christian Reformed Church'), (select max(id) from contact));
-- Illinois Faith Based Emergency Preparedness Initiative
insert into contact (name) values ('Dr. Leon Dingle');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'http://www.idph.state.il.us/planready/index.htm' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Illinois Faith Based Emergency Preparedness Initiative'), (select max(id) from contact));
-- Illinois Maternal and Child Health Coalition
insert into contact (name) values ('');
update contact set phone = '3124918161', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Illinois Maternal and Child Health Coalition'), (select max(id) from contact));
-- Illinois PIRG
insert into contact (name) values ('');
update contact set phone = '3122910441', email = 'alozanoff@illinoispirg.org', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Illinois PIRG'), (select max(id) from contact));
-- Illinois Women's Health Registry
insert into contact (name) values ('Sarah Bristol-Gould Director, Research Programs; IL Women\'s Health Registry');
update contact set phone = '3125031764', email = 'null', fax = '3125061764', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Illinois Women\'s Health Registry'), (select max(id) from contact));
-- Imagine Chicago
insert into contact (name) values ('');
update contact set phone = '7732752520', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Imagine Chicago'), (select max(id) from contact));
-- Inner City Muslim Action Network
insert into contact (name) values ('Mr. Shamar Hemphill');
update contact set phone = '7734344626', email = 'shamar@imancentral.org', fax = 'null', url = 'http://www.imancentral.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Inner City Muslim Action Network'), (select max(id) from contact));
-- Institute for Women\'s Health Research
insert into contact (name) values ('');
update contact set phone = '3125031308', email = 'null', fax = '3125031764', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Institute for Women\'s Health Research'), (select max(id) from contact));
-- Islamic Community Center
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Islamic Community Center'), (select max(id) from contact));
-- Islamic Foundation of Villa Park
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Islamic Foundation of Villa Park'), (select max(id) from contact));
-- Ismaili Center in Chicago
insert into contact (name) values ('Mr. Nizar Jawani');
update contact set phone = '7732621616', email = 'nizar.jiwani@gmail.com', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Ismaili Center in Chicago'), (select max(id) from contact));
-- Ismaili Center in Glenview
insert into contact (name) values ('Mr. Nizar Jiwani, Communications Director');
update contact set phone = '3123995713', email = 'nizar.jiwani@gmail.com', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Ismaili Center in Glenview'), (select max(id) from contact));
-- Jesus Name Apostolic Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Jesus Name Apostolic Church'), (select max(id) from contact));
-- Jewish Child and Family Services
insert into contact (name) values ('Ms. Robin Levine');
update contact set phone = '7734673700', email = 'null', fax = 'null', url = 'http://www.jcfs.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Jewish Child and Family Services'), (select max(id) from contact));
-- Jewish Community Emergency Resiliency Team
insert into contact (name) values ('Ms. Charlotte Mallon');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'http://www.juf.org/guide/category.aspx?id=31892' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Jewish Community Emergency Resiliency Team'), (select max(id) from contact));
-- Jewish Healing Network of Chicago
insert into contact (name) values ('');
update contact set phone = '8475685216', email = 'null', fax = '8475685125', url = 'http://www.jcfs.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Jewish Healing Network of Chicago'), (select max(id) from contact));
-- Jewish School-Based Wellness Initiative
insert into contact (name) values ('Maureen Benjamins Senior Epidemiologist');
update contact set phone = '7732572324', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Jewish School-Based Wellness Initiative'), (select max(id) from contact));
-- Joshua Missionary Baptist Church
insert into contact (name) values ('');
update contact set phone = '7735330034', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Joshua Missionary Baptist Church'), (select max(id) from contact));
-- Journey Community Church
insert into contact (name) values ('Rev. Daniel Park');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'http://www.journeytogether.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Journey Community Church'), (select max(id) from contact));
-- Joy To Be Fit Gospel Aerobics Ministry
insert into contact (name) values ('Stephanie Jackson-Rowe, Founder and President');
update contact set phone = '7083662633', email = 'joytobefitboom@sbcaol.com', fax = 'null', url = 'null' where id = (select max(id) from contact);
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
update contact set phone = '7083444470', email = 'null', fax = '7083444564', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'La Academia'), (select max(id) from contact));
-- Lakeview Presbyterian Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Lakeview Presbyterian Church'), (select max(id) from contact));
-- Latino Community Program
insert into contact (name) values ('Judy Guitelman, Program Coordinator');
update contact set phone = '3123649071', email = 'null', fax = '3123649066', url = 'http://www.networkofstrength.org/illinois' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Latino Community Program'), (select max(id) from contact));
-- LaVerne Barnes
insert into contact (name) values ('');
update contact set phone = '7083969777', email = 'null', fax = '7083969732', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'LaVerne Barnes'), (select max(id) from contact));
-- Lead Safe Housing Initiatives
insert into contact (name) values ('Mary Burns, Community Projects Director');
update contact set phone = '3129156811', email = 'null', fax = '3129156485', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Lead Safe Housing Initiatives'), (select max(id) from contact));
-- lead safe illinois
insert into contact (name) values ('');
update contact set phone = '3129156811', email = 'null', fax = '3129156485', url = 'http://www.leadsafeillinois.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'lead safe illinois'), (select max(id) from contact));
-- Leadership and Church Development
insert into contact (name) values ('Jorge Montes, Reverend');
update contact set phone = '7083444470', email = 'illconfmontes@aol.com', fax = '7083444564', url = 'http://www.uccillconf.org/' where id = (select max(id) from contact);
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
-- Little Brothers - Friends of the Elderly, Chicago Chapter
insert into contact (name) values ('');
update contact set phone = '3124551000', email = 'null', fax = '3124559674', url = 'http://www.littlebrotherschicago.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Little Brothers - Friends of the Elderly, Chicago Chapter'), (select max(id) from contact));
-- Lively Stone Missonary Baptist Church
insert into contact (name) values ('');
update contact set phone = '7733791750', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Lively Stone Missonary Baptist Church'), (select max(id) from contact));
-- Living Well Ministries
insert into contact (name) values ('');
update contact set phone = '7736554357', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Living Well Ministries'), (select max(id) from contact));
-- Lutheran Church of Atonement
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Lutheran Church of Atonement'), (select max(id) from contact));
-- Lutheran Church of the Ascension
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Lutheran Church of the Ascension'), (select max(id) from contact));
-- Lutheran General Hospital - Mission and Spiritual
insert into contact (name) values ('Rev. Kathi Bender Schwich');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'http://www.advocatehealth.com/lgch/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Lutheran General Hospital - Mission and Spiritual'), (select max(id) from contact));
-- Lutheran Social Services of Illinois
insert into contact (name) values ('Daniel Schwick, V.P Church and Community');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'http://www.lssi.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Lutheran Social Services of Illinois'), (select max(id) from contact));
-- M.I.K.E. Minority Intervention and Kidney Education Program
insert into contact (name) values ('Courtney Nicholas, Associate Director');
update contact set phone = '3122248172', email = 'cnicholas@kidneyfund.org', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'M.I.K.E. Minority Intervention and Kidney Education Program'), (select max(id) from contact));
-- Ministry to New Moms
insert into contact (name) values ('Vicki Burke, Founder of the Ministry to New Moms');
update contact set phone = '7086477658', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
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
insert into contact (name) values ('Imam Kifah Mustapha');
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
insert into contact (name) values ('Rev. Dr. Biak Mang');
update contact set phone = '7734931847', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Myanmar Christian Church of Metro Chicago'), (select max(id) from contact));
-- New Hope Bible Church
insert into contact (name) values ('');
update contact set phone = '3123942860', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'New Hope Bible Church'), (select max(id) from contact));
-- New Life Baptist Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'New Life Baptist Church'), (select max(id) from contact));
-- New Life Community Church
insert into contact (name) values ('');
update contact set phone = '7738389470', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'New Life Community Church'), (select max(id) from contact));
-- New Life Covenant Church
insert into contact (name) values ('');
update contact set phone = '7733847113', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
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
update contact set phone = '7732446201', email = 'null', fax = '7732446244', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'North Park Theological Seminary'), (select max(id) from contact));
-- North Shore Baptist Church
insert into contact (name) values ('Ms. Dawn Noldan/Mrs. Emy Kosmas');
update contact set phone = '7737284200', email = 'cmvetty@northshorebaptist.org', fax = 'null', url = 'http://www.northshorebaptist.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'North Shore Baptist Church'), (select max(id) from contact));
-- North Shore Church of Christ
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'North Shore Church of Christ'), (select max(id) from contact));
-- Northfield Presbyterian Church
insert into contact (name) values ('Rev. Bumhoon (John) Lee');
update contact set phone = '8478085700', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Northfield Presbyterian Church'), (select max(id) from contact));
-- Northside P.O.W.E.R.
insert into contact (name) values ('Marilyn Pagan-Banks, Executive Director');
update contact set phone = '7732622297', email = 'goodnewskitchen@sbcglobal.net', fax = '7732627872', url = 'http://www.gnck.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Northside P.O.W.E.R.'), (select max(id) from contact));
-- Nuestra Senora de Gaudalupe
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Nuestra Senora de Gaudalupe'), (select max(id) from contact));
-- Older Adult Programs
insert into contact (name) values ('Dana Bright Community Health Coordinator');
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
insert into contact (name) values ('Brett McCleneghan, Senior Minister');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Park Ridge Community Church'), (select max(id) from contact));
-- Peace Lutheran Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Peace Lutheran Church'), (select max(id) from contact));
-- People\'s Church of the Harvest
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'People\'s Church of the Harvest'), (select max(id) from contact));
-- Peoples Church of Chicago
insert into contact (name) values ('Rev. Jean Darling');
update contact set phone = '7737846633', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
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
insert into contact (name) values ('Gabriela Kowalczyk, Program Coordinator');
update contact set phone = '3123649071', email = 'null', fax = '3123649066', url = 'http://www.networkofstrength.org/illinois' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Polish Community'), (select max(id) from contact));
-- Primera Iglesia Congregacional
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Primera Iglesia Congregacional'), (select max(id) from contact));
-- Program of Religion/Spirituality and Mental Health
insert into contact (name) values ('');
update contact set phone = '3124134609', email = 'null', fax = '3124134503', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Program of Religion/Spirituality and Mental Health'), (select max(id) from contact));
-- Progressive Baptist Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Progressive Baptist Church'), (select max(id) from contact));
-- Pui Tak Center
insert into contact (name) values ('Mr. David Wu');
update contact set phone = '3123281188', email = 'davidwu@puitak.org', fax = 'null', url = 'http://www.puitak.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Pui Tak Center'), (select max(id) from contact));
-- Rahab\'s House, Inc.
insert into contact (name) values ('Denise Henley, Rev./President');
update contact set phone = '7735935896', email = 'admin@rahabshouse.net', fax = 'null', url = 'http://www.rahabshouse.net/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Rahab\'s House, Inc.'), (select max(id) from contact));
-- Rainbow Hospice and Palliative Care
insert into contact (name) values ('Dave Samson');
update contact set phone = '8476859900', email = 'Info@RainbowHospice.org', fax = '8472949613', url = 'http://www.rainbowhospice.org/' where id = (select max(id) from contact);
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
update contact set phone = '8007570202', email = 'null', fax = '3129426116', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Rush University Medical Center'), (select max(id) from contact));
-- Salem Baptist
insert into contact (name) values ('');
update contact set phone = '7733712300', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
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
update contact set phone = '7732572324', email = 'null', fax = '7732575680', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Sinai Urban Health Institute'), (select max(id) from contact));
-- South Suburban Interfaith Ministerial Association
insert into contact (name) values ('Re. Kris Orr');
update contact set phone = '7087984150', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'South Suburban Interfaith Ministerial Association'), (select max(id) from contact));
-- Spanish Christian Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Spanish Christian Church'), (select max(id) from contact));
-- St Matthews United Methodist Church
insert into contact (name) values ('');
update contact set phone = '3123377111', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'St Matthews United Methodist Church'), (select max(id) from contact));
-- St. Ailbe Catholic Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'St. Ailbe Catholic Church'), (select max(id) from contact));
-- St. Anne Church
insert into contact (name) values ('Rev. Thomas Bishop');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'St. Anne Church'), (select max(id) from contact));
-- St. Clement\'s Episcopal Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'St. Clement\'s Episcopal Church'), (select max(id) from contact));
-- St. Francis of Assisi Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'St. Francis of Assisi Church'), (select max(id) from contact));
-- St. Genevieve Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'St. Genevieve Church'), (select max(id) from contact));
-- St. Ita Catholic Church
insert into contact (name) values ('Sr. Mary Jeanne Hayes');
update contact set phone = '7735615343', email = 'mjh816@sbcglobal.net', fax = 'null', url = 'http://www.saintita.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'St. Ita Catholic Church'), (select max(id) from contact));
-- St. James Lutheran Church
insert into contact (name) values ('Pastor Erin Clausen');
update contact set phone = 'null', email = 'stjames.pastor@gmail.com', fax = 'null', url = 'http://www.stjamesws.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'St. James Lutheran Church'), (select max(id) from contact));
-- St. John MB Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'St. John MB Church'), (select max(id) from contact));
-- St. John United Church of Christ
insert into contact (name) values ('');
update contact set phone = '8472556687', email = 'office@churchonthepark.com', fax = '8472556388', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'St. John United Church of Christ'), (select max(id) from contact));
-- St. Kevins\'s Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'St. Kevins\'s Church'), (select max(id) from contact));
-- St. Luke\'s Lutheran of Logan Square
insert into contact (name) values ('');
update contact set phone = '7732355420', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'St. Luke\'s Lutheran of Logan Square'), (select max(id) from contact));
-- St. Luke\'s Lutheran Church of Logan Square
insert into contact (name) values ('Erik Christensen, Rev.');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'St. Luke\'s Lutheran Church of Logan Square'), (select max(id) from contact));
-- St. Mark International Christian Ch.
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'St. Mark International Christian Ch.'), (select max(id) from contact));
-- St. Paul UCC
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'St. Paul UCC'), (select max(id) from contact));
-- St. Paul\'s Church by-the-Lake
insert into contact (name) values ('Ms. Judith Gramer');
update contact set phone = 'null', email = 'jvg001@sbcglobal.net', fax = 'null', url = 'http://www.stpaulsbylake.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'St. Paul\'s Church by-the-Lake'), (select max(id) from contact));
-- St. Pius V. Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'St. Pius V. Church'), (select max(id) from contact));
-- St. Sabina Church
insert into contact (name) values ('');
update contact set phone = '7734834300', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'St. Sabina Church'), (select max(id) from contact));
-- St. Stephen AME Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'St. Stephen AME Church'), (select max(id) from contact));
-- St. Sylvester Catholic Church
insert into contact (name) values ('Dora Albert');
update contact set phone = '7732353646', email = 'stsylvester@archchicago.org', fax = 'null', url = 'http://stsylvesterparish.com/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'St. Sylvester Catholic Church'), (select max(id) from contact));
-- Suburban Chicago Interfaith Mental Health Coalition
insert into contact (name) values ('Mr. Bob Skrocki');
update contact set phone = '6306827979', email = 'null', fax = 'null', url = 'http://www.scimc.org/' where id = (select max(id) from contact);
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
insert into contact (name) values ('Rev. Patti Nakai');
update contact set phone = '7733344661', email = 'rev.eshin.patti23@gmail.com', fax = 'null', url = 'http://www.budtempchi.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'The Buddhist Temple of Chicago'), (select max(id) from contact));
-- The Christian Aerobics and Fitness Association (CAFA)
insert into contact (name) values ('');
update contact set phone = '7083662633', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'The Christian Aerobics and Fitness Association (CAFA)'), (select max(id) from contact));
-- The South Church
insert into contact (name) values ('Rev. Rick Kessler');
update contact set phone = '8472530501', email = 'null', fax = 'null', url = 'http://www.thesouthchurch.com/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'The South Church'), (select max(id) from contact));
-- The Unversity of Illinois Medical Center for Women\'s Health Associates
insert into contact (name) values ('Contact: Sharon Greene-Hughes, Antenatal Testing Specialist, Maternal Fetal Medicine High Risk Nurse');
update contact set phone = '3124137500', email = 'sghughes@uic.edu', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'The Unversity of Illinois Medical Center for Women\'s Health Associates'), (select max(id) from contact));
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
insert into contact (name) values ('Ms. Ann Fisher Raney');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'http://www.tpoint.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Turning Point'), (select max(id) from contact));
-- Ubumama - Chicago
insert into contact (name) values ('Bliss Browne, President');
update contact set phone = 'null', email = 'bliss@imaginechicago.org', fax = 'null', url = 'http://www.ubumama.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Ubumama - Chicago'), (select max(id) from contact));
-- United Baptist Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'United Baptist Church'), (select max(id) from contact));
-- United Faith Missionary Baptist Church
insert into contact (name) values ('');
update contact set phone = '7083381150', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'United Faith Missionary Baptist Church'), (select max(id) from contact));
-- United in Faith Church
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'United in Faith Church'), (select max(id) from contact));
-- Unity Lutheran Church
insert into contact (name) values ('Rev. Fred Kinsey');
update contact set phone = '7738784747', email = 'unitylutheran@ameritech.net', fax = 'null', url = 'http://www.unitylutheranchicago.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Unity Lutheran Church'), (select max(id) from contact));
-- Unity Northwest Church
insert into contact (name) values ('Rev. Greg Barrette');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'http://www.unitynorthwest.org/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Unity Northwest Church'), (select max(id) from contact));
-- Universal House of Refuge Center
insert into contact (name) values ('');
update contact set phone = 'null', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Universal House of Refuge Center'), (select max(id) from contact));
-- University of Illinois\' Division of Community Health
insert into contact (name) values ('Bertha Paul, School and Community Health Educator');
update contact set phone = '3129964656', email = 'null', fax = '3129963848', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'University of Illinois\' Division of Community Health'), (select max(id) from contact));
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
insert into contact (name) values ('Janine Lewis, Director of Health Promotions');
update contact set phone = '7737860249', email = 'jlewis6@gmail.com', fax = '7737860256', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Westside Health Authority'), (select max(id) from contact));
-- Wholistic Medical Clinic
insert into contact (name) values ('');
update contact set phone = '7083969777', email = 'null', fax = 'null', url = 'null' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'Wholistic Medical Clinic'), (select max(id) from contact));
-- ZAM\'s Hope Community Resource Center
insert into contact (name) values ('');
update contact set phone = 'null', email = 'zehra_zamshope@yahoo.com', fax = 'null', url = 'http://www.zamshope.net/' where id = (select max(id) from contact);
insert into organization_contact (organization_fk, contact_fk) values ((select id from organization where name = 'ZAM\'s Hope Community Resource Center'), (select max(id) from contact));