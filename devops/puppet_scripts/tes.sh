#!bin/sh

monitorInstall=`echo $1 | sed -e "s/MON_OS//g"`
monitorInstall=`echo $monitorInstall | sed -e "s/,/\\', \\'/g"`

echo $monitorInstall

