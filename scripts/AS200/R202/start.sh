#!/bin/bash
cd /usr/lib/frr
./watchfrr zebra bgpd ldpd &
cd 
sleep 1

vtysh << EOF
config
#IP Configuration:
interface lo
ip address 2.2.0.1/16
ip address 2.255.0.2/32
interface eth0
ip address 2.2.0.1/30
interface eth1
ip address 10.2.12.2/30

#OSPF:
router ospf
router-id 2.255.0.2
network 2.2.0.0/16 area 0
network 2.255.0.2/32 area 0
network 10.2.12.0/30 area 0

#BGP:
router bgp 200
network 2.2.0.0/16
neighbor 2.255.0.1 remote-as 200
neighbor 2.255.0.1 update-source 2.255.0.2
neighbor 2.255.0.1 next-hop-self
EOF

bash
