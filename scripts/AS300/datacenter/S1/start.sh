PS4='[*] '
set -x

net del all
net commit

#IP addresses:
net add interface swp1 ip add 10.1.1.2/30
net add interface swp2 ip add 10.2.1.2/30
net add loopback lo ip add 3.3.3.3/32


#OPSF:
net add ospf router-id 3.3.3.3
net add ospf network 0.0.0.0/0 area 0


#MP-eBGP:
net add bgp autonomous-system 65000
net add bgp router-id 3.3.3.3
net add bgp neighbor swp1 remote-as external
net add bgp neighbor swp2 remote-as external
net add bgp evpn neighbor swp1 activate
net add bgp evpn neighbor swp2 activate

net commit


set +x
