# Journalctl - Užitečné příkazy

## Základní použití
### Zobrazení logů
```bash
# Zobrazení všech logů
journalctl

# Zobrazení logů v reálném čase
journalctl -f

# Zobrazení logů od posledního bootu
journalctl -b

# Zobrazení logů z předchozího bootu
journalctl -b -1
```

### Filtrování podle času
```bash
# Logy od určitého data
journalctl --since="2024-01-01"

# Logy do určitého data
journalctl --until="2024-01-31"

# Logy za poslední hodinu
journalctl --since "1 hour ago"

# Logy za poslední den
journalctl --since "1 day ago"
```

## Filtrování logů
### Podle služby
```bash
# Logy konkrétní služby
journalctl -u služba.service

# Logy více služeb
journalctl -u služba1.service -u služba2.service

# Logy NetworkManager
journalctl -u NetworkManager.service
```

### Podle priority
```bash
# Pouze chybové zprávy
journalctl -p err

# Důležité a kritické zprávy
journalctl -p "emerg".."crit"

# Priority:
# 0: emerg
# 1: alert
# 2: crit
# 3: err
# 4: warning
# 5: notice
# 6: info
# 7: debug
```

## Správa žurnálu
### Údržba
```bash
# Zobrazení velikosti žurnálu
journalctl --disk-usage

# Vyčištění starých záznamů
journalctl --vacuum-time=2d    # Starší než 2 dny
journalctl --vacuum-size=1G    # Omezení na 1GB

# Rotace žurnálu
journalctl --rotate
```

### Export a analýza
```bash
# Export do textového souboru
journalctl > system_log.txt

# Export ve formátu JSON
journalctl -o json > system_log.json

# Export konkrétní služby
journalctl -u služba.service > service_log.txt
```

## Pokročilé filtrování
```bash
# Logy konkrétního procesu
journalctl _PID=1234

# Logy konkrétního uživatele
journalctl _UID=1000

# Logy podle cesty k executable
journalctl _EXE=/usr/bin/program

# Kombinované filtrování
journalctl _SYSTEMD_UNIT=sshd.service _PID=1234
```

## Formátování výstupu
```bash
# Kompaktní výstup
journalctl --no-pager

# Výstup s časovými razítky
journalctl --output=short-precise

# Pouze zprávy bez metadat
journalctl --output=cat

# Výstup ve formátu JSON
journalctl --output=json
```

## Užitečné kombinace
```bash
# Chyby od posledního bootu
journalctl -b -p err

# Poslední boot v reálném čase
journalctl -b -f

# Chyby konkrétní služby
journalctl -u služba.service -p err

# Logy kernelu
journalctl -k
```

## Řešení problémů
```bash
# Kontrola integrity žurnálu
journalctl --verify

# Zobrazení statistik žurnálu
journalctl --header

# Výpis bootů systému
journalctl --list-boots

# Kontrola chyb při startu
journalctl -b -p err..alert
```

## Užitečné aliasy
```bash
# Přidat do ~/.bashrc nebo ~/.zshrc
alias jctl='journalctl'
alias jctlf='journalctl -f'
alias jctlb='journalctl -b'
alias jctlerr='journalctl -p err..alert'
``` 