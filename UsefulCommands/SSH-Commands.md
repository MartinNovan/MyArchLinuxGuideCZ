# SSH - Užitečné příkazy

## Základní SSH operace
### Připojení
```bash
# Základní připojení
ssh uživatel@server

# Připojení na specifický port
ssh -p 2222 uživatel@server

# Připojení s verbose výstupem
ssh -v uživatel@server

# Připojení s konkrétním klíčem
ssh -i ~/.ssh/můj_klíč uživatel@server
```

### Správa klíčů
```bash
# Generování SSH klíče
ssh-keygen -t ed25519
ssh-keygen -t rsa -b 4096

# Kopírování veřejného klíče na server
ssh-copy-id uživatel@server

# Kontrola otisků klíčů
ssh-keygen -lf ~/.ssh/id_ed25519.pub
```

## Přenos souborů
### SCP (Secure Copy)
```bash
# Kopírování souboru na server
scp soubor.txt uživatel@server:/cílová/cesta/

# Kopírování adresáře na server
scp -r adresář/ uživatel@server:/cílová/cesta/

# Kopírování ze serveru
scp uživatel@server:/vzdálený/soubor.txt ./

# Kopírování mezi servery
scp uživatel@server1:/soubor.txt uživatel@server2:/cílová/cesta/
```

### SFTP
```bash
# Připojení k SFTP
sftp uživatel@server

# Základní SFTP příkazy
put soubor.txt    # Nahrání souboru
get soubor.txt    # Stažení souboru
ls                # Seznam souborů
cd                # Změna adresáře
pwd               # Aktuální adresář
```

## Pokročilé SSH funkce
### Tunelování
```bash
# Local port forwarding
ssh -L 8080:localhost:80 uživatel@server

# Remote port forwarding
ssh -R 8080:localhost:80 uživatel@server

# Dynamic port forwarding (SOCKS proxy)
ssh -D 1080 uživatel@server
```

### SSH agent
```bash
# Spuštění SSH agenta
eval $(ssh-agent)

# Přidání klíče do agenta
ssh-add ~/.ssh/id_ed25519

# Seznam klíčů v agentovi
ssh-add -l

# Odstranění všech klíčů
ssh-add -D
```

## Konfigurace
### SSH config
```bash
# ~/.ssh/config
Host server
    HostName server.example.com
    User uživatel
    Port 2222
    IdentityFile ~/.ssh/speciální_klíč

# Použití konfigurace
ssh server
```

### Zabezpečení
```bash
# /etc/ssh/sshd_config
PermitRootLogin no
PasswordAuthentication no
PubkeyAuthentication yes
Port 2222
```

## Údržba a diagnostika
### Řešení problémů
```bash
# Test SSH připojení
ssh -T git@github.com

# Debug mód
ssh -vvv uživatel@server

# Kontrola SSH služby
sudo systemctl status sshd
```

### Správa známých hostů
```bash
# Odstranění starého klíče
ssh-keygen -R server.example.com

# Kontrola známých hostů
cat ~/.ssh/known_hosts

# Skenování klíče hosta
ssh-keyscan server.example.com
```

## Automatizace
### SSH bez hesla
```bash
# Generování klíče bez hesla
ssh-keygen -t ed25519 -N ""

# Automatické přihlášení
cat ~/.ssh/id_ed25519.pub | ssh uživatel@server "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
```

### Spouštění příkazů
```bash
# Vzdálené spuštění příkazu
ssh uživatel@server 'ls -la'

# Spuštění více příkazů
ssh uživatel@server 'cd /var/log && tail -f syslog'

# Spuštění sudo příkazu
ssh uživatel@server 'sudo systemctl restart nginx'
```

## Užitečné aliasy
```bash
# Přidat do ~/.bashrc nebo ~/.zshrc
alias ssha='eval $(ssh-agent) && ssh-add'
alias sshk='ssh-keygen -t ed25519'
alias sshc='ssh-copy-id'
alias ssht='ssh -T'
``` 