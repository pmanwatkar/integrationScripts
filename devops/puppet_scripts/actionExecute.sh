#!/bin/sh

script=$1
certname=$2
ipaddress=$3
os=$4
user=$5
parent=$6
actionprop=$7
actionval=$8
keyName="LabSetup"

echo $user" Parent= "$parent" "$certname
if [ "$parent" == "Database_MySql" ]; then
actionval=$(echo $actionval | sed -e 's/\\/\\\\\\\\/g' | tr ',' ' ')
echo $actionval
else
actionval=$(echo $actionval | sed -e 's/\\/\\\\\\\\/g' | sed -e 's/,/\\\",\\\"/g')
actionval=$(echo "\\\"$actionval\\\"")
echo $actionval
fi

str="node '${certname}' {"
str=$str'\n $parent="'$parent'"\n $parameters="'$actionval'"\n $script="'$script'"\n\n include actions'
str=$str"\n }"
echo -e $str > /etc/puppet/manifests/${certname}.${user}.${script}.pp
echo "import '${certname}.${user}.${script}.pp'" > /etc/puppet/manifests/$certname.pp

if [ "$os" == "LinuxOS" ]; then
  ssh -i /usr/Devops/Keys/${keyName}.pem -o StrictHostKeyChecking=no root@$ipaddress puppet agent -t
elif [ "$os" == "Windows" ]; then
  (echo "C:\\Devops\\temp\\installModules.bat"; echo exit; ) | winexe -U devops%Admin098 -W WORKGROUP //$ipaddress "cmd.exe"
fi



