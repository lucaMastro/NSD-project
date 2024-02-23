#!/bin/bash
ip addr add 10.1.3.2/30 dev eth0
ip addr add 3.2.0.2/30 dev eth1
ip route add default via 3.2.0.1
ip route add 192.168.0.0/24 via 10.1.3.1

# creo la cartella per le configurazioni ovpn:
mkdir -p /root/CA/ccd
cp /root/ovpn_conf/gw_client /root/CA/ccd
cp /root/ovpn_conf/server.ovpn /root/CA/server

# avvia openvpn
openvpn /root/CA/server/server.ovpn &

iptables -A POSTROUTING -t nat -o eth1 -j MASQUERADE

iptables -F FORWARD
iptables -P FORWARD ACCEPT
iptables -A FORWARD -m state --state ESTABLISHED -j ACCEPT
iptables -A FORWARD -i eth0 -d 192.168.100.0/24 -j DROP
iptables -A FORWARD -i eth0 -d 192.168.2.0/24 -j DROP

cd
bash

