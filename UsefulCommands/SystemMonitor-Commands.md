# Monitoring systému - Užitečné příkazy

## Základní monitoring
### Systémové informace
```bash
# Základní informace o systému
uname -a

# Informace o CPU
lscpu
cat /proc/cpuinfo

# Informace o paměti
free -h
cat /proc/meminfo

# Informace o disku
df -h
```

### Monitoring v reálném čase
```bash
# Základní systémový monitor
top

# Vylepšený monitor (htop)
htop

# Monitoring CPU a paměti
vmstat 1

# Monitoring I/O
iostat -x 1
```

## Pokročilý monitoring
### Grafické nástroje
```bash
# Systémový monitor
gnome-system-monitor

# Monitoring sítě
iftop
nethogs

# Monitoring disku
iotop
```

### Výkonnostní nástroje
```bash
# Statistiky výkonu
mpstat 1

# Latence disku
iostat -dx 1

# Využití procesoru po jádrech
mpstat -P ALL 1
```

## Logování a analýza
### Systémové logy
```bash
# Sledování systémových logů
journalctl -f

# Logy jádra
dmesg
dmesg -w

# Statistiky systému
sar -u 1 5
```

### Analýza výkonu
```bash
# Analýza výkonu procesů
pidstat 1

# Analýza využití paměti
smem

# Analýza využití swap
swapon --show
```

## Síťový monitoring
### Síťové statistiky
```bash
# Síťová připojení
netstat -tulpn

# Aktivní spojení
ss -tuln

# Bandwidth monitoring
bmon
```

### Analýza sítě
```bash
# Monitoring síťového provozu
tcpdump -i any
wireshark

# Statistiky síťového rozhraní
ip -s link
```

## Monitoring procesů
### Správa procesů
```bash
# Seznam procesů
ps aux

# Strom procesů
pstree

# Sledování změn procesů
watch -n 1 'ps aux'
```

### Analýza procesů
```bash
# Detailní informace o procesu
ps -p PID -f

# Sledování konkrétního procesu
top -p PID

# Využití CPU podle procesů
ps -eo pid,ppid,%cpu,%mem,cmd --sort=-%cpu
```

## Monitoring zdrojů
### Využití CPU
```bash
# Zatížení CPU
uptime
w

# Teplota CPU
sensors

# Frekvence CPU
watch -n 1 'cat /proc/cpuinfo | grep MHz'
```

### Využití paměti
```bash
# Detailní využití paměti
ps_mem

# Cache a buffer
sync; echo 3 > /proc/sys/vm/drop_caches

# Největší konzumenti paměti
ps aux --sort=-%mem | head
```

## Užitečné aliasy
```bash
# Přidat do ~/.bashrc nebo ~/.zshrc
alias mem='free -h'
alias cpu='mpstat 1 5'
alias io='iostat -x 1 5'
alias net='netstat -tulpn'
alias watch-cpu='watch -n 1 "mpstat 1 1"'
```

## Automatizace monitoringu
```bash
# Pravidelný záznam statistik
sar -o /tmp/system_stats 1 3600

# Automatický monitoring pomocí cronu
* * * * * /usr/bin/vmstat >> /var/log/vmstat.log

# Monitoring s alertingem
#!/bin/bash
mem=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
if [ ${mem%.*} -gt 90 ]; then
    echo "High memory usage!" | mail -s "Memory Alert" admin@example.com
fi
``` 