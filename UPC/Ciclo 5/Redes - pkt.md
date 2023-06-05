## Configuracion de TF Redes

### Indice

1. [ISP](#1-isp)

2. [Lima](#2-lima)

   2.1. [Router Lima](#21-configuracion-del-router-lima)

   2.2. [MLS Lima 1](#22-configuracion-del-switch-multi-capa-1)

   2.3. [MLS Lima 2](#23-configuracion-del-switch-multi-capa-2)

   2.4. [Switch Normal](#24-configuracion-del-switch-normal)

3. [Comandos adicionales](#3-comandos-adicionales)

4. [Tablas de mascaras de subred](#4-tablas-de-mascaras-de-subred)

### 1. ISP

#### 1.1. Configuracion del router ISP

```
en
conf t
hostname ISP

interface s0/0/0
description LINK ISP-LIMA
ip address 100.50.50.1 255.255.255.252
clock rate 64000
bandwidth 16384
no shutdown
do show history

ip route 172.24.0.0 255.255.0.0 100.50.50.2 1

username RTLIM1 secret grupo4

int s0/0/0
encapsulation ppp
ppp authentication chap
exit
```

### 2. Lima

#### 2.1. Configuracion del router Lima

```bash
en
conf t
hostname RTLIM1

interface s0/0/0
description LINK LIMA-ISP
ip address 100.50.50.2 255.255.255.252
bandwidth 16384
no shutdown
do show history
interface s0/0/1
description LINK LIMA-PIURA
ip address 172.24.254.5 255.255.255.252
clock rate 64000
bandwidth 8192
no shutdown
do show history
interface s0/1/0
description LINK LIMA-AREQUIPA
ip address 172.24.254.9 255.255.255.252
clock rate 64000
bandwidth 8192
no shutdown
do show history
interface s0/1/1
description LINK LIMA-CUZCO
ip address 172.24.254.13 255.255.255.252
clock rate 64000
bandwidth 8192
no shutdown
do show history
interface s0/2/0
description LINK LIMA-CAJAMARCA
ip address 172.24.254.17 255.255.255.252
clock rate 64000
bandwidth 8192
no shutdown
do show history

int g0/0
ip add 172.24.254.21 255.255.255.252
ip ospf 100 area 0
int g0/1
ip add 172.24.254.25 255.255.255.252

ip route 0.0.0.0 0.0.0.0 s0/0/0 1

router ospf 100
router-id 1.1.1.1
network 100.50.50.0 0.0.0.3 area 0
network 172.24.254.4 0.0.0.3 area 0
network 172.24.254.8 0.0.0.3 area 0
network 172.24.254.12 0.0.0.3 area 0
network 172.24.254.16 0.0.0.3 area 0
network 172.24.254.20 0.0.0.3 area 0
network 172.24.254.24 0.0.0.3 area 0
pasive-interface s0/0/0
default-information originate
exit

username RTPIU1 secret grupo4
username RTARE1 secret grupo4
username RTCAJ1 secret grupo4
username RTCUS1 secret grupo4
username ISP secret grupo4

int s0/0/0
encapsulation ppp
ppp authentication chap
int s0/0/1
encapsulation ppp
ppp authentication pap
ppp pap sent-username RTLIM1 password grupo4
int s0/1/0
encapsulation ppp
ppp authentication pap
ppp pap sent-username RTLIM1 password grupo4
int s0/1/1
encapsulation ppp
ppp authentication pap
ppp pap sent-username RTLIM1 password grupo4
int s0/2/0
encapsulation ppp
ppp authentication pap
ppp pap sent-username RTLIM1 password grupo4
EXIT
```

#### 2.2. Configuracion del switch multi-capa 1

```bash
en
conf t
hostname MLSLIM1

vlan 10
name ADMINISTRACION
vlan 20
name LOGISTICA
vlan 30
name MARKETING
vlan 40
name VENTAS
vlan 50
name FINANZAS
vlan 60
name WIFI-CLIENTES
vlan 70
name WIFI-EJECUTIVOS
vlan 80
name SERVIDORES
vlan 99
name NATIVA

int range f0/2-9
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan all
exit

int vlan 10
ip add 172.24.16.1 255.255.255.128
no shutdown
int vlan 20
ip add 172.24.16.129 255.255.255.192
no shutdown
int vlan 30
ip add 172.24.16.193 255.255.255.192
no shutdown
int vlan 40
ip add 172.24.17.1 255.255.255.224
no shutdown
int vlan 50
ip add 172.24.17.33 255.255.255.224
no shutdown
int vlan 60
ip add 172.24.17.65 255.255.255.224
no shutdown
int vlan 70
ip add 172.24.17.129 255.255.255.224
no shutdown
int vlan 80
ip add 172.24.17.225 255.255.255.224
no shutdown
int vlan 99
ip add 172.24.99.33 255.255.255.224
no shutdown
exit

int f0/10
no sw
ip add 172.24.254.22 255.255.255.252
ip ospf 100 area 0
int vlan 10
ip ospf 100 area 0
int vlan 20
ip ospf 100 area 0
int vlan 30
ip ospf 100 area 0
int vlan 40
ip ospf 100 area 0
int vlan 50
ip ospf 100 area 0
int vlan 60
ip ospf 100 area 0
int vlan 70
ip ospf 100 area 0
int vlan 80
ip ospf 100 area 0


ip default-gateway 172.24.99.33
ip routing

ip dhcp pool pool-vlan10
network 172.24.16.0 255.255.255.128
default-router 172.24.16.1
dns-server 172.24.17.230
domain-name NETWORKPIONEERS.LIMA.COM
exit
ip dhcp pool pool-vlan20
network 172.24.16.128 255.255.255.192
default-router 172.24.16.129
dns-server 172.24.17.230
domain-name NETWORKPIONEERS.LIMA.COM
exit
ip dhcp pool pool-vlan30
network 172.24.16.192 255.255.255.192
default-router 172.24.16.193
dns-server 172.24.17.230
domain-name NETWORKPIONEERS.LIMA.COM
exit
ip dhcp pool pool-vlan40
network 172.24.17.0 255.255.255.224
default-router 172.24.17.1
dns-server 172.24.17.230
domain-name NETWORKPIONEERS.LIMA.COM
exit
ip dhcp pool pool-vlan50
network 172.24.17.32 255.255.255.224
default-router 172.24.17.33
dns-server 172.24.17.230
domain-name NETWORKPIONEERS.LIMA.COM
exit
ip dhcp pool pool-vlan60
network 172.24.17.64 255.255.255.224
default-router 172.24.17.65
dns-server 172.24.17.230
domain-name NETWORKPIONEERS.LIMA.COM
exit
ip dhcp pool pool-vlan70
network 172.24.17.128 255.255.255.224
default-router 172.24.17.129
dns-server 172.24.17.230
domain-name NETWORKPIONEERS.LIMA.COM
exit

router ospf 100
network 172.24.16.0 0.0.0.127 area 0
network 172.24.16.128 0.0.0.63 area 0
network 172.24.16.192 0.0.0.63 area 0
network 172.24.17.0 0.0.0.31 area 0
network 172.24.17.32 0.0.0.31 area 0
network 172.24.17.64 0.0.0.31 area 0
network 172.24.17.128 0.0.0.31 area 0
network 172.24.17.224 0.0.0.31 area 0
network 172.24.99.32 0.0.0.31 area 0
network 172.24.254.20 0.0.0.3 area 0
passive-interface f0/2
passive-interface f0/3
passive-interface f0/4
passive-interface f0/5
passive-interface f0/6
passive-interface f0/7
passive-interface f0/8
passive-interface f0/9
```

#### 2.3. Configuracion del switch multi-capa 2

```bash
en
conf t
hostname MLSLIM2

vlan 10
name ADMINISTRACION
vlan 20
name LOGISTICA
vlan 30
name MARKETING
vlan 40
name VENTAS
vlan 50
name FINANZAS
vlan 60
name WIFI-CLIENTES
vlan 70
name WIFI-EJECUTIVOS
vlan 80
name SERVIDORES
vlan 99
name NATIVA

int range f0/2-9
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan all
exit

int f0/10
no sw
ip add 172.24.254.26 255.255.255.252

int vlan 10
ip add 172.24.16.2 255.255.255.128
no shutdown
int vlan 20
ip add 172.24.16.130 255.255.255.192
no shutdown
int vlan 30
ip add 172.24.16.194 255.255.255.192
no shutdown
int vlan 40
ip add 172.24.17.2 255.255.255.224
no shutdown
int vlan 50
ip add 172.24.17.34 255.255.255.224
no shutdown
int vlan 60
ip add 172.24.17.66 255.255.255.224
no shutdown
int vlan 70
ip add 172.24.17.130 255.255.255.224
no shutdown
int vlan 80
ip add 172.24.17.226 255.255.255.224
no shutdown
int vlan 99
ip add 172.24.99.34 255.255.255.224
no shutdown
exit

ip default-gateway 172.24.99.33
ip routing
```

#### 2.4. Configuracion del switch

```bash
en
conf t
hostname SWLIM9

vlan 10
name ADMINISTRACION
vlan 20
name LOGISTICA
vlan 30
name MARKETING
vlan 40
name VENTAS
vlan 50
name FINANZAS
vlan 60
name WIFI-CLIENTES
vlan 70
name WIFI-EJECUTIVOS
vlan 80
name SERVIDORES
vlan 99
name NATIVA

int vlan 99
ip add 172.24.99.50 255.255.255.224
no shutdown
exit
ip default-gateway 172.24.99.33
```

### 3. Comandos adicionales

#### 3.1. Seguridad basica

```bash
en
conf t
line console 0
password grupo4
login
line vty 0 15
password grupo4
login
exit
enable secret grupo4
banner motd % *** Solo personal del equipo 4 con la debida autorización, accedera al dispositivo *** %
```

#### 3.2. Configuracion de domain lookup

```bash
no ip domain-lookup
```

#### 3.3. Comandos de verificacion

```
show ip interface brief
show ip route
show interfaces vlan
```

### 4. Tablas de mascaras de subred

| CIDR Notation |    Subnet Mask    | Wildcard Mask |
| :-----------: | :---------------: | :-----------: |
|      /24      |  `255.255.255.0`  |  `0.0.0.255`  |
|      /25      | `255.255.255.128` |  `0.0.0.127`  |
|      /26      | `255.255.255.192` |  `0.0.0.63`   |
|      /27      | `255.255.255.224` |  `0.0.0.31`   |
|      /28      | `255.255.255.240` |  `0.0.0.15`   |
|      /29      | `255.255.255.248` |   `0.0.0.7`   |
|      /30      | `255.255.255.252` |   `0.0.0.3`   |

---

[Regresar al inicio](#indice)

//002
