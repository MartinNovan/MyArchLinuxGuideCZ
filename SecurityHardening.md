# Zabezpečení systému Arch Linux

## Úvod
Zabezpečení systému je komplexní proces, který zahrnuje mnoho vrstev ochrany. Tento dokument popisuje základní i pokročilé metody zabezpečení Arch Linuxu.

## Základní zabezpečení

### Správa hesel
#### Silná hesla
```bash
# Generování silného hesla
openssl rand -base64 32

# Změna hesla
passwd

# Nastavení politiky hesel v /etc/security/pwquality.conf
minlen = 12
minclass = 4
maxrepeat = 3
```

#### PAM konfigurace
```bash
# /etc/pam.d/system-auth
auth required pam_faillock.so preauth silent deny=3 unlock_time=600
auth required pam_unix.so try_first_pass nullok
auth [default=die] pam_faillock.so authfail
auth optional pam_permit.so
auth required pam_env.so
```

### Firewall
#### UFW (Uncomplicated Firewall)
```bash
# Základní nastavení
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw enable

# Pokročilá pravidla
ufw limit ssh
ufw allow from 192.168.1.0/24 to any port 80
```

#### iptables
```bash
# Základní pravidla
iptables -F
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
```

## Systémové zabezpečení

### Kernel hardening
#### Sysctl nastavení
```bash
# /etc/sysctl.d/99-security.conf
kernel.kptr_restrict=2
kernel.dmesg_restrict=1
kernel.unprivileged_bpf_disabled=1
net.core.bpf_jit_harden=2
kernel.yama.ptrace_scope=2
```

#### Zakázání modulů
```bash
# /etc/modprobe.d/blacklist.conf
blacklist cramfs
blacklist freevxfs
blacklist jffs2
blacklist hfs
blacklist hfsplus
blacklist udf
```

### Filesystem zabezpečení
```bash
# /etc/fstab
/dev/sda1 /boot          ext4    defaults,nodev,nosuid,noexec 0 2
/dev/sda2 /              ext4    defaults,nodev 0 1
/dev/sda3 /home          ext4    defaults,nodev,nosuid 0 2
tmpfs     /tmp           tmpfs   defaults,nodev,nosuid,noexec 0 0
```

## Aplikační zabezpečení

### SELinux/AppArmor
```bash
# Instalace AppArmor
pacman -S apparmor

# Aktivace v bootloaderu
GRUB_CMDLINE_LINUX="apparmor=1 security=apparmor"

# Základní profily
aa-enforce /etc/apparmor.d/*
```

### ASLR a další ochrana
```bash
# /etc/sysctl.d/99-sysctl.conf
kernel.randomize_va_space=2
fs.protected_hardlinks=1
fs.protected_symlinks=1
```

## Monitorování a audit

### Auditd
```bash
# Instalace
pacman -S audit

# Základní pravidla v /etc/audit/rules.d/audit.rules
-w /etc/passwd -p wa -k identity
-w /etc/group -p wa -k identity
-w /etc/shadow -p wa -k identity
-w /etc/sudoers -p wa -k sudo_changes
```

### Logování
```bash
# Rsyslog konfigurace
*.* action(type="omfwd" target="logserver" port="514" protocol="tcp")

# Journald nastavení
Storage=persistent
Compress=yes
SystemMaxUse=2G
```

## Síťové zabezpečení

### SSH hardening
```bash
# /etc/ssh/sshd_config
PermitRootLogin no
PasswordAuthentication no
MaxAuthTries 3
AllowUsers user1 user2
Protocol 2
```

### Fail2ban
```bash
# /etc/fail2ban/jail.local
[DEFAULT]
bantime = 1h
findtime = 10m
maxretry = 3

[sshd]
enabled = true
port = ssh
filter = sshd
logpath = /var/log/auth.log
```

## Pokročilé zabezpečení

### LUKS šifrování
```bash
# Vytvoření šifrovaného oddílu
cryptsetup luksFormat /dev/sda2

# Otevření oddílu
cryptsetup open /dev/sda2 cryptroot

# /etc/crypttab
cryptroot UUID=xxx none luks
```

### Secure Boot
```bash
# Generování klíčů
openssl req -new -x509 -newkey rsa:2048 -keyout MOK.key -out MOK.crt
sbsign --key MOK.key --cert MOK.crt --output /boot/vmlinuz-linux /boot/vmlinuz-linux
```

## Detekce průniků

### AIDE (Advanced Intrusion Detection Environment)
```bash
# Instalace
pacman -S aide

# Inicializace databáze
aide --init
mv /var/lib/aide/aide.db.new /var/lib/aide/aide.db

# Kontrola systému
aide --check
```

### Rootkit detekce
```bash
# Instalace rkhunter
pacman -S rkhunter

# Aktualizace databáze
rkhunter --update
rkhunter --propupd

# Kontrola systému
rkhunter --check
```

## Automatizace a údržba

### Automatické aktualizace
```bash
# /etc/systemd/system/security-updates.service
[Unit]
Description=Daily security updates

[Service]
Type=oneshot
ExecStart=/usr/bin/pacman -Syu --noconfirm

[Install]
WantedBy=multi-user.target
```

### Pravidelné kontroly
```bash
# Skript pro kontrolu bezpečnosti
#!/bin/bash
aide --check
rkhunter --check
fail2ban-client status
aureport --summary
```

## Doporučené postupy

### Základní principy
1. **Princip nejmenších oprávnění**
   - Používejte sudo místo root
   - Omezte přístup k souborům
   - Používejte SELinux/AppArmor

2. **Pravidelná údržba**
   - Aktualizace systému
   - Kontrola logů
   - Zálohování konfigurace

3. **Monitoring**
   - Sledování neobvyklé aktivity
   - Pravidelné bezpečnostní audity
   - Testování zabezpečení

### Checklist
- [ ] Silná hesla pro všechny účty
- [ ] Aktivní firewall
- [ ] Aktualizovaný systém
- [ ] Zabezpečené SSH
- [ ] Aktivní monitoring
- [ ] Šifrované disky
- [ ] Pravidelné zálohy
- [ ] Dokumentované změny

## Odkazy
- [Arch Wiki - Security](https://wiki.archlinux.org/title/Security)
- [Arch Wiki - AppArmor](https://wiki.archlinux.org/title/AppArmor)
- [Arch Wiki - SELinux](https://wiki.archlinux.org/title/SELinux) 