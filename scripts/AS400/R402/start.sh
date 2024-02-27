#IP Configuration:
sysctl -w net.ipv4.ip_forward=1

ip addr add 192.168.2.2/24 dev eth0
ip addr add 4.1.0.2/30 dev eth1
ip route add default via 4.1.0.1

iptables -A POSTROUTING -t nat -o eth1 -j MASQUERADE

# start ovpn
openvpn /root/ovpn/gw_client.ovpn &

cd
bash
