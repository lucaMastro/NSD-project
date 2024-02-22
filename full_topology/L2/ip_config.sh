PS4='[*] '
set -x

sudo ip route add default via 10.2.1.2 dev swp1 vrf TEN1 prio 100
sudo ip route append default via 10.2.2.2 dev swp2 vrf TEN1 prio 100
sudo ip route add default via 10.2.1.2 dev swp1 vrf TEN2 prio 100
sudo ip route append default via 10.2.2.2 dev swp2 vrf TEN2 prio 100

sudo ip route add 192.168.0.0/24 dev vlan10 
sudo ip route add 192.168.1.0/24 dev vlan20

set +x
