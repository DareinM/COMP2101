#!/bin/bash
#Creation of Virtual Web Server

#installing lxd

if test "which lxc"-;
then 
 echo "container exists"
else 
 sudo snap install lxd
fi

#initializing lxdbr0

if test lxdbr0;
then
 echo "lxdbr0 exists"
else
 lxd init
fi

#launching a container
if test 'COMP2101-S22 > lxc list';
then
 echo "Already launched"
else
 lxc launch ubuntu:22.04 COMP2101-S22
fi

#Associating COMP2101-S22 name with container's Ip address in /etc/hosts
if test 'COMP2101-S22 > sudo /etc/hosts';
then
 echo "COMP2101-S22 is already associated with container's IP address"
else
 lxc exec test -- ip r | awk '/default/{print $9}'
fi

#Installing Apache2
if test 'apache2 > lxc exec COMP2101-S22 bash';
then
 echo "apache2 is already installed"
else
lxc exec COMP2101-S22 -- apt install apache2
fi

#Retreiving default webpage from web service and notifying the user of success or failure
curl COMP2101-S22 && echo "Success" || echo "failure"
