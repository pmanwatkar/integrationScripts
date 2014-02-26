#!/bin/sh

vmName=$1
ipaddress=$2
keyName=$3
os=$4
blueprint=$5
arrStr=$6
moduleprop=$7
moduleval=$8


moduleprop=`echo $moduleprop | sed 's/ApachePort/apachePort/g'`
arrStr=`echo $arrStr | tr '[A-Z]' '[a-z]'`
echo $arrStr

testStr=`echo 1 | awk -v two=$moduleval -v one=$moduleprop -F"," '{split(one,a);split(two,b);for(i=1;i<=length(a);i++)print "$"a[i]"=\""b[i]"\"\\\\n"}'`

echo $testStr

cd /etc/puppet/manifests/
echo `pwd`

test=`grep -e "import '${vmName}.pp'" site.pp`

if [ -z "$test" ]; then 
 echo "import '${vmName}.pp'" >> site.pp 
fi

# echo -e "\$extlookup_datadir = '/etc/puppetlabs/puppet/tmp/'" > ${host}.pp
# echo -e "\$extlookup_precedence = ['"$host"','common']" >> ${host}.pp

str="node '${vmName}' inherits blueprint$blueprint {"
str=$str"\n $testStr"
moduleInstall=`echo "$arrStr" | tr ',' ' '`

for i in $moduleInstall
do
str=$str"\n include "$i
done
str=$str"\n include snmp\n import 'blueprint${blueprint}.pp'"
str=$str"\n }"
echo -e $str > ${vmName}.pp

sleep 20

if [ "$os" == "LinuxOS" ]; then
  ssh -i /usr/Devops/Keys/${keyName}.pem -o StrictHostKeyChecking=no root@$ipaddress puppet agent -t
elif [ "$os" == "Windows" ]; then
  (echo "C:\\Devops\\temp\\installModules.bat"; echo exit; ) | winexe -U devops%Admin098 -W WORKGROUP //$ipaddress "cmd.exe"
fi

sleep 30
echo ModuleInstall DONE !!!!!!!!
#echo "node '${vmName}' inherits blueprint$blueprint {\n\timport 'blueprint${blueprint}.pp'\n}" >  ${vmName}.pp


#rm -rf /etc/puppetlabs/puppet/tmp/${host}.csv

#sed -i "/import '${vmName}.pp'"/d site.pp
