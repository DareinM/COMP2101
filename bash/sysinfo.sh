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
echo Report for "$HOSTNAME"
#command for lines style
awk '{print}'  lines.txt
# My Fully Qualified Domain Name(FQDN)
echo -n "FQDN: "; hostname --fqdn
#My operating system and version
echo -n "Operating System name and version:" ;grep PRETTY /etc/os-release 
#My IP address
echo -n "IP Address:"; hostname -I
#my root filesystem available space
echo -n "Root Filesystem Free Space:" ; df -h --output=avail /dev/sda3 | grep '[0-5]'
#ending lines
awk '{print}' lines.txt
#ending for now. I'll be back soon.
