#!/bin/sh

certname=$1
ip=$2
blueprint=$3
os=$4

FILE="/etc/puppet/manifests/blueprint${blueprint}.pp"
alias=${certname/.hcl.com/}

hoststr="\nhost { '"$certname"':\n\t#osName => '$os,$ip',\n\tip => '$ip',\n\thost_aliases => '$alias',\n\tensure => 'present',\n}\n###\n"

if [ -f $FILE ]; then
	sed -i "s/###/$hoststr/g" $FILE
else
	hoststr="node blueprint$blueprint {\n $hoststr }"
	echo -e $hoststr > $FILE
fi





