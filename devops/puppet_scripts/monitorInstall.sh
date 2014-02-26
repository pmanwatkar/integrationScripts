#!/bin/sh

ip=$1
monitorInstall=$(echo $6 | sed -e "s/Mon_Os,//g;s/,Mon_Os//g;s/Mon_Os//g;s/Mon_//g")
vmName=$2
keyName=$3
group=$4
#cwConfigFile=$8
os=$5
monitorInstall=$(echo $6 | sed -e "s/Mon_Os,//g;s/,Mon_Os//g;s/Mon_Os//g;s/Mon_//g")
monitorInstall=$(echo $monitorInstall | sed -e "s/,/\\\', \\\'/g")
echo -e $monitorInstall
monitorStr="\'Device\', \'${monitorInstall}\'"
monitorStrW="\'Device_WMI\', \'${monitorInstall}\'"
#group="application"
monitorProp=$7
monitorVal=$8
system=`echo $vmName | awk -F- '{print $(NF-1)}'`

#cwProp=`echo $monitorInstall | grep -c CloudWatch`
#if [ "$cwProp" -eq 0 ]; then
 #  continue;
#elif [ "$cwProp" -eq 1 ]; then
 #  monitorProp="$monitorProp,CW_Instance_ID,CW_EncyptedFile" 
   
  # if [ "$os" == "LinuxOS" ]; then
   #   cwInstId=`ssh -i /usr/Devops/Keys/${keyName}.pem -o StrictHostKeyChecking=no root@$ip facter ec2_instance_id`
   #elif [ "$os" == "Windows" ]; then
      #cwInstId=(echo "C:\\Devops\\temp\\installModule.bat"; echo exit; ) | winexe -U Administrator%Admin098 -W WORKGROUP //$ip "cmd.exe"
   #fi
  # monitorVal="$monitorVal,$cwInstId,$cwConfigFile"
#fi


#echo $monitorStr;
echo $monitorStr

#echo $monitorStr;
testStr=`echo 1 | awk -v two=$monitorVal -v one=$monitorProp -F"," '{split(one,a);split(two,b);for(i=1;i<=length(a);i++)print "z"a[i]"="b[i]", "}'`

testStr=`echo $testStr | sed -e 's/=/=\\\"/g'`
testStr=`echo $testStr | sed -e 's/,/\\\",/g'`
#echo -e $testStr
if [ "$os" == "LinuxOS" ]; then
	writeStr="/Devices/Server $testStr setGroups=\'/${group}\', setSystems=\'/${system}\', setManageIp=\'${ip}\', zDeviceTemplates=[ $monitorStr ]"
elif [ "$os" == "Windows" ]; then
	writeStr="/Devices/Server/Windows zWinUser=\'Administrator\', zWinPassword=\'Admin098\', $testStr setGroups=\'/${group}\', setSystems=\'/${system}\', setManageIp=\'${ip}\', zDeviceTemplates=[ $monitorStrW ]"
fi

#echo -e $writeStr

ssh  -i /usr/Devops/Keys/${keyName}.pem -o StrictHostKeyChecking=no root@zenoss.hcl.com "echo -e  $writeStr  > /home/zenoss/ZenossDevices/$vmName.txt; echo $vmName >> /home/zenoss/ZenossDevices/$vmName.txt; zenbatchload /home/zenoss/ZenossDevices/$vmName.txt "


#ssh zenoss@10.98.241.240 "echo -e /Devices/Server/Linux $testStr setGroups=\'/${group}\', zDeviceTemplates=[ $monitorStr ] >> /home/zenoss/ZenossDevices/$ip.txt; echo $ip >> /home/zenoss/ZenossDevices/$ip.txt;"
# zenbatchload /home/zenoss/ZenossDevices/$ip.txt"
 
