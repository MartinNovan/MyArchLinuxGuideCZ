# Užitečné tipy a triky pro Arch Linux

## Správa balíčků

### Rychlé hledání balíčků
```bash
pacman -Ss hledany_balicek
```

### Zobrazení informací o balíčku
```bash
pacman -Si balicek
```

### Zobrazení nainstalovaných balíčků
```bash
pacman -Qe
```

### Vyčištění cache
```bash
sudo pacman -Scc
```

## Správa systému

### Zobrazení volného místa
```bash
df -h
```

### Hledání velkých souborů
```bash
find / -size +100M
```

### Monitorování procesů
```bash
htop
```

## Užitečné aliasy

### Přidání do .bashrc nebo .zshrc
```bash
alias update='sudo pacman -Syu'
alias clean='sudo pacman -Rns $(pacman -Qtdq)'
alias ll='ls -la'
alias grep='grep --color=auto'
```

## Rychlé příkazy

### Zobrazení informací o systému
```bash
neofetch
```

### Testování rychlosti disku
```bash
sudo hdparm -Tt /dev/sda
```

### Monitorování teploty
```bash
sensors
```

## Užitečné skripty

### Záloha seznamu balíčků
```bash
pacman -Qqe > pkglist.txt
```

### Obnova balíčků ze seznamu
```bash
pacman -S - < pkglist.txt
```

## Doporučené postupy

1. **Pravidelné aktualizace**
   - Aktualizujte systém alespoň jednou týdně
   - Před aktualizací zkontrolujte Arch Linux novinky

2. **Zálohování**
   - Pravidelně zálohujte důležité soubory
   - Udržujte seznam nainstalovaných balíčků

3. **Dokumentace**
   - Zapisujte si provedené změny
   - Uchovávejte důležité příkazy

## Odkazy
- [Arch Wiki - Tips and tricks](https://wiki.archlinux.org/title/General_recommendations)
- [Arch Wiki - Pacman tips](https://wiki.archlinux.org/title/Pacman/Tips_and_tricks)
- [Arch Wiki - System maintenance](https://wiki.archlinux.org/title/System_maintenance)