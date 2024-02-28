#!/bin/bash
sysctl -w net.ipv4.ip_forward=1

ip addr add 3.2.0.2/30 dev eth1
ip route add default via 3.2.0.1

ip link add link eth0 name eth0.100 type vlan id 100
ip link add link eth0 name eth0.200 type vlan id 200

ip addr add 10.1.3.2/30 dev eth0.100
ip addr add 10.1.3.2/30 dev eth0.200

ip link set eth0.100 up
ip link set eth0.200 up

ip route add 192.168.0.0/24 via 10.1.3.1 dev eth0.100
ip route add 192.168.1.0/24 via 10.1.3.1 dev eth0.200

# avvia openvpn
openvpn /root/CA/server/server.ovpn &

iptables -A POSTROUTING -t nat -o eth1 -j MASQUERADE

iptables -F FORWARD
iptables -P FORWARD ACCEPT
iptables -A FORWARD -m state --state ESTABLISHED -j ACCEPT
iptables -A FORWARD -i eth0.100 -d 192.168.100.0/24 -j DROP
iptables -A FORWARD -i eth0.100 -d 192.168.2.0/24 -j DROP
iptables -A FORWARD -i eth0.200 -d 192.168.0.0/24 -j DROP
iptables -A FORWARD -i eth0.100 -d 192.168.1.0/24 -j DROP

cd
bash
