# Yay - Užitečné příkazy

## Základní operace
### Instalace balíčků
```bash
# Instalace balíčku z AUR
yay -S název_balíčku

# Instalace bez potvrzení
yay -S --noconfirm název_balíčku

# Instalace s výběrem poskytovatele
yay -S název_balíčku --ask
```

### Aktualizace systému
```bash
# Aktualizace všech balíčků (včetně AUR)
yay -Syu

# Aktualizace pouze AUR balíčků
yay -Sua

# Vynucená aktualizace databáze a balíčků
yay -Syyu
```

## Vyhledávání
```bash
# Vyhledání balíčku v AUR
yay -Ss klíčové_slovo

# Zobrazení informací o balíčku
yay -Si název_balíčku

# Vyhledání balíčku s detailním výstupem
yay -Ss --sortby popularity klíčové_slovo
```

## Údržba systému
```bash
# Vyčištění nepotřebných závislostí
yay -Yc

# Vyčištění mezipaměti
yay -Sc

# Úplné vyčištění mezipaměti
yay -Scc

# Odstranění osiřelých balíčků
yay -Yns $(yay -Qtdq)
```

## Správa zdrojových kódů
```bash
# Stažení PKGBUILD bez instalace
yay -G název_balíčku

# Editace PKGBUILD před instalací
yay -S název_balíčku --editmenu

# Zobrazení závislostí balíčku
yay -Si název_balíčku
```

## Pokročilé možnosti
```bash
# Instalace s vlastními parametry
yay -S název_balíčku --mflags "--skipchecksums --skippgpcheck"

# Synchronizace a aktualizace s výběrem balíčků
yay -Syu --menu

# Export seznamu nainstalovaných AUR balíčků
yay -Qm > aur_packages.txt
```

## Konfigurace
```bash
# Zobrazení statistik AUR
yay -P --stats

# Nastavení editoru pro PKGBUILD
yay --editor vim

# Nastavení prohlížeče diff
yay --diffedit
```

## Užitečné aliasy
```bash
# Přidat do ~/.bashrc nebo ~/.zshrc
alias yayin='yay -S'              # Instalace
alias yayss='yay -Ss'            # Vyhledávání
alias yaysyu='yay -Syu'          # Aktualizace
alias yaysyyu='yay -Syyu'        # Vynucená aktualizace
```

## Řešení problémů
```bash
# Přeinstalace balíčku
yay -S --rebuildall název_balíčku

# Kontrola konfliktů
yay -Pk

# Vynucená instalace
yay -S --overwrite "*" název_balíčku
```
