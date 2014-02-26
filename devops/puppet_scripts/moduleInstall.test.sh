#!/bin/sh

hostname=agent1.hcl.com
ipaddress=10.98.241.181

cd /etc/puppetlabs/puppet/manifests/

test=`grep "import '${hostname}.pp'" site.pp`

if [ -z $test ]; then
  echo "import '${hostname}.pp'" >> site.pp 
fi

arrStr="php mysql-server apache"
strLine=""
str="node '${hostname}' {"

for i in $arrStr
do
  strLine=$strLine"\n include "$i
done
strLine=$strLine"\n }"
echo -e $str$strLine > ${hostname}.pp

ssh root@$ipaddress puppet agent -t

sleep 30

rm -rf ${hostname}.pp

grep -Ev "import '${hostname}.pp" site.pp > site.pp
