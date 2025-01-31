# Firewall - Užitečné příkazy

## UFW (Uncomplicated Firewall)
### Základní operace
```bash
# Zapnutí/vypnutí firewallu
sudo ufw enable
sudo ufw disable

# Kontrola stavu
sudo ufw status
sudo ufw status verbose
sudo ufw status numbered

# Reset pravidel
sudo ufw reset
```

### Správa pravidel
```bash
# Povolení portu
sudo ufw allow 80
sudo ufw allow 80/tcp

# Zakázání portu
sudo ufw deny 80
sudo ufw deny 80/tcp

# Povolení služby
sudo ufw allow ssh
sudo ufw allow http

# Povolení rozsahu portů
sudo ufw allow 6000:6007/tcp
```

### Pokročilá pravidla
```bash
# Povolení z konkrétní IP adresy
sudo ufw allow from 192.168.1.100

# Povolení na konkrétní rozhraní
sudo ufw allow in on eth0 to any port 80

# Povolení z podsítě
sudo ufw allow from 192.168.1.0/24

# Rate limiting
sudo ufw limit ssh
```

## iptables
### Základní operace
```bash
# Zobrazení pravidel
sudo iptables -L
sudo iptables -L -v
sudo iptables -L --line-numbers

# Vyčištění pravidel
sudo iptables -F
```

### Správa pravidel
```bash
# Povolení portu
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT

# Zakázání portu
sudo iptables -A INPUT -p tcp --dport 80 -j DROP

# Povolení ustanovených spojení
sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
```

### NAT a forwarding
```bash
# Povolení forwardingu
sudo iptables -A FORWARD -i eth0 -o wlan0 -j ACCEPT

# NAT pravidlo
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

# Port forwarding
sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8080
```

## firewalld
### Základní operace
```bash
# Start/stop služby
sudo systemctl start firewalld
sudo systemctl stop firewalld

# Kontrola stavu
sudo firewall-cmd --state

# Reload konfigurace
sudo firewall-cmd --reload
```

### Zóny a služby
```bash
# Seznam zón
sudo firewall-cmd --get-zones

# Aktivní zóny
sudo firewall-cmd --get-active-zones

# Přidání služby do zóny
sudo firewall-cmd --zone=public --add-service=http

# Přidání portu do zóny
sudo firewall-cmd --zone=public --add-port=80/tcp
```

## Monitorování a logování
### Sledování provozu
```bash
# Sledování zahozených paketů
sudo iptables -I INPUT 1 -j LOG

# Kontrola logů
sudo tail -f /var/log/syslog | grep UFW
sudo tail -f /var/log/messages | grep firewalld
```

### Diagnostika
```bash
# Test připojení
nc -zv localhost 80

# Kontrola otevřených portů
sudo netstat -tulpn
sudo ss -tulpn
```

## Užitečné aliasy
```bash
# Přidat do ~/.bashrc nebo ~/.zshrc
alias fw='sudo ufw status verbose'
alias fwadd='sudo ufw allow'
alias fwdel='sudo ufw delete'
alias fwlist='sudo iptables -L -v --line-numbers'
```

## Běžné konfigurace
```bash
# Základní webový server
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

# Základní SSH server
sudo ufw allow 22/tcp

# Základní mail server
sudo ufw allow 25/tcp
sudo ufw allow 143/tcp
sudo ufw allow 993/tcp
``` 