#IP Configuration:
sysctl -w net.ipv4.ip_forward=1

ip addr add 10.0.0.2/24 dev eth0
ip addr add 2.2.0.2/30 dev eth1
ip route add default via 2.2.0.1

iptables -F
iptables -A POSTROUTING -t nat -o eth1 -j MASQUERADE
iptables -P FORWARD DROP

iptables -A FORWARD -m state --state ESTABLISHED -j ACCEPT
iptables -A FORWARD -i eth0 -o eth1 -j ACCEPT

cd
bash
