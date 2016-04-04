update organization set uid = 'ed787a92' where id = 18
update organization set logo = 'cfcht_logo.png' where id = 18

-- We need a public user for CFCHT
insert into public.user (uuid, username, fname, lname, email, status_fk, create_dttm, activate_dttm) values (
'51b921d8-f805-440a-8db8-3352904bfa73', 
'pUser-ed787a92',
'Public',
'User',
'',
'1',
now(),
now()) returning id;

--(Got 246)

-- We need a CFCHT public group
insert into public.group (name, descr, create_dttm, activate_dttm, uid) values (
'Public Group',
'This group is a placeholder for public ed787a92',
now(),
now(),
'503ebc8d') returning id;

-- (Got 18)

-- Tie new public user to public group
insert into user_group (user_fk, create_dttm, group_fk, role_fk) values
(246,
now(),
18,
5);

-- Tie new public user to CFCHT
insert into user_organization (user_fk, organization_fk, grantor_fk, create_dttm, role_fk) values (
246,
18,
88,
now(),
5)


-- Add events
-- Events are tied to public group. Public site access logs in under pUser-c2007e9b which is tied to public group and to c2007e9b (that is, CFCHT)
-- So CFCHT public events are pulled by association with pUser

insert into event (uuid, start_dttm, duration, name, descr, reserved_user_fk, tz_name, tz_abbrev, type, location, isBbbMeet) values (
'8ceada6c-d4b3-4c39-9595-64f562253ded',
'2016-12-15 17:25:00-07',
'00:30:00',
'Test Event',
'',
'88',
'America/Chicago',
'CST',
'collaboration',
'740 Monroe Street',
false)
returning id

insert into event_group (event_fk, group_fk) values (47, 18)

-- Real data

insert into event (uuid, start_dttm, duration, name, descr, reserved_user_fk, admin_user_fk, tz_name, tz_abbrev, create_dttm, location, isBbbMeet, registration, url, contact, registration_url) values (
'6160e9c2-a58d-4480-9d8a-52b9c2408724',
'2015-12-05 10:00:00-07',
'03:00:00',
'Honest, Open, Proud (HOP) Workshop ',
'Participants in the program will attend three two-hour workshops that guide people through the process of making disclosure decisions. A leader with lived experience will run the group.',
'88',
'88',
'America/Chicago',
'CST',
now(),
'NAMI Chicago, 1536 W. Chicago Ave., Chicago, IL  60642',
false,
'Registration is closed. The workshop is free to participants. Contact Kyra Wilson to register for the Honest, Open, Proud workshop at 312-563-0445 or Kyra@namichicago.org',
'www.chicagofaithandhealth.org/app/files/public/439/Honest-Open-Proud-HOP.pdf',
'',
'') returning id

insert into event_group (event_fk, group_fk) values (55, 18)

insert into event (uuid, start_dttm, duration, name, descr, reserved_user_fk, admin_user_fk, tz_name, tz_abbrev, create_dttm, location, isBbbMeet, registration, url, contact, registration_url) values (
'dc8c37e2-71b4-4e37-a0d2-d5f69e677286',
'2016-01-28 11:30:00-07',
'00:02:30',
'Living With Grief Teleconference ',
'2016 Living With Grief® Program
HFA
Managing Conflict/Finding Meaning
Supporting Families at Life\'s End

This pre-recorded teleconference will address tangible strategies that can be used to facilitate meetings with family members during a serious illness and at the end of life.  The panelists will discuss practical solutions to conflict among family members, such as caregiving disputes, financial concerns, and religious or spiritual differences.

Living with Grief Teleconferences cover topics related to grief, bereavement and end-of-life care sponsored by the Hospice Foundation of America. ',
'88',
'88',
'America/Chicago',
'CST',
now(),
'Credits will be available for a wide range of professional boards. Webcast Registration is $115.95. Webcast & DVD is $140.95.',
false,
'Registration is not required',
'www.chicagofaithandhealth.org/app/files/public/435/Living-With-Grief-1-28-2016.docx',
'',
'register.hospicefoundation.org/products/managing-conflict-finding-meaning-webcast') returning id

insert into event_group (event_fk, group_fk) values (56, 18)

insert into event (uuid, start_dttm, duration, name, descr, reserved_user_fk, admin_user_fk, tz_name, tz_abbrev, create_dttm, location, isBbbMeet, registration, url, contact, registration_url) values (
'318ae3fd-60e3-4611-ac56-98c386b207db',
'2016-01-28 09:00:00-07',
'05:00:00',
'Nature, Faith and Health',
'<p>We all know that time spent in nature is good for the soul. But did you know that scientists are beginning to document that is it good for the body and brain, as well as the community?</p>
<p>Natural surroundings have been found to reduce anger, confusion, depression, tension, and migraines, and have secondary effects on community building and violence prevention.</p>
<p>All faith traditions incorporate images and metaphors from nature into descriptions of God and faith practice.  This event helps to make the connection between Nature, Faith and Health.</p>
<p>On January 28th, 2016, Dr. Theresa Horton of Northwestern University will join the Cook County Forest Preserve District and The Center for Faith and Community Health Transformation for a multifaceted presentation on harnessing the benefits of nature. Dr. Horton will share recent studies on nature and human health. The Forest Preserve debuts new and exciting programs and opportunities for Chicago-land faith communities, and The Center will provide theological resources for retreats, field trips, and programming for children and youth.</p>
<p>Please join us for this pioneering area of healthy living. Lunch will be included.  Stay after lunch for a nature walk (or snowshoe if there\'s snow)!</p>',
'88',
'88',
'America/Chicago',
'CST',
now(),
'',
false,
'Lunch is included in the program. For more information or with questions, contact Olga Wegehaupt at olga.wegehaupt@advocatehealth.com or 630-929-6108.',
'www.chicagofaithandhealth.org/app/files/public/442/Nature-Faith-and-Health-Flyer.pdf',
'',
'www.eventbrite.com/e/connecting-faith-nature-and-health-tools-for-faith-communities-tickets-19950303896') returning id

insert into event_group (event_fk, group_fk) values (57, 18)

insert into event (uuid, start_dttm, duration, name, descr, reserved_user_fk, admin_user_fk, tz_name, tz_abbrev, create_dttm, location, isBbbMeet, registration, url, contact, registration_url) values (
'7e95965a-d233-4856-8e80-47b5ddb64492',
'2016-01-13 09:00:00-07',
'05:00:00',
'Access to Care',
'<p>Access to Care is a 28 year old non-profit program providing affordable primary health care services of residents of suburban Cook County who do not qualify for any public health programs (Medicaid, CountyCare, Medicare, All Kids, Family Care).</p>
<p>Informational Workshop  from 12:00 a.m. to 2:00 p.m.</p>
<p>Access to Care Special Registration all day from 10:00 a.m.-3:00 p.m.</p>
<p>Access to Care Special Registration is for clients needing affordable primary care.  Services include: Doctor\'s visits for $5, Labe and X-ray for $5, and prescription medication for $15, $30 and $40.</p>
<p>If you or you know someone who fits the description please come to this event.</p>',
'88',
'88',
'America/Chicago',
'CST',
now(),
'United Protestant Church, 10 Hemlock St., Park Forest, IL 60466',
false,
'Bring required documents listed on flyer to register for Access to Care. To register for the workshop call 708-531-0608 or email kbarnickel@sphcc.org',
'www.accesstocare.org/',
'',
'www.chicagofaithandhealth.org/app/files/public/441/Access-to-Care-Informational-Workshop.docx') returning id

insert into event_group (event_fk, group_fk) values (58, 18)

insert into event (uuid, start_dttm, duration, name, descr, reserved_user_fk, admin_user_fk, tz_name, tz_abbrev, create_dttm, location, isBbbMeet, registration, url, contact, registration_url) values (
'e256131f-5d0d-48e1-b0ab-c58fc68a23e5',
'2016-02-13 08:00:00-07',
'06:00:00',
'All in the Family',
'<p>Heart Disease Lecture & Hands Only CPR Class</p>
<p>Presenters:<br/>Justine Parker, MD (English)<br/>Pilar Ortega, MD (Spanish)</p>
<p>Refreshments will be served!</p>
<p>FREE SCREENINGS: BP, Cholesterol, Glucose and BMI</p>
<p>Registration: 9am  Lecture: 9:30am (English and Spanish – Two tracks)</p>
<p>CPR Class: 1pm – 3pm (Limited to the first 20 Registrants - English)</p>',
'88',
'88',
'America/Chicago',
'CST',
now(),
'Advocate Illinois Masonic Medical Center, Center for Education Building – Ringel Rooms 1-3',
false,
'To Register, please call 1800-323-8622 or Hispanocare at (1-844) 414-7979 Toll Free and Mentioned Code: #9C74 and specify English or Spanish Presentation',
'',
'northbridgetech.org/downloads/tmp/2016_Flyer_Heart_Health_Feb_Program_-_Bilingual.pdf',
'') returning id

insert into event_group (event_fk, group_fk) values (75, 18);
