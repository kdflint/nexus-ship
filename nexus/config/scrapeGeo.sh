#! /bin/bash

# check integrity of location table data

# addresses.txt is a file generated using this query
# select translate(l.id || '^https://maps.googleapis.com/maps/api/geocode/json?address=' || l.address1 || ', ' || l.municipality || ', ' || l.region2 || ' ' || l.postal_code || '&key=<<key>>', ' ', '+') from location l;
# remove quotations marks if necessary
# substitute <<key>>

# Run this script on addresses.txt to get the location table geo update statements

# After geo data updated, issue this to get static json

# select '"' || o.id || '" : [ {"lat" : ' || l.latitude || ', "lng" : ' || l.longitude || ', "title" : "' || o.name || '" } ]'
# from organization o, location l, organization_location ol
# where ol.organization_fk = o.id
# and ol.location_fk = l.id

# Tidy up quotes and commas
# Validate at https://jsonformatter.curiousconcept.com/

clear 

lat=lat
lng=lng
loc=location_type
counter=0

for CALL in $(cat addresses-prd.txt); do
		IFS='^' read -ra RECORD <<< "$CALL"
		# curl to get geo data from Google (api calls pre-formatted in loop input file)
		# for each address, output an update statement to insert lat and long to location table
		
		# Below is susceptible to string "lat" elsewhere in document, such as Palatine - check output
		# Much better to convert JSON input to a data structure
		
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