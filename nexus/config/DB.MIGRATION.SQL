
-- copy over directory/views/include from last deploy - this is a defect

-- put soft link to newtopic_notify.txt
~/phpBB3/language/en/email/short$ mv newtopic_notify.txt newtopic_notify_overridden.txt

ln -s ~/projects/nexus-community/nexus/web/modules/forum/styles/nexus/email/short/newtopic_notify.txt newtopic_notify.txt

~/public_html/dev/forum/language/en/email/short$ mv topic_notify.txt topic_notify_overridden.txt


ln -s ~/public_html/dev/nexus/web/modules/forum/styles/nexus/email/short/topic_notify.txt topic_notify.txt


	
	
