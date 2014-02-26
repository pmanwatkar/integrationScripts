#!/bin/sh

cp /usr/Devops/Scripts/hostFile/hosts /etc/hosts
ssh -i /usr/Devops/Keys/LabSetup.pem -o StrictHostKeyChecking=no root@puppetca.hcl.com "cp /usr/Devops/Scripts/hostFile/hosts /etc/hosts"
ssh -i /usr/Devops/Keys/LabSetup.pem -o StrictHostKeyChecking=no root@dbserver.hcl.com "cp /usr/Devops/Scripts/hostFile/hosts /etc/hosts"
ssh -i /usr/Devops/Keys/LabSetup.pem -o StrictHostKeyChecking=no root@puppetm2.hcl.com "cp /usr/Devops/Scripts/hostFile/hosts /etc/hosts"
ssh -i /usr/Devops/Keys/LabSetup.pem -o StrictHostKeyChecking=no root@zenoss.hcl.com "cp /usr/Devops/Scripts/hostFile/hosts /etc/hosts"
ssh -i /usr/Devops/Keys/LabSetup.pem -o StrictHostKeyChecking=no root@nfsrepo.hcl.com "cp /usr/Devops/Repo/Scripts/hostFile/hosts /etc/hosts"

