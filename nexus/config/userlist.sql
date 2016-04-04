nb_nexus

select distinct email 
from public.user u, user_organization uo, organization_account oa
where oa.account_type = 'NWM'
and uo.organization_fk = oa.organization_fk
and u.id = uo.user_fk

union

select distinct email
from invitation i
where i.accept_dttm is null;

nb_waterwheel

select email from grant_application;


Last list, gleaned

laura.grace.uiuc@gmail.com
jimmeka@iamnotthemedia.org
slichtenwalter@peoplesrc.org
dia@world-trust.org
kim@sunflowerfoundation.com.au
lam@calachicago.org
sarab@ibarj.org
Ryan@ayuda.com
Syeda.Naqvi@cookcountyjustice.org
ctacouragecampaign@gmail.com
karen.ziech@gmail.com
tom@civiclab.us
fatima@ayuda.com
madelaine.obvi@gmail.com
lcheatham@peoplesrc.org
lharrington01@roosevelt.edu
shakti@world-trust.org
jvictor@peoplesrc.org
kim@sunflowerfoundation.com.au
lnolive2@Gmail.com
krista@world-trust.org
urvi47@gmail.com
ppower@internode.on.net
dia.penning@gmail.com
ginny@world-trust.org
rhummanee@world-trust.org
abi@world-trust.org
aimee@world-trust.org
irambona_thierry@yahoo.com
chad@calachicago.org
ryan@ayuda.com