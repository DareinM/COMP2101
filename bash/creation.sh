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

if test 'ip l | grep lxdbr0';
then
 echo "lxdbr0 exists"
else
 lxd init
fi

#launching a container
if test 'lxc list | grep COMP2101-S22';
then
 echo "Already launched"
else
 lxc launch ubuntu:22.04 COMP2101-S22
fi

#Associating COMP2101-S22 name with container's Ip address in /etc/hosts
if test 'grep COMP2101-S22 /etc/hosts';
then
 echo "COMP2101-S22 is already associated with container's IP address"
else
 lxc exec test -- ip r | awk '/default/{print $9}'
fi

#Installing Apache2
if test 'lxc exec COMP2101-S22 service apache2 status';
then
 echo "apache2 is already installed"
else
lxc exec COMP2101-S22 -- apt install apache2
fi

#Retreiving default webpage from web service and notifying the user of success or failure
curl COMP2101-S22 && echo "Success" || echo "failure"
