#!/bin/sh
ip=$1
values=`echo $2 | tr ',' ' '`
i=1
finalStr=""
for str in $values
do
finalStr="$finalStr server server$i $str weight 1 maxconn 512 check\\\n"
i=$(( i+1 ))
done
ssh root@$ip "sed -i "s/127.0.0.1/$ip/g" /etc/haproxy/haproxy.cfg; echo -e $finalStr >> /etc/haproxy/haproxy.cfg"
