#!/bin/bash

#filename
echo "$ ./sysinfo.sh"
echo
#For Bash Lab2
echo
#Report of myvm
host=$HOSTNAME
FQDN=$(hostname --fqdn)
system=$(grep PRETTY /etc/os-release)
ip=$(hostname -I)
root=$(df -h --output=avail /dev/sda3 | tail -1)

cat <<template
Report for $host
=================================
FQDN:$FQDN
Operating System and Version:$system
IP Address:$ip
Root FIlesystem Free Space: $root
=================================
template
#ending for now. I'll be back soon.
