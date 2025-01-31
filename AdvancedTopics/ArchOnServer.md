# Arch Linux na serveru

## Úvod
Tento dokument popisuje specifické aspekty používání Arch Linuxu jako serverového operačního systému, včetně optimalizace výkonu, zabezpečení a správy služeb.

## Základní nastavení

### Minimální instalace
```bash
pacstrap /mnt base linux linux-firmware
```

### Konfigurace sítě
```bash
sudo pacman -S networkmanager
sudo systemctl enable NetworkManager
```

### Nastavení časové zóny
```bash
ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
hwclock --systohc
```

## Optimalizace výkonu

### I/O scheduler
```bash
echo deadline | sudo tee /sys/block/sda/queue/scheduler
```

### TCP tuning
```bash
echo 'net.core.rmem_max=16777216' | sudo tee -a /etc/sysctl.conf
echo 'net.core.wmem_max=16777216' | sudo tee -a /etc/sysctl.conf
```

### Zvýšení limitů souborů
```bash
echo '* soft nofile 65536' | sudo tee -a /etc/security/limits.conf
echo '* hard nofile 65536' | sudo tee -a /etc/security/limits.conf
```

## Zabezpečení

### Firewall
```bash
sudo pacman -S ufw
sudo ufw allow ssh
sudo ufw enable
```

### SELinux
```bash
sudo pacman -S selinux
sudo nano /etc/selinux/config
```

### Automatické aktualizace
```bash
sudo pacman -S unattended-upgrades
sudo systemctl enable unattended-upgrades
```

## Správa služeb

### Web server
```bash
sudo pacman -S nginx
sudo systemctl enable nginx
```

### Databáze
```bash
sudo pacman -S mariadb
sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
sudo systemctl enable mariadb
```

### Email server
```bash
sudo pacman -S postfix
sudo systemctl enable postfix
```

## Monitorování

### Základní nástroje
```bash
sudo pacman -S htop iotop iftop
```

### Logování
```bash
sudo pacman -S rsyslog
sudo systemctl enable rsyslog
```

### Upozornění
```bash
sudo pacman -S monit
sudo systemctl enable monit
```

## Zálohování

### Rsync
```bash
sudo pacman -S rsync
```

### Cron joby
```bash
0 3 * * * rsync -avz /important/data backup@server:/backup
```

### Automatické zálohování
```bash
sudo pacman -S bacula
sudo systemctl enable bacula
```

## Doporučené postupy

1. **Zabezpečení**
   - Pravidelně aktualizujte systém
   - Používejte silná hesla
   - Omezte přístup k službám

2. **Monitorování**
   - Sledujte využití zdrojů
   - Nastavte upozornění na kritické hodnoty
   - Analyzujte logy

3. **Zálohování**
   - Pravidelně zálohujte data
   - Testujte obnovu záloh
   - Udržujte zálohy na externím úložišti

## Užitečné odkazy
- [Arch Wiki - Server](https://wiki.archlinux.org/title/Server)
- [Arch Wiki - Security](https://wiki.archlinux.org/title/Security)
- [Arch Wiki - Network configuration](https://wiki.archlinux.org/title/Network_configuration)