#!/bin/sh

RG="$1" #pass Resource group name , can pull all the vm ips and names
Ip=$(az vm list-ip-addresses -g $RG  | grep -A1 privateIpAddresses | awk '{print $1}' | egrep -v "privateIpAddresses|--" | sed -e 's/^"//' -e 's/"$//')
#echo "$Ip"
Name=$(az vm list-ip-addresses -g $RG | grep -A1 "virtualMachine" | awk '{print $2}' | egrep -v "{|^$" | sed -e 's/^"//' -e 's/",$//')
#echo "$Name"

echo "\n["$RG"]" >> /home/guru/ipinventory_"$RG"
echo "$Ip" >> /home/guru/ipinventory_"$RG"
echo "\n["$RG":vars] " >> /home/guru/ipinventory_"$RG"
echo "ansible_connection=ssh" >> /home/guru/ipinventory_"$RG"
echo "ansible_user=guru" >> /home/guru/ipinventory_"$RG"
echo "ansible_ssh_pass=Newone@13579*" >> /home/guru/ipinventory_"$RG"

if (( $# != 1 ))
then
        print “USAGE: $0 arg1, pass resource group name as arg“
        exit
fi

