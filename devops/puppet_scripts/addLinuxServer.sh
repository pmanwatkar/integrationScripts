#!/bin/sh
vmName=$1
ipaddress=$2
username=$3
FQDN=${vmName}.hcl.com

echo "Hostname = " $FQDN
echo "ipaddress = " $ipaddress

ssh ${username}@$ipaddress "hostname"
ssh ${username}@$ipaddress "hostname ${FQDN}; sed -i '/${ipaddress}'/d /etc/hosts ; echo -e '${ipaddress} ${FQDN} ${vmName}' >> /etc/hosts; echo 10.98.241.61 master.hcl.com master >> /etc/hosts"

#ssh root@10.98.241.80 echo "10.98.241.61 master.hcl.com master >> /etc/hosts"

sed -e "5 a\ q_puppetagent_certname=$FQDN" /root/puppet2.5_repository/answers.agent > /root/puppet2.5_repository/${FQDN}.main

puppet node install --install-script puppet-enterprise --installer-payload ~/puppet2.5_repository/puppet-enterprise-latest-el-5-i386.tar.gz --installer-answers ~/puppet2.5_repository/${FQDN}.main --puppetagent-certname $FQDN --login root --keyfile /root/.ssh/id_rsa --debug $ipaddress

sleep 60

puppet cert sign $FQDN

rm -rf /root/puppet2.5_repository/${FQDN}.main

ssh ${username}@$ipaddress puppet agent -t

sleep 60

ssh root@$ipaddress puppet agent -t

echo "Agent Install Ho gya Bhai"
exit
