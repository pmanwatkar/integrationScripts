#!/bin/sh

hostIp=`curl http://169.254.169.254/latest/meta-data/local-ipv4/`

sed -i '/puppetm1.hcl.com/d' /usr/Devops/Scripts/hostFile/hosts

echo "$hostIp    puppetm1.hcl.com        puppetm1" >> /usr/Devops/Scripts/hostFile/hosts

