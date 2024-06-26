#!/bin/bash
cd /usr/lib/frr
./watchfrr zebra bgpd ldpd &
cd 
sleep 1

vtysh << EOF
config
#IP Configuration:
interface lo
ip address 1.255.0.2/32

interface eth0
ip address 10.1.12.2/30

interface eth1
ip address 10.1.23.1/30

#OSPF:
router ospf
router-id 1.255.0.2
network 1.255.0.2/32 area 0
network 10.1.12.0/30 area 0
network 10.1.23.0/30 area 0
EOF

#MPLS pre-setup:
# in /etc/sysctl.conf
echo "net.mpls.conf.lo.input = 1
net.mpls.conf.eth0.input = 1
net.mpls.conf.eth1.input = 1
net.mpls.platform_labels=100000" > /etc/sysctl.conf

sysctl -p

vtysh << EOF
config
#MPLS:
mpls ldp
router-id 1.255.0.2
ordered-control
address-family ipv4
discovery transport-address 1.255.0.2
interface eth0
interface eth1
interface lo
EOF


bash
