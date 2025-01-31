# Síťové příkazy - Užitečné příkazy

## Základní síťové nástroje
### IP příkazy
```bash
# Zobrazení síťových rozhraní
ip addr show
ip a

# Zobrazení routovací tabulky
ip route show
ip r

# Zapnutí/vypnutí síťového rozhraní
ip link set eth0 up
ip link set eth0 down

# Nastavení IP adresy
ip addr add 192.168.1.100/24 dev eth0
```

### NetworkManager
```bash
# Zobrazení všech připojení
nmcli connection show

# Zobrazení aktivních připojení
nmcli connection show --active

# Připojení k WiFi
nmcli device wifi connect "SSID" password "heslo"

# Zapnutí/vypnutí WiFi
nmcli radio wifi on
nmcli radio wifi off
```

## Diagnostika sítě
### Ping a traceroute
```bash
# Test dostupnosti
ping google.com

# Omezený počet pingů
ping -c 4 google.com

# Traceroute
traceroute google.com

# MTR (kombinace ping a traceroute)
mtr google.com
```

### DNS nástroje
```bash
# DNS lookup
nslookup google.com

# Detailní DNS informace
dig google.com

# Reverzní DNS lookup
dig -x 8.8.8.8

# DNS server test
dig @8.8.8.8 google.com
```

## Síťové porty a služby
### Netstat a SS
```bash
# Seznam všech otevřených portů
netstat -tuln

# Seznam aktivních připojení
ss -tuln

# Seznam naslouchajících TCP portů
netstat -tlnp

# Seznam procesů používajících síť
netstat -tulnp
```

### Firewall
```bash
# Zobrazení pravidel firewallu
iptables -L

# Zobrazení NAT pravidel
iptables -t nat -L

# UFW status
ufw status

# UFW povolení portu
ufw allow 80
```

## Síťové utility
### Wget a cURL
```bash
# Stažení souboru
wget https://example.com/file.zip

# Stažení s pokračováním
wget -c https://example.com/file.zip

# HTTP požadavek
curl https://example.com

# POST požadavek
curl -X POST -d "data" https://example.com
```

### SSH
```bash
# Připojení k serveru
ssh uživatel@server

# Kopírování souborů přes SSH
scp soubor.txt uživatel@server:/cílová/cesta

# Generování SSH klíčů
ssh-keygen -t ed25519

# Kopírování veřejného klíče na server
ssh-copy-id uživatel@server
```

## Monitorování sítě
### Bandwidth monitoring
```bash
# Sledování síťového provozu
iftop

# Monitoring přenosu dat
nethogs

# Detailní statistiky
vnstat

# Real-time statistiky
vnstat -l
```

### Packet capture
```bash
# Zachycení paketů na rozhraní
tcpdump -i eth0

# Zachycení specifického portu
tcpdump -i eth0 port 80

# Uložení do souboru
tcpdump -w capture.pcap
```

## Bezdrátové sítě
### WiFi diagnostika
```bash
# Skenování dostupných sítí
iwlist wlan0 scan

# Informace o připojení
iwconfig wlan0

# Síla signálu
watch -n 1 cat /proc/net/wireless
```

## Užitečné aliasy
```bash
# Přidat do ~/.bashrc nebo ~/.zshrc
alias myip='curl ifconfig.me'
alias ports='netstat -tuln'
alias connections='netstat -tulnp'
alias wifi='nmcli device wifi list'
```

## Řešení problémů
```bash
# Reset síťového rozhraní
systemctl restart NetworkManager

# Vyčištění DNS cache
systemd-resolve --flush-caches

# Test MTU
ping -s 1472 -M do google.com

# Kontrola routování
ip route get 8.8.8.8
``` 