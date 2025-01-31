# Sledování využití zdrojů - Užitečné příkazy

## Využití CPU
### Základní monitoring
```bash
# Základní informace o CPU
top
htop

# Zatížení CPU
uptime
mpstat 1

# Využití podle procesů
ps aux --sort=-%cpu | head

# Teplota CPU
sensors
```

### Pokročilá analýza
```bash
# Detailní statistiky CPU
sar -u 1 5

# Využití podle jader
mpstat -P ALL 1

# Latence CPU
perf stat -a sleep 1

# Profilování CPU
perf record -a -g sleep 10
```

## Využití paměti
### RAM monitoring
```bash
# Základní informace o paměti
free -h
vmstat 1

# Detailní využití
smem
ps_mem

# Top procesy podle paměti
ps aux --sort=-%mem | head
```

### Swap využití
```bash
# Informace o swap
swapon --show

# Využití swap podle procesů
for file in /proc/*/status ; do awk '/VmSwap|Name/{printf $2 " " $3}END{ print ""}' $file; done | sort -k 2 -n -r | head

# Vyčištění cache
sync; echo 3 > /proc/sys/vm/drop_caches
```

## Diskové operace
### I/O monitoring
```bash
# Sledování I/O
iostat -x 1

# I/O podle procesů
iotop

# Využití disku
df -h
du -sh /*
```

### Analýza I/O
```bash
# Detailní I/O statistiky
pidstat -d 1

# Latence I/O
ioping /dev/sda

# Benchmark disku
dd if=/dev/zero of=test bs=1M count=1000
```

## Síťové zdroje
### Bandwidth monitoring
```bash
# Síťový provoz
iftop
nethogs

# Statistiky rozhraní
ip -s link

# Detailní analýza
tcpdump -i any
```

### Síťová spojení
```bash
# Aktivní spojení
netstat -tulpn
ss -tuln

# Spojení podle procesu
lsof -i

# Statistiky spojení
netstat -s
```

## Systémové zdroje
### Celkové využití
```bash
# Systémové statistiky
dstat

# Komplexní monitoring
atop
glances

# Zátěž systému
w
uptime
```

### Limity systému
```bash
# Limity procesů
ulimit -a

# Systémové limity
sysctl -a

# Kontrola limitů
cat /proc/sys/fs/file-max
```

## Užitečné aliasy
```bash
# Přidat do ~/.bashrc nebo ~/.zshrc
alias meminfo='free -h'
alias cpuinfo='mpstat 1 5'
alias diskinfo='df -h'
alias netinfo='netstat -tulpn'
```

## Automatizace monitoringu
```bash
# Pravidelný záznam statistik
#!/bin/bash
while true; do
    date >> stats.log
    free -h >> stats.log
    mpstat 1 1 >> stats.log
    sleep 300
done

# Monitoring s alertingem
#!/bin/bash
mem=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
if [ ${mem%.*} -gt 90 ]; then
    echo "High memory usage!" | mail -s "Memory Alert" admin@example.com
fi
``` 