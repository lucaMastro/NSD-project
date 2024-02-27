#!/bin/bash
cd /usr/lib/frr
./watchfrr zebra bgpd ldpd &
cd 

sleep 1
vtysh << EOF
config
#IP Configuration:
interface lo
ip address 4.1.0.1/16
ip address 4.255.0.1/32
interface eth0
ip address 10.34.34.2/30
interface eth1
ip address 4.1.0.1/30

#BGP:
router bgp 400
network 4.1.0.0/16
neighbor 10.34.34.1 remote-as 300
EOF


bash
