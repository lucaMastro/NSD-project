PS4='[*] '
set -x

net del all
net commit

#Configuration:
net add bridge bridge ports swp3,swp4,swp5
net add bridge bridge vids 10,20,50,60,100,200
net add bridge bridge vlan-aware

net add interface swp3 bridge access 10
net add interface swp4 bridge access 20

net add vlan 100 
net add bridge bridge ports swp5
net add vlan 200
net add bridge bridge ports swp5

#IP addresses:
net add interface swp1 ip add 10.1.1.1/30
net add interface swp2 ip add 10.1.2.1/30
net add loopback lo ip add 1.1.1.1/32

net add vlan 10 ip address 192.168.0.254/24
net add vlan 20 ip address 192.168.1.254/24
net add vlan 100 ip address 10.1.3.1/30
net add vlan 100 ip gateway 10.1.3.2
net add vlan 200 ip address 10.1.3.1/30
net add vlan 200 ip gateway 10.1.3.2


#OSPF:
net add ospf router-id 1.1.1.1
net add ospf network 10.1.1.0/30 area 0
net add ospf network 10.1.2.0/30 area 0
net add ospf network 1.1.1.1/32 area 0
net add ospf passive-interface swp3,swp4,swp5


#VXLAN:
net add vxlan vni-10 vxlan id 10
net add vxlan vni-10 vxlan local-tunnelip 1.1.1.1
net add vxlan vni-10 bridge access 10
net add vxlan vni-20 vxlan id 20
net add vxlan vni-20 vxlan local-tunnelip 1.1.1.1
net add vxlan vni-20 bridge access 20
net add vxlan vni-100 vxlan id 100
net add vxlan vni-100 vxlan local-tunnelip 1.1.1.1
net add vxlan vni-100 bridge access 100
net add vxlan vni-200 vxlan id 200
net add vxlan vni-200 vxlan local-tunnelip 1.1.1.1
net add vxlan vni-200 bridge access 200


#MP-eBGP:
net add bgp autonomous-system 65001
net add bgp router-id 1.1.1.1
net add bgp neighbor swp1 remote-as 65000
net add bgp neighbor swp2 remote-as 65000
net add bgp evpn neighbor swp1 activate
net add bgp evpn neighbor swp2 activate
net add bgp evpn advertise-all-vni

net add bgp vrf TEN1 autonomous-system 65001
net add bgp vrf TEN1 l2vpn evpn advertise ipv4 unicast
net add bgp vrf TEN1 l2vpn evpn default-originate ipv4

net add bgp vrf TEN2 autonomous-system 65001
net add bgp vrf TEN2 l2vpn evpn advertise ipv4 unicast
net add bgp vrf TEN2 l2vpn evpn default-originate ipv4


#L3VNI:
net add vlan 50
net add vxlan vni-1000 vxlan id 1000
net add vxlan vni-1000 vxlan local-tunnelip 1.1.1.1
net add vxlan vni-1000 bridge access 50
net add vlan 60
net add vxlan vni-2000 vxlan id 2000
net add vxlan vni-2000 vxlan local-tunnelip 1.1.1.1
net add vxlan vni-2000 bridge access 60


#VRFs:
net add vrf TEN1 vni 1000
net add vlan 50 vrf TEN1
net add vlan 10 vrf TEN1
net add vlan 100 vrf TEN1

net add vrf TEN2 vni 2000
net add vlan 60 vrf TEN2
net add vlan 20 vrf TEN2
net add vlan 200 vrf TEN2

net commit

set +x
