define("SUPPORT_URL", "http://northbridgetech.org/dev/support");

Make new folder partner/image
Move images from partner to partner/image

from public_html/<env>/nexus
tar czvf partner.tar.gz partner/
cd partner
mkdir image
cp *.png image (etc)

ls -l | wc -l
if  counts match
	rm *.png, etc
	rm partner.tar.gz
	
	
	
mkdir timezones/output
cd output
mv web/scripts/timeZoneData.js to new output folder
ln -s ~/batch/dev/nexus/module/timezones/output/timeZoneData.js timeZoneData.js

ln -s ~/public_html/dev/nexus/web/src/framework/PgDb.php PgDb.php
copy over timezone batch files

add cron job

add dev demo cron job

