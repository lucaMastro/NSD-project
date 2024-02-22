PS4='[*] '
set -x

net del all
net commit

#Configuration:
net add bridge bridge ports swp3,swp4
net add interface swp3 bridge access 10
net add interface swp4 bridge access 20


#IP addresses:
net add interface swp1 ip add 10.2.1.1/30
net add interface swp2 ip add 10.2.2.1/30
net add loopback lo ip add 2.2.2.2/32
#
net add vlan 10 ip add 192.168.0.254/24
net add vlan 20 ip add 192.168.1.254/24


#OPSF:
net add ospf router-id 2.2.2.2
net add ospf network 10.2.1.0/30 area 0
net add ospf network 10.2.2.0/30 area 0
net add ospf network 2.2.2.2/32 area 0
net add ospf passive-interface swp3,swp4


#VXLAN:
net add vxlan vni100 vxlan id 100
net add vxlan vni100 vxlan local-tunnelip 2.2.2.2
net add vxlan vni100 bridge access 10
net add vxlan vni200 vxlan id 200
net add vxlan vni200 vxlan local-tunnelip 2.2.2.2
net add vxlan vni200 bridge access 20


#MP-eBGP:
net add bgp autonomous-system 65002
net add bgp router-id 2.2.2.2
net add bgp neighbor swp1 remote-as 65000
net add bgp neighbor swp2 remote-as 65000
net add bgp evpn neighbor swp1 activate
net add bgp evpn neighbor swp2 activate
net add bgp evpn advertise-all-vni


#L3VNI:
net add vlan 50
net add vxlan vni-1000 vxlan id 1000
net add vxlan vni-1000 vxlan local-tunnelip 2.2.2.2
net add vxlan vni-1000 bridge access 50

net add vlan 60
net add vxlan vni-2000 vxlan id 2000
net add vxlan vni-2000 vxlan local-tunnelip 2.2.2.2
net add vxlan vni-2000 bridge access 60


#VRFs:
net add vrf TEN1 vni 1000
net add vlan 50 vrf TEN1
net add vlan 10 vrf TEN1

net add vrf TEN2 vni 2000
net add vlan 60 vrf TEN2
net add vlan 20 vrf TEN2

net commit

bash /home/cumulus/ip_config.sh

set +x
