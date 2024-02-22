PS4='[*] '
set -x

sudo ip route add default via 10.1.2.1 dev swp1

set +x
