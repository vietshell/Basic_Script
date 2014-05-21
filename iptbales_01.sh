#!/bin/sh

#  iptbales_01.sh
#  
#
#  Created by HSP SI Viet Nam on 5/19/14.
#
iptables -D INPUT -j DROP
iptables -D INPUT -j DROP
iptables -D OUTPUT -j ACCEPT
iptables -D OUTPUT -j DROP
iptables -D OUTPUT -p icmp -j REJECT --reject-with icmp-port-unreachable
iptables -D OUTPUT -j DROP

iptables -D OUTPUT -p icmp -j REJECT --reject-with icmp-port-unreachable

 php-mcrypt
php-pecl-redis




iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT


-A INPUT -p icmp -m limit --limit 1/sec --limit-burst 2 -j ACCEPT
-A INPUT -p icmp -m limit --limit 1/sec --limit-burst 2 -j LOG --log-prefix "PING-DROP:"
-A INPUT -p icmp -j DROP
-A INPUT -p icmp -f -j DROPLOG
-A INPUT -p icmp -m state --state ESTABLISHED -m limit --limit 6/sec --limit-burst 20 -j ACCEPT
-A INPUT -p icmp -m state --state RELATED -m limit --limit 6/sec --limit-burst 20 -j RELATED_ICMP
-A INPUT -p icmp -m icmp --icmp-type 8 -m limit --limit 6/sec --limit-burst 20 -j ACCEPT
-A INPUT -p icmp -j DROPLOG
-A FORWARD -p icmp -f -j DROPLOG
-A FORWARD -p icmp -j DROPLOG
-A OUTPUT -p icmp -j ACCEPT
-A OUTPUT -p icmp -f -j DROPLOG
-A OUTPUT -p icmp -m state --state ESTABLISHED -m limit --limit 6/sec --limit-burst 20 -j ACCEPT
-A OUTPUT -p icmp -m state --state RELATED -m limit --limit 6/sec --limit-burst 20 -j RELATED_ICMP
-A OUTPUT -p icmp -m icmp --icmp-type 8 -m limit --limit 6/sec --limit-burst 20 -j ACCEPT
-A OUTPUT -p icmp -j DROPLOG
-A REJECTLOG -j REJECT --reject-with icmp-port-unreachable
-A RELATED_ICMP -p icmp -m icmp --icmp-type 3 -j ACCEPT
-A RELATED_ICMP -p icmp -m icmp --icmp-type 11 -j ACCEPT
-A RELATED_ICMP -p icmp -m icmp --icmp-type 12 -j ACCEPT