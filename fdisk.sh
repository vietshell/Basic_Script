#!/bin/sh

#  fdisk.sh
#  
#
#  Created by HSP SI Viet Nam on 5/12/14.
#
40  fdisk /dev/sdc
41  fdisk -l
42  pvcreate /dev/sdc1
43  pvdisplay
44  vgextend vg_mysql /dev/sdc1
45  fdisk
46  vgdisplay
47  history
48  lvextend -r -l 100%FREE /dev/vg_mysql/lv_root
49  lvextend -l+100%FREE /dev/vg_mysql/lv_root
50  resize2fs /dev/mapper/vg_mysql-lv_root