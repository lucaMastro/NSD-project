# Progetto-NSD

Progetto per il corso di _Network and System Defence_.

**Autori**

- :man_technologist: Enrico D'Alessandro (matricola 0306424)
- :man_technologist: Luca Mastrobattista (matricola 0292461)

## Topologia

<p align="center">
  <img width=90% src="images/topology.png">
</p>

## Indice

1.  [AS100](#AS100)
       1. [Configurazione dei router](##Configurazione_dei_router)
       1. [R101](##R101)
       1. [R102](##R102)
       1. [R103](##R103)

1.  [AS200](#AS200)

        1. [R201](#R201)

        1. [R202](#R202)

        1. [R203](#R203)

           1. [Client-200](#Client-200)
              1. [MAC - AppArmor](#MAC-AppArmor)

1.  [AS300](#AS300)

    1. [R301](#R301)

    2. [R302](#R302)

    3. [GW300](#GW300)

1.  [Datacenter](#Datacenter)

    1. [Spines](#Spines)
    2. [Leaves](#Leaves)
    3. [End-Hosts](#End-Hosts)

1.  [AS400](#AS400)

    1. [R401](#R401)
    2. [R402](#R402)
       1. [Client-400](#Client-400)

1.  [OpenVPN](#OpenVPN)

    1. [Installazione del servizio](#Installazione_di_OpenVPN_su_Lubuntu_22.04.3)

# AS100

## Configurazione dei router
 Gli script di configurazione dei router dell'AS100 saranno discussi nelle sezioni seguenti.

## R101
Configurazione delle interfacce:
```
interface eth0
 ip address 10.12.12.1/30
exit
!
interface eth1
 ip address 10.1.12.1/30
 mpls enable
exit
!
interface lo
 ip address 1.1.0.1/16
 ip address 1.255.0.1/32
 mpls enable
exit
```

Configurazione del protocollo BGP:
```
router bgp 100
 bgp router-id 1.255.0.1
 neighbor 1.255.0.3 remote-as 100
 neighbor 1.255.0.3 update-source 1.255.0.1
 neighbor 10.12.12.2 remote-as 200
 !
 address-family ipv4 unicast
  network 1.1.0.0/16
  neighbor 1.255.0.3 next-hop-self
 exit-address-family
exit
```
Configurazione del protocollo OSPF:
```
router ospf
 ospf router-id 1.255.0.1
 network 1.255.0.1/32 area 0
 network 10.1.12.0/30 area 0
exit
```

Configurazione del protocollo MPLS:
```
mpls ldp
 router-id 1.255.0.1
 ordered-control
 !
 address-family ipv4
  discovery transport-address 1.255.0.1
  !
  interface eth1
  exit
  !
  interface lo
  exit
  !
 exit-address-family
 !
exit
```

 **N.B**: per utilizzare correttamente MPLS è necessario abilitare le interfacce che possono accettare pacchetti MPLS. In particolare, è stato necessario modificare il file `/etc/sysctl.conf` con l'aggiunta dei seguenti parametri di configurazione:
```
net.mpls.conf.lo.input = 1
net.mpls.conf.eth1.input = 1
net.mpls.platform_labels = 100000
```
Inoltre, per rendere attive le modifiche è necessario utilizzare il comando `sysctl -p`.
 

## R102

Configurazione delle interfacce:
```
interface eth0
 ip address 10.1.12.2/30
 mpls enable
exit
!
interface eth1
 ip address 10.1.23.1/30
 mpls enable
exit
!
interface lo
 ip address 1.255.0.2/32
 mpls enable
exit
```

Configurazione del protocollo OSPF:
```
router ospf
 ospf router-id 1.255.0.2
 network 1.255.0.2/32 area 0
 network 10.1.12.0/30 area 0
 network 10.1.23.0/30 area 0
exit
```

Configurazione del protocollo MPLS:
```
mpls ldp
 router-id 1.255.0.2
 ordered-control
 !
 address-family ipv4
  discovery transport-address 1.255.0.2
  !
  interface eth0
  exit
  !
  interface eth1
  exit
  !
  interface lo
  exit
  !
 exit-address-family
 !
exit
```

**N.B**: per utilizzare correttamente MPLS è necessario abilitare le interfacce che possono accettare pacchetti MPLS. In particolare, è stato necessario modificare il file `/etc/sysctl.conf` con l'aggiunta dei seguenti parametri di configurazione:
```
net.mpls.conf.lo.input = 1
net.mpls.conf.eth0.input = 1
net.mpls.conf.eth1.input = 1
net.mpls.platform_labels = 100000
```
Inoltre, per rendere attive le modifiche è necessario utilizzare il comando `sysctl -p`.
 

## R103
Configurazione delle interfacce:
```
interface eth0
 ip address 10.13.13.1/30
exit
!
interface eth1
 ip address 10.1.23.2/30
 mpls enable
exit
!
interface lo
 ip address 1.255.0.3/32
 ip address 1.3.0.1/16
 mpls enable
exit
```

Configurazione del protocollo BGP:
```
router bgp 100
 bgp router-id 1.255.0.3
 neighbor 1.255.0.1 remote-as 100
 neighbor 1.255.0.1 update-source 1.255.0.3
 neighbor 10.13.13.2 remote-as 300
 !
 address-family ipv4 unicast
  network 1.3.0.0/16
  neighbor 1.255.0.1 next-hop-self
 exit-address-family
exit
```

Configurazione del protocollo OSPF:
```
router ospf
 ospf router-id 1.255.0.3
 network 1.255.0.3/32 area 0
 network 10.1.23.0/30 area 0
exit
```

Configurazione del protocollo MPLS:
```
mpls ldp
 router-id 1.255.0.3
 ordered-control
 !
 address-family ipv4
  discovery transport-address 1.255.0.3
  !
  interface eth1
  exit
  !
  interface lo
  exit
  !
 exit-address-family
 !
exit
```

**N.B**: per utilizzare correttamente MPLS è necessario abilitare le interfacce che possono accettare pacchetti MPLS. In particolare, è stato necessario modificare il file `/etc/sysctl.conf` con l'aggiunta dei seguenti parametri di configurazione:
```
net.mpls.conf.lo.input = 1
net.mpls.conf.eth1.input = 1
net.mpls.platform_labels = 100000
```
Inoltre, per rendere attive le modifiche è necessario utilizzare il comando `sysctl -p`.
