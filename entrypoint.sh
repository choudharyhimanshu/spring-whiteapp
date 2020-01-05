#!/bin/bash

set -x

# Extracting values from DB URL
proto="`echo $DATABASE_URL | grep '://' | sed -e's,^\(.*://\).*,\1,g'`"
url=`echo $DATABASE_URL | sed -e s,$proto,,g`
userpass="`echo $url | grep @ | cut -d@ -f1`"
dbusername=`echo $userpass | grep : | cut -d: -f1`
dbpassword=`echo $userpass | grep : | cut -d: -f2`
hostport=`echo $url | sed -e s,$userpass@,,g | cut -d/ -f1`
dbhost=`echo $hostport | grep : | cut -d: -f1`
dbport=`echo $hostport | grep : | cut -d: -f2`
dbname="`echo $url | grep / | cut -d/ -f2-`"

sed -i "s#&&port&&#$PORT#g" /usr/src/application.yml
sed -i "s#&&dbhost&&#$dbhost#g" /usr/src/application.yml
sed -i "s#&&dbport&&#$dbport#g" /usr/src/application.yml
sed -i "s#&&dbname&&#$dbname#g" /usr/src/application.yml
sed -i "s#&&dbusername&&#$dbusername#g" /usr/src/application.yml
sed -i "s#&&dbpassword&&#$dbpassword#g" /usr/src/application.yml

exec java -Dspring.config.location=/usr/src/application.yml -jar /usr/src/service.jar
