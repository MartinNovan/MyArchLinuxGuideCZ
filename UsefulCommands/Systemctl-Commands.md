# Systemctl - Užitečné příkazy

## Správa služeb
### Základní operace se službami
```bash
# Spuštění služby
systemctl start služba.service

# Zastavení služby
systemctl stop služba.service

# Restartování služby
systemctl restart služba.service

# Obnovení konfigurace služby
systemctl reload služba.service

# Zjištění stavu služby
systemctl status služba.service
```

### Automatické spouštění
```bash
# Povolení služby při startu
systemctl enable služba.service

# Zakázání služby při startu
systemctl disable služba.service

# Povolení a okamžité spuštění
systemctl enable --now služba.service

# Zakázání a okamžité zastavení
systemctl disable --now služba.service
```

## Systémové operace
### Správa systému
```bash
# Restart systému
systemctl reboot

# Vypnutí systému
systemctl poweroff

# Uspání systému
systemctl suspend

# Hibernace
systemctl hibernate
```

### Kontrola systému
```bash
# Zobrazení všech jednotek
systemctl list-units

# Zobrazení pouze aktivních jednotek
systemctl list-units --state=active

# Zobrazení selhávajících jednotek
systemctl list-units --state=failed

# Zobrazení všech služeb
systemctl list-units --type=service
```

## Analýza a řešení problémů
### Diagnostika
```bash
# Zobrazení závislostí služby
systemctl list-dependencies služba.service

# Zobrazení konfiguračního souboru
systemctl cat služba.service

# Zobrazení vlastností služby
systemctl show služba.service

# Kontrola, zda je služba aktivní
systemctl is-active služba.service

# Kontrola, zda je služba povolena
systemctl is-enabled služba.service
```

### Logy služeb
```bash
# Zobrazení logů služby
journalctl -u služba.service

# Zobrazení logů služby v reálném čase
journalctl -u služba.service -f

# Zobrazení logů služby od posledního bootu
journalctl -u služba.service -b
```

## Správa timers (časovačů)
```bash
# Seznam všech časovačů
systemctl list-timers

# Spuštění časovače
systemctl start časovač.timer

# Povolení časovače
systemctl enable časovač.timer

# Kontrola stavu časovače
systemctl status časovač.timer
```

## Síťové služby
```bash
# Restart síťového rozhraní
systemctl restart NetworkManager

# Kontrola stavu firewallu
systemctl status firewalld

# Restart SSH služby
systemctl restart sshd
```

## Užitečné aliasy
```bash
# Přidat do ~/.bashrc nebo ~/.zshrc
alias sstart='sudo systemctl start'
alias sstop='sudo systemctl stop'
alias srestart='sudo systemctl restart'
alias sstatus='systemctl status'
alias senable='sudo systemctl enable'
alias sdisable='sudo systemctl disable'
```

## Tipy pro řešení problémů
```bash
# Zobrazení všech selhání od posledního bootu
systemctl --failed

# Kontrola využití systémových prostředků
systemd-cgtop

# Reset selhávající služby
sudo systemctl reset-failed služba.service

# Maskování problematické služby
sudo systemctl mask problematická.service
```
