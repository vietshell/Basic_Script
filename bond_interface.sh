#!/bin/sh

#  bond_interface.sh
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
fi
options=`ip link show | grep "BROADCAST,MULTICAST" | awk '{print $2}' | sed 's/://'`

prompt="Nhap vao lua chon cua ban :"
printf "=========================================================================\n"
printf "Ban Muon Cau Hinh cho interface nao \n"
printf "=========================================================================\n"

PS3="$prompt"
select opt in $options "Thoat"; do
break
done

if [ "$opt" = "" ]; then
    echo "Khong duoc la rong..."
    echo "Nhap Lai"
    sh $ns
    exit 1
fi

if [ "$opt" = "Thoat" ]; then
echo "Goodby My Love..."
exit 1
fi

cat > /etc/sysconfig/network-scripts/ifcfg-$opt << eof
DEVICE=$opt
TYPE=Ethernet
ONBOOT=yes
BOOTPROTO=none
IPV6INIT=no
USERCTL=no
MASTER=$bond_int
SLAVE=yes
eof

ifdown $opt && ifup $opt
echo "Success"
exit 1