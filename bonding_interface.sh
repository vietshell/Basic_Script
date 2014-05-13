#!/bin/sh

#  bonding_interface.sh
#  
#
#  Created by HSP SI Viet Nam on 5/10/14.
#
clear
thumuc=`pwd`
ns=`echo $0`
nodung="=========================================================================
Danh sach Update chuong trinh, ban muon lam gi vui long chon
=========================================================================
1) Cau hinh Bond Interface	     3) Thoat
2) Add Interface vao Bond interface
"
prompt="Nhap vao lua chon cua ban:"
options=("Cau hinh Bond Interface" "Add Interface vao Bond interface")
printf "=========================================================================\n"
printf "Danh sach Update chuong trinh, ban muon lam gi vui long chon \n"
printf "=========================================================================\n"
PS3="$prompt"
select opt in "${options[@]}" "Thoat"; do
case "$REPLY" in
1 ) sh $thumuc/bond_config; echo "$noidung";;
2 ) sh $thumuc/bond_interface; echo "$noidung";;

$(( ${#options[@]}+1 )) ) echo "Chao tam biet!"; break;;
*) echo "Ban nhap sai, vui long nhap theo so thu tu tren danh sach";continue;;

esac

done

exit 1