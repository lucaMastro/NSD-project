#!/bin/bash
cd /usr/lib/frr
./watchfrr zebra bgpd ldpd &
cd 
sleep 1

vtysh << EOF
config
#IP Configuration:
interface lo
ip address 1.3.0.1/16
ip address 1.255.0.3/32

interface eth0
ip address 10.13.13.1/30

interface eth1
ip address 10.1.23.2/30

#OSPF:
router ospf
router-id 1.255.0.3
network 1.255.0.3/32 area 0
network 10.1.23.0/30 area 0
EOF


#MPLS pre-setup:
# in /etc/sysctl.conf
echo "net.mpls.conf.lo.input = 1
net.mpls.conf.eth1.input = 1
net.mpls.platform_labels=100000" > /etc/sysctl.conf

sysctl -p

vtysh << EOF
config
#MPLS:
mpls ldp
router-id 1.255.0.3
ordered-control
address-family ipv4
discovery transport-address 1.255.0.3
interface eth1
interface lo

#BGP:
router bgp 100
bgp router-id 1.255.0.3
network 1.3.0.0/16
neighbor 1.255.0.1 remote-as 100
neighbor 1.255.0.1 update-source 1.255.0.3
neighbor 1.255.0.1 next-hop-self
neighbor 10.13.13.2 remote-as 300
EOF


bash
