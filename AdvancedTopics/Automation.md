# Automatizace v Arch Linuxu

## Úvod
Automatizace je klíčem k efektivní správě systému. Tento dokument popisuje různé nástroje a techniky pro automatizaci úloh v Arch Linuxu.

## Systemd

### Timer jednotky
1. Vytvořte službu:
```bash
sudo nano /etc/systemd/system/myjob.service
```
```ini
[Unit]
Description=My Custom Job

[Service]
ExecStart=/path/to/script.sh
```

2. Vytvořte timer:
```bash
sudo nano /etc/systemd/system/myjob.timer
```
```ini
[Unit]
Description=Run My Custom Job Daily

[Timer]
OnCalendar=daily
Persistent=true

[Install]
WantedBy=timers.target
```

3. Povolte a spusťte timer:
```bash
sudo systemctl enable myjob.timer
sudo systemctl start myjob.timer
```

### Monitorování časovačů
```bash
systemctl list-timers
```

## Ansible

### Instalace
```bash
sudo pacman -S ansible
```

### Základní použití
1. Vytvořte inventář:
```ini
[webservers]
192.168.1.10
192.168.1.11

[dbservers]
192.168.1.20
```

2. Vytvořte playbook:
```yaml
---
- hosts: webservers
  become: yes
  tasks:
    - name: Ensure Apache is installed
      pacman:
        name: apache
        state: present
```

3. Spusťte playbook:
```bash
ansible-playbook -i inventory playbook.yml
```

## Cron

### Základní použití
1. Otevřete crontab:
```bash
crontab -e
```

2. Přidejte úlohu:
```bash
# Každý den v 3:00
0 3 * * * /path/to/script.sh
```

### Speciální syntaxe
```bash
@reboot /path/to/script.sh
@daily /path/to/script.sh
@weekly /path/to/script.sh
```

## Shell skriptování

### Základní skript
```bash
#!/bin/bash

# Proměnné
BACKUP_DIR="/backups"
DATE=$(date +%F)

# Záloha
tar -czf "$BACKUP_DIR/backup_$DATE.tar.gz" /important/data

# Odeslání notifikace
echo "Záloha dokončena" | mail -s "Záloha $DATE" admin@example.com
```

### Automatizace pomocí skriptů
1. Vytvořte skript
2. Udělejte ho spustitelným:
```bash
chmod +x script.sh
```
3. Přidejte do cronu nebo systemd timeru

## Automatizace pomocí Git

### Hooks
1. Vytvořte hook:
```bash
nano .git/hooks/post-commit
```
2. Přidejte skript:
```bash
#!/bin/bash
echo "Commit proveden, spouštím nasazení..."
/path/to/deploy.sh
```

### CI/CD
1. Vytvořte pipeline:
```yaml
stages:
  - build
  - test
  - deploy

build_job:
  stage: build
  script:
    - make build

test_job:
  stage: test
  script:
    - make test
```

## Užitečné nástroje

### Taskwarrior
```bash
sudo pacman -S task
```

### Rundeck
```bash
yay -S rundeck
```

### Jenkins
```bash
yay -S jenkins
```

## Doporučené postupy

1. **Dokumentace**
   - Komentujte skripty
   - Udržujte README soubory
   - Zaznamenávejte provedené změny

2. **Testování**
   - Testujte skripty v izolovaném prostředí
   - Používejte virtuální stroje nebo kontejnery
   - Implementujte unit testy

3. **Zálohování**
   - Pravidelně zálohujte konfigurační soubory
   - Udržujte seznam automatizovaných úloh
   - Implementujte monitoring

## Užitečné odkazy
- [Arch Wiki - Systemd](https://wiki.archlinux.org/title/Systemd)
- [Arch Wiki - Cron](https://wiki.archlinux.org/title/Cron)
- [Ansible Documentation](https://docs.ansible.com/)
- [Git Hooks](https://git-scm.com/docs/githooks) 