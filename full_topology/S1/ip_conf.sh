set -x
PS4='[*] '

sudo ip route add default via 10.1.1.1 dev swp1

set +x
