# Pacman - Užitečné příkazy

## Základní operace
### Instalace balíčků
```bash
# Instalace jednoho balíčku
pacman -S název_balíčku

# Instalace více balíčků
pacman -S balíček1 balíček2

# Instalace bez potvrzení
pacman -S --noconfirm název_balíčku
```

### Odstranění balíčků
```bash
# Odstranění balíčku
pacman -R název_balíčku

# Odstranění balíčku a jeho závislostí
pacman -Rs název_balíčku

# Odstranění balíčku, závislostí a konfiguračních souborů
pacman -Rns název_balíčku
```

### Aktualizace systému
```bash
# Synchronizace databáze
pacman -Sy

# Aktualizace všech balíčků
pacman -Syu

# Vynucená aktualizace
pacman -Syyu
```

## Vyhledávání
```bash
# Vyhledání balíčku
pacman -Ss klíčové_slovo

# Vyhledání lokálně nainstalovaného balíčku
pacman -Qs klíčové_slovo

# Zobrazení informací o balíčku
pacman -Si název_balíčku

# Zobrazení informací o nainstalovaném balíčku
pacman -Qi název_balíčku
```

## Údržba
```bash
# Vyčištění cache balíčků
pacman -Sc

# Vyčištění všech cachí
pacman -Scc

# Seznam osiřelých balíčků
pacman -Qdt

# Odstranění osiřelých balíčků
pacman -Rns $(pacman -Qtdq)
```

## Řešení problémů
```bash
# Kontrola problémů databáze
pacman -Dk

# Oprava databáze
pacman -Dk --fix

# Vynucená instalace balíčku
pacman -S --overwrite "*" název_balíčku
```

## Pokročilé použití
```bash
# Export seznamu explicitně nainstalovaných balíčků
pacman -Qe > packages.txt

# Instalace balíčků ze seznamu
pacman -S --needed - < packages.txt

# Zobrazení reverzních závislostí
pacman -Sii název_balíčku
```

## Užitečné aliasy
```bash
# Přidat do ~/.bashrc nebo ~/.zshrc
alias pacupg='sudo pacman -Syu'        # Upgrade
alias pacin='sudo pacman -S'           # Install
alias pacrem='sudo pacman -Rns'        # Remove
alias pacss='pacman -Ss'               # Search
alias pacsyu='sudo pacman -Syyu'       # Force sync and upgrade
# Pomocí zavolání aliasu v konzoli (např. pacupg) se vyvolá příkaz který jsme ta alias dosadili
```
