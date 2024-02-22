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
pwd
cd ..
cat start.sh 
ls
ls ..
cp ../start.sh .
vi start.sh 
ls
cat log
rm log
ip a
vtysh 
vtysh << EOF
config
#IP Configuration:
interface lo
ip address 2.2.0.1/16
ip address 2.255.0.2/32
interface eth0
ip address 2.2.0.1/30
interface eth1
ip address 10.2.12.2/30

#OSPF:
router ospf
router-id 2.255.0.2
network 2.2.0.0/16 area 0
network 2.255.0.2/32 area 0
network 10.2.12.0/30 area 0

#BGP:
router bgp 200
network 2.2.0.0/16
neighbor 2.255.0.1 remote-as 200
neighbor 2.255.0.1 update-source 2.255.0.2
neighbor 2.255.0.1 next-hop-self
EOF

ip a
exit
#!/bin/bash
vtysh << EOF
config
#IP Configuration:
interface lo
ip address 2.2.0.1/16
ip address 2.255.0.2/32
interface eth0
ip address 2.2.0.1/30
interface eth1
ip address 10.2.12.2/30

#OSPF:
router ospf
router-id 2.255.0.2
network 2.2.0.0/16 area 0
network 2.255.0.2/32 area 0
network 10.2.12.0/30 area 0

#BGP:
router bgp 200
network 2.2.0.0/16
neighbor 2.255.0.1 remote-as 200
neighbor 2.255.0.1 update-source 2.255.0.2
neighbor 2.255.0.1 next-hop-self
EOF

ip a
bash -i ./vtysh_conf.sh 
exit
#!/bin/bash
vtysh << EOF
config
#IP Configuration:
interface lo
ip address 2.2.0.1/16
ip address 2.255.0.2/32
interface eth0
ip address 2.2.0.1/30
interface eth1
ip address 10.2.12.2/30

#OSPF:
router ospf
router-id 2.255.0.2
network 2.2.0.0/16 area 0
network 2.255.0.2/32 area 0
network 10.2.12.0/30 area 0

#BGP:
router bgp 200
network 2.2.0.0/16
neighbor 2.255.0.1 remote-as 200
neighbor 2.255.0.1 update-source 2.255.0.2
neighbor 2.255.0.1 next-hop-self
EOF

ip a show eth0
ls
bash -i vtysh_conf.sh 
exit
vi start.sh 
ip a show eth0
cat start.sh 
exit
