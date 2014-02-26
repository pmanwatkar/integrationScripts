#!/bin/sh

rootpassword=NULL
mysqlport=3306
apacheport=8083
sslport=433
apacheuser=apache1
apachegroup=apache
documentroot=/var/www/html3
host=test.cloud.com
ipaddress=10.98.241.47
arrStr=apache,mysql::server


/root/puppet-scripts/moduleInstall.sh $rootpassword $mysqlport $apacheport $sslport $apacheuser $apachegroup $documentroot $host $ipaddress $arrStr
