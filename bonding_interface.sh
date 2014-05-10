#!/bin/sh

#  bonding_interface.sh
#  
#
#  Created by HSP SI Viet Nam on 5/10/14.
#
ns=`echo $0`
prompt="Nhap vao lua chon cua ban:"

options=("Cau hinh Bond Interface" "Add Interface vao Bond interface")

printf "=========================================================================\n"
printf "Danh sach Update chuong trinh, ban muon lam gi vui long chon \n"
printf "=========================================================================\n"
PS3="$prompt"

select opt in "${options[@]}" "Thoat"; do

case "$REPLY" in

1 )



$(( ${#options[@]}+1 )) ) echo "Chao tam biet!"; break;;
*) echo "Ban nhap sai, vui long nhap theo so thu tu tren danh sach";continue;;

esac

done

#configure number interface
vi /etc/sysconfig/network-scripts/ifcfg-eth0
# change like follows
DEVICE=eth0
TYPE=Ethernet
ONBOOT=yes
BOOTPROTO=none
IPV6INIT=no
USERCTL=no
MASTER=bond0
SLAVE=yes



#configure bond interface
vi /etc/sysconfig/network-scripts/ifcfg-bond0
DEVICE=bond0
TYPE=Ethernet
ONBOOT=yes
BOOTPROTO=none
IPV6INIT=no
USERCTL=no
IPADDR=10.0.0.100
GATEWAY=10.0.0.1
DNS1=10.0.0.10
BONDING_OPTS="mode=1 primary=eth0 miimon=500"