# Správa procesů - Užitečné příkazy

## Základní operace s procesy
### Zobrazení procesů
```bash
# Seznam všech procesů
ps aux

# Strom procesů
pstree

# Procesy konkrétního uživatele
ps -u uživatel

# Interaktivní zobrazení
top
htop
```

### Správa procesů
```bash
# Ukončení procesu
kill PID
kill -9 PID  # Vynucené ukončení

# Ukončení podle jména
pkill název_procesu
killall název_procesu

# Pozastavení procesu
kill -STOP PID

# Obnovení procesu
kill -CONT PID
```

## Pokročilá správa
### Priorita procesů
```bash
# Změna priority (nice)
nice -n 10 příkaz
renice 10 PID

# Zobrazení procesů podle priority
ps -el

# Real-time priorita
chrt -f 99 příkaz
```

### Limity procesů
```bash
# Nastavení limitů
ulimit -n 4096  # Počet otevřených souborů
ulimit -u 100   # Počet procesů

# Zobrazení limitů
ulimit -a

# Trvalé nastavení v /etc/security/limits.conf
* soft nofile 4096
* hard nofile 8192
```

## Monitoring procesů
### Sledování výkonu
```bash
# Využití CPU a paměti
ps aux --sort=-%cpu
ps aux --sort=-%mem

# Sledování I/O
iotop
iostat

# Sledování systémových volání
strace -p PID
```

### Analýza procesů
```bash
# Debug informace
gdb -p PID

# Sledování otevřených souborů
lsof -p PID

# Sledování síťových spojení
netstat -p PID
```

## Správa démonů
### Systemd služby
```bash
# Status služby
systemctl status služba

# Start/stop služby
systemctl start služba
systemctl stop služba

# Povolení/zakázání při startu
systemctl enable služba
systemctl disable služba
```

### Tradiční init skripty
```bash
# Start/stop služby
/etc/init.d/služba start
/etc/init.d/služba stop

# Status služby
service služba status
```

## Automatizace
### Plánování úloh
```bash
# Spuštění na pozadí
nohup příkaz &

# Spuštění s nízkou prioritou
nice příkaz &

# Plánování pomocí at
at now + 1 hour
at> příkaz
```

### Cron úlohy
```bash
# Editace cron úloh
crontab -e

# Seznam cron úloh
crontab -l

# Systémové cron úlohy
/etc/crontab
```

## Řešení problémů
### Diagnostika
```bash
# Hledání zombie procesů
ps aux | grep Z

# Kontrola zatížení systému
uptime
w

# Analýza využití paměti
free -h
vmstat 1
```

### Krizové situace
```bash
# Ukončení všech procesů uživatele
pkill -u uživatel

# Vynucený reboot
echo b > /proc/sysrq-trigger

# Výpis posledních zpráv kernelu
dmesg | tail
```

## Užitečné aliasy
```bash
# Přidat do ~/.bashrc nebo ~/.zshrc
alias psa='ps aux'
alias psg='ps aux | grep'
alias top10='ps aux --sort=-%cpu | head'
alias killz='kill -9'
```

## Bezpečnost
```bash
# Kontrola běžících služeb
netstat -tulpn

# Kontrola SUID procesů
find / -perm -4000 -type f

# Kontrola procesů bez vlastníka
ps aux | awk '$1 == "?"'
``` 