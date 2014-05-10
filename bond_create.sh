#!/bin/sh

#  bond_create.sh
#  
#
#  Created by HSP SI Viet Nam on 5/10/14.
#
clear
ns=`echo $0`
read -p"Dien Vao ten bond interface cua ban: " bond_int
if [ "$bond_int" = "" ]; then
echo "Bond interface not Null!"
echo "Nhap Lai:"
sh $ns
exit 1
fi
read -p"IP address: " bond_ip
if [ "$bond_ip" = "" ]; then
echo "Bond IP not Null!"
echo "Nhap Lai:"
sh $ns
exit 1
fi

read -p"Net Mask: " bond_net
if [ "$bond_net" = "" ]; then
echo "Bond Net not Null!"
echo "Nhap Lai:"
sh $ns
exit 1
fi

read -p"Gateway: " bond_gw
if [ "$bond_gw" = "" ]; then
echo "Bond Gateway not Null!"
echo "Nhap Lai:"
sh $ns
exit 1
fi

cat > /etc/sysconfig/network-scripts/ifcfg-$bond_int << eof
DEVICE=$bond_int
TYPE=Ethernet
ONBOOT=yes
BOOTPROTO=none
IPV6INIT=no
USERCTL=no
IPADDR=$bond_ip
NETMASK=$bond_net
GATEWAY=$bond_gw
DNS1=8.8.8.8
BONDING_OPTS="mode=1 miimon=100 downdelay=200 updelay=200"
eof

cat > /etc/modprobe.d/bonding.conf << eof
alias $bond_int bonding
options $bond_int mode=active-backup miimon=100 downdelay=200 updelay=200
eof
modprobe bonding mode=active-backup miimon=100 downdelay=200 updelay=200
/etc/init.d/network restart
echo "Success"
exit 1