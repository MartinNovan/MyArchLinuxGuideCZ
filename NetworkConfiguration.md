# Síťová konfigurace v Arch Linux

## Úvod
Arch Linux nabízí několik způsobů konfigurace sítě, od nízkoúrovňových nástrojů po pokročilé správce sítě. Tento dokument popisuje různé metody a jejich použití.

## Základní nástroje

### ip (iproute2)
Moderní nástroj pro konfiguraci sítě:
```bash
# Zobrazení síťových rozhraní
ip link show

# Nastavení IP adresy
ip addr add 192.168.1.100/24 dev eth0

# Aktivace/deaktivace rozhraní
ip link set eth0 up
ip link set eth0 down

# Zobrazení směrovací tabulky
ip route show
```

### iwctl (iwd)
Nástroj pro správu WiFi:
```bash
# Spuštění interaktivního režimu
iwctl

# Vyhledání sítí
station wlan0 scan
station wlan0 get-networks

# Připojení k síti
station wlan0 connect SSID
```

## NetworkManager

### Základní použití
```bash
# Status připojení
nmcli general status

# Seznam WiFi sítí
nmcli device wifi list

# Připojení k WiFi
nmcli device wifi connect SSID password heslo

# Správa připojení
nmcli connection show
nmcli connection up SSID
nmcli connection down SSID
```

### Konfigurace připojení
```bash
# Vytvoření statického připojení
nmcli connection add \
    type ethernet \
    con-name "static-eth0" \
    ifname eth0 \
    ipv4.method manual \
    ipv4.addresses 192.168.1.100/24 \
    ipv4.gateway 192.168.1.1 \
    ipv4.dns "8.8.8.8,8.8.4.4"

# Úprava připojení
nmcli connection modify "static-eth0" \
    ipv4.addresses 192.168.1.101/24

# Automatické připojení
nmcli connection modify "static-eth0" \
    connection.autoconnect yes
```

## Systemd-networkd

### Základní konfigurace
Umístění: `/etc/systemd/network/`

```ini
# 20-wired.network
[Match]
Name=eth0

[Network]
DHCP=yes
```

```ini
# 25-wireless.network
[Match]
Name=wlan0

[Network]
DHCP=yes
```

### Statická konfigurace
```ini
# 30-static.network
[Match]
Name=eth0

[Network]
Address=192.168.1.100/24
Gateway=192.168.1.1
DNS=8.8.8.8
DNS=8.8.4.4
```

## DNS konfigurace

### systemd-resolved
```bash
# Aktivace služby
systemctl enable --now systemd-resolved

# Konfigurace v /etc/systemd/resolved.conf
[Resolve]
DNS=8.8.8.8 8.8.4.4
FallbackDNS=1.1.1.1
Domains=~.
DNSSEC=allow-downgrade
DNSOverTLS=opportunistic
```

### /etc/resolv.conf
```bash
# Ruční konfigurace
nameserver 8.8.8.8
nameserver 8.8.4.4
search local.domain
```

## Firewall

### UFW (Uncomplicated Firewall)
```bash
# Instalace
pacman -S ufw

# Základní konfigurace
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw allow http
ufw allow https

# Aktivace
ufw enable
```

### iptables
```bash
# Základní pravidla
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p tcp --dport ssh -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -P INPUT DROP

# Uložení pravidel
iptables-save > /etc/iptables/iptables.rules
```

## Pokročilá konfigurace

### Bonding (agregace linek)
```ini
# /etc/systemd/network/bond0.netdev
[NetDev]
Name=bond0
Kind=bond

[Bond]
Mode=active-backup
MIIMonitorSec=1s
```

```ini
# /etc/systemd/network/bond0.network
[Match]
Name=bond0

[Network]
DHCP=yes
```

### VLAN
```ini
# /etc/systemd/network/vlan10.netdev
[NetDev]
Name=vlan10
Kind=vlan

[VLAN]
Id=10
```

### Bridge
```ini
# /etc/systemd/network/br0.netdev
[NetDev]
Name=br0
Kind=bridge
```

## Bezdrátové sítě

### wpa_supplicant
```bash
# Konfigurace
wpa_passphrase SSID heslo > /etc/wpa_supplicant/wpa_supplicant.conf

# Spuštění
wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant/wpa_supplicant.conf
```

### Zabezpečení
```bash
# Generování silného klíče
wpa_passphrase SSID heslo

# Skrytí SSID
nmcli connection modify SSID wifi-sec.hidden yes
```

## Diagnostika

### Základní nástroje
```bash
# Ping
ping -c 4 archlinux.org

# Traceroute
traceroute archlinux.org

# DNS lookup
dig archlinux.org
nslookup archlinux.org
```

### Síťové nástroje
```bash
# Sledování síťového provozu
tcpdump -i eth0

# Analýza portů
netstat -tuln
ss -tuln

# Sledování připojení
nethogs eth0
iftop -i eth0
```

## Řešení problémů

### Kontrolní seznam
1. **Fyzické připojení**
   ```bash
   ip link show
   ethtool eth0
   ```

2. **IP konfigurace**
   ```bash
   ip addr show
   ip route show
   ```

3. **DNS resoluce**
   ```bash
   ping 8.8.8.8
   dig @8.8.8.8 archlinux.org
   ```

### Běžné problémy
```bash
# Obnovení DHCP
dhclient -r eth0
dhclient eth0

# Reset NetworkManager
systemctl restart NetworkManager

# Vyčištění DNS cache
systemd-resolve --flush-caches
```

## Automatizace

### Skripty
```bash
# Kontrola připojení
#!/bin/bash
if ! ping -c 1 8.8.8.8 &> /dev/null; then
    nmcli connection up "backup-connection"
    notify-send "Přepnuto na záložní připojení"
fi
```

### Systemd služby
```ini
# /etc/systemd/system/network-check.service
[Unit]
Description=Network Connection Check
After=network.target

[Service]
Type=simple
ExecStart=/usr/local/bin/network-check.sh

[Install]
WantedBy=multi-user.target
```

## Doporučené postupy

1. **Bezpečnost**
   - Používejte silná hesla pro WiFi
   - Aktivujte firewall
   - Pravidelně aktualizujte firmware

2. **Výkon**
   - Používejte aktuální ovladače
   - Optimalizujte MTU
   - Monitorujte využití sítě

3. **Údržba**
   - Zálohujte konfigurační soubory
   - Dokumentujte změny
   - Pravidelně kontrolujte logy

## Odkazy
- [Arch Wiki - Network Configuration](https://wiki.archlinux.org/title/Network_configuration)
- [Arch Wiki - NetworkManager](https://wiki.archlinux.org/title/NetworkManager)
- [Arch Wiki - Wireless](https://wiki.archlinux.org/title/Wireless) 