#!/bin/bash
#filename
echo "$ ./sysinfo.sh"

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
 
#ending for now. I'll be back soon.
