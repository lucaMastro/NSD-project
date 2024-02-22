vi start.sh
vi /start.sh 
cd /
./start.sh 
ls
ls
ls
ls
cd start.sh 
vi start.sh 
vi /etc/frr/daemons 
ls
vi /start.sh
ls
chmod +x start.sh 
./start.sh 
vim /etc/frr/daemons 
vi /etc/frr/daemons 
ls
ls
ls
cd start.sh 
ls
vim start.sh 
vi start.sh 
ls
ls
ls -l
vtysh 
ls
vtysh 
vtysh << EOF
#IP Configuration:
interface lo
ip address 1.1.0.1/16
ip address 1.255.0.1/32

interface eth0
ip address 10.12.12.1/30

interface eth1
ip address 10.1.12.1/30


#OSPF:
router ospf
router-id 1.255.0.1
network 1.255.0.1/32 area 0
network 10.1.12.0/30 area 0
EOF

#MPLS pre-setup:
# in /etc/sysctl.conf
echo "net.mpls.conf.lo.input = 1
net.mpls.conf.eth1.input = 1
net.mpls.platform_labels=100000" > /etc/sysctl.conf
sysctl -p
vtysh << EOF
#MPLS:
mpls ldp
router-id 1.255.0.1
ordered-control
address-family ipv4
discovery transport-address 1.255.0.1
interface eth1
interface lo


#BGP:
router bgp 100
bgp router-id 1.255.0.1
network 1.1.0.0/16
neighbor 1.255.0.3 remote-as 100
neighbor 1.255.0.3 update-source 1.255.0.1
neighbor 1.255.0.3 next-hop-self
neighbor 10.12.12.2 remote-as 200
EOF

vtysh 
vtysh 
vtysh 
vtysh << EOF
config
#IP Configuration:
interface lo
ip address 1.1.0.1/16
ip address 1.255.0.1/32

interface eth0
ip address 10.12.12.1/30

interface eth1
ip address 10.1.12.1/30


#OSPF:
router ospf
router-id 1.255.0.1
network 1.255.0.1/32 area 0
network 10.1.12.0/30 area 0
EOF

vim /root/start.sh
vi /root/start.sh
ls
cp start.sh /root/start.sh 
rm /root/start.sh 
cp start.sh /root/start.sh 
cd /
cp start.sh /root/start.sh 
vi /root/start.sh 
vim start.sh 
vi start.sh 
