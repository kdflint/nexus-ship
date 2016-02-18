#! /bin/bash

# addresses.txt is a file generated using this query
# select translate(l.id || '^https://maps.googleapis.com/maps/api/geocode/json?address=' || l.address1 || ', ' || l.municipality || ', ' || l.region2 || ' ' || l.postal_code || '&key=<<key>>', ' ', '+') from location l;
# remove quotations marks if necessary

# Prior to above, clean data something like this
#--update location set address1 = address2 where id = 325
#--update location set address2 = '' where id = 325;
#--update location set address1 = address2 where id = 464;
#--update location set address2 = '' where id = 464;
#--update location set address2 = '' where id = 382;

# Fix Palatine

# After geo data updated, issue this to get static json

#select '"' || o.id || '" : [ {"lat" : ' || l.latitude || ', "lng" : ' || l.longitude || ', "title" : "' || o.name || '" } ]'
#from organization o, location l, organization_location ol
#where ol.organization_fk = o.id
#and ol.location_fk = l.id

#then tidy up quotes and commas

clear 

lat=lat
lng=lng
loc=location_type
counter=0

for CALL in $(cat addresses-prd.txt); do
		IFS='^' read -ra RECORD <<< "$CALL"
		#echo "${RECORD[0]}"
		#echo "${RECORD[1]}"
		# curl to get geo data from Google (api calls formatted in addesses.txt)
		# for each address, output an update statement to insert lat and long to location table
    CONTENT="$(curl -s "${RECORD[1]}")"
  	x="${CONTENT%%$lat*}"
  	y="${CONTENT%%$lng*}"
  	z="${CONTENT%%$loc*}"
  	latStart="$((${#x}+8))" 	
  	latEnd="$((${#y}-3))"
  	lngStart="$((${#y}+8))"
  	lngEnd="$((${#z}-5))"
  	latSubstr="$((latStart-latEnd))"
  	lngSubstr="$((lngStart-lngEnd))"
		# Why does latSubstr and lngSubstr not work in below expressions? Hidden characters in encoding, maybe?
		# I use constant instead (10) which causes precision to vary depending on sign. 	
  	LATITUDE=`expr substr "$CONTENT" "$latStart" 9`
  	LONGITUDE=`expr substr "$CONTENT" "$lngStart" 9`   
    echo "update location set latitude = '$LATITUDE', longitude = '$LONGITUDE' where id = ${RECORD[0]};" >> geoUpdate-prd.sql
done

echo "Done"