#!/bin/sh

scp -r /root/puppet-apps/haproxy root@$ipaddress:/root/haproxy
ssh root@$ipaddress bash /root/haproxy/install.sh $servers 
