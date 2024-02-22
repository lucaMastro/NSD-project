#IP Configuration:
ip addr add 10.0.0.1/24 dev eth0
ip route add default via 10.0.0.2

openvpn /root/ovpn/end_host_client.ovpn &
cd
bash

