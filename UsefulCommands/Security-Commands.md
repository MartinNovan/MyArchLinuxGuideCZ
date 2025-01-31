# Bezpečnostní příkazy - Užitečné příkazy

## Základní bezpečnost
### Kontrola systému
```bash
# Kontrola běžících služeb
systemctl list-units --type=service

# Kontrola otevřených portů
netstat -tulpn
ss -tulpn

# Kontrola aktivních spojení
lsof -i

# Kontrola procesů
ps aux
```

### Správa uživatelů
```bash
# Kontrola přihlášených uživatelů
who
w

# Historie přihlášení
last
lastb

# Kontrola sudo oprávnění
sudo -l
```

## Firewall
### UFW
```bash
# Status firewallu
ufw status verbose

# Povolení/zakázání portů
ufw allow 22
ufw deny 23

# Logování
ufw logging on
tail -f /var/log/ufw.log
```

### iptables
```bash
# Zobrazení pravidel
iptables -L -v

# Základní bezpečnostní pravidla
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -P INPUT DROP
```

## Audit systému
### Kontrola souborů
```bash
# Kontrola SUID/SGID
find / -type f -perm /6000 -ls

# Kontrola oprávnění
find / -nouser -o -nogroup

# Kontrola integrity
aide --check
```

### Logování
```bash
# Kontrola systémových logů
journalctl -p err..emerg

# Audit systému
auditctl -w /etc/passwd -p wa
ausearch -f /etc/passwd

# Kontrola auth logů
tail -f /var/log/auth.log
```

## Šifrování
### GPG
```bash
# Generování klíčů
gpg --full-generate-key

# Šifrování souboru
gpg -e -r "příjemce" soubor

# Dešifrování
gpg -d soubor.gpg
```

### Disk encryption
```bash
# Vytvoření šifrovaného oddílu
cryptsetup luksFormat /dev/sdX

# Otevření šifrovaného oddílu
cryptsetup open /dev/sdX název

# Zavření
cryptsetup close název
```

## Síťová bezpečnost
### SSH
```bash
# Bezpečná konfigurace SSH
# /etc/ssh/sshd_config
PermitRootLogin no
PasswordAuthentication no
Protocol 2

# Generování klíčů
ssh-keygen -t ed25519
```

### SSL/TLS
```bash
# Generování certifikátu
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout private.key -out certificate.crt

# Kontrola certifikátu
openssl x509 -in certificate.crt -text
```

## Monitoring a detekce
### Intrusion Detection
```bash
# Kontrola rootkitů
rkhunter --check
chkrootkit

# Monitoring souborů
inotifywait -m -r /důležitý/adresář

# Kontrola integrity
tripwire --check
```

### Síťový monitoring
```bash
# Packet capture
tcpdump -i any port 80

# Síťová analýza
wireshark

# IDS
snort -A console -q -c /etc/snort/snort.conf
```

## Hardening systému
### Základní zabezpečení
```bash
# Nastavení bezpečných oprávnění
chmod 600 /etc/shadow
chmod 644 /etc/passwd

# Zakázání nepotřebných služeb
systemctl disable služba
systemctl mask služba
```

### Konfigurace
```bash
# Bezpečné nastavení systému
# /etc/sysctl.conf
net.ipv4.tcp_syncookies = 1
net.ipv4.conf.all.rp_filter = 1
kernel.randomize_va_space = 2
```

## Užitečné aliasy
```bash
# Přidat do ~/.bashrc nebo ~/.zshrc
alias chkports='netstat -tulpn'
alias chkusers='w'
alias chkauth='tail -f /var/log/auth.log'
alias seccheck='rkhunter --check'
``` 