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


