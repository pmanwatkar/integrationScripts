#!/bin/sh
count=$1
blueprint=$2

scrCount=$( grep "osName => " /etc/puppet/manifests/blueprint${blueprint}.pp | wc -l)

while [[ "$count" != "$scrCount" ]] ; do
    sleep 120
done

if [ "$count" == "$scrCount" ]; then
	for line in  $(grep "osName => " /etc/puppet/manifests/blueprint${blueprint}.pp | cut -d"'" -f2)
	do
		os=$(echo $line | cut -d"," -f1)
		ipaddress=$(echo $line | cut -d"," -f2)
		if [ "$os" == "LinuxOS" ]; then
			ssh -i /usr/Devops/Keys/LabSetup.pem -o StrictHostKeyChecking=no root@$ipaddress puppet agent -t
		elif [ "$os" == "Windows" ]; then
			(echo "C:\\Devops\\temp\\installModules.bat"; echo exit; ) | winexe -U devops%Admin098 -W WORKGROUP //$ipaddress "cmd.exe"
		fi

	done
fi
