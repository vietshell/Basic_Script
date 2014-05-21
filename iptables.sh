#!/bin/sh

#  iptables.sh
#  
#
#  Created by HSP SI Viet Nam on 5/14/14.
#


#Khai bao cac bien
IPTABLES='/sbin/iptables'
www_port='80'
tomcat_port='8080'
db_port='3306'
IPTABLES='/sbin/iptables'
outside='eth0'
inside='eth1'
inside_allow='192.168.1.0/24'

#enable net forwarding in kernel
sed -i 's/net.ipv4.ip_forward/\#net.ipv4.ip_forward/g' /etc/sysctl.conf
echo net.ipv4.ip_forward = 1
#Set default Policy
$IPTABLES -P INPUT ACCEPT
$IPTABLES -P OUTPUT ACCEPT
$IPTABLES -P FORWARD ACCEPT

$IPTABLES -t nat -P PREROUTING ACCEPT
$IPTABLES -t nat -P POSTROUTING ACCEPT
$IPTABLES -t nat -P OUTPUT ACCEPT

$IPTABLES -t mangle -P PREROUTING ACCEPT
$IPTABLES -t mangle -P POSTROUTING ACCEPT
$IPTABLES -t mangle -P OUTPUT ACCEPT
$IPTABLES -t mangle -P INPUT ACCEPT
$IPTABLES -t mangle -P FORWARD ACCEPT

#Flush all rule
$IPTABLES -F
$IPTABLES -X
$IPTABLES -t nat -F
$IPTABLES -t nat -X
$IPTABLES -t mangle -F
$IPTABLES -t mangle -X

#Zero all packet
$IPTABLES -Z
$IPTABLES -t nat -Z
$IPTABLES -t mangle -Z

#allow inside connection internet
$IPTABLES -t nat -A POSTROUTING -o $outside -j MASQUERADE
$IPTABLES -t nat -A FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
$IPTABLES -t nat -A FORWARD -s $inside_allow -o $outside -j ACCEPT

#nat port web
#nat
-A PREROUTING -i eth0 -p tcp -m tcp --dport 80 -j DNAT --to-destination 192.168.1.69:80
-A PREROUTING -i eth0 -p tcp -m tcp --dport 8080 -j DNAT --to-destination 192.168.1.96:8080
-A PREROUTING -i eth0 -p tcp -m tcp --dport 3306 -j DNAT --to-destination 192.168.1.113:3306
-A POSTROUTING -o eth0 -j MASQUERADE


#-m iprange --src-range
#--dst-range
#filter
-A INPUT -p tcp -m tcp --dport 22 -j ACCEPT
-A INPUT -p tcp -m tcp --sport 22 -j ACCEPT
-A FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
-A FORWARD -d 192.168.1.69/32 -p tcp -m tcp --dport 80 -j ACCEPT
-A FORWARD -s 192.168.1.69/32 -o eth0 -j DROP
-A FORWARD -d 192.168.1.96/32 -p tcp -m tcp --dport 8080 -j ACCEPT
-A FORWARD -d 192.168.1.113/32 -p tcp -m tcp --dport 3306 -j ACCEPT
-A FORWARD -s 192.168.1.96/32 -o eth0 -j DROP
-A FORWARD -s 192.168.1.0/24 -o eth0 -j ACCEPT
-A OUTPUT -p tcp -m tcp --sport 22 -j ACCEPT
-A OUTPUT -p tcp -m tcp --dport 22 -j ACCEPT





