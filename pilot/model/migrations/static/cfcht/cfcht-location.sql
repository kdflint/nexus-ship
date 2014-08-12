-- executed, error on mismatched quotation mark. One mismatched organization name. Both fixed.

--30th Ward - St. James Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('5730 W. Fullerton', '', 'Chicago', 'Illinois', '60639', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = '30th Ward - St. James Church'), (select max(id) from location));
--A Just Harvest
insert into location (address1, address2, municipality, region2, postal_code, country) values ('7649 North Paulina Street', '', 'Chicago', 'Illinois', '60626', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'A Just Harvest'), (select max(id) from location));
--Access Living
insert into location (address1, address2, municipality, region2, postal_code, country) values ('115 W. Chicago', '', 'Chicago', 'Illinois', '60654', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Access Living'), (select max(id) from location));
--Adalberto Memorial United Methodist Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('2716 W Division St', '', 'Chicago', 'Illinois', '60622', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Adalberto Memorial United Methodist Church'), (select max(id) from location));
--Advocate Christ Medical Center
insert into location (address1, address2, municipality, region2, postal_code, country) values ('4440 W. 95th St.', '', 'Oak Lawn', 'Illinois', '60453', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Advocate Christ Medical Center'), (select max(id) from location));
--Advocate Clinical Pastoral Education
insert into location (address1, address2, municipality, region2, postal_code, country) values ('2025 Windsor Drive', '', 'Oak Brook', 'Illinois', '60523', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Advocate Clinical Pastoral Education'), (select max(id) from location));
--Advocate Health Care
insert into location (address1, address2, municipality, region2, postal_code, country) values ('2025 Windsor Drive', '', 'Oak Brook', 'Illinois', '60523', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Advocate Health Care'), (select max(id) from location));
--Advocate Parish Nurse Ministry
insert into location (address1, address2, municipality, region2, postal_code, country) values ('205 W. Touhy Ave.', 'Suite 127', 'Park Ridge', 'Illinois', '60068', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Advocate Parish Nurse Ministry'), (select max(id) from location));
--Advocate United Church of Christ
insert into location (address1, address2, municipality, region2, postal_code, country) values ('2440 York', '', 'Blue Island', 'Illinois', '60406', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Advocate United Church of Christ'), (select max(id) from location));
--African-American Alzheimer\'s Outreach Initiative
insert into location (address1, address2, municipality, region2, postal_code, country) values ('8430 W. Bryn Mawr Avenue', 'Suite 800', 'Chicago', 'Illinois', '60631', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'African-American Alzheimer\'s Outreach Initiative'), (select max(id) from location));
--Agape Family Life Center
insert into location (address1, address2, municipality, region2, postal_code, country) values ('2424 W. Lithuanian Plaza', '', 'Chicago', 'Illinois', '60629', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Agape Family Life Center'), (select max(id) from location));
--Age Options
insert into location (address1, address2, municipality, region2, postal_code, country) values ('1048 Lake St.', 'Suite 300', 'Oak Park', 'Illinois', '60301', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Age Options'), (select max(id) from location));
--Alexian Brothers Parish Services
insert into location (address1, address2, municipality, region2, postal_code, country) values ('25 E. Schaumburg Rd.', 'Suite 106', 'Schaumburg', 'Illinois', '60194', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Alexian Brothers Parish Services'), (select max(id) from location));
--Alzheimer's Association - Greater Illinois Chapter
insert into location (address1, address2, municipality, region2, postal_code, country) values ('8430 W. Bryn Mawr Avenue', 'Suite 800', 'Chicago', 'Illinois', '60631', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Alzheimer\'s Association - Greater Illinois Chapter'), (select max(id) from location));
--Am I My Brothers Keeper
insert into location (address1, address2, municipality, region2, postal_code, country) values ('283 E. Lincoln Highway', '', 'Chicago Heights', 'Illinois', '60411', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Am I My Brothers Keeper'), (select max(id) from location));
--American Heart Association Cultural Health Initiatives
insert into location (address1, address2, municipality, region2, postal_code, country) values ('208 S. LaSalle Street', 'Suite 900', 'Chicago', 'Illinois', '60604', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'American Heart Association Cultural Health Initiatives'), (select max(id) from location));
--American Kidney Fund
insert into location (address1, address2, municipality, region2, postal_code, country) values ('4259 S. Berkeley Avenue', '', 'Chicago', 'Illinois', '60653', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'American Kidney Fund'), (select max(id) from location));
--Antioch Telegu Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('2788 Wolf Rd.', '', 'Northlake', 'Illinois', '60164', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Antioch Telegu Church'), (select max(id) from location));
--Apostolic Church of God
insert into location (address1, address2, municipality, region2, postal_code, country) values ('3823 S. Indiana Ave', '', 'Chicago', 'Illinois', '60653', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Apostolic Church of God'), (select max(id) from location));
--Apostolic Faith Church Health Professions Ministry
insert into location (address1, address2, municipality, region2, postal_code, country) values ('3823 South Ind. Ave.', '', 'Chicago', 'Illinois', '60653', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Apostolic Faith Church Health Professions Ministry'), (select max(id) from location));
--B\'nai Yehuda Beth Shalom
insert into location (address1, address2, municipality, region2, postal_code, country) values ('1424 W. 183rd St.', '', 'Homewood', 'Illinois', '60430', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'B\'nai Yehuda Beth Shalom'), (select max(id) from location));
--Beacon Light
insert into location (address1, address2, municipality, region2, postal_code, country) values ('4236 W. Cermak RD', '', 'Chicago', 'Illinois', '60623', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Beacon Light'), (select max(id) from location));
--Bethel Reform Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('5433 S. Austin', '', 'Chicago', 'Illinois', '60638', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Bethel Reform Church'), (select max(id) from location));
--Bikur Cholim (visiting the sick) training
insert into location (address1, address2, municipality, region2, postal_code, country) values ('5150 Golf Road', '', 'Skokie', 'Illinois', '60077', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Bikur Cholim (visiting the sick) training'), (select max(id) from location));
--Breast Cancer Network of Strength
insert into location (address1, address2, municipality, region2, postal_code, country) values ('300 W. Adams', 'Suite 430', 'Chicago', 'Illinois', '60606', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Breast Cancer Network of Strength'), (select max(id) from location));
--Buddhist International Tzu Chi Relief Foundation (Midwest)
insert into location (address1, address2, municipality, region2, postal_code, country) values ('1430 Plainfield Rd.', '', 'Darien', 'Illinois', '60561', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Buddhist International Tzu Chi Relief Foundation (Midwest)'), (select max(id) from location));
--Campaign for Better Health Care
insert into location (address1, address2, municipality, region2, postal_code, country) values ('1325 S. Wabash', 'Suite 305', 'Chicago', 'Illinois', '60605', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Campaign for Better Health Care'), (select max(id) from location));
--CARRI (Chicago Area Regional Recovery Initiative)
insert into location (address1, address2, municipality, region2, postal_code, country) values ('7620 Madison Ave.', '%LCFS', 'River Forest', 'Illinois', '60305', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'CARRI (Chicago Area Regional Recovery Initiative)'), (select max(id) from location));
--Center for Faith and Health
insert into location (address1, address2, municipality, region2, postal_code, country) values ('3225 W. Foster Ave.', '', 'Chicago', 'Illinois', '60625', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Center for Faith and Health'), (select max(id) from location));
--Central Spanish Baptist Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('2417 N. Campbell', '', 'Chicago', 'Illinois', '60647', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Central Spanish Baptist Church'), (select max(id) from location));
--Chicago Chin Baptist Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('5255 N. Ashland', '', 'Chicago', 'Illinois', '60660', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Chicago Chin Baptist Church'), (select max(id) from location));
--Chicago Theological Seminary
insert into location (address1, address2, municipality, region2, postal_code, country) values ('5757 S. University Avenue', '', 'Chicago', 'Illinois', '60637', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Chicago Theological Seminary'), (select max(id) from location));
--Chicago Uptown Ministry
insert into location (address1, address2, municipality, region2, postal_code, country) values ('4720 N. Sheridan Rd.', '', 'Chicago', 'Illinois', '60641', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Chicago Uptown Ministry'), (select max(id) from location));
--Chinmaya Mission Chicago-Badri
insert into location (address1, address2, municipality, region2, postal_code, country) values ('11 S 80 Rte. 83', '', 'Willowbrook', 'Illinois', '60527', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Chinmaya Mission Chicago-Badri'), (select max(id) from location));
--Christ Temple Apostolic Faith Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('14 S. Ashland Ave.', '', 'Chicago', 'Illinois', '60607', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Christ Temple Apostolic Faith Church'), (select max(id) from location));
--Christian Churches Caring
insert into location (address1, address2, municipality, region2, postal_code, country) values ('4100 N. Long Ave.', '', 'Chicago', 'Illinois', '60641', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Christian Churches Caring'), (select max(id) from location));
--Christian Fellowship Flock
insert into location (address1, address2, municipality, region2, postal_code, country) values ('10724 S Ewing Ave', '', 'Chicago', 'Illinois', '60617', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Christian Fellowship Flock'), (select max(id) from location));
--Church of Jesus Christ Latter Day Saints
insert into location (address1, address2, municipality, region2, postal_code, country) values ('3235 W. Wrightwood', '', 'Chicago', 'Illinois', '60647', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Church of Jesus Christ Latter Day Saints'), (select max(id) from location));
--Community Health Services and Health Promotion
insert into location (address1, address2, municipality, region2, postal_code, country) values ('111 N. County Farm Road', '', 'Wheaton', 'Illinois', '60187', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Community Health Services and Health Promotion'), (select max(id) from location));
--Community-Outreach Project
insert into location (address1, address2, municipality, region2, postal_code, country) values ('9 N. Cicero', '', 'Chicago', 'Illinois', '60644', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Community-Outreach Project'), (select max(id) from location));
--Congregational Health Partnerships
insert into location (address1, address2, municipality, region2, postal_code, country) values ('205 W. Touhy Ave', 'Suite 127', 'Park Ridge', 'Illinois', '60068', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Congregational Health Partnerships'), (select max(id) from location));
--Congregational Outreach
insert into location (address1, address2, municipality, region2, postal_code, country) values ('2532 W. Warren', '', 'Chicago', 'Illinois', '60612', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Congregational Outreach'), (select max(id) from location));
--Congregational United Church of Christ of Arlington Heights
insert into location (address1, address2, municipality, region2, postal_code, country) values ('1001 W. Kirchhoff Rd.', '', 'Arlington Heights', 'Illinois', '60005', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Congregational United Church of Christ of Arlington Heights'), (select max(id) from location));
--Consortium to Lower Obesity in Chicago Children (CLOCC)
insert into location (address1, address2, municipality, region2, postal_code, country) values ('2300 Children\'s Plaza', '#157', 'Chicago', 'Illinois', '60614', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Consortium to Lower Obesity in Chicago Children (CLOCC)'), (select max(id) from location));
--Cornerstone Community Outreach
insert into location (address1, address2, municipality, region2, postal_code, country) values ('4615 N. Clifton Ave.', '', 'Chicago', 'Illinois', '60640', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Cornerstone Community Outreach'), (select max(id) from location));
--Council of Islamic Organizations of Greater Chicago
insert into location (address1, address2, municipality, region2, postal_code, country) values ('231 S. State St.', '', 'Chicago', 'Illinois', '60604', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Council of Islamic Organizations of Greater Chicago'), (select max(id) from location));
--Delegate Church Association of Advocate BroMenn Medical Center
insert into location (address1, address2, municipality, region2, postal_code, country) values ('1304 Franklin Ave.', '', 'Normal', 'Illinois', '61761', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Delegate Church Association of Advocate BroMenn Medical Center'), (select max(id) from location));
--DuPage Department of Public Health
insert into location (address1, address2, municipality, region2, postal_code, country) values ('111 W. County Farm Road', '', 'Wheaton', 'Illinois', '60187', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'DuPage Department of Public Health'), (select max(id) from location));
--Ebenezer Baptist
insert into location (address1, address2, municipality, region2, postal_code, country) values ('4919 W. Lexington', '', 'Chicago', 'Illinois', '60644', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Ebenezer Baptist'), (select max(id) from location));
--Ebenezer Lutheran Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('1650 W. Foster', '', 'Chicago', 'Illinois', '60643', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Ebenezer Lutheran Church'), (select max(id) from location));
--Edgewater Presbyterian Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('1020 W. Bryn Mawr', '', 'Chicago', 'Illinois', '60660', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Edgewater Presbyterian Church'), (select max(id) from location));
--Education and Life Coaching
insert into location (address1, address2, municipality, region2, postal_code, country) values ('6554 N. Rockwell Street', '', 'Chicago', 'Illinois', '60645', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Education and Life Coaching'), (select max(id) from location));
--Epworth United Methodist Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('5253 N. Kenmore Ave.', '', 'Chicago', 'Illinois', '60640', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Epworth United Methodist Church'), (select max(id) from location));
--Evergreen Presbyterian Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('196 Highland Ave.', '', 'Wheeling', 'Illinois', '60090', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Evergreen Presbyterian Church'), (select max(id) from location));
--Exodus Community Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('385 S. Buffalo Grove Rd.', '', 'Buffalo Grove', 'Illinois', '60089', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Exodus Community Church'), (select max(id) from location));
--Faith Caucus
insert into location (address1, address2, municipality, region2, postal_code, country) values ('1325 S. Wabash', '#305', 'Chicago', 'Illinois', '60605', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Faith Caucus'), (select max(id) from location));
--Faith in Place
insert into location (address1, address2, municipality, region2, postal_code, country) values ('70 E. Lake St,', 'Suite 920', 'Chicago', 'Illinois', '60612', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Faith in Place'), (select max(id) from location));
--Faith Temple COGIC
insert into location (address1, address2, municipality, region2, postal_code, country) values ('7158 South Peoria Street', '', 'Chicago', 'Illinois', '60612', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Faith Temple COGIC'), (select max(id) from location));
--Faith United Methodist Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('15015 Grant St', '', 'Dolton', 'Illinois', '60419', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Faith United Methodist Church'), (select max(id) from location));
--First Baptist Church, Berwyn
insert into location (address1, address2, municipality, region2, postal_code, country) values ('6916 W. 34th St.', '', 'Berwyn', 'Illinois', '60402', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'First Baptist Church, Berwyn'), (select max(id) from location));
--First Baptist Church, LaGrange
insert into location (address1, address2, municipality, region2, postal_code, country) values ('20 N. Ashland Ave.', '', 'LaGrange', 'Illinois', '60525', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'First Baptist Church, LaGrange'), (select max(id) from location));
--First Baptist Church, Park Forest
insert into location (address1, address2, municipality, region2, postal_code, country) values ('80 N. Orchard Ave.', '', 'Park Forest', 'Illinois', '60466', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'First Baptist Church, Park Forest'), (select max(id) from location));
--First Congregational Church of Western Springs
insert into location (address1, address2, municipality, region2, postal_code, country) values ('1106 Chestnut St.', '', 'Western Springs', 'Illinois', '60558', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'First Congregational Church of Western Springs'), (select max(id) from location));
--First Evangelical Free Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('5255 N. Ashland', '', 'Chicago', 'Illinois', '60640', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'First Evangelical Free Church'), (select max(id) from location));
--First Grace Missionary Baptist Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('4134 W. Grenshaw Street', '', 'Chicago', 'Illinois', '60624', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'First Grace Missionary Baptist Church'), (select max(id) from location));
--First New Bethlehem Community Development Corporation
insert into location (address1, address2, municipality, region2, postal_code, country) values ('325 East 69th Street', '', 'Chicago', 'Illinois', '60637-4601', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'First New Bethlehem Community Development Corporation'), (select max(id) from location));
--Flossmoor Community Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('2218 Hutchison Road', '', 'Flossmoor', 'Illinois', '60422', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Flossmoor Community Church'), (select max(id) from location));
--Fourth Presbyterian Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('26 E. Chestnut Street', '', 'Chicago', 'Illinois', '60611', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Fourth Presbyterian Church'), (select max(id) from location));
--Friendly Visits
insert into location (address1, address2, municipality, region2, postal_code, country) values ('355 N Ashland Avenue', '', 'Chicago', 'Illinois', '60607-1019', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Friendly Visits'), (select max(id) from location));
--Friendship Baptist Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('2201 Foster St', '', 'Evanston', 'Illinois', '60201', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Friendship Baptist Church'), (select max(id) from location));
--Gloria Dei Lutheran Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('1133 Pfinsten Rd.', '', 'Northbrook', 'Illinois', '60062', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Gloria Dei Lutheran Church'), (select max(id) from location));
--God Can Ministries
insert into location (address1, address2, municipality, region2, postal_code, country) values ('1100 Greenwood Ave', '', 'Ford Heights', 'Illinois', '60411', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'God Can Ministries'), (select max(id) from location));
--Grace Calvary United Methodist Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('7800 South Loomis Blvd', '', 'Chicago', 'Illinois', '60620', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Grace Calvary United Methodist Church'), (select max(id) from location));
--Grace Calvary United Methodist Church- Gospel Cafe
insert into location (address1, address2, municipality, region2, postal_code, country) values ('7800 South Loomis Blvd.', '', 'Chicago', 'Illinois', '60620', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Grace Calvary United Methodist Church- Gospel Cafe'), (select max(id) from location));
--Grace Evangelical Lutheran Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('5 N. Princeton Ave.', '', 'Villa Park', 'Illinois', '60181', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Grace Evangelical Lutheran Church'), (select max(id) from location));
--Grace Lutheran Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('7300 Division St.', '', 'River Forest', 'Illinois', '60305', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Grace Lutheran Church'), (select max(id) from location));
--Greater Galilee MB Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('1308 W. Independence Blvd', '', 'Chicago', 'Illinois', '60623', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Greater Galilee MB Church'), (select max(id) from location));
--Greater Galilee Missionary Baptist Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('1308 S. Independence Blvd.', '', 'Chicago', 'Illinois', '60623', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Greater Galilee Missionary Baptist Church'), (select max(id) from location));
--Greater Open Door Baptist Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('1301 S. Sawyer Ave.', '', 'Chicago', 'Illinois', '60623', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Greater Open Door Baptist Church'), (select max(id) from location));
--Greater Progressive Missionary Baptist Church Baptist Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('1625 S. Lawndale', '', 'Chicago', 'Illinois', '60623', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Greater Progressive Missionary Baptist Church Baptist Church'), (select max(id) from location));
--Greater St. John Bible Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('1256 N. Waller', '', 'Chicago', 'Illinois', '60651', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Greater St. John Bible Church'), (select max(id) from location));
--Greater St. Paul A M E C
insert into location (address1, address2, municipality, region2, postal_code, country) values ('4236 W. Cermak Road', '', 'Chicago', 'Illinois', '60623', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Greater St. Paul A M E C'), (select max(id) from location));
--Greater Walters AME Zion Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('8422 S. Damen', '', 'Chicago', 'Illinois', '60620', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Greater Walters AME Zion Church'), (select max(id) from location));
--Hamdard Center for Health and Human Services
insert into location (address1, address2, municipality, region2, postal_code, country) values ('1542 West Devon Ave', '', 'Chicago', 'Illinois', '60626', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Hamdard Center for Health and Human Services'), (select max(id) from location));
--Health Initiatives, West Cook Area
insert into location (address1, address2, municipality, region2, postal_code, country) values ('7234 W. Ogden Ave', 'Suite 35', 'Riverside', 'Illinois', '60546', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Health Initiatives, West Cook Area'), (select max(id) from location));
--Healthy Spirit Healthy Soul
insert into location (address1, address2, municipality, region2, postal_code, country) values ('225 North Michigan Avenue', '#1210', 'Chicago', 'Illinois', '60601-7833', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Healthy Spirit Healthy Soul'), (select max(id) from location));
--Hispanocare - Chicago
insert into location (address1, address2, municipality, region2, postal_code, country) values ('836 W. Wellington', 'Suite 159', 'Chicago', 'Illinois', '60657', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Hispanocare - Chicago'), (select max(id) from location));
--Hyde Park Christian Reformed Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('5144 S. Cornell Ave', '', 'Chicago', 'Illinois', '60615', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Hyde Park Christian Reformed Church'), (select max(id) from location));
--Illinois Faith Based Emergency Preparedness Initiative
insert into location (address1, address2, municipality, region2, postal_code, country) values ('122 S. Michigan', 'Suite 2009', 'Chicago', 'Illinois', '60603', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Illinois Faith Based Emergency Preparedness Initiative'), (select max(id) from location));
--Illinois PIRG
insert into location (address1, address2, municipality, region2, postal_code, country) values ('407 S. Dearborn', 'Suite 701', 'Chicago', 'Illinois', '60605', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Illinois PIRG'), (select max(id) from location));
--Illinois Women's Health Registry
insert into location (address1, address2, municipality, region2, postal_code, country) values ('300 E Superior St', '', 'Chicago', 'Illinois', '60611', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Illinois Women\'s Health Registry'), (select max(id) from location));
--Imagine Chicago
insert into location (address1, address2, municipality, region2, postal_code, country) values ('910 W Castlewood Terrace', '', 'Chicago', 'Illinois', '60640', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Imagine Chicago'), (select max(id) from location));
--Inner City Muslim Action Network
insert into location (address1, address2, municipality, region2, postal_code, country) values ('2744 W. 63rd St', '', 'Chicago', 'Illinois', '60629', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Inner City Muslim Action Network'), (select max(id) from location));
--Institute for Women's Health Research
insert into location (address1, address2, municipality, region2, postal_code, country) values ('300 E Superior St', '', 'Chicago', 'Illinois', '60611', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Institute for Women\'s Health Research'), (select max(id) from location));
--Islamic Community Center
insert into location (address1, address2, municipality, region2, postal_code, country) values ('480 Potter Rd', '', 'Des Plaines', 'Illinois', '60016', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Islamic Community Center'), (select max(id) from location));
--Islamic Foundation of Villa Park
insert into location (address1, address2, municipality, region2, postal_code, country) values ('300 W. Highridge Rd', '', 'Villa Park', 'Illinois', '60181', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Islamic Foundation of Villa Park'), (select max(id) from location));
--Ismaili Center in Chicago
insert into location (address1, address2, municipality, region2, postal_code, country) values ('6259 N. Broadway Ave', '', 'Chicago', 'Illinois', '60660', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Ismaili Center in Chicago'), (select max(id) from location));
--Ismaili Center in Glenview
insert into location (address1, address2, municipality, region2, postal_code, country) values ('100 Shermer Road', '', 'Glenview', 'Illinois', '60025', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Ismaili Center in Glenview'), (select max(id) from location));
--Jesus Name Apostolic Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('208 Lake Street', '', 'Waukegan', 'Illinois', '60085', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Jesus Name Apostolic Church'), (select max(id) from location));
--Jewish Child and Family Services
insert into location (address1, address2, municipality, region2, postal_code, country) values ('3145 W. Pratt Blvd', '', 'Chicago', 'Illinois', '60645', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Jewish Child and Family Services'), (select max(id) from location));
--Jewish Community Emergency Resiliency Team
insert into location (address1, address2, municipality, region2, postal_code, country) values ('3145 W. Praat Blvd', '', 'Chicago', 'Illinois', '60645', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Jewish Community Emergency Resiliency Team'), (select max(id) from location));
--Jewish Healing Network of Chicago
insert into location (address1, address2, municipality, region2, postal_code, country) values ('5150 Golf Road', '', 'Skokie', 'Illinois', '60077', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Jewish Healing Network of Chicago'), (select max(id) from location));
--Jewish School-Based Wellness Initiative
insert into location (address1, address2, municipality, region2, postal_code, country) values ('1500 S. California Ave', '', 'Chicago', 'Illinois', '60608', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Jewish School-Based Wellness Initiative'), (select max(id) from location));
--Joshua Missionary Baptist Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('3255 W. Carroll Avenue', '', 'Chicago', 'Illinois', '60624', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Joshua Missionary Baptist Church'), (select max(id) from location));
--Journey Community Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('9600 Capitol Dr.', '', 'Wheeling', 'Illinois', '60090', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Journey Community Church'), (select max(id) from location));
--Kenwood UCC
insert into location (address1, address2, municipality, region2, postal_code, country) values ('4608 S. Greenwood Ave', '', 'Chicago', 'Illinois', '60653', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Kenwood UCC'), (select max(id) from location));
--Kimball Ave. Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('2324 N. Kimball Avenue', '', 'Chicago', 'Illinois', '60647', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Kimball Ave. Church'), (select max(id) from location));
--La Academia
insert into location (address1, address2, municipality, region2, postal_code, country) values ('1840 Westchester Blvd', 'Suite 200', 'Westchester', 'Illinois', '60154', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'La Academia'), (select max(id) from location));
--Lakeview Presbyterian Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('716 W. Addison', '', 'Chicago', 'Illinois', '60613', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Lakeview Presbyterian Church'), (select max(id) from location));
--Latino Community Program
insert into location (address1, address2, municipality, region2, postal_code, country) values ('300 W. Adams', 'Suite 35', 'Chicago', 'Illinois', '60606', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Latino Community Program'), (select max(id) from location));
--LaVerne Barnes
insert into location (address1, address2, municipality, region2, postal_code, country) values ('2813 W. 147th Street', '', 'Posen', 'Illinois', '60469', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'LaVerne Barnes'), (select max(id) from location));
--Lead Safe Housing Initiatives
insert into location (address1, address2, municipality, region2, postal_code, country) values ('25 E. Pearson', '', 'Chicago', 'Illinois', '60611', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Lead Safe Housing Initiatives'), (select max(id) from location));
--lead safe illinois
insert into location (address1, address2, municipality, region2, postal_code, country) values ('Loyola Law School', '25 E. Pearson St.', 'Chicago', 'Illinois', '60611', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'lead safe illinois'), (select max(id) from location));
--Leadership and Church Development
insert into location (address1, address2, municipality, region2, postal_code, country) values ('1840 Westchester Blvd', 'Suite 200', 'Westchester', 'Illinois', '60154', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Leadership and Church Development'), (select max(id) from location));
--Liberty Baptist
insert into location (address1, address2, municipality, region2, postal_code, country) values ('4849 S. King Dr.', '', 'Chicago', 'Illinois', '60615', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Liberty Baptist'), (select max(id) from location));
--Lilydale Baptist Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('649 W. 113th Street', '', 'Chicago', 'Illinois', '60628', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Lilydale Baptist Church'), (select max(id) from location));
--Lincoln United Methodist Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('2242 South Damen Avenue', '', 'Chicago', 'Illinois', '60608', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Lincoln United Methodist Church'), (select max(id) from location));
--Little Brothers - Friends of the Elderly, Chicago Chapter
insert into location (address1, address2, municipality, region2, postal_code, country) values ('355 N Ashland Avenue', '', 'Chicago', 'Illinois', '60607-1019', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Little Brothers - Friends of the Elderly, Chicago Chapter'), (select max(id) from location));
--Lively Stone Missonary Baptist Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('4938 W. Chicago Avenue', '', 'Chicago', 'Illinois', '60651', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Lively Stone Missonary Baptist Church'), (select max(id) from location));
--Living Well Ministries
insert into location (address1, address2, municipality, region2, postal_code, country) values ('6554 N. Rockwell Street', '', 'Chicago', 'Illinois', '60645', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Living Well Ministries'), (select max(id) from location));
--Lutheran Church of Atonement
insert into location (address1, address2, municipality, region2, postal_code, country) values ('909 East Main Street', '', 'Barrington', 'Illinois', '60010', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Lutheran Church of Atonement'), (select max(id) from location));
--Lutheran Church of the Ascension
insert into location (address1, address2, municipality, region2, postal_code, country) values ('460 Sunset Ridge Rd', '', 'Northfield', 'Illinois', '60093', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Lutheran Church of the Ascension'), (select max(id) from location));
--Lutheran General Hospital - Mission and Spiritual
insert into location (address1, address2, municipality, region2, postal_code, country) values ('1775 W. Dempster', '', 'Park Ridge', 'Illinois', '60068', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Lutheran General Hospital - Mission and Spiritual'), (select max(id) from location));
--Lutheran Social Services of Illinois
insert into location (address1, address2, municipality, region2, postal_code, country) values ('1001 E. Touhy Ave.', '', 'Illinois', 'Illinois', '60018', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Lutheran Social Services of Illinois'), (select max(id) from location));
--M.I.K.E. Minority Intervention and Kidney Education Program
insert into location (address1, address2, municipality, region2, postal_code, country) values ('4259 S. Berkeley Avenue', '', 'Chicago', 'Illinois', '60653', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'M.I.K.E. Minority Intervention and Kidney Education Program'), (select max(id) from location));
--Ministry to New Moms
insert into location (address1, address2, municipality, region2, postal_code, country) values ('2218 Hutchison Road', '', 'Flossmoor', 'Illinois', '60422', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Ministry to New Moms'), (select max(id) from location));
--Montrose Baptist Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('4411 N. Melvina Ave', '', 'Chicago', 'Illinois', '60630', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Montrose Baptist Church'), (select max(id) from location));
--Monument of Faith Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('2750 W. Columbus Ave', '', 'Chicago', 'Illinois', '60652', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Monument of Faith Church'), (select max(id) from location));
--Mosque Foundation
insert into location (address1, address2, municipality, region2, postal_code, country) values ('7360 West 93rd Street', '', 'Bridgeview', 'Illinois', '60455-2171', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Mosque Foundation'), (select max(id) from location));
--Mosque of Umar Inc.
insert into location (address1, address2, municipality, region2, postal_code, country) values ('11405 S. Michigan Avenue', '', 'Chicago', 'Illinois', '60628', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Mosque of Umar Inc.'), (select max(id) from location));
--Most Blessed Trinity Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('450 Keller Avenue', '', 'Waukegan', 'Illinois', '60085', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Most Blessed Trinity Church'), (select max(id) from location));
--Mount Calvary Baptist Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('1259 W. 111th Place', '', 'Chicago', 'Illinois', '60643', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Mount Calvary Baptist Church'), (select max(id) from location));
--Mount Pisgah Ministries
insert into location (address1, address2, municipality, region2, postal_code, country) values ('1813 Church Street', '', 'Evanston', 'Illinois', '60201', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Mount Pisgah Ministries'), (select max(id) from location));
--Myanmar Christian Church of Metro Chicago
insert into location (address1, address2, municipality, region2, postal_code, country) values ('501 S. Emerson St.', '', 'Mt Prospect', 'Illinois', '60056', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Myanmar Christian Church of Metro Chicago'), (select max(id) from location));
--New Hope Bible Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('1137 N. Leavitt St.', '', 'Chicago', 'Illinois', '60622', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'New Hope Bible Church'), (select max(id) from location));
--New Life Baptist Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('11026 S. Indiana Ave.', '', 'Chicago', 'Illinois', '60628', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'New Life Baptist Church'), (select max(id) from location));
--New Life Covenant Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('2704 W. North Ave.', '', 'Chicago', 'Illinois', '60647', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'New Life Covenant Church'), (select max(id) from location));
--New Life Worship Center
insert into location (address1, address2, municipality, region2, postal_code, country) values ('32 E. 113th Place', '', 'Chicago', 'Illinois', '60628', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'New Life Worship Center'), (select max(id) from location));
--New Mt.Pilgrim MB Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('4301 W. Washington Blvd', '', 'Chicago', 'Illinois', '60624', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'New Mt.Pilgrim MB Church'), (select max(id) from location));
--New Pasadena MB Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('11300 South Indiana Avenue', '', 'Chicago', 'Illinois', '60628', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'New Pasadena MB Church'), (select max(id) from location));
--North Park Theological Seminary
insert into location (address1, address2, municipality, region2, postal_code, country) values ('3225 W. Foster Ave', '', 'Chicago', 'Illinois', '60625-4895', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'North Park Theological Seminary'), (select max(id) from location));
--North Shore Church of Christ
insert into location (address1, address2, municipality, region2, postal_code, country) values ('326 Julian St', '', 'Waukegan', 'Illinois', '60085', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'North Shore Church of Christ'), (select max(id) from location));
--Northfield Presbyterian Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('100 N. Northgate Pkwy.', '', 'Wheeling', 'Illinois', '60090', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Northfield Presbyterian Church'), (select max(id) from location));
--Northside P.O.W.E.R.
insert into location (address1, address2, municipality, region2, postal_code, country) values ('7649 North Paulina Street', '', 'Chicago', 'Illinois', '60626', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Northside P.O.W.E.R.'), (select max(id) from location));
--Nuestra Senora de Gaudalupe
insert into location (address1, address2, municipality, region2, postal_code, country) values ('2415 North Butrick', '', 'Waukegan', 'Illinois', '60085', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Nuestra Senora de Gaudalupe'), (select max(id) from location));
--Older Adult Programs
insert into location (address1, address2, municipality, region2, postal_code, country) values ('710 S Paulina Street', '4th Floor', 'Chicago', 'Illinois', '60612', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Older Adult Programs'), (select max(id) from location));
--Our Lady of Fatima Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('3845 S. California Ave', '', 'Chicago', 'Illinois', '60632', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Our Lady of Fatima Church'), (select max(id) from location));
--Our Lady of Good Counsel
insert into location (address1, address2, municipality, region2, postal_code, country) values ('601 Talma Street', '', 'Aurora', 'Illinois', '60505', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Our Lady of Good Counsel'), (select max(id) from location));
--Park Manor Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('7000 S. King Drive', '', 'Chicago', 'Illinois', '60637', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Park Manor Church'), (select max(id) from location));
--Park Ridge Community Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('100 S. Courtland Ave', '', 'Park Ridge', 'Illinois', '60068', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Park Ridge Community Church'), (select max(id) from location));
--Peace Lutheran Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('21W500 Butterfield Rd', '', 'Lombard', 'Illinois', '60148', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Peace Lutheran Church'), (select max(id) from location));
--People\'s Church of the Harvest
insert into location (address1, address2, municipality, region2, postal_code, country) values ('3570 West Fifth Avenue', '', 'Chicago', 'Illinois', '60624', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'People\'s Church of the Harvest'), (select max(id) from location));
--Peoples Church of Chicago
insert into location (address1, address2, municipality, region2, postal_code, country) values ('941 W. Lawrence Ave', '', 'Chicago', 'Illinois', '60640', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Peoples Church of Chicago'), (select max(id) from location));
--Pillar of Love UCC
insert into location (address1, address2, municipality, region2, postal_code, country) values ('7438 W. 62nd Place', '', 'Summit Argo', 'Illinois', '60501', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Pillar of Love UCC'), (select max(id) from location));
--Pleasant Ridge Baptist Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('116 S. Central Ave.', '', 'Chicago', 'Illinois', '60644', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Pleasant Ridge Baptist Church'), (select max(id) from location));
--Polish Community
insert into location (address1, address2, municipality, region2, postal_code, country) values ('300 W. Adams', 'Suite 35', 'Chicago', 'Illinois', '60606', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Polish Community'), (select max(id) from location));
--Primera Iglesia Congregacional
insert into location (address1, address2, municipality, region2, postal_code, country) values ('1305 N. Hamlin', '', 'Chicago', 'Illinois', '60651', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Primera Iglesia Congregacional'), (select max(id) from location));
--Program of Religion/Spirituality and Mental Health
insert into location (address1, address2, municipality, region2, postal_code, country) values ('1601 W. Taylor', '', 'Chicago', 'Illinois', '60612', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Program of Religion/Spirituality and Mental Health'), (select max(id) from location));
--Progressive Baptist Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('3658 South Wentworth Avenue', '', 'Chicago', 'Illinois', '60609', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Progressive Baptist Church'), (select max(id) from location));
--Pui Tak Center
insert into location (address1, address2, municipality, region2, postal_code, country) values ('2216 S. Wentworkth', '', 'Chicago', 'Illinois', '60616', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Pui Tak Center'), (select max(id) from location));
--Rainbow Hospice and Palliative Care
insert into location (address1, address2, municipality, region2, postal_code, country) values ('1550 Bishop Court', '', 'Mount Prospect', 'Illinois', '60056', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Rainbow Hospice and Palliative Care'), (select max(id) from location));
--Redeeming Life Family Worship Center COGIC
insert into location (address1, address2, municipality, region2, postal_code, country) values ('PO Box 621', '', 'Blue Island', 'Illinois', '60406', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Redeeming Life Family Worship Center COGIC'), (select max(id) from location));
--Reformation Lutheran Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('11310 S. Forest Avenue', '', 'Chicago', 'Illinois', '60628', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Reformation Lutheran Church'), (select max(id) from location));
--Revelation International Outreach Ministries
insert into location (address1, address2, municipality, region2, postal_code, country) values ('127 N. Leamington Ave', '', 'Chicago', 'Illinois', '60644', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Revelation International Outreach Ministries'), (select max(id) from location));
--Rush University Medical Center
insert into location (address1, address2, municipality, region2, postal_code, country) values ('710 S Paulina Street', '4th Floor', 'Chicago', 'Illinois', '60612', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Rush University Medical Center'), (select max(id) from location));
--Salem Baptist
insert into location (address1, address2, municipality, region2, postal_code, country) values ('752 E. 114th St', '', 'Chicago', 'Illinois', '60628', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Salem Baptist'), (select max(id) from location));
--Shiloh Baptist Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('800 S. Genessee St.', '', 'Waukegan', 'Illinois', '60085', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Shiloh Baptist Church'), (select max(id) from location));
--Shiloh Missionary Baptist Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('10540 S. Halsted', '', 'Chicago', 'Illinois', '60628', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Shiloh Missionary Baptist Church'), (select max(id) from location));
--Sinai Urban Health Institute
insert into location (address1, address2, municipality, region2, postal_code, country) values ('1500 S. California Ave', '', 'Chicago', 'Illinois', '60608', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Sinai Urban Health Institute'), (select max(id) from location));
--South Suburban Interfaith Ministerial Association
insert into location (address1, address2, municipality, region2, postal_code, country) values ('2640 Park Dr.', 'St. John the Evangelist', 'Flossmoor', 'Illinois', '60422', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'South Suburban Interfaith Ministerial Association'), (select max(id) from location));
--Spanish Christian Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('1507 W. Sunnyside,', '', 'Chicago', 'Illinois', '60640', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Spanish Christian Church'), (select max(id) from location));
--St Matthews United Methodist Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('1000 N. Orleans St', '', 'Chicago', 'Illinois', '60610', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'St Matthews United Methodist Church'), (select max(id) from location));
--St. Ailbe Catholic Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('9015 South Harper,', '', 'Chicago', 'Illinois', '60619', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'St. Ailbe Catholic Church'), (select max(id) from location));
--St. Anne Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('120 Els St', '', 'Barrington', 'Illinois', '60010', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'St. Anne Church'), (select max(id) from location));
--St. Clement\'s Episcopal Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('2508 Walnut St.', '', 'Blue Island', 'Illinois', '60406', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'St. Clement\'s Episcopal Church'), (select max(id) from location));
--St. Francis of Assisi Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('813 W. Roosevelt Rd.', '', 'Chicago', 'Illinois', '60608', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'St. Francis of Assisi Church'), (select max(id) from location));
--St. Genevieve Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('2451 N. Lamon', '', 'Chicago', 'Illinois', '60639', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'St. Genevieve Church'), (select max(id) from location));
--St. Ita Catholic Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('1220 W. Catalpa', '', 'Chicago', 'Illinois', '60640', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'St. Ita Catholic Church'), (select max(id) from location));
--St. James Lutheran Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('5129 Wolf Rd', '', 'Western Springs', 'Illinois', '60558', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'St. James Lutheran Church'), (select max(id) from location));
--St. John MB Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('211 E. 115th St.', '', 'Chicago', 'Illinois', '60628', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'St. John MB Church'), (select max(id) from location));
--St. Kevins\'s Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('10501 S. Torrence Ave.', '', 'Chicago', 'Illinois', '60617', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'St. Kevins\'s Church'), (select max(id) from location));
--St. Luke's Lutheran of Logan Square
insert into location (address1, address2, municipality, region2, postal_code, country) values ('2649 N. Francisco Ave.', '', 'Chicago', 'Illinois', '60647', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'St. Luke\'s Lutheran of Logan Square'), (select max(id) from location));
--St. Luke\'s Lutheran Church of Logan Square
insert into location (address1, address2, municipality, region2, postal_code, country) values ('2649 N. Francisco Ave.', '', 'Chicago', 'Illinois', '60647', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'St. Luke\'s Lutheran Church of Logan Square'), (select max(id) from location));
--St. Mark International Christian Ch.
insert into location (address1, address2, municipality, region2, postal_code, country) values ('832 N. Leclaire Ave', '', 'Chicago', 'Illinois', '60651', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'St. Mark International Christian Ch.'), (select max(id) from location));
--St. Paul UCC
insert into location (address1, address2, municipality, region2, postal_code, country) values ('144 E Palatine Rd', '', 'Palatine', 'Illinois', '60067', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'St. Paul UCC'), (select max(id) from location));
--St. Paul\'s Church by-the-Lake
insert into location (address1, address2, municipality, region2, postal_code, country) values ('7100 N. Ashland Ave.', '', 'Chicago', 'Illinois', '60626', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'St. Paul\'s Church by-the-Lake'), (select max(id) from location));
--St. Pius V. Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('1910 S. Ashland Ave', '', 'Chicago', 'Illinois', '60622', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'St. Pius V. Church'), (select max(id) from location));
--St. Sabina Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('1210 W. 78th Place', '', 'Chicago', 'Illinois', '60620', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'St. Sabina Church'), (select max(id) from location));
--St. Stephen AME Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('3042 W. Washington', '', 'Chicago', 'Illinois', '60612', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'St. Stephen AME Church'), (select max(id) from location));
--St. Sylvester Catholic Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('2157 N. Humboldt Blvd', '', 'Chicago', 'Illinois', '60647', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'St. Sylvester Catholic Church'), (select max(id) from location));
--Suburban Chicago Interfaith Mental Health Coalition
insert into location (address1, address2, municipality, region2, postal_code, country) values ('111 N. County Farm Rd', '', 'Wheaton', 'Illinois', '60187', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Suburban Chicago Interfaith Mental Health Coalition'), (select max(id) from location));
--Sunrise Missionary Baptist Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('351 S. Kilbourn', '', 'Chicago', 'Illinois', '60624', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Sunrise Missionary Baptist Church'), (select max(id) from location));
--Temple of Faith Missionary Baptist Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('6201 S Wolcott Ave', '', 'Chicago', 'Illinois', '60636', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Temple of Faith Missionary Baptist Church'), (select max(id) from location));
--The American Heart Association (AHA)
insert into location (address1, address2, municipality, region2, postal_code, country) values ('208 S. LaSalle Street', 'Suite 900', 'Chicago', 'Illinois', '60604', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'The American Heart Association (AHA)'), (select max(id) from location));
--The Buddhist Temple of Chicago
insert into location (address1, address2, municipality, region2, postal_code, country) values ('1151 W. Leland Ave', '', 'Chicago', 'Illinois', '60640', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'The Buddhist Temple of Chicago'), (select max(id) from location));
--The South Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('501 S. Emerson', '', 'Mt Prospect', 'Illinois', '60056', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'The South Church'), (select max(id) from location));
--The Unversity of Illinois Medical Center for Women's Health Associates
insert into location (address1, address2, municipality, region2, postal_code, country) values ('1801 West Taylor Street', '4th Floor', 'Chicago', 'Illinois', '60612', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'The Unversity of Illinois Medical Center for Women\'s Health Associates'), (select max(id) from location));
--Third Baptist Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('1551 W. 95th St.', '', 'Chicago', 'Illinois', '60643', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Third Baptist Church'), (select max(id) from location));
--Triedstone Full Gospel Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('1415 West 104th Street', '', 'Chicago', 'Illinois', '60643', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Triedstone Full Gospel Church'), (select max(id) from location));
--Trinity AME Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('210 South Avenue', '', 'Waukegan', 'Illinois', '60085', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Trinity AME Church'), (select max(id) from location));
--Trinity United Church of Christ
insert into location (address1, address2, municipality, region2, postal_code, country) values ('400 W. 95th Street', '', 'Chicago', 'Illinois', '60628', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Trinity United Church of Christ'), (select max(id) from location));
--True Worship Baptist Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('1107 N Pulaski Rd', '', 'Chicago', 'Illinois', '60651', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'True Worship Baptist Church'), (select max(id) from location));
--Turning Point
insert into location (address1, address2, municipality, region2, postal_code, country) values ('8324 N. Skokie Blvd', '', 'Skokie', 'Illinois', '60077', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Turning Point'), (select max(id) from location));
--Ubumama - Chicago
insert into location (address1, address2, municipality, region2, postal_code, country) values ('910 W Castlewood Terrace', '', 'Chicago', 'Illinois', '60640', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Ubumama - Chicago'), (select max(id) from location));
--United Baptist Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('4242 W. Roosevelt', '', 'Chicago', 'Illinois', '60624', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'United Baptist Church'), (select max(id) from location));
--United Faith Missionary Baptist Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('40 S. 19th Ave.', '', 'Maywood', 'Illinois', '60153', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'United Faith Missionary Baptist Church'), (select max(id) from location));
--United in Faith Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('6525 W. Irving Park Rd.', '', 'Chicago', 'Illinois', '60634', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'United in Faith Church'), (select max(id) from location));
--Unity Lutheran Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('1212 W. Balmoral Ave.', '', 'Chicago', 'Illinois', '60640', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Unity Lutheran Church'), (select max(id) from location));
--Unity Northwest Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('259 E. Central Rd', '', 'Des Plaines', 'Illinois', '60016', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Unity Northwest Church'), (select max(id) from location));
--Universal House of Refuge Center
insert into location (address1, address2, municipality, region2, postal_code, country) values ('15704 Park Ave.', '', 'Harvey', 'Illinois', '60426', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Universal House of Refuge Center'), (select max(id) from location));
--University of Illinois Division of Community Health
insert into location (address1, address2, municipality, region2, postal_code, country) values ('845 S. Damen', '5th Floor', 'Chicago', 'Illinois', '60612', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'University of Illinois Division of Community Health'), (select max(id) from location));
--Victory Christian Assembly Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('2902 W. 159th Street', '', 'Markham', 'Illinois', '60428', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Victory Christian Assembly Church'), (select max(id) from location));
--VOCMA Faith Community Baptist Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('3456 W. Flournoy Ave', '', 'Chicago', 'Illinois', '60624', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'VOCMA Faith Community Baptist Church'), (select max(id) from location));
--Wesley United Methodist Church
insert into location (address1, address2, municipality, region2, postal_code, country) values ('201 E. 95th St.', '', 'Chicago', 'Illinois', '60619', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Wesley United Methodist Church'), (select max(id) from location));
--Westside Health Authority
insert into location (address1, address2, municipality, region2, postal_code, country) values ('4800 W. Chicago', '', 'Chicago', 'Illinois', '60651', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Westside Health Authority'), (select max(id) from location));
--Wholistic Medical Clinic
insert into location (address1, address2, municipality, region2, postal_code, country) values ('LaVerne Barnes, DO, MPH', '2813 W. 147th St.', 'Posen', 'Illinois', '60469', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'Wholistic Medical Clinic'), (select max(id) from location));
--ZAM\'s Hope Community Resource Center
insert into location (address1, address2, municipality, region2, postal_code, country) values ('6401 N. Artesian Ave.', '', 'Chicago', 'Illinois', '60654', 'US');
insert into organization_location (organization_fk, location_fk) values ((select id from organization where name = 'ZAM\'s Hope Community Resource Center'), (select max(id) from location));