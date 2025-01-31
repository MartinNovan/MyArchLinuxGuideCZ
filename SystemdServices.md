# Systemd služby a správa systému

## Co je systemd?
Systemd je systém pro inicializaci a správu služeb v moderních Linux systémech. Nahrazuje tradiční init systém a poskytuje:
- Paralelní spouštění služeb
- Automatické spouštění služeb na vyžádání
- Sledování procesů
- Správu připojení zařízení
- Správu logů

## Základní koncepty

### Jednotky (Units)
Systemd používá různé typy jednotek pro správu systému:

1. **Service Units (.service)**
   - Správa služeb a démonů
   - Například: sshd.service, nginx.service

2. **Socket Units (.socket)**
   - Síťové sockety a IPC
   - Aktivace služeb na základě připojení
   - Například: cups.socket

3. **Mount Units (.mount)**
   - Správa připojených souborových systémů
   - Například: home.mount

4. **Timer Units (.timer)**
   - Plánování úloh (alternativa k cronu)
   - Například: backup.timer

5. **Target Units (.target)**
   - Skupiny jednotek
   - Definují stav systému
   - Například: multi-user.target

### Stavy služeb
- **active (running)** - Služba běží
- **active (exited)** - Služba úspěšně dokončena
- **failed** - Služba selhala
- **inactive** - Služba není spuštěna
- **enabled** - Služba se spustí při startu
- **disabled** - Služba se nespustí při startu

## Správa služeb

### Základní příkazy
```bash
# Start služby
systemctl start služba.service

# Zastavení služby
systemctl stop služba.service

# Restart služby
systemctl restart služba.service

# Reload konfigurace
systemctl reload služba.service

# Status služby
systemctl status služba.service
```

### Automatické spouštění
```bash
# Povolení služby při startu
systemctl enable služba.service

# Zakázání služby při startu
systemctl disable služba.service

# Povolení a okamžitý start
systemctl enable --now služba.service

# Zakázání a okamžité zastavení
systemctl disable --now služba.service
```

## Konfigurace služeb

### Umístění jednotek
- `/usr/lib/systemd/system/` - Systémové jednotky
- `/etc/systemd/system/` - Uživatelské jednotky
- `/run/systemd/system/` - Běhové jednotky

### Anatomie service souboru
```ini
[Unit]
Description=Popis služby
After=network.target
Requires=některá.service

[Service]
Type=simple
ExecStart=/usr/bin/program
ExecStop=/usr/bin/program stop
Restart=always
User=nobody
Group=nobody

[Install]
WantedBy=multi-user.target
```

### Typy služeb
- **simple** - Hlavní proces je spuštěn přímo
- **forking** - Služba se rozdvojí (fork)
- **oneshot** - Jednorázové spuštění
- **notify** - Služba signalizuje připravenost
- **dbus** - Služba se registruje na D-Bus

## Pokročilé funkce

### Závislosti služeb
```ini
[Unit]
# Musí běžet před touto službou
Before=další.service

# Musí běžet po této službě
After=předchozí.service

# Vyžaduje běh této služby
Requires=nutná.service

# Doporučuje běh této služby
Wants=volitelná.service

# Konflikt s touto službou
Conflicts=konfliktní.service
```

### Restart politiky
```ini
[Service]
# Vždy restartovat
Restart=always

# Restartovat pouze při selhání
Restart=on-failure

# Nikdy nerestartovat
Restart=no

# Časový limit pro restart
RestartSec=5s
```

### Omezení zdrojů
```ini
[Service]
# Omezení CPU
CPUQuota=50%

# Omezení paměti
MemoryLimit=1G

# Omezení I/O
IOWeight=100
```

## Logování a diagnostika

### Journald
```bash
# Zobrazení logů služby
journalctl -u služba.service

# Sledování logů v reálném čase
journalctl -u služba.service -f

# Logy od posledního bootu
journalctl -u služba.service -b

# Logy za poslední hodinu
journalctl -u služba.service --since "1 hour ago"
```

### Diagnostika problémů
```bash
# Kontrola závislostí
systemctl list-dependencies služba.service

# Seznam selhávajících služeb
systemctl --failed

# Detailní status
systemctl status služba.service -l

# Analýza boot procesu
systemd-analyze blame
```

## Uživatelské služby

### Správa uživatelských služeb
```bash
# Start uživatelské služby
systemctl --user start služba.service

# Status uživatelské služby
systemctl --user status služba.service

# Povolení uživatelské služby
systemctl --user enable služba.service
```

### Umístění uživatelských jednotek
- `~/.config/systemd/user/` - Uživatelské jednotky
- `/usr/lib/systemd/user/` - Systémové uživatelské jednotky

## Bezpečnost

### Izolace služeb
```ini
[Service]
# Izolace v chroot
RootDirectory=/var/lib/služba

# Omezení přístupu k souborům
ProtectSystem=strict
ProtectHome=true

# Omezení síťového přístupu
PrivateNetwork=true

# Omezení privilegií
CapabilityBoundingSet=CAP_NET_BIND_SERVICE
```

### Doporučené postupy
1. **Minimální oprávnění**
   - Používejte dedikované uživatele
   - Omezte přístup k systému
   - Definujte jasné závislosti

2. **Monitorování**
   - Sledujte logy služeb
   - Nastavte upozornění na selhání
   - Pravidelně kontrolujte status

3. **Údržba**
   - Pravidelně aktualizujte konfigurace
   - Čistěte staré logy
   - Testujte restart služeb

## Užitečné tipy

### Aliasy pro bash/zsh
```bash
# Přidat do ~/.bashrc nebo ~/.zshrc
alias scs='systemctl status'
alias scr='systemctl restart'
alias scf='systemctl --failed'
alias jc='journalctl -xe'
```

### Automatizace
```bash
# Skript pro restart služby při selhání
#!/bin/bash
if ! systemctl is-active --quiet služba.service; then
    systemctl restart služba.service
    notify-send "Služba restartována"
fi
```

## Odkazy
- [Arch Wiki - Systemd](https://wiki.archlinux.org/title/Systemd)
- [Systemd dokumentace](https://www.freedesktop.org/software/systemd/man/)