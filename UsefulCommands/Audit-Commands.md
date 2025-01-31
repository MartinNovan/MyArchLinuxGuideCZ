# Systémový audit - Užitečné příkazy

## Auditd
### Základní konfigurace
```bash
# Start služby
systemctl start auditd
systemctl enable auditd

# Kontrola stavu
auditctl -s

# Zobrazení pravidel
auditctl -l
```

### Nastavení pravidel
```bash
# Sledování souboru
auditctl -w /etc/passwd -p wa -k passwd_changes

# Sledování adresáře
auditctl -w /etc/ssh/ -p wa -k ssh_config

# Sledování systémových volání
auditctl -a always,exit -F arch=b64 -S execve -k exec_commands
```

## Vyhledávání v auditech
### Základní vyhledávání
```bash
# Vyhledávání podle klíče
ausearch -k passwd_changes

# Vyhledávání podle času
ausearch -ts today
ausearch -ts recent

# Vyhledávání podle uživatele
ausearch -ua root
```

### Pokročilé vyhledávání
```bash
# Kombinované vyhledávání
ausearch -k passwd_changes -ts today -ua root

# Vyhledávání v systémových voláních
ausearch -sc execve

# Vyhledávání podle procesu
ausearch -p 1234
```

## Reporty
### Generování reportů
```bash
# Základní report
aureport

# Report přihlášení
aureport --login

# Report příkazů
aureport --exec

# Report modifikací
aureport --file
```

### Specifické reporty
```bash
# Report selhání
aureport --failed

# Report anomálií
aureport --anomaly

# Report podle uživatele
aureport --user
```

## Systémové logy
### Journalctl
```bash
# Kontrola systémových logů
journalctl -p err..emerg

# Logy podle služby
journalctl -u auditd

# Logy podle času
journalctl --since "1 hour ago"
```

### Syslog
```bash
# Kontrola auth logů
tail -f /var/log/auth.log

# Kontrola systémových logů
tail -f /var/log/syslog

# Kontrola bezpečnostních logů
tail -f /var/log/secure
```

## Monitoring souborů
### AIDE
```bash
# Inicializace databáze
aide --init

# Kontrola změn
aide --check

# Update databáze
aide --update
```

### Tripwire
```bash
# Inicializace
tripwire --init

# Kontrola systému
tripwire --check

# Update politiky
tripwire --update-policy
```

## Síťový audit
### Tcpdump
```bash
# Zachycení provozu
tcpdump -i any

# Uložení do souboru
tcpdump -w capture.pcap

# Analýza souboru
tcpdump -r capture.pcap
```

### Wireshark
```bash
# Zachycení provozu
tshark

# Analýza souboru
tshark -r capture.pcap

# Filtrování provozu
tshark -Y "http"
```

## Bezpečnostní kontroly
### Rootkit kontrola
```bash
# Kontrola rkhunter
rkhunter --check

# Kontrola chkrootkit
chkrootkit

# Update databáze
rkhunter --update
```

### Kontrola integrity
```bash
# Kontrola balíčků
rpm -Va
dpkg -V

# Kontrola důležitých souborů
sha256sum -c hash.txt
```

## Užitečné aliasy
```bash
# Přidat do ~/.bashrc nebo ~/.zshrc
alias audit-status='auditctl -s'
alias audit-rules='auditctl -l'
alias audit-report='aureport'
alias check-integrity='aide --check'
```

## Automatizace
```bash
# Denní audit
#!/bin/bash
date >> /var/log/daily_audit.log
auditctl -l >> /var/log/daily_audit.log
aureport --summary >> /var/log/daily_audit.log

# Monitoring změn
#!/bin/bash
aide --check | mail -s "AIDE Report" admin@example.com
``` 