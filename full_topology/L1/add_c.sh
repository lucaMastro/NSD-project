PS4='[*] '
set -x


#Configuration:
net add bridge bridge ports swp3,swp4,swp6
net add interface swp6 bridge access 30


#IP addresses:
net add vlan 30 ip add 192.168.30.254/24
net add ospf passive-interface swp6


#VXLAN:
net add vxlan vni300 vxlan id 300
net add vxlan vni300 vxlan local-tunnelip 1.1.1.1
net add vxlan vni300 bridge access 30


#VRFs:
net add vlan 30 vrf TEN1

net commit

ip route add default via 10.1.3.2 dev vlan30 vrf TEN1
ip route add 192.168.30.0/24 dev vlan30 

set +x
