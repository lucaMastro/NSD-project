PS4='[*] '
set -x

ip route add default via 10.1.3.2 dev vlan10 vrf TEN1
ip route add default via 10.1.3.2 dev vlan20 vrf TEN2
ip route add 192.168.0.0/24 dev vlan10

ip route add 192.168.2.0/24 via 10.1.3.2
ip route add 192.168.100.0/24 via 10.1.3.2

sudo iptables -A POSTROUTING -t nat -o swp5 -j MASQUERADE

set +x
