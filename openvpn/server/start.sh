#!/bin/bash
ip addr add 10.1.3.2/30 dev eth0
ip addr add 3.2.0.2/30 dev eth1
ip route add default via 3.2.0.1

# creo la cartella per le configurazioni ovpn:
mkdir -p /root/CA/ccd
cp /root/ovpn_conf/gw_client /root/CA/ccd
cp /root/ovpn_conf/server.ovpn /root/CA/server

# avvia openvpn
openvpn /root/CA/server/server.ovpn &

iptables -A POSTROUTING -t nat -o eth1 -j MASQUERADE
cd
bash
