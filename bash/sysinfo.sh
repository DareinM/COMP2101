#!/bin/bash

#filename
echo "$ ./sysinfo.sh"
echo
#For Bash Lab1

#Hostname of my machine
echo Hostname:"$HOSTNAME"

#Domain name of the system:
echo Domain name: 
hostname -d
#Operating System running on this machine
echo Operating System name: 
grep PRETTY /etc/os-release

# Version of the operating System
echo Version:
uname -r

#IP Addresses (IPv4 and IPv6)
echo IPv4:
hostname -I

#Status of Root filesystem:
echo Root Filesystem Status:
df -h /dev/sda3

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
