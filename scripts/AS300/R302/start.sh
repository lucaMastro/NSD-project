#!/bin/bash
cd /usr/lib/frr
./watchfrr zebra bgpd ldpd &
cd 
sleep 1

vtysh << EOF
config
#IP Configuration:
interface lo
ip address 3.2.0.1/16
ip address 3.255.0.2/32
interface eth0
ip address 3.2.0.1/30
interface eth1
ip address 10.3.12.2/30
interface eth2
ip address 10.34.34.1/30

#OSPF:
router ospf
router-id 3.255.0.2
network 3.2.0.0/16 area 0
network 3.255.0.2/32 area 0
network 10.3.12.0/30 area 0

#BGP:
router bgp 300
network 3.2.0.0/16
neighbor 3.255.0.1 remote-as 300
neighbor 3.255.0.1 update-source 3.255.0.2
neighbor 3.255.0.1 next-hop-self
neighbor 10.34.34.2 remote-as 400
EOF


bash
